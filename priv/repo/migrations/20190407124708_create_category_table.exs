defmodule PhoenixCource.Repo.Migrations.CreateCategoryTable do
  use Ecto.Migration

  def change do
    create table("categories") do
      add(:name, :text, null: false)
      timestamps()
    end
  end
end
