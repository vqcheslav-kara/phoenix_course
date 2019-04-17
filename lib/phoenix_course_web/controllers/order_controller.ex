defmodule PhoenixCourseWeb.OrderController do
  use PhoenixCourseWeb, :controller
  alias PhoenixCourse.{Order, User, Product}

  def index(conn, _params) do
    orders = Order.all_preloaded()

    conn
    |> assign(:orders, orders)
    |> render("index.html")
  end

  def new(conn, _params) do
    conn
    |> assign(:changeset, Order.changeset(%Order{products: []}))
    |> assign(:users, User.all())
    |> assign(:products, Product.all())
    |> render("new.html")
  end

  def create(conn, %{"order" => params}) do
    case Order.new(params) do
      {:ok, _} ->
        conn
        |> put_flash(
          :info,
          "Order created!"
        )
        |> redirect(to: Routes.order_path(conn, :index))

      {:error, changeset} ->
        conn
        |> assign(:users, User.all())
        |> assign(:products, Product.all())
        |> assign(:changeset, changeset)
        |> render("new.html")
    end
  end

  def edit(conn, %{"id" => id}) do
    order = Order.get_preloaded(id)
    changeset = Order.changeset(order)

    conn
    |> assign(:order, order)
    |> assign(:users, User.all())
    |> assign(:products, Product.all())
    |> assign(:changeset, changeset)
    |> render("edit.html")
  end

  def update(conn, %{"id" => id, "order" => params}) do
    case Order.update_by_id(id, params) do
      {:ok, _} ->
        conn
        |> put_flash(
          :info,
          "Order updated!"
        )
        |> redirect(to: Routes.order_path(conn, :index))

      {:error, changeset} ->
        conn
        |> assign(:changeset, changeset)
        |> render("new.html")
    end
  end

  def delete(conn, %{"id" => id}) do
    case Order.delete_by_id(id) do
      {:ok, _} ->
        conn
        |> put_flash(
          :info,
          "Order deleted!"
        )
        |> redirect(to: Routes.order_path(conn, :index))

      {:error, changeset} ->
        conn
        |> assign(:changeset, changeset)
        |> render("new.html")
    end
  end
end
