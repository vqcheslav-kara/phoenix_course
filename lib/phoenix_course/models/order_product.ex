defmodule PhoenixCourse.OrderProduct do
  use Ecto.Schema
  import Ecto.Query, warn: false

  @timestamps_opts [type: :utc_datetime, usec: false]
  schema "order_products" do
    field(:order_id, :integer)
    field(:product_id, :integer)
    timestamps()
  end
end
