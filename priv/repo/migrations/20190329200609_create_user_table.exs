defmodule PhoenixCource.Repo.Migrations.CreateUserTable do
  use Ecto.Migration

  def change do
    create table("users") do
      add(:first_name, :text, null: false)
      add(:last_name, :text, null: false)
      add(:email, :text, null: false)
      add(:password, :text, null: false)
      add(:user_type, :text, default: "customer", null: false)
      timestamps()
    end

    create(unique_index(:users, [:email], name: :users_email))
  end
end
