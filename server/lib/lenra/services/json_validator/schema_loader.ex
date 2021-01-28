defmodule LenraServices.JsonValidator.SchemaLoader do
  @moduledoc false

  def load_schema(path) do
    Application.app_dir(:lenra, Application.fetch_env!(:lenra, :json_validator_schema))
    |> Path.join(path)
    |> File.read()
    |> case do
      {:ok, file_content} -> file_content
      {:error, _reason} -> raise "Cannot load json schema #{path}"
    end
    |> Jason.decode!()
  end
end
