defmodule CommentatorWeb.PageController do
  use CommentatorWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
