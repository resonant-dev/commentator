defmodule Commentator.Repo do
  use Ecto.Repo,
    otp_app: :commentator,
    adapter: Ecto.Adapters.Postgres
end
