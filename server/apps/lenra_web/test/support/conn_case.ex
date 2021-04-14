defmodule LenraWeb.ConnCase do
  @moduledoc """
  This module defines the test case to be used by
  tests that require setting up a connection.

  Such tests rely on `Phoenix.ConnTest` and also
  import other functionality to make it easier
  to build common data structures and query the data layer.

  Finally, if the test case interacts with the database,
  we enable the SQL sandbox, so changes done to the database
  are reverted at the end of every test. If you are using
  PostgreSQL, you can even run database tests asynchronously
  by setting `use LenraWeb.ConnCase, async: true`, although
  this option is not recommended for other databases.
  """

  use ExUnit.CaseTemplate
  alias Ecto.Adapters.SQL.Sandbox

  using do
    quote do
      # Import conveniences for testing with connections
      import Plug.Conn
      import Phoenix.ConnTest
      import LenraWeb.ConnCase
      import UserTestHelper

      alias LenraWeb.Router.Helpers, as: Routes

      # The default endpoint for testing
      @endpoint LenraWeb.Endpoint
    end
  end

  setup tags do
    :ok = Sandbox.checkout(Lenra.Repo)

    conn = Phoenix.ConnTest.build_conn()

    conn =
      if tags[:user_authentication] do
        {:ok, %{inserted_user: user}} = UserTestHelper.register_john_doe()
        {:ok, jwt, _} = Lenra.Guardian.encode_and_sign(user, %{typ: "access", role: user.role})

        conn
        |> Plug.Conn.put_req_header("accept", "application/json")
        |> Plug.Conn.put_req_header("authorization", "Bearer " <> jwt)
      else
        conn
      end

    {:ok, conn: conn}
  end
end
