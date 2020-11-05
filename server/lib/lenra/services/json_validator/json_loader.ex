defmodule LenraServices.Loader do
  @moduledoc false

  @behaviour Xema.Loader

  @spec fetch(URI.t()) :: {:ok, any} | {:error, any}
  def fetch(uri),
    do:
      "lib/lenra/services/json_validator/json/"
      |> Path.join(uri.path)
      |> File.read!()
      |> Jason.decode()
end
