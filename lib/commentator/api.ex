defmodule Commentator.Api do
  @moduledoc false
  use Ash.Api,
    extensions: [
      AshJsonApi.Api,
      AshAdmin.Api
    ]

  resources do
    resource Commentator.Comment
    resource Commentator.User
  end

  admin do
    show? true
  end
end
