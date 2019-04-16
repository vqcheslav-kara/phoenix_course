defmodule PhoenixCourse.Repo do
  use Ecto.Repo,
    otp_app: :phoenix_course,
    adapter: Ecto.Adapters.Postgres
end
