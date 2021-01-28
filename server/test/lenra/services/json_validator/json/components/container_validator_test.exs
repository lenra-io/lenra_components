defmodule LenraServices.ContainerValidatorTest do
  use ExUnit.Case, async: true

  @moduledoc """
    Test the "container_validator.schema.json" schema
  """
  alias LenraServices.JsonValidator

  setup do
    %{
      schema: JsonValidator.resolve_schema("components/container_validator.schema.json")
    }
  end

  test "valide container", %{schema: schema} do
    json = %{
      "type" => "container",
      "children" => [
        %{
          "type" => "text",
          "value" => "Txt test"
        }
      ]
    }

    assert {:ok, "Schema valide"} ==
             LenraServices.JsonValidator.validate_json(schema, json)
  end

  test "valid empty container", %{schema: schema} do
    json = %{
      "type" => "container",
      "children" => []
    }

    assert {:ok, "Schema valide"} ==
             LenraServices.JsonValidator.validate_json(schema, json)
  end

  test "invalid container type", %{schema: schema} do
    json = %{
      "type" => "containers",
      "children" => []
    }

    assert {:error, [{"/type", "Incorrect type \"^container$\".", :type_invalid}]} ==
             LenraServices.JsonValidator.validate_json(schema, json)
  end

  test "invalide component inside the container", %{schema: schema} do
    json = %{
      "type" => "container",
      "children" => [
        %{
          "type" => "text",
          "value" => "Txt test"
        },
        %{
          "type" => "New"
        }
      ]
    }

    assert {:error, [{"/children/1", "The component has incorrect type.", :type_invalid_found}]} ==
             LenraServices.JsonValidator.validate_json(schema, json)
  end

  test "invalid container with no children property", %{schema: schema} do
    json = %{
      "type" => "container"
    }

    assert {:error, [{"", "Required property \"children\" was not present.", :object_error}]} ==
             LenraServices.JsonValidator.validate_json(schema, json)
  end
end
