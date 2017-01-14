# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :portfolio,
  ecto_repos: [Portfolio.Repo]

# Configures the endpoint
config :portfolio, Portfolio.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "Rpl4kq3ccpoQVLfWtP8V2Iccgpu0YR/PxKNSeUrm0FV05c+CeLlzAa9rTZwePY1M",
  render_errors: [view: Portfolio.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Portfolio.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
