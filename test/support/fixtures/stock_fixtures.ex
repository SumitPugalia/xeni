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
        close: 42,
        high: 42,
        low: 42,
        open: 42,
        timestamp: 42
      })
      |> Xeni.Stock.create_ohlc()

    ohlc
  end
end
