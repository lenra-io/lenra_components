defmodule Mix.Tasks.Lenra do
  @moduledoc """
    This module provides the version of lenra.
  """

  use Mix.Task

  def run(["version"]) do
    IO.puts(Mix.Project.config()[:version])
  end

  def run(_) do
    IO.puts("Usage : lenra version")
  end
end
