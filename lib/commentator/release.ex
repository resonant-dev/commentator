defmodule Commentator.Release do
  @moduledoc false
  @app :commentator
  require Logger

  def migrate do
    Logger.info("Running migrations...")

    for repo <- repos() do
      Application.ensure_all_started(@app)
      {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :up, all: true))
    end
  end

  def rollback(repo, version) do
    Application.ensure_all_started(@app)

    {:ok, _, _} = Ecto.Migrator.with_repo(repo, &Ecto.Migrator.run(&1, :down, to: version))
  end

  defp repos do
    Application.load(@app)
    Application.fetch_env!(@app, :ecto_repos)
  end
end
