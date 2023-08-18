defmodule Xeni.UtilsTest do
  use Xeni.DataCase
  alias Xeni.Utils

  describe "to_lowest_unit" do
    test "to_lowest_unit/1 converts a float to lowest unit" do
      assert Utils.to_lowest_unit(123.15) == 12315
    end

    test "to_lowest_unit/1 converts a integer to lowest unit" do
      assert Utils.to_lowest_unit(123) == 12300
    end

    test "to_lowest_unit/1 returns nil for nil input" do
      assert is_nil(Utils.to_lowest_unit(nil))
    end

    test "to_lowest_unit/1 returns unchanges value for invalid input" do
      assert Utils.to_lowest_unit("asd") == "asd"
    end
  end

  describe "to_unix" do
    test "to_unix/1 converts a iso datetime to unix" do
      assert Utils.to_unix("2021-09-01T08:00:00Z") == 1_630_483_200
    end

    test "to_unix/1 returns nil for nil input" do
      assert is_nil(Utils.to_unix(nil))
    end

    test "to_unix/1 returns unchanges value for invalid input" do
      assert Utils.to_unix("invalid") == "invalid"
    end
  end
end
