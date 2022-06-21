defmodule Github do
  alias Github.Users.Get, as: UserGet

  defdelegate get_user_by_name(params), to: UserGet, as: :user_repos
end
