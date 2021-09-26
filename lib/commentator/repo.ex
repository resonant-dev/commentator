defmodule Commentator.Repo do
  use AshPostgres.Repo,
    otp_app: :commentator
end
