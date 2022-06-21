defmodule GithubWeb.UsersView do
  use GithubWeb, :view

  def render("users.json", %{repos: repos}) do
    %{data: render_many(repos, __MODULE__, "user.json")}
  end

  def render("user.json", %{users: repos}) do
    %{
      "id" => repos.id,
      "name" => repos.name,
      "description" => repos.description,
      "html_url" => repos.html_url,
      "stargazers_count" => repos.stargazers_count
    }
  end
end
