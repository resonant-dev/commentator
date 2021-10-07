import Config

# config/runtime.exs is executed for all environments, including
# during releases. It is executed after compilation and before the
# system starts, so it is typically used to load production configuration
# and secrets from environment variables or elsewhere. Do not define
# any compile-time configuration in here, as it won't be applied.
# The block below contains prod specific runtime configuration.
if config_env() == :prod do
  database_url =
    System.get_env("DATABASE_ECTO_URL") ||
      raise """
      environment variable DATABASE_ECTO_URL is missing.
      For example: ecto://USER:PASS@HOST/DATABASE
      """

  config :commentator, Commentator.Repo,
    # socket_options: [:inet6],
    ssl: true,
    ssl_opts: [certfile: "priv/certs/ca-certificate.crt"],
    url: database_url,
    maintenance_database: "defaultdb",
    pool_size: String.to_integer(System.get_env("POOL_SIZE") || "10")

  secret_key_base =
    System.get_env("SECRET_KEY_BASE") ||
      raise """
      environment variable SECRET_KEY_BASE is missing.
      You can generate one by calling: mix phx.gen.secret
      """

  config :commentator, CommentatorWeb.Endpoint,
    http: [
      # Enable IPv6 and bind on all interfaces.
      # Set it to  {0, 0, 0, 0, 0, 0, 0, 1} for local network only access.
      # See the documentation on https://hexdocs.pm/plug_cowboy/Plug.Cowboy.html
      # for details about using IPv6 vs IPv4 and loopback vs public addresses.
      ip: {0, 0, 0, 0, 0, 0, 0, 0},
      port: String.to_integer(System.get_env("PORT") || "4000")
    ],
    url: [
      host: System.get_env("HOSTNAME", "commentator.resonant.dev"),
      port: String.to_integer(System.get_env("HOST_PORT", "443")),
      scheme: "https"
    ],
    secret_key_base: secret_key_base,
    server: true,
    check_origin: ["//commentator.resonant.dev", "//commentator.sbx1.resonant.dev"]

  # ## Using releases
  #
  # If you are doing OTP releases, you need to instruct Phoenix
  # to start each relevant endpoint:
  #
  #     config :commentator, CommentatorWeb.Endpoint, server: true
  #
  # Then you can assemble a release by calling `mix release`.
  # See `mix help release` for more information.

  # ## Configuring the mailer
  #
  # In production you need to configure the mailer to use a different adapter.
  # Also, you may need to configure the Swoosh API client of your choice if you
  # are not using SMTP. Here is an example of the configuration:
  #
  #     config :commentator, Commentator.Mailer,
  #       adapter: Swoosh.Adapters.Mailgun,
  #       api_key: System.get_env("MAILGUN_API_KEY"),
  #       domain: System.get_env("MAILGUN_DOMAIN")
  #
  # For this example you need include a HTTP client required by Swoosh API client.
  # Swoosh supports Hackney and Finch out of the box:
  #
  #     config :swoosh, :api_client, Swoosh.ApiClient.Hackney
  #
  # See https://hexdocs.pm/swoosh/Swoosh.html#module-installation for details.
end
