defmodule CalendoWeb.LiveViewHelpers do
  def class_list(items) do
    items
    |> Enum.reject(&(elem(&1, 1) == false))
    |> Enum.map(&elem(&1, 0))
    |> Enum.join(" ")
  end

  def schedule_string(start_at, end_at, time_zone) do
    slot_start_str = format_time_str(start_at, time_zone)
    slot_end_str = format_time_str(end_at, time_zone)
    date_str = format_date_str(start_at, time_zone)
    "#{slot_start_str} - #{slot_end_str}, #{date_str}"
  end

  defp format_time_str(tym, time_zone) do
    tym
    |> DateTime.shift_zone!(time_zone)
    |> Timex.format!("{h24}:{m}")
  end

  defp format_date_str(dat, time_zone) do
    dat
    |> DateTime.shift_zone!(time_zone)
    |> Timex.format!("{WDfull}, {Mfull} {D}, {YYYY}")
  end
end
