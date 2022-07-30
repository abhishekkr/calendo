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

  def handle_event("submit", %{"event" => event}, %{assigns: assigns} = socket) do
    %{event_type: event_type} = assigns
    event
    |> persist_event(assigns)
    |> Calendo.insert_event()
    |> case do
      {:ok, event} ->
        ok_path = Routes.live_path(
          socket,
          CalendoWeb.EventsLive,
          event_type.slug,
          event.id
        )
        {:noreply, push_redirect(socket, to: ok_path)}

      {:error, changeset} ->
        IO.inspect changeset
        {:noreply, assign(socket, changeset: changeset)}
    end
  end

  defp persist_event(
    event,
    %{
        end_at: end_at,
        event_type: event_type,
        start_at: start_at,
        time_zone: time_zone
    } = _assigns
  ) do
    event
    |> Map.put("end_at", end_at)
    |> Map.put("event_type_id", event_type.id)
    |> Map.put("start_at", start_at)
    |> Map.put("time_zone", time_zone)
  end
end
