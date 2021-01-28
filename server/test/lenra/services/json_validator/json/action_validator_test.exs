defmodule LenraServices.ActionValidatorTest do
  use ExUnit.Case, async: true

  @moduledoc """
    Test the "action_validator.schema.json" schema
  """
  alias LenraServices.JsonValidator

  setup do
    %{
      schema: JsonValidator.resolve_schema("action_validator.schema.json")
    }
  end

  test "valid action name", %{schema: schema} do
    assert {:ok, "Schema valide"} = LenraServices.JsonValidator.validate_json(schema, "test")

    assert {:ok, "Schema valide"} ==
             LenraServices.JsonValidator.validate_json(schema, "test_hello")

    assert {:ok, "Schema valide"} ==
             LenraServices.JsonValidator.validate_json(schema, "TestHello")

    assert {:ok, "Schema valide"} ==
             LenraServices.JsonValidator.validate_json(schema, "TEST_HELLO")

    assert {:ok, "Schema valide"} ==
             LenraServices.JsonValidator.validate_json(schema, "test42hello")

    assert {:ok, "Schema valide"} == LenraServices.JsonValidator.validate_json(schema, "test42")
  end

  test "invalid action name", %{schema: schema} do
    err_pattern = [{"", "Does not match pattern \"^[a-zA-Z_$][a-zA-Z_$0-9]*$\".", :object_error}]
    err_integer = [{"", "Type mismatch. Expected String but got Integer.", :object_error}]

    assert {:error, err_pattern} == LenraServices.JsonValidator.validate_json(schema, "")
    assert {:error, err_pattern} == LenraServices.JsonValidator.validate_json(schema, "42")

    assert {:error, err_integer} == LenraServices.JsonValidator.validate_json(schema, 42)

    assert {:error, err_pattern} == LenraServices.JsonValidator.validate_json(schema, "42test")

    assert {:error, err_pattern} ==
             LenraServices.JsonValidator.validate_json(schema, "test space")

    assert {:error, err_pattern} ==
             LenraServices.JsonValidator.validate_json(schema, "test_spécial_char")
  end
end
