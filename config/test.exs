import Config

# Configure your database
#
# The MIX_TEST_PARTITION environment variable can be used
# to provide built-in test partitioning in CI environment.
# Run `mix help test` for more information.
config :calendo, Calendo.Repo,
  adapter: Ecto.Adapters.SQLite3,
  username: "sqlite3",
  password: "sqlite3",
  hostname: "localhost",
  database: "calendo_test#{System.get_env("MIX_TEST_PARTITION")}",
  pool: Ecto.Adapters.SQL.Sandbox,
  pool_size: 10

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :calendo, CalendoWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "yRrsktaVJlzymVDDnsgWN7c/sWLMXLPxgR5t5nIruPZ2nhZuYJ+XsYlq0OqvDDiV",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
