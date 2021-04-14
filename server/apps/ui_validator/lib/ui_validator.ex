defmodule UIValidator do
  @moduledoc """
    Services to validate json with json schema
  """

  def validate(ui) do
    with :ok <- validate_for_schema(ui, "root_validator.schema.json", "") do
      validate_json_tree(ui["root"], "/root")
    end
  end

  defp validate_json_tree(%{"type" => comp_type, "children" => children} = comp, prefix_path) do
    with :ok <- validate_component(comp_type, comp, "#{prefix_path}/#{comp_type}") do
      children
      |> Enum.with_index()
      |> Enum.reduce([], fn {child, idx}, errors ->
        case validate_json_tree(child, "#{prefix_path}/children/#{idx}") do
          :ok -> errors
          {:error, err} -> errors ++ err
        end
      end)
      |> case do
        [] -> :ok
        errors -> {:error, errors}
      end
    end
  end

  defp validate_json_tree(%{"type" => comp_type} = comp, prefix_path) do
    validate_component(comp_type, comp, prefix_path)
  end

  defp validate_json_tree(_comp, prefix_path) do
    {:error, [{"No type found", prefix_path}]}
  end

  defp validate_component(comp_type, comp, prefix_path) do
    validate_for_schema(comp, "components/#{comp_type}_validator.schema.json", prefix_path)
  end

  def validate_for_schema(json, schema_url, prefix_path) do
    case UIValidator.JsonSchemata.get_schema(schema_url) do
      :error ->
        {:error, [{"Invalid type", prefix_path}]}

      schema ->
        case ExJsonSchema.Validator.validate(schema, json) do
          :ok ->
            :ok

          {:error, errors} ->
            {:error, Enum.map(errors, fn {message, "#" <> path} -> {message, prefix_path <> path} end)}
        end
    end
  end
end
