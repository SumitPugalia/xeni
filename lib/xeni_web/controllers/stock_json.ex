defmodule XeniWeb.StockJSON do
  def insert(%{ohlc: ohlc}) do
    {:ok, dt} = ohlc.timestamp |> DateTime.from_unix()

    %{
      id: ohlc.id,
      timestamp: dt |> DateTime.to_string(),
      open: ohlc.open / 100,
      high: ohlc.high / 100,
      low: ohlc.low / 100,
      close: ohlc.close / 100
    }
  end

  def average(%{average: average}) do
    %{
      total_moving_average: average.total_moving_average / 100,
      open_moving_average: average.open_moving_average / 100,
      high_moving_average: average.high_moving_average / 100,
      close_moving_average: average.close_moving_average / 100,
      low_moving_average: average.low_moving_average / 100
    }
  end
end
