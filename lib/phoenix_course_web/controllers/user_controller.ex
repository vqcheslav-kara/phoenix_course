defmodule PhoenixCourseWeb.UserController do
  use PhoenixCourseWeb, :controller
  alias PhoenixCourse.User

  def new(conn, _params) do
    conn
    |> assign(:errors, [])
    |> put_layout("auth.html")
    |> render("new.html")
  end

  def create(conn, params) do
    case User.create(params) do
      {:ok, _} ->
        conn
        |> put_flash(
          :info,
          "Account has been created you can login with your email and password!"
        )
        |> redirect(to: Routes.auth_path(conn, :new))

      {:error, %{errors: errors}} ->
        conn
        |> assign(:errors, errors)
        |> render("new.html")
    end
  end
end
