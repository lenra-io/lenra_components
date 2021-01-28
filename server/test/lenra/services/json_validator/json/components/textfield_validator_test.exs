defmodule LenraServices.TextfieldValidatorTest do
  use ExUnit.Case, async: true

  @moduledoc """
    Test the "textfield_validator.schema.json" schema
  """
  alias LenraServices.JsonValidator

  setup do
    %{
      schema: JsonValidator.resolve_schema("components/textfield_validator.schema.json")
    }
  end

  test "valide textfield", %{schema: schema} do
    json = %{
      "type" => "textfield",
      "value" => "",
      "listeners" => %{
        "onChange" => %{
          "action" => "anyaction",
          "props" => %{
            "number" => 10,
            "value" => "value"
          }
        }
      }
    }

    assert {:ok, "Schema valide"} ==
             LenraServices.JsonValidator.validate_json(schema, json)
  end

  test "valide textfield with no listener", %{schema: schema} do
    json = %{
      "type" => "textfield",
      "value" => "test"
    }

    assert {:ok, "Schema valide"} ==
             LenraServices.JsonValidator.validate_json(schema, json)
  end

  test "invalide type textfield", %{schema: schema} do
    json = %{
      "type" => "textfields",
      "value" => "test"
    }

    assert {:error, [{"/type", "Incorrect type \"^textfield$\".", :type_invalid}]} ==
             LenraServices.JsonValidator.validate_json(schema, json)
  end

  test "invalid textfield with no value", %{schema: schema} do
    json = %{
      "type" => "textfield"
    }

    assert {:error, [{"", "Required property \"value\" was not present.", :object_error}]} ==
             LenraServices.JsonValidator.validate_json(schema, json)
  end

  test "invalid textfield with invalid action and props in listener", %{schema: schema} do
    json = %{
      "type" => "textfield",
      "value" => "test",
      "listeners" => %{
        "onChange" => %{
          "action" => 10,
          "props" => ""
        }
      }
    }

    assert {:error,
            [
              {"/listeners/onChange/action", "Type mismatch. Expected String but got Integer.",
               :object_error},
              {"/listeners/onChange/props", "Type mismatch. Expected Object but got String.",
               :object_error}
            ]} ==
             LenraServices.JsonValidator.validate_json(schema, json)
  end

  test "invalid textfield with invalid listener key", %{schema: schema} do
    json = %{
      "type" => "textfield",
      "value" => "test",
      "listeners" => %{
        "onClick" => %{
          "action" => 42,
          "props" => "machin"
        }
      }
    }

    assert {:error,
            [
              {"/listeners/onClick", "Invalid property.", :object_error}
            ]} ==
             LenraServices.JsonValidator.validate_json(schema, json)
  end

  test "valid textfield with empty value", %{schema: schema} do
    json = %{
      "type" => "textfield",
      "value" => ""
    }

    assert {:ok, "Schema valide"} ==
             LenraServices.JsonValidator.validate_json(schema, json)
  end

  test "invalide textfield with empty listeners", %{schema: schema} do
    json = %{
      "type" => "textfield",
      "value" => "test",
      "listeners" => %{}
    }

    assert {:error,
            [{"/listeners", "Expected a minimum of 1 properties but got 0", :object_error}]} ==
             LenraServices.JsonValidator.validate_json(schema, json)
  end
end
