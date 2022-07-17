defmodule CalendoWeb.Live.InitAssigns do
  import Phoenix.LiveView
  require Logger

  def on_mount(_default, _params, _session, socket) do
    owner = Application.get_env(:calendo, :owner)
    socket = assign(socket, :owner, owner)

    {:cont, socket}
  end
end

