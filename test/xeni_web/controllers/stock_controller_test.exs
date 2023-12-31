defmodule XeniWeb.StockControllerTest do
  use XeniWeb.ConnCase

  describe "insert ohlc data" do
    test "successfully inserts ohlc data", %{conn: conn} do
      now = DateTime.utc_now()

      create_ohlc_attrs = %{
        "close" => 16.04,
        "high" => 29.13,
        "low" => 15.91,
        "open" => 26.83,
        "timestamp" => now |> DateTime.to_string()
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

      {:ok, dt, _} = timestamp |> DateTime.from_iso8601()
      assert is_integer(id)
      assert dt |> DateTime.to_date() == DateTime.to_date(now)
      assert dt |> DateTime.to_time() == now |> DateTime.truncate(:second) |> DateTime.to_time()
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

  describe "average ohlc data" do
    test "gets average of ohlc data for nil data", %{conn: conn} do
      conn =
        conn
        |> get(~p"/api/average?window=last_1_hour")

      assert %{
               "close_moving_average" => nil,
               "high_moving_average" => nil,
               "low_moving_average" => nil,
               "open_moving_average" => nil,
               "total_moving_average" => nil
             } == json_response(conn, 200)

      conn =
        conn
        |> get(~p"/api/average?window=last_1_items")

      assert %{
               "close_moving_average" => nil,
               "high_moving_average" => nil,
               "low_moving_average" => nil,
               "open_moving_average" => nil,
               "total_moving_average" => nil
             } == json_response(conn, 200)
    end

    test "gets average of ohlc data by items count", %{conn: conn} do
      ## Latest
      ohlc_fixture(%{timestamp: System.os_time(:second)})
      ## 3 hours old
      ohlc_fixture(%{open: 10000, timestamp: System.os_time(:second) - 3 * 60 * 60})

      conn =
        conn
        |> get(~p"/api/average?window=last_2_items")

      assert %{
               "close_moving_average" => 30.0,
               "high_moving_average" => 40.0,
               "low_moving_average" => 10.0,
               "open_moving_average" => 60.0,
               "total_moving_average" => 35.0
             } == json_response(conn, 200)
    end

    test "gets average of ohlc data by hour", %{conn: conn} do
      ## Latest
      ohlc_fixture(%{timestamp: System.os_time(:second)})
      ## 3 hours old
      ohlc_fixture(%{open: 10000, timestamp: System.os_time(:second) - 3 * 60 * 60})

      conn =
        conn
        |> get(~p"/api/average?window=last_1_hour")

      assert %{
               "close_moving_average" => 30.0,
               "high_moving_average" => 40.0,
               "low_moving_average" => 10.0,
               "open_moving_average" => 20.0,
               "total_moving_average" => 25.0
             } == json_response(conn, 200)

      conn =
        conn
        |> get(~p"/api/average?window=last_4_hour")

      assert %{
               "close_moving_average" => 30.0,
               "high_moving_average" => 40.0,
               "low_moving_average" => 10.0,
               "open_moving_average" => 60.0,
               "total_moving_average" => 35.0
             } == json_response(conn, 200)
    end

    test "errors to get average of ohlc data by invalid window", %{conn: conn} do
      conn =
        conn
        |> get(~p"/api/average?window=last_2_item")

      assert %{"errors" => %{"detail" => "window is invalid"}} == json_response(conn, 400)

      conn =
        conn
        |> get(~p"/api/average?window=last_invalid_item")

      assert %{"errors" => %{"detail" => "window is invalid"}} == json_response(conn, 400)

      conn =
        conn
        |> get(~p"/api/average?window=last_invalid_hour")

      assert %{"errors" => %{"detail" => "window is invalid"}} == json_response(conn, 400)
    end
  end
end
