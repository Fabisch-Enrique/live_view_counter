import Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :live_view_counter, LiveViewCounterWeb.Endpoint,
  http: [ip: {127, 0, 0, 1}, port: 4002],
  secret_key_base: "JiN5x0XZ0bQmw30dvy9cNIg6+ne8F3n8uoNcREbsgP4CJ2z5GgEck90KD6aUXAQM",
  server: false

# In test we don't send emails.
config :live_view_counter, LiveViewCounter.Mailer,
  adapter: Swoosh.Adapters.Test

# Print only warnings and errors during test
config :logger, level: :warn

# Initialize plugs at runtime for faster test compilation
config :phoenix, :plug_init_mode, :runtime
