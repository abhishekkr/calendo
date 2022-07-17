defmodule CalendoWeb.EventTypeLive do
  use CalendoWeb, :live_view

  alias CalendoWeb.Components.EventType

  def mount(%{"event_type_slug" => slug}, _session, socket) do
    case Calendo.get_event_type_by_slug(slug) do
      {:ok, event_type} ->
        socket = socket
                 |> assign(event_type: event_type)
                 |> assign(page_title: event_type.name)
        {:ok, socket}
      {:error, :not_found} ->
        {:ok, socket, layout: {CalendoWeb.LayoutView, "not_found.html"}}
    end
  end
end
