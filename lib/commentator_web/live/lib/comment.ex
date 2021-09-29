defmodule CommentatorWeb.Lib.Comment do
  use Surface.Component

  prop first, :boolean
  prop comment, :struct

  def render(assigns) do
    ~F"""
    <div class="flex text-sm text-gray-500 space-x-4">
            <div class="flex-none py-4">
                <img
                  src="https://images.unsplash.com/photo-1502685104226-ee32379fefbe?ixlib=rb-=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=facearea&facepad=8&w=256&h=256&q=80"
                  alt=""
                  class="p-0 w-10 h-10 bg-gray-100 rounded-full"
                />
                {!--<img src={avatarSrc} alt="" className="w-10 h-10 bg-gray-100 rounded-full" />--}
            </div>
            {!-- <div class={classNames(first ? '' : 'border-t border-gray-200', 'flex-1 py-4')}> --}
            <div class="border-t border-gray-200 flex-1 py-4">
                <h3 class="font-medium text-gray-900">User Name</h3>
                <p>
                  <time dateTime={@comment.inserted_at}>{Timex.format!(@comment.inserted_at, "%B %d, %Y", :strftime)}</time>
                </p>
                <div class="mt-4 prose prose-sm max-w-none text-gray-500">
                    {@comment.text}
                </div>
            </div>
        </div>
    """
  end
end
