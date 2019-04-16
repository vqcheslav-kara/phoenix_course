defmodule PhoenixCourse.Repo.Migrations.CreateProductTable do
  use Ecto.Migration

  def change do
    create table("products") do
      add(:name, :text, null: false)
      add(:price, :float, null: false)
      add(:category_id, references(:categories))
      timestamps()
    end
  end
end
