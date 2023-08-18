defmodule XeniWeb.Spec.Stock do
  require OpenApiSpex
  alias OpenApiSpex.Schema

  defmodule OHLCRequest do
    OpenApiSpex.schema(%{
      type: :object,
      properties: %{
        timestamp: %Schema{type: :string, description: "DateTime with TimeZone"},
        open: %Schema{type: :float, description: "open data"},
        high: %Schema{type: :float, description: "high data"},
        low: %Schema{type: :float, description: "low data"},
        close: %Schema{type: :float, description: "close data"}
      },
      required: [
        :timestamp,
        :open,
        :high,
        :low,
        :close
      ],
      example: %{
        timestamp: "2021-09-01T08:00:00Z",
        open: 26.83,
        high: 29.13,
        low: 15.91,
        close: 16.04
      }
    })
  end

  defmodule OHLCResponse do
    OpenApiSpex.schema(%{
      type: :object,
      properties: %{
        id: %Schema{type: :string, description: "Employee Identifier"},
        timestamp: %Schema{type: :string, description: "DateTime with TimeZone"},
        open: %Schema{type: :float, description: "open data"},
        high: %Schema{type: :float, description: "high data"},
        low: %Schema{type: :float, description: "low data"},
        close: %Schema{type: :float, description: "close data"}
      },
      required: [
        :id,
        :timestamp,
        :open,
        :high,
        :low,
        :close
      ],
      example: %{
        id: 1,
        timestamp: "2021-09-01T08:00:00Z",
        open: 26.83,
        high: 29.13,
        low: 15.91,
        close: 16.04
      }
    })
  end

  defmodule MovingAverageResponse do
    OpenApiSpex.schema(%{
      type: :object,
      properties: %{
        total_moving_average: %Schema{type: :float, description: "total moving average"},
        open_moving_average: %Schema{type: :float, description: "open moving average"},
        high_moving_average: %Schema{type: :float, description: "high moving average"},
        close_moving_average: %Schema{type: :float, description: "cose moving average"},
        low_moving_average: %Schema{type: :float, description: "low moving average"}
      },
      required: [
        :total_moving_average,
        :open_moving_average,
        :high_moving_average,
        :close_moving_average,
        :low_moving_average
      ],
      example: %{
        total_moving_average: 26.83,
        open_moving_average: 26.83,
        high_moving_average: 26.83,
        close_moving_average: 26.83,
        low_moving_average: 26.83
      }
    })
  end
end
