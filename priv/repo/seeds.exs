# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Calendo.Repo.insert!(%Calendo.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.
#

alias Calendo.{EventType, Repo}

Repo.delete_all(EventType)

event_types = [
  %{
    name: "15 minute meeting",
    description: "Short meeting call.",
    slug: "15-min-meeting",
    duration: 15,
    color: "blue"
  },
  %{
    name: "30 minute meeting",
    description: "Extended meeting call.",
    slug: "30-min-meeting",
    duration: 30,
    color: "pink"
  },
  %{
    name: "An hour long discussion",
    description: "One hour of catch-up.",
    slug: "catchup-60",
    duration: 60,
    color: "purple"
  }
]

for event_type <- event_types do
  event_type
  |> EventType.changeset()
  |> Repo.insert!()
end
