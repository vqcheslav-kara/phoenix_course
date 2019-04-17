defmodule PhoenixCourseWeb.ProductView do
  use PhoenixCourseWeb, :view

  defp categories_for_select(categories) do
    Enum.map(categories, fn %{id: id, name: name} -> {name, id} end)
  end
end
