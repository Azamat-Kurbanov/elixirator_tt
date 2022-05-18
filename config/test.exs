import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :elixirator_tt, ElixiratorTtWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "OQzvEKJu4+WviZqFJYQ6kvEP288/kW2f/pjct+rnOwMOIhcNs+YAm+JYb6X+2a7P",
  server: false

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
