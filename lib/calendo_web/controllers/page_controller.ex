defmodule CalendoWeb.PageController do
  use CalendoWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
