defmodule PhoenixCource.Repo do
  use Ecto.Repo,
    otp_app: :phoenix_cource,
    adapter: Ecto.Adapters.Postgres
end
