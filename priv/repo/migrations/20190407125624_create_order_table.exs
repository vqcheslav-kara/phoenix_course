defmodule PhoenixCourse.Repo.Migrations.CreateOrderTable do
  use Ecto.Migration

  def change do
    create table("orders") do
      add(:status, :text, null: false, default: "in_progress")
      add(:user_id, references(:users))
      timestamps()
    end
  end
end
