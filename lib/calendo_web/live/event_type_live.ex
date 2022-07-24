defmodule CalendoWeb.EventTypeLive do
  use CalendoWeb, :live_view

  alias CalendoWeb.Components.EventType
  alias Timex.Duration

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

  @impl LiveView
  def handle_params(params, _uri, socket) do
    socket = assign_dates(socket, params)

    {:noreply, socket}
  end

  defp assign_dates(socket, params) do
    current = current_from_params(socket, params)
    month_start = Timex.beginning_of_month(current)
    month_end   = Timex.end_of_month(current)

    prev_month = month_start
                  |> Timex.add(Duration.from_days(-1))
                  |> date_to_month()
    next_month = month_end
                  |> Timex.add(Duration.from_days(1))
                  |> date_to_month()

    socket
    |> assign(current: current)
    |> assign(month_start: month_start)
    |> assign(month_end: month_end)
    |> assign(prev_month: prev_month)
    |> assign(next_month: next_month)
  end

  defp current_from_params(socket, %{"month" => month}) do
    do_current_from_params(socket, "#{month}-01")
  end
  defp current_from_params(socket, %{"date" => date}) do
    do_current_from_params(socket, date)
  end
  defp current_from_params(socket, _) do
    Timex.today(socket.assigns.time_zone)
  end
  defp do_current_from_params(socket, date) do
    case Timex.parse(date, "{YYYY}-{0M}-{D}") do
      {:ok, current} ->
        NaiveDateTime.to_date(current)
      _ ->
        Timex.today(socket.assigns.time_zone)
    end
  end

  defp date_to_month(date_time) do
    Timex.format!(date_time, "{YYYY}-{0M}")
  end
end
