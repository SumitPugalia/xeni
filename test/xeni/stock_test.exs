defmodule Xeni.StockTest do
  use Xeni.DataCase

  alias Xeni.Stock

  describe "ohlcs" do
    alias Xeni.Stock.OHLC

    import Xeni.StockFixtures

    @invalid_attrs %{close: nil, high: nil, low: nil, open: nil, timestamp: nil}

    test "list_ohlcs/0 returns all ohlcs" do
      ohlc = ohlc_fixture()
      assert Stock.list_ohlcs() == [ohlc]
    end

    test "get_ohlc!/1 returns the ohlc with given id" do
      ohlc = ohlc_fixture()
      assert Stock.get_ohlc!(ohlc.id) == ohlc
    end

    test "create_ohlc/1 with valid data creates a ohlc" do
      valid_attrs = %{close: 42, high: 42, low: 42, open: 42, timestamp: 42}

      assert {:ok, %OHLC{} = ohlc} = Stock.create_ohlc(valid_attrs)
      assert ohlc.close == 42
      assert ohlc.high == 42
      assert ohlc.low == 42
      assert ohlc.open == 42
      assert ohlc.timestamp == 42
    end

    test "create_ohlc/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Stock.create_ohlc(@invalid_attrs)
    end

    test "update_ohlc/2 with valid data updates the ohlc" do
      ohlc = ohlc_fixture()
      update_attrs = %{close: 43, high: 43, low: 43, open: 43, timestamp: 43}

      assert {:ok, %OHLC{} = ohlc} = Stock.update_ohlc(ohlc, update_attrs)
      assert ohlc.close == 43
      assert ohlc.high == 43
      assert ohlc.low == 43
      assert ohlc.open == 43
      assert ohlc.timestamp == 43
    end

    test "update_ohlc/2 with invalid data returns error changeset" do
      ohlc = ohlc_fixture()
      assert {:error, %Ecto.Changeset{}} = Stock.update_ohlc(ohlc, @invalid_attrs)
      assert ohlc == Stock.get_ohlc!(ohlc.id)
    end

    test "delete_ohlc/1 deletes the ohlc" do
      ohlc = ohlc_fixture()
      assert {:ok, %OHLC{}} = Stock.delete_ohlc(ohlc)
      assert_raise Ecto.NoResultsError, fn -> Stock.get_ohlc!(ohlc.id) end
    end

    test "change_ohlc/1 returns a ohlc changeset" do
      ohlc = ohlc_fixture()
      assert %Ecto.Changeset{} = Stock.change_ohlc(ohlc)
    end
  end
end
