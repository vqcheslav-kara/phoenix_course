defmodule PhoenixCourseWeb.CategoryController do
  use PhoenixCourseWeb, :controller
  alias PhoenixCourse.Category

  def index(conn, _params) do
    categories = Category.all()

    conn
    |> assign(:categories, categories)
    |> render("index.html")
  end

  def new(conn, _params) do
    conn
    |> assign(:changeset, Category.changeset(%Category{}))
    |> render("new.html")
  end

  def create(conn, %{"category" => params}) do
    case Category.new(params) do
      {:ok, _} ->
        conn
        |> put_flash(
          :info,
          "Category created!"
        )
        |> redirect(to: Routes.category_path(conn, :index))

      {:error, changeset} ->
        conn
        |> assign(:changeset, changeset)
        |> render("new.html")
    end
  end

  def edit(conn, %{"id" => id}) do
    category = Category.get(id)
    changeset = Category.changeset(category)

    conn
    |> assign(:category, category)
    |> assign(:changeset, changeset)
    |> render("edit.html")
  end

  def update(conn, %{"id" => id, "category" => params}) do
    case Category.update_by_id(id, params) do
      {:ok, _} ->
        conn
        |> put_flash(
          :info,
          "Category updated!"
        )
        |> redirect(to: Routes.category_path(conn, :index))

      {:error, changeset} ->
        conn
        |> assign(:changeset, changeset)
        |> render("new.html")
    end
  end

  def delete(conn, %{"id" => id}) do
    case Category.delete_by_id(id) do
      {:ok, _} ->
        conn
        |> put_flash(
          :info,
          "Category deleted!"
        )
        |> redirect(to: Routes.category_path(conn, :index))

      {:error, changeset} ->
        conn
        |> assign(:changeset, changeset)
        |> render("new.html")
    end
  end
end
