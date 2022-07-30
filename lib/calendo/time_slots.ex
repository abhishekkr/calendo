defmodule Calendo.TimeSlots do
  @moduledoc false

  @default_day_start 9   # for 9-to-5
  @default_day_end   17  # for 9-to-5

  @spec build(Date.t(), String.t(), non_neg_integer) :: [DateTime.t()]
  def build(date, time_zone, duration) do
    from = date
            |> Timex.to_datetime(time_zone)
            |> Timex.set(hour: day_start())
    to = Timex.set(from, hour: day_end())

    from
    |> Stream.iterate(&DateTime.add(&1, duration * 60, :second))
    |> Stream.take_while(&(DateTime.diff(to, &1) > 0))
    |> Enum.to_list()
  end

  defp day_start, do: Application.get_env(:calendo, :owner)[:day_start] || @default_day_start
  defp day_end, do: Application.get_env(:calendo, :owner)[:day_end] || @default_day_end
end
