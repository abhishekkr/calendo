defmodule Calendo.EventType.Repo do
  @moduledoc false

  alias Calendo.{EventType, Repo}
  import Ecto.Query, only: [order_by: 3]

  def available do
    EventType
    |> order_by([e], e.name)
    |> Repo.all()
  end
end
