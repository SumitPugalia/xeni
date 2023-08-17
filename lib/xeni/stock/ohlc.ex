defmodule Xeni.Stock.OHLC do
  use Ecto.Schema
  import Ecto.Changeset

  schema "ohlcs" do
    field :close, :integer
    field :high, :integer
    field :low, :integer
    field :open, :integer
    field :timestamp, :integer

    timestamps()
  end

  @fields [:timestamp, :open, :high, :low, :close]
  @doc false
  def changeset(ohlc, attrs) do
    ohlc
    |> cast(attrs, @fields)
    |> validate_required(@fields)
  end
end
