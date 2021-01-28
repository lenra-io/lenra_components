defmodule LenraServers.JsonValidator do
  use GenServer

  @moduledoc """
    `LenraServers.JsonValidator` is a GenServer that allow to validate a json schema with `LenraServers.JsonValidator.validate_ui/1`
  """

  # Client (api)

  @doc """
    Return :ok if the shema is valide or return :error if the schema are invalide

    iex> LenraServers.JsonValidator.validate_ui(%{"root" => %{"type" => "text", "value" => ""}})
    {:ok, "Schema valide"}

    iex> LenraServers.JsonValidator.validate_ui(%{"root" => %{}})
    {:error, [{"/root", "The component has no type property.", :type_missing}]}
  """
  def validate_ui(ui) do
    GenServer.call(__MODULE__, {:validate, ui})
  end

  def start_link(schema_url) do
    GenServer.start_link(__MODULE__, schema_url, name: __MODULE__)
  end

  # Server (callbacks)
  @impl true
  def init(schema_url) do
    {:ok, LenraServices.JsonValidator.resolve_schema(schema_url)}
  end

  @impl true
  def handle_call({:validate, json}, _from, schema) do
    {:reply, LenraServices.JsonValidator.validate_json(schema, json), schema}
  end
end
