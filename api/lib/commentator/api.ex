defmodule Commentator.Api do
  use Ash.Api,
    extensions: [
      AshJsonApi.Api
    ]

  resources do
    resource Commentator.Comment
    resource Commentator.User
  end
end
