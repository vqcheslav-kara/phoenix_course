defmodule PhoenixCource.GuardianErrorHandler do
  import Plug.Conn
  use PhoenixCourceWeb, :controller
  @behaviour Guardian.Plug.ErrorHandler

  @impl Guardian.Plug.ErrorHandler
  def auth_error(conn, _, _opts) do
    redirect(conn, to: Routes.auth_path(conn, :new))
  end
end
