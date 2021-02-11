defmodule UserTestHelper do
  @moduledoc """
    Test helper for user
  """
  alias Lenra.{User, Repo}
  alias LenraServices.UserServices

  @john_doe_user_params %{
    "first_name" => "John",
    "last_name" => "Doe",
    "email" => "john.doe@lenra.fr",
    "password" => "johndoethefirst"
  }

  def register_user(params) do
    %User{role: User.const_unvalidated_user_role()}
    |> User.changeset(params)
    |> UserServices.register()
    |> Repo.transaction()
  end

  def register_john_doe(changes \\ %{}) do
    @john_doe_user_params
    |> Map.merge(changes)
    |> register_user()
  end

  def get_john_doe_access_token do
    {:ok, %{user: user}} = register_john_doe()
    get_access_token(user)
  end

  def get_access_token(user) do
    {:ok, token, _} = Lenra.Guardian.encode_and_sign(user)
    token
  end
end
