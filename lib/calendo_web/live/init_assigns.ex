defmodule CalendoWeb.Live.InitAssigns do
  import Phoenix.LiveView

  def on_mount(:default, _params, _session, socket) do
    owner = Application.get_env(:calendo, :owner)
    time_zone = get_connect_params(socket)["timezone"] || owner.time_zone

    socket = socket
              |> assign(:owner, owner)
              |> assign(:time_zone, time_zone)

    {:cont, socket}
  end
end

