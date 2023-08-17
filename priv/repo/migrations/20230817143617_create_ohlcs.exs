defmodule Xeni.Repo.Migrations.CreateOhlcs do
  use Ecto.Migration

  def change do
    create table(:ohlcs) do
      add :timestamp, :integer
      add :open, :integer
      add :high, :integer
      add :low, :integer
      add :close, :integer

      timestamps()
    end
  end
end
