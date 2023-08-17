defmodule XeniWeb.Spec.ErrorMessage do
  require OpenApiSpex
  alias OpenApiSpex.Schema

  OpenApiSpex.schema(%{
    title: "error",
    type: :object,
    properties: %{
      errors: %Schema{type: :object, description: "Error message"}
    }
  })
end
