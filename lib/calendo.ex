defmodule Calendo do
  @moduledoc """
  Calendo keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  defdelegate available_event_types,
    to: Calendo.EventType.Repo, as: :available

  defdelegate get_event_type_by_slug(slug),
    to: Calendo.EventType.Repo, as: :get_by_slug

  defdelegate build_time_slots(date, time_zone, duration),
    to: Calendo.TimeSlots, as: :build

  defdelegate insert_event(params),
    to: Calendo.Event.Repo, as: :insert

  defdelegate get_event_by_id(id),
    to: Calendo.Event.Repo, as: :get
end
