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

config :ueberauth, Ueberauth,
  providers: [
    github: { Ueberauth.Strategy.Github, [] },
    twitter: { Ueberauth.Strategy.Twitter, [] }
  ]

config :ueberauth, Ueberauth.Strategy.Github.OAuth,
  client_id: "f7967f56fc96702fb75f",
  client_secret: "00dd4658f8944706a59a0f6b3ddb15196d9ec025"

config :ueberauth, Ueberauth.Strategy.Twitter.OAuth,
  consumer_key: "jXpWfluhwYz68sT6wlLq93I9r",
  consumer_secret: "pJBRJwc1bMAgufx2yXJh8t8dI9qJ3MkUXagblMly4uA3byIxqF"

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
