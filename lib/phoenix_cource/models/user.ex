defmodule PhoenixCource.User do
  use Ecto.Schema
  import Ecto.Changeset
  import Ecto.Query, warn: false
  alias PhoenixCource.Repo

  @timestamps_opts [type: :utc_datetime, usec: false]
  schema "users" do
    field(:email, :string)
    field(:first_name, :string)
    field(:last_name, :string)
    field(:password, :string)
    field(:user_type, :string)
    timestamps()
  end

  @doc false
  def changeset(attrs \\ %{}) do
    %__MODULE__{}
    |> cast(
      attrs,
      [
        :password,
        :first_name,
        :last_name,
        :email,
        :user_type
      ],
      []
    )
    |> validate_required([
      :first_name,
      :last_name,
      :email,
      :user_type
    ])
    |> validate_length(:password, min: 6, max: 100)
    |> validate_inclusion(:user_type, ["admin", "customer"])
    |> unique_constraint(:email, name: "users_email")
    |> validate_confirmation(:password, message: "passwords don't match!")
    |> put_password_hash()
  end

  defp put_password_hash(
         %Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset
       ) do
    put_change(changeset, :password, Bcrypt.hash_pwd_salt(password))
  end

  defp put_password_hash(changeset) do
    changeset
  end

  def create(params, user_type \\ "customer") do
    params
    |> Map.put("user_type", user_type)
    |> changeset()
    |> Repo.insert()
  end

  def get_by_email(email) do
    Repo.get_by(__MODULE__, email: email)
  end

  def get_user!(id) do
    Repo.get!(__MODULE__, id)
  end

  def authenticate_user(email, plain_text_password) do
    case get_by_email(email) do
      nil ->
        Bcrypt.no_user_verify()
        {:error, :invalid_credentials}

      user ->
        IO.inspect(user)

        if Bcrypt.verify_pass(plain_text_password, user.password) do
          {:ok, user}
        else
          {:error, :invalid_credentials}
        end
    end
  end
end
