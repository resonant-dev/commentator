defmodule CommentatorWeb.Lib.CommentForm do
  use Surface.LiveComponent

  alias Surface.Components.Form
  alias Surface.Components.Form.{Field, Label, TextArea}

  alias Commentator.Comment

  data save_disabled, :boolean, default: true
  data form, :struct

  def render(assigns) do
    ~F"""
    <div class="text-sm text-gray-500 space-x-4">
      <Form for={@form} change="change" submit="submit">
          <Field name={:text}>
              <Label class="sr-only">
                  Comment
              </Label>
              <div class="mt-1 sm:mt-0 sm:col-span-2">
                  <TextArea
                      id="text"
                      rows={3}
                      class="shadow-sm block w-full focus:ring-indigo-500 focus:border-indigo-500 sm:text-sm border border-gray-300 rounded-md"
                      opts={placeholder: "Write a comment..."}
                  />
              </div>
          </Field>
          <div class="pt-5">
              <div class="flex justify-end">
                  <button
                      type="button"
                      :on-click="cancel"
                      class="bg-white py-2 px-4 border border-gray-300 rounded-md shadow-sm text-sm font-medium text-gray-700 hover:bg-gray-50 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500"
                  >
                      Cancel
                  </button>
                  <button
                      type="submit"
                      disabled={@save_disabled}
                      :on-click="submit"
                      class={
                        "ml-3 inline-flex justify-center py-2 px-4 border border-transparent shadow-sm text-sm font-medium rounded-md text-white",
                        "cursor-not-allowed bg-indigo-400": @save_disabled,
                        "bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500": !@save_disabled
                      }
                  >
                      Save
                  </button>
              </div>
          </div>
      </Form>
    </div>
    """
  end

  def mount(socket) do
    {:ok,
     assign(socket,
       form: new_form()
     )}
  end

  def handle_event("change", %{"form" => params}, socket) do
    form = AshPhoenix.Form.validate(socket.assigns.form, params)

    {:noreply,
     socket
     |> assign(:form, form)
     |> assign(:save_disabled, !form.valid?)}
  end

  def handle_event("cancel", _params, socket) do
    {:noreply,
     socket
     |> assign(:form, new_form())
     |> assign(:save_disabled, true)}
  end

  def handle_event("submit", _params, socket) do
    case AshPhoenix.Form.submit(socket.assigns.form) do
      {:ok, _result} ->
        {:noreply,
         socket
         |> assign(:form, new_form())
         |> assign(:save_disabled, true)}

      {:error, form} ->
        {:noreply, socket |> assign(:form, form)}
    end
  end

  defp new_form() do
    AshPhoenix.Form.for_create(Comment, :create, api: Commentator.Api)
  end
end
