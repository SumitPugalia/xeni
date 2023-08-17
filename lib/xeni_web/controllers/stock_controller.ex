defmodule XeniWeb.StockController do
  use XeniWeb, :controller
  use OpenApiSpex.ControllerSpecs

  alias XeniWeb.Spec
  alias Xeni.Stock
  alias Xeni.Utils

  action_fallback XeniWeb.FallbackController

  security [%{"authorization" => []}]

  ################################################################################################
  #  Insert OHLC data
  ################################################################################################

  operation :insert,
    summary: "Insert OHLC data",
    tags: ["OHLC"],
    description: "use when a new ohlc data is to be persisted",
    request_body:
      {"The ohlc attributes", "application/json", Spec.Stock.OHLCRequest, required: true},
    responses: [
      ok: {"OHLC", "application/json", Spec.Stock.OHLCResponse},
      bad_request: {"invalid request", "application/json", Spec.ErrorMessage}
    ]

  def insert(conn, params) do
    with  params <- transform(params),
      {:ok, created_ohlc} <- Stock.create_ohlc(params) do
        conn
        |> put_status(:ok)
        |> render(:insert, %{ohlc: created_ohlc})
    end
  end

  defp transform(params) do
    %{
      open: Map.get(params, "open") |> Utils.to_lowest_unit(),
      high: Map.get(params, "high") |> Utils.to_lowest_unit(),
      low: Map.get(params, "low") |> Utils.to_lowest_unit(),
      close: Map.get(params, "close") |> Utils.to_lowest_unit(),
      timestamp: Map.get(params, "timestamp") |> Utils.to_unix()
    }
  end

  ################################################################################################
  #  Average OHLC data
  ################################################################################################

  operation :average,
    summary: "Moving Average for OHLC data",
    tags: ["OHLC"],
    description: "use when moving average for ohlc data is to be retrieved based on params",
    parameters: [
      window: [in: :query, type: :string, description: "window to calculate moving average", example: "last_20_items"],
    ],
    responses: [
      ok: {"OHLC", "application/json", Spec.Stock.MovingAvergaeResponse},
      bad_request: {"invalid request", "application/json", Spec.ErrorMessage}
    ]

  def average(_conn, _params), do: {:error, :bad_request}
end
