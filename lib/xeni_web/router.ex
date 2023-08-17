defmodule XeniWeb.Router do
  use XeniWeb, :router

  @swagger_ui_config [
    path: "/api/openapi",
    default_model_expand_depth: 3,
    display_operation_id: true
  ]

  def swagger_ui_config, do: @swagger_ui_config

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {XeniWeb.Layouts, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]

    plug OpenApiSpex.Plug.PutApiSpec, module: XeniWeb.ApiSpec
  end

  scope "/" do
    pipe_through :browser

    get "/swaggerui", OpenApiSpex.Plug.SwaggerUI, @swagger_ui_config
  end

  scope "/api" do
    pipe_through :api

    get "/openapi", OpenApiSpex.Plug.RenderSpec, []
  end

  scope "/", XeniWeb do
    pipe_through :browser

    get "/", PageController, :home
  end

  scope "/api", XeniWeb do
    pipe_through :api

    post "/insert", StockController, :insert
    get "/average", StockController, :average
  end

  # Enable LiveDashboard and Swoosh mailbox preview in development
  if Application.compile_env(:xeni, :dev_routes) do
    # If you want to use the LiveDashboard in production, you should put
    # it behind authentication and allow only admins to access it.
    # If your application does not have an admins-only section yet,
    # you can use Plug.BasicAuth to set up some basic authentication
    # as long as you are also using SSL (which you should anyway).
    import Phoenix.LiveDashboard.Router

    scope "/dev" do
      pipe_through :browser

      live_dashboard "/dashboard", metrics: XeniWeb.Telemetry
      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
