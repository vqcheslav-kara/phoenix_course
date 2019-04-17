defmodule PhoenixCourse.Product do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, warn: false
  alias PhoenixCourse.Repo
  alias PhoenixCourse.Category

  @timestamps_opts [type: :utc_datetime, usec: false]
  schema "products" do
    field(:name, :string)
    field(:price, :float)
    belongs_to(:category, Category)
    timestamps()
  end

  @doc false
  def changeset(category, attrs \\ %{}) do
    category
    |> cast(
      attrs,
      [
        :name,
        :price,
        :category_id
      ]
    )
    |> validate_required([
      :name,
      :price,
      :category_id
    ])
  end

  def new(params) do
    %__MODULE__{}
    |> changeset(params)
    |> Repo.insert()
  end

  def all() do
    Repo.all(__MODULE__)
  end

  def all_preloaded() do
    Repo.preload(all(), :category)
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
