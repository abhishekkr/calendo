defmodule CalendoWeb.Live.InitAssigns do
  import Phoenix.LiveView

  def on_mount(:default, _params, _session, socket) do
    socket = socket |> assign_user(:owner)
    {:cont, socket}
  end

  def on_mount(:private, _params, _session, socket) do
    socket = socket |> assign_user(:owner)
    {:cont, socket}
  end

  defp assign_user(socket, :owner) do
    owner = Application.get_env(:calendo, :owner)
    time_zone = get_connect_params(socket)["timezone"] || owner.time_zone

    socket
    |> assign(:owner, owner)
    |> assign(:time_zone, time_zone)
  end
end

