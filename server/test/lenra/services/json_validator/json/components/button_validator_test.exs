defmodule LenraServices.ButtonValidatorTest do
  use ExUnit.Case, async: true

  @moduledoc """
    Test the "button_validator.schema.json" schema
  """
  alias LenraServices.JsonValidator

  setup do
    %{
      schema: JsonValidator.resolve_schema("components/button_validator.schema.json")
    }
  end

  test "valide button", %{schema: schema} do
    json = %{
      "type" => "button",
      "value" => "",
      "listeners" => %{
        "onClick" => %{
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

  test "valide button with no listener", %{schema: schema} do
    json = %{
      "type" => "button",
      "value" => "test"
    }

    assert {:ok, "Schema valide"} ==
             LenraServices.JsonValidator.validate_json(schema, json)
  end

  test "invalide button type", %{schema: schema} do
    json = %{
      "type" => "buttons",
      "value" => "test"
    }

    assert {:error, [{"/type", "Incorrect type \"^button$\".", :type_invalid}]} ==
             LenraServices.JsonValidator.validate_json(schema, json)
  end

  test "invalid button with no value", %{schema: schema} do
    json = %{
      "type" => "button"
    }

    assert {:error, [{"", "Required property \"value\" was not present.", :object_error}]} ==
             LenraServices.JsonValidator.validate_json(schema, json)
  end

  test "invalid button with invalid action and props in listener", %{schema: schema} do
    json = %{
      "type" => "button",
      "value" => "test",
      "listeners" => %{
        "onClick" => %{
          "action" => 10,
          "props" => ""
        }
      }
    }

    assert {:error,
            [
              {"/listeners/onClick/action", "Type mismatch. Expected String but got Integer.", :object_error},
              {"/listeners/onClick/props", "Type mismatch. Expected Object but got String.", :object_error}
            ]} ==
             LenraServices.JsonValidator.validate_json(schema, json)
  end

  test "invalid button with invalid listener key", %{schema: schema} do
    json = %{
      "type" => "button",
      "value" => "test",
      "listeners" => %{
        "onChange" => %{
          "action" => 42,
          "props" => "machin"
        }
      }
    }

    assert {:error,
            [
              {"/listeners/onChange", "Invalid property.", :object_error}
            ]} ==
             LenraServices.JsonValidator.validate_json(schema, json)
  end

  test "valid button with empty value", %{schema: schema} do
    json = %{
      "type" => "button",
      "value" => ""
    }

    assert {:ok, "Schema valide"} ==
             LenraServices.JsonValidator.validate_json(schema, json)
  end

  test "invalide button with empty listeners", %{schema: schema} do
    json = %{
      "type" => "button",
      "value" => "test",
      "listeners" => %{}
    }

    assert {:error, [{"/listeners", "Expected a minimum of 1 properties but got 0", :object_error}]} ==
             LenraServices.JsonValidator.validate_json(schema, json)
  end

  test "invalide button with empty listeners and no value", %{schema: schema} do
    json = %{
      "type" => "button",
      "listeners" => %{}
    }

    assert {:error,
            [
              {"", "Required property \"value\" was not present.", :object_error},
              {"/listeners", "Expected a minimum of 1 properties but got 0", :object_error}
            ]} ==
             LenraServices.JsonValidator.validate_json(schema, json)
  end
end
