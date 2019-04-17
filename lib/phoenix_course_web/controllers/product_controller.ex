defmodule PhoenixCourseWeb.ProductController do
  use PhoenixCourseWeb, :controller
  alias PhoenixCourse.{Product, Category}

  def index(conn, _params) do
    products = Product.all_preloaded()

    conn
    |> assign(:products, products)
    |> render("index.html")
  end

  def new(conn, _params) do
    conn
    |> assign(:changeset, Product.changeset(%Product{}))
    |> assign(:categories, Category.all())
    |> render("new.html")
  end

  def create(conn, %{"product" => params}) do
    case Product.new(params) do
      {:ok, _} ->
        conn
        |> put_flash(
          :info,
          "Product created!"
        )
        |> redirect(to: Routes.product_path(conn, :index))

      {:error, changeset} ->
        conn
        |> assign(:changeset, changeset)
        |> assign(:categories, Category.all())
        |> render("new.html")
    end
  end

  def edit(conn, %{"id" => id}) do
    product = Product.get(id)
    changeset = Product.changeset(product)

    conn
    |> assign(:product, product)
    |> assign(:changeset, changeset)
    |> assign(:categories, Category.all())
    |> render("edit.html")
  end

  def update(conn, %{"id" => id, "product" => params}) do
    case Product.update_by_id(id, params) do
      {:ok, _} ->
        conn
        |> put_flash(
          :info,
          "Product updated!"
        )
        |> redirect(to: Routes.product_path(conn, :index))

      {:error, changeset} ->
        conn
        |> assign(:changeset, changeset)
        |> render("new.html")
    end
  end

  def delete(conn, %{"id" => id}) do
    case Product.delete_by_id(id) do
      {:ok, _} ->
        conn
        |> put_flash(
          :info,
          "Product deleted!"
        )
        |> redirect(to: Routes.product_path(conn, :index))

      {:error, changeset} ->
        conn
        |> assign(:changeset, changeset)
        |> render("new.html")
    end
  end
end
