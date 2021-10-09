defmodule CommentatorWeb.EmbedLive do
  @moduledoc false
  use Surface.LiveView

  import AshPhoenix.LiveView
  alias Commentator.Api
  alias CommentatorWeb.Lib.{Comment, CommentForm}

  @impl true
  def render(assigns) do
    ~F"""
    <div id="embed-live" :hook="EmbedLive" class="max-w-6xl mx-auto px-4 sm:px-6 lg:px-8">
      <div class="bg-white py-4 px-1">
        <h2 class="sr-only">Comments</h2>
        <div id="comment-list" class="-my-4">
          {#for comment <- @comments}
            <Comment {=comment} />
          {#else}
            <div class="px-3 py-4 font-medium text-gray-500">No comments yet...</div>
          {/for}
        </div>
        <div class="border-t border-gray-200 mt-4 flex-1 py-4">
          <CommentForm id="new" />
        </div>
        <div id="list-bottom" class="sr-only" />
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
  def handle_info(%{topic: topic, payload: payload}, socket) do
    {:noreply,
     socket
     |> push_event("post_submit", %{})
     |> handle_live(topic, :comments)}
  end

  def fetch_comments(_socket, _opts) do
    Commentator.Comment
    |> Ash.Query.sort(inserted_at: :asc)
    |> Api.read!()
  end
end
