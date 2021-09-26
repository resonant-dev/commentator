[
  import_deps: [:ecto, :phoenix, :ash, :ash_json_api, :ash_postgres, :ash_admin, :surface],
  inputs: ["*.{ex,exs}", "priv/*/seeds.exs", "{config,lib,test}/**/*.{ex,exs}"],
  subdirectories: ["priv/*/migrations"]
]
