defmodule LenraServices.ComponentValidatorTest do
  use ExUnit.Case, async: true

  @moduledoc """
    Test the "component_validator.schema.json" schema
  """
  alias LenraServices.JsonValidator

  setup do
    %{
      schema: JsonValidator.resolve_schema("components/component_validator.schema.json")
    }
  end

  test "a component must have a type", %{schema: schema} do
    json = %{}

    assert {:error, [{"", "The component has no type property.", :type_missing}]} ==
             JsonValidator.validate_json(schema, json)
  end

  test "a component type must be a valid component", %{schema: schema} do
    json = %{"type" => "truc"}

    assert {:error, [{"", "The component has incorrect type.", :type_invalid_found}]} ==
             JsonValidator.validate_json(schema, json)
  end

  test "a component can be a text", %{schema: schema} do
    json = %{
      "type" => "text",
      "value" => "Txt test"
    }

    assert {:ok, "Schema valide"} ==
             JsonValidator.validate_json(schema, json)
  end

  test "a component can be a button", %{schema: schema} do
    json = %{
      "type" => "button",
      "value" => "test"
    }

    assert {:ok, "Schema valide"} ==
             LenraServices.JsonValidator.validate_json(schema, json)
  end

  test "a component can be a textfield", %{schema: schema} do
    json = %{
      "type" => "textfield",
      "value" => "test"
    }

    assert {:ok, "Schema valide"} ==
             LenraServices.JsonValidator.validate_json(schema, json)
  end

  test "a component can be a container", %{schema: schema} do
    json = %{
      "type" => "container",
      "children" => []
    }

    assert {:ok, "Schema valide"} ==
             LenraServices.JsonValidator.validate_json(schema, json)
  end
end
