defmodule UIValidator.JsonSchemata do
  use GenServer

  @moduledoc """
    `LenraServers.JsonValidator` is a GenServer that allow to validate a json schema with `LenraServers.JsonValidator.validate_ui/1`
  """

  # Client (api)

  def get_schema(path) do
    GenServer.call(__MODULE__, {:get_schema, path})
  end

  def start_link(_) do
    GenServer.start_link(__MODULE__, %{}, name: __MODULE__)
  end

  # Server (callbacks)
  @impl true
  def init(_) do
    root_json_directory =
      Application.app_dir(:ui_validator, Application.fetch_env!(:ui_validator, :json_validator_schema_dir))

    relative_shemata_path =
      Path.join(root_json_directory, "/**/*.schema.json")
      |> Path.wildcard()
      |> Enum.map(&Path.relative_to(&1, root_json_directory))

    schemata = Enum.map(relative_shemata_path, &load_schema/1)
    schemata_map = Enum.zip(relative_shemata_path, schemata) |> Enum.into(%{})

    {:ok, schemata_map}
  end

  def load_schema(path) do
    read_schema(path)
    |> ExJsonSchema.Schema.resolve()
  end

  def read_schema(path) do
    Application.app_dir(:ui_validator, Application.fetch_env!(:ui_validator, :json_validator_schema_dir))
    |> Path.join(path)
    |> File.read()
    |> case do
      {:ok, file_content} -> file_content
      {:error, _reason} -> raise "Cannot load json schema #{path}"
    end
    |> Jason.decode!()
  end

  @impl true
  def handle_call({:get_schema, path}, _from, schemata_map) do
    {:reply, Map.get(schemata_map, path, :error), schemata_map}
  end
end
