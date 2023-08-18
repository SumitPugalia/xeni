defmodule XeniWeb.StockControllerTest do
  use XeniWeb.ConnCase

  describe "insert ohlc data" do
    test "successfully inserts ohlc data", %{conn: conn} do
      create_ohlc_attrs = %{
        "close" => 16.04,
        "high" => 29.13,
        "low" => 15.91,
        "open" => 26.83,
        "timestamp" => DateTime.utc_now() |> DateTime.to_string()
      }

      conn =
        conn
        |> post(~p"/api/insert", create_ohlc_attrs)

      assert %{
               "id" => id,
               "close" => 16.04,
               "high" => 29.13,
               "low" => 15.91,
               "open" => 26.83,
               "timestamp" => timestamp
             } = json_response(conn, 200)

      assert is_integer(id)
      assert timestamp |> IO.inspect()
    end

    test "erorrs to inserts ohlc data for missing data", %{conn: conn} do
      create_ohlc_attrs = %{}

      conn =
        conn
        |> post(~p"/api/insert", create_ohlc_attrs)

      assert %{
               "errors" => %{
                 "close" => ["can't be blank"],
                 "high" => ["can't be blank"],
                 "low" => ["can't be blank"],
                 "open" => ["can't be blank"],
                 "timestamp" => ["can't be blank"]
               }
             } == json_response(conn, 400)
    end

    test "erorrs to inserts ohlc data for invalid data", %{conn: conn} do
      create_ohlc_attrs = %{
        "close" => "invalid",
        "high" => "invalid",
        "low" => "invalid",
        "open" => "invalid",
        "timestamp" => "invalid"
      }

      conn =
        conn
        |> post(~p"/api/insert", create_ohlc_attrs)

      assert %{
               "errors" => %{
                 "close" => ["is invalid"],
                 "high" => ["is invalid"],
                 "low" => ["is invalid"],
                 "open" => ["is invalid"],
                 "timestamp" => ["is invalid"]
               }
             } == json_response(conn, 400)
    end
  end
end
