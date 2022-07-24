defmodule CalendoWeb.PageLive do
  use CalendoWeb, :live_view

  alias CalendoWeb.Components.EventType

  def mount(_params, _session, socket) do
    event_types = Calendo.available_event_types()
    event_socket = assign(socket, event_types: event_types)
    temp_assigns = [event_types: []]

    {:ok, event_socket, temporary_assigns: temp_assigns}
  end
end
