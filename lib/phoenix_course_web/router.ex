defmodule PhoenixCourseWeb.Router do
  use PhoenixCourseWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :auth do
    plug PhoenixCourse.GuardianPipeline
  end

  pipeline :ensure_auth do
    plug Guardian.Plug.EnsureAuthenticated
  end

  scope "/", PhoenixCourseWeb do
    pipe_through [:browser, :auth]
    get "/login", AuthController, :new
    post "/login", AuthController, :login
    get "/sign-in", UserController, :new
    post "/sign-in", UserController, :create
  end

  scope "/", PhoenixCourseWeb do
    pipe_through [:browser, :auth, :ensure_auth]
    get "/", PageController, :index
    resources "/categories", CategoryController
    resources "/products", ProductController
    resources "/orders", OrderController
    post "/logout", AuthController, :logout
  end

  # Other scopes may use custom stacks.
  # scope "/api", PhoenixCourseWeb do
  #   pipe_through :api
  # end
end
