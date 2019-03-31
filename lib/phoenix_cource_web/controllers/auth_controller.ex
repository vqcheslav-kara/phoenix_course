defmodule PhoenixCourceWeb.AuthController do
  use PhoenixCourceWeb, :controller

  alias PhoenixCource.{User, Guardian}

  def new(conn, _params) do
    render(conn, "index.html")
  end

  def login(conn, %{"email" => email, "password" => password}) do
    User.authenticate_user(email, password)
    |> login_reply(conn)
  end

  def logout(conn, _) do
    conn
    |> Guardian.Plug.sign_out()
    |> redirect(to: "/login")
  end

  defp login_reply({:ok, user}, conn) do
    IO.inspect(user)

    conn
    |> put_flash(:success, "Welcome back!")
    |> Guardian.Plug.sign_in(user)
    |> redirect(to: "/")
  end

  defp login_reply({:error, reason}, conn) do
    conn
    |> put_flash(:error, to_string(reason))
    |> new(%{})
  end
end
