defmodule PhoenixCourseWeb.OrderView do
  use PhoenixCourseWeb, :view

  def users_for_select(users) do
    Enum.map(users, fn %{id: id, email: email} -> {email, id} end)
  end

  def products_for_select(users) do
    Enum.map(users, fn %{id: id, name: name} -> {name, id} end)
  end
end
