defmodule LenraServices.JsonValidator.ErrorFormatter do
  @moduledoc """
    Permet la génération du/des message d'erreur à partir de l'objet d'erreur retourné par `ExJsonSchema.Validator.validate/2`
  """

  alias ExJsonSchema.Validator.Error
  require Logger

  def priority(:type_missing) do
    1
  end

  def priority(:type_invalid) do
    2
  end

  def priority(:type_invalid_found) do
    3
  end

  def priority(:object_error) do
    4
  end

  def priority(:not_expected) do
    5
  end

  def format(errors) do
    Enum.flat_map(errors, fn error ->
      get_error_string(error, "")
    end)
    |> Enum.sort_by(&{elem(&1, 0), priority(elem(&1, 2))})
  end

  defp type_names(types) do
    types
    |> List.wrap()
    |> Enum.map(&String.capitalize/1)
    |> Enum.join(", ")
  end

  def get_error_string(%Error.Type{expected: expected, actual: actual}, path) do
    [
      {path, "Type mismatch. Expected #{type_names(expected)} but got #{type_names(actual)}.", :object_error}
    ]
  end

  def get_error_string(%Error.AllOf{invalid: invalids}, path) do
    invalids
    |> Enum.flat_map(&get_error_string(&1, path))
  end

  def get_error_string(%Error.AnyOf{invalid: invalids}, path) do
    invalids
    |> Enum.flat_map(&get_error_string(&1, path))
  end

  def get_error_string(
        %Error.OneOf{valid_indices: [_first, _second | _], invalid: _invalids},
        path
      ) do
    [
      {path, "Expected exactly one of the schemata to match, but the multiple schemata did.", :not_expected}
    ]
  end

  def get_error_string(
        %Error.OneOf{valid_indices: _valid_indices, invalid: invalids},
        path
      ) do
    invalid_type_errors =
      invalids
      |> Enum.map(&get_error_string(&1, path))
      |> Enum.filter(fn errors ->
        not Enum.any?(errors, fn {_path, _err, err_priority} ->
          err_priority == :type_invalid
        end)
      end)
      |> flatten()

    case invalid_type_errors do
      [] ->
        [{path, "The component has incorrect type.", :type_invalid_found}]

      [_] ->
        invalid_type_errors

      _ ->
        [{path, "The component has no type property.", :type_missing}]
    end
  end

  def get_error_string(%Error.InvalidAtIndex{errors: errors}, path) do
    errors
    |> Enum.flat_map(&get_error_string(&1, path))
  end

  def get_error_string(%Error.Not{}, path) do
    [{path, "Expected schema not to match but it did.", :not_expected}]
  end

  def get_error_string(%Error.AdditionalProperties{}, path) do
    [{path, "Invalid property.", :object_error}]
  end

  def get_error_string(%Error.MinProperties{expected: expected, actual: actual}, path) do
    [{path, "Expected a minimum of #{expected} properties but got #{actual}", :object_error}]
  end

  def get_error_string(%Error.MaxProperties{expected: expected, actual: actual}, path) do
    [{path, "Expected a maximum of #{expected} properties but got #{actual}", :object_error}]
  end

  def get_error_string(%Error.Required{missing: [missing]}, path) do
    [{path, "Required property \"#{missing}\" was not present.", :object_error}]
  end

  def get_error_string(%Error.Required{missing: missing}, path) do
    [
      {path,
       "Required properties #{missing |> Enum.map(fn miss -> "\"#{miss}\"" end) |> Enum.join(", ")} were not present.",
       :object_error}
    ]
  end

  def get_error_string(
        %Error.Dependencies{property: property, missing: [missing]},
        path
      ) do
    [
      {path, "Property \"#{property}\" depends on property \"#{missing}\" to be present but it was not.", :object_error}
    ]
  end

  def get_error_string(%Error.Dependencies{property: property, missing: missing}, path) do
    [
      {path,
       "Property \"#{property}\" depends on properties #{
         missing |> Enum.map(fn miss -> "\"#{miss}\"" end) |> Enum.join(", ")
       } to be present but they were not.", :object_error}
    ]
  end

  def get_error_string(%Error.AdditionalItems{}, path) do
    [{path, "Schema does not allow additional items.", :object_error}]
  end

  def get_error_string(%Error.MinItems{expected: expected, actual: actual}, path) do
    [{path, "Expected a minimum of #{expected} items but got #{actual}.", :object_error}]
  end

  def get_error_string(%Error.MaxItems{expected: expected, actual: actual}, path) do
    [{path, "Expected a maximum of #{expected} items but got #{actual}.", :object_error}]
  end

  def get_error_string(%Error.UniqueItems{}, path) do
    [{path, "Expected items to be unique but they were not.", :not_expected}]
  end

  def get_error_string(%Error.Enum{}, path) do
    [{path, "Value is not allowed in enum.", :not_expected}]
  end

  def get_error_string(%Error.Minimum{expected: expected, exclusive?: exclusive?}, path) do
    [
      {path, "Expected the value to be #{if exclusive?, do: ">", else: ">="} #{expected}", :object_error}
    ]
  end

  def get_error_string(%Error.Maximum{expected: expected, exclusive?: exclusive?}, path) do
    [
      {path, "Expected the value to be #{if exclusive?, do: "<", else: "<="} #{expected}", :object_error}
    ]
  end

  def get_error_string(%Error.MultipleOf{expected: expected}, path) do
    [{path, "Expected value to be a multiple of #{expected}.", :object_error}]
  end

  def get_error_string(%Error.MinLength{expected: expected, actual: actual}, path) do
    [
      {path, "Expected value to have a minimum length of #{expected} but was #{actual}.", :object_error}
    ]
  end

  def get_error_string(%Error.MaxLength{expected: expected, actual: actual}, path) do
    [
      {path, "Expected value to have a maximum length of #{expected} but was #{actual}.", :object_error}
    ]
  end

  def get_error_string(%Error.Pattern{expected: expected}, path) do
    if String.ends_with?(path, "/type") do
      [{path, "Incorrect type #{inspect(expected)}.", :type_invalid}]
    else
      [{path, "Does not match pattern #{inspect(expected)}.", :object_error}]
    end
  end

  def get_error_string(%Error.Format{expected: expected}, path) do
    [{path, "Expected to be a valid #{format_name(expected)}.", :object_error}]
  end

  def get_error_string(%Error{error: error, path: "#" <> path}, parent_path) do
    get_error_string(error, parent_path <> path)
  end

  def get_error_string(_any, path) do
    [{path, "Unexpected unknown error", :not_expected}]
  end

  defp format_name("date-time"), do: "ISO 8601 date-time"
  defp format_name("ipv4"), do: "IPv4 address"
  defp format_name("ipv6"), do: "IPv6 address"
  defp format_name(expected), do: expected

  defp flatten(list), do: flatten(list, [])
  defp flatten([h | t], acc) when h == [], do: flatten(t, acc)
  defp flatten([h | t], acc) when is_list(h), do: flatten(t, flatten(h, acc))
  defp flatten([h | t], acc), do: flatten(t, [h | acc])
  defp flatten([], acc), do: acc
  defp flatten(not_list, _acc), do: not_list
end
