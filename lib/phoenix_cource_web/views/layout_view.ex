defmodule PhoenixCourceWeb.LayoutView do
  use PhoenixCourceWeb, :view

  def active_link(conn, controllers) when is_list(controllers) do
    if Enum.member?(controllers, Phoenix.Controller.controller_module(conn)) do
      "active"
    else
      ""
    end
  end

  def active_link(conn, controller) do
    active_link(conn, [controller])
  end
end
