defmodule GithubWeb.UserController do
  use GithubWeb, :controller

  def index(conn, %{"username" => username}) do
    case Github.get_user_by_name(username) do
      {:ok, repos} ->
        conn
        |> put_status(:ok)
        |> put_view(GithubWeb.UsersView)
        |> render("users.json", repos: repos)

      {:error, message} ->
        conn
        |> put_status(:bad_request)
        |> put_view(GithubWeb.ErrorView)
        |> render("error.json", message: message)
    end
  end
end
