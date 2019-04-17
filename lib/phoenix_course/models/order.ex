defmodule PhoenixCourse.Order do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, warn: false
  alias PhoenixCourse.{Repo, User, Product, OrderProduct}

  @timestamps_opts [type: :utc_datetime, usec: false]
  schema "orders" do
    field(:status, :string)
    belongs_to(:user, User)
    many_to_many(:products, Product, join_through: OrderProduct, on_replace: :delete)
    timestamps()
  end

  @doc false
  def changeset(order, attrs \\ %{}) do
    changeset =
      order
      |> cast(
        attrs,
        [
          :status,
          :user_id
        ]
      )
      |> validate_required([
        :status,
        :user_id
      ])
      |> validate_inclusion(:status, ["in_progress", "confirmed", "received"])

    IO.inspect(attrs)

    case attrs do
      %{"products" => products} ->
        products_transformed = Enum.map(products, fn id -> Product.get(id) end)
        put_assoc(changeset, :products, products_transformed)

      _ ->
        changeset
    end
  end

  def new(params) do
    %__MODULE__{}
    |> changeset(params)
    |> Repo.insert()
  end

  def all() do
    __MODULE__
    |> Repo.all()
  end

  def all_preloaded() do
    all()
    |> Repo.preload([:products, :user])
  end

  def get(id) do
    Repo.get!(__MODULE__, id)
  end

  def get_preloaded(id) do
    get(id) |> Repo.preload([:products, :user])
  end

  def update_by_id(id, params) do
    id
    |> get_preloaded()
    |> changeset(params)
    |> Repo.update()
  end

  def delete_by_id(id) do
    id
    |> get()
    |> Repo.delete()
  end
end
