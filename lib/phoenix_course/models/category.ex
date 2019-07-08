defmodule PhoenixCourse.Category do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, warn: false
  alias PhoenixCourse.Repo

  @timestamps_opts [type: :utc_datetime, usec: false]
  schema "categories" do
    field(:name, :string)
    timestamps()
  end

  @doc false
  def changeset(category, attrs \\ %{}) do
    category
    |> cast(attrs, [:name])
    |> validate_required([:name])
    |> unique_constraint(:name, name: "categories_name")
  end

  def new(params) do
    %__MODULE__{}
    |> changeset(params)
    |> Repo.insert()
  end

  def all() do
    Repo.all(__MODULE__)
  end

  def get(id) do
    Repo.get!(__MODULE__, id)
  end

  def update_by_id(id, params) do
    id
    |> get()
    |> changeset(params)
    |> Repo.update()
  end

  def delete_by_id(id) do
    id
    |> get()
    |> Repo.delete()
  end
end
