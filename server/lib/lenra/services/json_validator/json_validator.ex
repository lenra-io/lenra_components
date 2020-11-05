defmodule LenraServices.JsonValidator do
  @moduledoc """
    Services to validate json with json schema
  """

  @doc """
    Return :ok if the shema is valide or return :error if the schema are invalide

    iex>LenraServices.JsonValidator.validate_json("text", %{type: "text", value: ""})
    {:ok, "Schema valide"}

    iex>LenraServices.JsonValidator.validate_json("text", %{type: "txt", value: ""})
    {:error, %{properties: %{"type" => %{pattern: ~r/text/, value: "txt"}}}}
  """
  def validate_json(schema_validator, schema) do
    # Just the name of validator
    validator =
      File.read!(
        "lib/lenra/services/json_validator/json/#{schema_validator}_validator.schema.json"
      )
      |> Jason.decode!()

    # Schema validator already read
    # validator=Jason.decode!(schema_validator)

    schema_decoded =
      schema
      |> Jason.encode!()
      |> Jason.decode!()

    validator_xema = JsonXema.new(validator)
    response(JsonXema.validate(validator_xema, schema_decoded))
  end

  defp response(:ok) do
    {:ok, "Schema valide"}
  end

  defp response({:error, %{message: _message, reason: reason}}) do
    {:error, reason}
  end
end
