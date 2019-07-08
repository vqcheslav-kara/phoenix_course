defmodule PhoenixCourseWeb.Api.AuthController do
  use PhoenixCourseWeb, :controller

  alias PhoenixCourse.{User, Guardian}
  plug :put_layout, "auth.html"

  def login(conn, %{"email" => email, "password" => password}) do
    email
    |> User.authenticate_user(password)
    |> login_reply(conn)
  end

  def logout(conn, _) do
    Guardian.Plug.sign_out(conn)

    text(conn, "logout")
  end

  def profile(conn, _) do
    user = Guardian.Plug.current_resource(conn)

    json(conn, %{email: user.email})
  end

  defp login_reply({:ok, user}, conn) do
    jwt =
      conn
      |> Guardian.Plug.sign_in(user)
      |> Guardian.Plug.current_token()

    json(conn, %{token: jwt})
  end

  defp login_reply({:error, reason}, conn) do
    text(conn, "error: #{reason}")
  end
end
