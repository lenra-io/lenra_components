defmodule LenraServices.UiValidatorTest do
  use ExUnit.Case, async: true

  @moduledoc """
    Test the "ui_validator.schema.json" schema
  """
  alias LenraServices.JsonValidator

  setup do
    %{
      schema: JsonValidator.resolve_schema("ui_validator.schema.json")
    }
  end

  test "valide basic UI", %{schema: schema} do
    json = %{
      "root" => %{
        "type" => "text",
        "value" => "Txt test"
      }
    }

    assert {:ok, "Schema valide"} ==
             JsonValidator.validate_json(schema, json)
  end

  test "A UI must have a root property", %{schema: schema} do
    json = %{}

    assert {:error, [{"", "Required property \"root\" was not present.", :object_error}]} ==
             JsonValidator.validate_json(schema, json)
  end

  test "the root property of a UI have to be a component", %{schema: schema} do
    json = %{
      "root" => "any"
    }

    assert {:error,
            [
              {"/root", "The component has no type property.", :type_missing},
              {"/root", "Type mismatch. Expected Object but got String.", :object_error}
            ]} ==
             JsonValidator.validate_json(schema, json)

    json = %{
      "root" => %{}
    }

    assert {:error,
            [
              {"/root", "The component has no type property.", :type_missing}
            ]} ==
             JsonValidator.validate_json(schema, json)
  end
end
