defmodule Commentator.Notifier do
  use Ash.Notifier

  def notify(
        %Ash.Notifier.Notification{
          resource: resource,
          action: %{type: :create}
        } = notification
      ) do
    IO.inspect(notification)
    Phoenix.PubSub.broadcast(Commentator.PubSub, resource, {__MODULE__, :create, nil})
  end

  def subscribe(topic) do
    IO.puts("subscribing to... #{topic}")
    Phoenix.PubSub.subscribe(Commentator.PubSub, topic)
  end

  def broadcast(pubsub, topic, payload) do
    IO.puts("broadcasting... #{topic}")
    IO.inspect(topic)

    Phoenix.PubSub.broadcast(pubsub, topic, %{
      topic: topic,
      payload: payload
    })
  end
end
