defmodule XeniWeb.ApiSpec do
  alias OpenApiSpex.{Components, Info, OpenApi, Paths, Server, SecurityScheme}
  alias XeniWeb.{Endpoint, Router}
  @behaviour OpenApi

  @impl OpenApi
  def spec do
    %OpenApi{
      servers: [
        Server.from_endpoint(Endpoint)
      ],
      paths: Paths.from_router(Router),
      info: %Info{
        title: "Xeni",
        version: "1.0"
      },
      components: %Components{
        securitySchemes: %{
          "authorization" => %SecurityScheme{
            type: "apiKey",
            name: "Authorization",
            in: "header"
          }
        }
      }
    }
    # Discover request/response schemas from path specs
    |> OpenApiSpex.resolve_schema_modules()
  end
end
