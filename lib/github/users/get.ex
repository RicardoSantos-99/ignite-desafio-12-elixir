defmodule Github.Users.Get do
  use Tesla

  alias Tesla.Env
  alias Github.Error

  @request_headers [{"user-agent", "Tesla"}]

  plug Tesla.Middleware.Headers, @request_headers
  plug Tesla.Middleware.BaseUrl, "https://api.github.com"
  plug Tesla.Middleware.JSON

  def user_repos(login) do
    ("/users/" <> login <> "/repos")
    |> get()
    |> IO.inspect()
    |> handle_get()
    |> IO.inspect()
  end

  defp handle_get({:ok, %Env{status: 200, body: body}}) do
    {:ok, convert_body(body)}
  end

  defp handle_get({:ok, %Env{body: %{"message" => _message}}}) do
    {:error, Error.build_user_not_found_error()}
  end

  defp convert_body(body) do
    Enum.map(body, fn elem ->
      %{
        name: elem["name"],
        id: elem["id"],
        description: elem["description"],
        html_url: elem["html_url"],
        stargazers_count: elem["stargazers_count"]
      }
    end)
  end
end
