defmodule PhoenixCourseWeb.PageController do
  use PhoenixCourseWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
