# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :calendo,
  ecto_repos: [Calendo.Repo],
 ## Temp, should be in DB later.. dynamic
  basic_auth: [username: "admin", password: "changeit"],
  owner: %{
    name: "AbhishekKr",
    time_zone: "Asia/Kolkata",
    day_start: 10,
    day_end: 19,
  }

# Configures the endpoint
config :calendo, CalendoWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [view: CalendoWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Calendo.PubSub,
  live_view: [signing_salt: "8LgSX5AJ"]

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.14.29",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
