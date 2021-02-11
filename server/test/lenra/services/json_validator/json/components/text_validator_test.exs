defmodule LenraServices.TextValidatorTest do
  use ExUnit.Case, async: true

  @moduledoc """
    Test the "text_validator.schema.json" schema
  """
  alias LenraServices.JsonValidator

  setup do
    %{
      schema: JsonValidator.resolve_schema("components/text_validator.schema.json")
    }
  end

  test "valide text component", %{schema: schema} do
    json = %{
      "type" => "text",
      "value" => "Txt test"
    }

    assert {:ok, "Schema valide"} ==
             JsonValidator.validate_json(schema, json)
  end

  test "valide text empty value", %{schema: schema} do
    json = %{
      "type" => "text",
      "value" => ""
    }

    assert {:ok, "Schema valide"} ==
             LenraServices.JsonValidator.validate_json(schema, json)
  end

  test "invalide text type", %{schema: schema} do
    json = %{
      "type" => "texts",
      "value" => ""
    }

    assert {:error, [{"/type", "Incorrect type \"^text$\".", :type_invalid}]} ==
             LenraServices.JsonValidator.validate_json(schema, json)
  end

  test "invalid text no value", %{schema: schema} do
    json = %{
      "type" => "text"
    }

    assert {:error, [{"", "Required property \"value\" was not present.", :object_error}]} ==
             LenraServices.JsonValidator.validate_json(schema, json)
  end

  test "invalid text no string value type", %{schema: schema} do
    json = %{
      "type" => "text",
      "value" => 42
    }

    assert {:error, [{"/value", "Type mismatch. Expected String but got Integer.", :object_error}]} ==
             LenraServices.JsonValidator.validate_json(schema, json)
  end
end
