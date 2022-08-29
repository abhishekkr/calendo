defmodule CalendoWeb.Router do
  use CalendoWeb, :router

  import Plug.BasicAuth


  pipeline :auth do
    plug :basic_auth, Application.compile_env(:calendo, :basic_auth)
  end

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {CalendoWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  live_session :private, on_mount: {CalendoWeb.Live.InitAssigns, :private} do
    scope "/user", CalendoWeb.Admin do
      pipe_through :browser
      pipe_through :auth

      live "/", EventTypesLive
    end
  end

  live_session :public, on_mount: CalendoWeb.Live.InitAssigns do
    scope "/", CalendoWeb do
      pipe_through :browser

      live "/", PageLive
      live "/:event_type_slug", EventTypeLive
      live "/:event_type_slug/:time_slot", ScheduleEventLive
      live "/events/:event_type_slug/:event_id", EventsLive
    end
  end
end
