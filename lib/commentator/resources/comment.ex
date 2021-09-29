defmodule Commentator.Comment do
  use Ash.Resource,
    data_layer: AshPostgres.DataLayer,
    extensions: [
      AshJsonApi.Resource,
      AshAdmin.Resource
    ],
    notifiers: [Ash.Notifier.PubSub]

  postgres do
    table "comments"
    repo Commentator.Repo
  end

  attributes do
    uuid_primary_key :id

    attribute :text, :string do
      allow_nil? false
    end

    attribute :closed?, :boolean, allow_nil?: true, default: false
    attribute :deleted?, :boolean, allow_nil?: true, default: false

    create_timestamp :inserted_at
    update_timestamp :updated_at
  end

  actions do
    create :create
    read :read
    update :update
    destroy :destroy
  end

  pub_sub do
    module Commentator.Notifier
    prefix "comment"
    name Commentator.PubSub

    publish :create, "created"
  end

  json_api do
    type "comment"

    routes do
      base "/comments"

      get :read
      index :read
      post :create
      patch :update
      delete :destroy
    end
  end
end
