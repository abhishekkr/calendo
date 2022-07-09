defmodule Calendo.Repo do
  use Ecto.Repo,
    otp_app: :calendo,
    adapter: Ecto.Adapters.SQLite3
end
