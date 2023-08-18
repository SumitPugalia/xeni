defmodule Xeni.StockFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `Xeni.Stock` context.
  """

  @doc """
  Generate a ohlc.
  """
  def ohlc_fixture(attrs \\ %{}) do
    {:ok, ohlc} =
      attrs
      |> Enum.into(%{
        close: 1000,
        high: 2000,
        low: 3000,
        open: 4000,
        timestamp: System.os_time(:second)
      })
      |> Xeni.Stock.create_ohlc()

    ohlc
  end
end
