defmodule XeniWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.

  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use XeniWeb, :controller

  # This clause handles errors returned by Ecto's insert/update/delete.
  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:bad_request)
    |> put_view(json: XeniWeb.ChangesetJSON)
    |> render(:error, changeset: changeset)
  end

  def call(conn, {:error, :not_found}) do
    conn
    |> put_status(:not_found)
    |> put_view(html: XeniWeb.ErrorHTML, json: XeniWeb.ErrorJSON)
    |> render(:"404")
  end

  def call(conn, {:error, :bad_request, message_string}) when is_binary(message_string) do
    conn
    |> put_status(:bad_request)
    |> put_view(json: XeniWeb.ErrorJSON)
    |> render("custom_error.json", message: message_string)
  end

  def call(conn, {:error, :bad_request}) do
    conn
    |> put_status(:bad_request)
    |> put_view(json: XeniWeb.ErrorJSON)
    |> render(:"400")
  end

  def call(conn, {:error, message}) when is_atom(message) do
    conn
    |> put_status(:bad_request)
    |> put_view(json: XeniWeb.ErrorJSON)
    |> render("custom_error.json", message: message |> to_string())
  end

  def call(conn, {:error, message_string}) when is_binary(message_string) do
    conn
    |> put_status(:bad_request)
    |> put_view(json: XeniWeb.ErrorJSON)
    |> render("custom_error.json", message: message_string)
  end
end
