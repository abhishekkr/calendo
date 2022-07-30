defmodule CalendoWeb.ScheduleEventLive do
  use CalendoWeb, :live_view

  alias Calendo.Event

  def mount(%{"event_type_slug" => slug, "time_slot" => time_slot}, _session, socket) do
    with {:ok, event_type} <- Calendo.get_event_type_by_slug(slug),
         {:ok, start_at, _} <- DateTime.from_iso8601(time_slot) do
      duration = Timex.Duration.from_minutes(event_type.duration)
      end_at = Timex.add(start_at, duration)
      changeset = Event.changeset(%Event{}, %{})

      socket = socket
                |> assign(changeset: changeset)
                |> assign(end_at: end_at)
                |> assign(event_type: event_type)
                |> assign(start_at: start_at)

      {:ok, socket}
    else
      _ ->
        {:ok, socket, layout: {CalendoWeb.LayoutView, "not_found.html"}}
    end
  end
end
