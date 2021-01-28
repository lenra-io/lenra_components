defmodule LenraServices.JsonValidator do
  @moduledoc """
    Services to validate json with json schema
  """

  alias LenraServices.JsonValidator.{ErrorFormatter, SchemaLoader}

  def validate_json(schema, json) do
    schema
    |> ExJsonSchema.Validator.validate(
      json,
      error_formatter: false
    )
    |> response()
  end

  @doc """
  Permet de créer l'objet schema nécessaire à l'appel `validate_json/2`
  Prends en paramètre le chemin `schema_url` vers le fichier.

  iex> LenraServices.JsonValidator.resolve_schema("action_validator.schema.json")
  %ExJsonSchema.Schema.Root{
    custom_format_validator: nil,
    location: :root,
    refs: %{},
    schema: %{
      "$id" => "http://lenra.me/action_validator.schema.json",
      "$schema" => "http://json-schema.org/draft-04/schema#",
      "description" => "The action name to call",
      "pattern" => "^[a-zA-Z_$][a-zA-Z_$0-9]*$",
      "title" => "Action",
      "type" => "string"
    }
  }

  En cas de fichier invalide ou inexistant, la fonction rise l'erreur
  iex> LenraServices.JsonValidator.resolve_schema("not/a/valid/file.json")
  ** (RuntimeError) Cannot load json schema not/a/valid/file.json
  """
  def resolve_schema(schema_url) do
    SchemaLoader.load_schema(schema_url)
    |> ExJsonSchema.Schema.resolve()
  end

  defp response(:ok) do
    {:ok, "Schema valide"}
  end

  defp response({:error, errors}) do
    {:error, ErrorFormatter.format(errors)}
  end
end
