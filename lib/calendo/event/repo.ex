defmodule Calendo.Event.Repo do
  @moduledoc false

  alias Calendo.{Event, Repo}

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
end
