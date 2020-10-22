defmodule Utils.DataManipulation do
  @moduledoc """
    `Utils.DataManipulation` is an utilitary module that allow Action Data manipulation such as replacing {{key.ref.value}} by data.key.ref.value
  """

  require Logger
  @data_key_regex ~r/{{([a-zA-Z0-9\-_.]+)}}/

  defp get_subelement_from_key(key, list) when is_list(list) do
    case Integer.parse(key) do
      {idx, ""} ->
        Enum.at(list, idx, nil)

      _any ->
        nil
    end
  end

  defp get_subelement_from_key(key, map) when is_map(map), do: Map.get(map, key, nil)
  defp get_subelement_from_key(_key, any), do: any

  @doc ~S"""
    Return the data stored in the given `map` specified by the given `key`
    ## Examples
      iex> Utils.DataManipulation.get_data_from_key("values.0.text", %{"values" => [%{"text" => "coucou"}]})
      "coucou"

      iex> Utils.DataManipulation.get_data_from_key("values", %{"values" => [%{"text" => "coucou"}]})
      [%{"text" => "coucou"}]

    If the given key does not exists, return nil
      iex> Utils.DataManipulation.get_data_from_key("values.0.other", %{"values" => [%{"text" => "coucou"}]})
      nil

      iex> Utils.DataManipulation.get_data_from_key("other.0.text", %{"values" => [%{"text" => "coucou"}]})
      nil
  """
  def get_data_from_key(key, map) when is_binary(key) and is_map(map) do
    key
    |> String.split(".")
    |> Enum.reduce(map, fn key, subdata -> get_subelement_from_key(key, subdata) end)
  end

  @doc ~S"""
  Search for all key matching `@data_key_regex` in any value of a map/list and replace them by the corresponding value with `get_data_from_key/2`

  ## Examples
    iex> Utils.DataManipulation.replace_keys(%{"type" => "text", "value" => "Bonjour {{values.0.text}}"}, %{"values" => [%{"text" => "Jean"}, %{"text" => "Alice"}]})
    %{"type" => "text", "value" => "Bonjour Jean"}

    iex> Utils.DataManipulation.replace_keys(%{"type" => "text", "value" => "Bonjour {{values.1.text}}"}, %{"values" => [%{"text" => "Jean"}, %{"text" => "Alice"}]})
    %{"type" => "text", "value" => "Bonjour Alice"}
  """

  def replace_keys(element, data) do
    i_replace_keys(element, data)
  end

  defp i_replace_keys(str, data) when is_binary(str) and is_map(data) do
    Regex.replace(@data_key_regex, str, fn _, m1 -> get_data_from_key(m1, data) |> to_string end)
  end

  defp i_replace_keys(map, data) when is_map(map) and is_map(data) do
    Map.new(map, fn {k, v} -> {k, replace_keys(v, data)} end)
  end

  defp i_replace_keys(list, data) when is_list(list) and is_map(data) do
    Enum.map(list, fn e -> replace_keys(e, data) end)
  end

  defp i_replace_keys(any, _data) do
    any
  end
end
