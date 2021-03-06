# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :commentator,
  ecto_repos: [Commentator.Repo]

config :commentator, ash_apis: [Commentator.Api]

config :mime, :types, %{
  "application/vnd.api+json" => ["json"]
}

# Configures the endpoint
config :commentator, CommentatorWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "SMM2SNmy4CFUGWH0NrC5mgAwnuQePgR+9b62Sl8lfCjxZc6jICNZKClWyjA99+7+",
  render_errors: [view: CommentatorWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: Commentator.PubSub,
  live_view: [signing_salt: "UmsOdxft"]

# Configures Elixir's Logger
config :logger, backends: [LoggerJSON]
config :commentator, Commentator.Repo, loggers: [{LoggerJSON.Ecto}, :log, [:info]]

config :logger_json, :backend,
  metadata: [:file, :line, :function, :module, :application, :httpRequest, :query],
  formatter: Commentator.LoggerFormatter

# Configures the mailer
#
# By default it uses the "Local" adapter which stores the emails
# locally. You can see the emails in your browser, at "/dev/mailbox".
#
# For production it's recommended to configure a different adapter
# at the `config/runtime.exs`.
config :commentator, Commentator.Mailer, adapter: Swoosh.Adapters.Local

config :surface, :components, [
  {Surface.Components.Form.ErrorTag,
   default_translator: {CommentatorWeb.ErrorHelpers, :translate_error}}
]

# Swoosh API client is needed for adapters other than SMTP.
config :swoosh, :api_client, false

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.12.18",
  default: [
    args: ~w(js/app.js --bundle --target=es2016 --outdir=../priv/static/assets),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason
config :phoenix, :logger, false

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
