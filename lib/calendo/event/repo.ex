defmodule Calendo.Event.Repo do
  @moduledoc false

  alias Calendo.{Event, Repo}
  import Ecto.Query, only: [order_by: 2, where: 3]
  import Ecto.Query.API, only: [fragment: 1]

  def insert(params) do
    %Event{}
    |> Event.changeset(params)
    |> Repo.insert()
  end

  def get(id) do
    Event
    |> Repo.get(id)
    |> Repo.preload(:event_type)
    |> case do
      nil ->
        {:error, :not_found}
      event ->
        {:ok, event}
    end
  end

  def get_by_start_date(date) do
    Event
    |> where([e], fragment("date(?)", e.start_at) == ^date)
    |> order_by(:start_at)
    |> Repo.all()
  end
end
