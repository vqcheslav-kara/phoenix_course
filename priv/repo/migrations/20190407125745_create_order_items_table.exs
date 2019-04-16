defmodule PhoenixCourse.Repo.Migrations.CreateOrderItemsTable do
  use Ecto.Migration

  def change do
    create table("order_items") do
      add(:order_id, references(:orders))
      add(:product_id, references(:products))
      timestamps()
    end
  end
end
