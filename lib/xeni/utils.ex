defmodule Xeni.Utils do
  def to_lowest_unit(value) when is_float(value), do: trunc(value * 100)
  def to_lowest_unit(value) when is_integer(value), do: value * 100
  def to_lowest_unit(value), do: value

  def to_unix(nil), do: nil

  def to_unix(value) do
    case DateTime.from_iso8601(value) do
      {:ok, datetime, _} -> DateTime.to_unix(datetime)
      _ -> value
    end
  end
end
