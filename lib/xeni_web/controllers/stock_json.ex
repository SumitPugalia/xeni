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

end
