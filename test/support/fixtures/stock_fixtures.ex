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
        close: 3000,
        high: 4000,
        low: 1000,
        open: 2000,
        timestamp: System.os_time(:second)
      })
      |> Xeni.Stock.create_ohlc()

    ohlc
  end
end
