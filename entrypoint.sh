#!/bin/bash
# docker entrypoint script.

# wait until Postgres is ready
while ! pg_isready -q -d $DATABASE_URL
do
  echo "$(date) - waiting for database to start"
  sleep 2
done

bin="/app/bin/commentator"
eval "$bin eval \"Commentator.Release.migrate\""
# start the elixir application
exec "$bin" "start"
