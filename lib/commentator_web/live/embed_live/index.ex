defmodule CommentatorWeb.EmbedLive do
  use Surface.LiveView

  import AshPhoenix.LiveView
  alias Commentator.Api
  alias CommentatorWeb.Lib.{Comment, CommentForm}

  @impl true
  def render(assigns) do
    ~F"""
    <div class="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8">
      <div class="bg-white py-4 px-1">
        <h2 class="sr-only">Comments</h2>
        <div class="-my-4">
          {#for comment <- @comments}
            <Comment {=comment} />
          {#else}
            <div class="px-3 py-4 font-medium text-gray-500">No comments yet...</div>
          {/for}
        </div>
        <div class="border-t border-gray-200 mt-4 flex-1 py-4">
          <CommentForm id="new" />
        </div>
      </div>
    </div>
    """
  end

  @impl true
  def mount(_params, _session, socket) do
    {:ok,
     keep_live(socket, :comments, &fetch_comments/2, subscribe: "comment:created", results: :lose)}
  end

  @impl true
  def handle_info(%{topic: topic, payload: %Phoenix.Socket.Broadcast{}}, socket) do
    {:noreply, handle_live(socket, topic, :comments)}
  end

  def fetch_comments(_socket, _opts) do
    IO.puts("Running callback")
    test = Api.read!(Commentator.Comment)
    IO.puts("Got... #{length(test)}")
    test
  end
end
