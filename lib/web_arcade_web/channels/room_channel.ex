defmodule WebArcadeWeb.RoomChannel do
  use Phoenix.Channel

  alias WebArcade.Accounts

  def join("room:lobby", _message, socket) do
    {:ok, socket}
  end

  def join("room:" <> _private_room_id, _params, _socket) do
    {:error, %{reason: "unauthorized"}}
  end

  def handle_in("new_msg", %{"body" => body}, socket) do
    user_id = socket.assigns.current_user
    current_user = Accounts.get_user!(user_id)

    if current_user do
      user_email = current_user.email
      broadcast!(socket, "draw_rectangle", %{})
      broadcast!(socket, "new_msg", %{body: "#{user_email}\n#{body}"})
    end

    {:noreply, socket}
  end

  def handle_in("specebar_pressed", _payload, socket) do
    IO.inspect("specebar_pressed")
    # broadcast!(socket, "draw_rectangle", %{})
    {:noreply, socket}
  end
end
