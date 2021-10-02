defmodule Commentator.User do
  @moduledoc false
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer,
    extensions: [
      AshJsonApi.Resource
    ]

  postgres do
    table "users"
    repo Commentator.Repo
  end

  attributes do
    uuid_primary_key :id

    attribute :email, :string, allow_nil?: false
    attribute :first_name, :string, allow_nil?: false
    attribute :last_name, :string, allow_nil?: false
  end

  actions do
    create :create
    read :read
    update :update
    destroy :destroy
  end

  json_api do
    type "user"

    routes do
      base "/users"

      get :read
      index :read
      post :create
      patch :update
      delete :destroy
    end
  end
end
