defmodule Commentator.Notifier do
  @moduledoc false
  use Ash.Notifier

  def notify(%Ash.Notifier.Notification{
        resource: resource,
        action: %{type: :create}
      }) do
    Phoenix.PubSub.broadcast(Commentator.PubSub, resource, {__MODULE__, :create, nil})
  end

  def subscribe(topic) do
    Phoenix.PubSub.subscribe(Commentator.PubSub, topic)
  end

  def broadcast(pubsub, topic, payload) do
    Phoenix.PubSub.broadcast(pubsub, topic, %{
      topic: topic,
      payload: payload
    })
  end
end
