defmodule CalendoWeb.EventTypeLive do
  use CalendoWeb, :live_view

  alias CalendoWeb.Components.EventType

  def mount(%{"event_type_slug" => _slug}, _session, socket) do
    {:ok, socket}
  end
end
