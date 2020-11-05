defmodule Lenra.RepoCase do
  @moduledoc """
    Setup the repo case test. Use it in new module test like that :
      defmodule LenraServices.UserTest do
        use Lenra.RepoCase
      end
  """
  use ExUnit.CaseTemplate
  alias Ecto.Adapters.SQL.Sandbox

  using do
    quote do
      alias Lenra.Repo

      import Ecto
      import Ecto.Query
      import Lenra.RepoCase

      # and any other stuff
    end
  end

  setup tags do
    :ok = Sandbox.checkout(Lenra.Repo)

    unless tags[:async] do
      Sandbox.mode(Lenra.Repo, {:shared, self()})
    end

    :ok
  end
end
