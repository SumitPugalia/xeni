defmodule Xeni.Stock do
  @moduledoc """
  The Stock context.
  """

  import Ecto.Query, warn: false
  alias Xeni.Repo

  alias Xeni.Stock.OHLC

  @doc """
  Returns the list of ohlcs.

  ## Examples

      iex> list_ohlcs()
      [%OHLC{}, ...]

  """
  def list_ohlcs do
    Repo.all(OHLC)
  end

  @doc """
  Gets a single ohlc.

  Raises `Ecto.NoResultsError` if the Ohlc does not exist.

  ## Examples

      iex> get_ohlc!(123)
      %OHLC{}

      iex> get_ohlc!(456)
      ** (Ecto.NoResultsError)

  """
  def get_ohlc!(id), do: Repo.get!(OHLC, id)

  @doc """
  Creates a ohlc.

  ## Examples

      iex> create_ohlc(%{field: value})
      {:ok, %OHLC{}}

      iex> create_ohlc(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create_ohlc(attrs \\ %{}) do
    %OHLC{}
    |> OHLC.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a ohlc.

  ## Examples

      iex> update_ohlc(ohlc, %{field: new_value})
      {:ok, %OHLC{}}

      iex> update_ohlc(ohlc, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update_ohlc(%OHLC{} = ohlc, attrs) do
    ohlc
    |> OHLC.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a ohlc.

  ## Examples

      iex> delete_ohlc(ohlc)
      {:ok, %OHLC{}}

      iex> delete_ohlc(ohlc)
      {:error, %Ecto.Changeset{}}

  """
  def delete_ohlc(%OHLC{} = ohlc) do
    Repo.delete(ohlc)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking ohlc changes.

  ## Examples

      iex> change_ohlc(ohlc)
      %Ecto.Changeset{data: %OHLC{}}

  """
  def change_ohlc(%OHLC{} = ohlc, attrs \\ %{}) do
    OHLC.changeset(ohlc, attrs)
  end
end
