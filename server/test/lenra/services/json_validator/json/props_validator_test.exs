defmodule LenraServices.PropsValidatorTest do
  use ExUnit.Case, async: true

  @moduledoc """
    Test the "props_validator.schema.json" schema
  """
  alias LenraServices.JsonValidator

  setup do
    %{
      schema: JsonValidator.resolve_schema("props_validator.schema.json")
    }
  end

  test "Valid props", %{schema: schema} do
    json = %{
      "idx" => 42,
      "any" => "Txt test",
      "obj" => %{}
    }

    assert {:ok, "Schema valide"} ==
             LenraServices.JsonValidator.validate_json(schema, json)
  end

  test "invalid not an object props", %{schema: schema} do
    assert {:error, [{"", "Type mismatch. Expected Object but got Integer.", :object_error}]} ==
             LenraServices.JsonValidator.validate_json(schema, 42)

    assert {:error, [{"", "Type mismatch. Expected Object but got String.", :object_error}]} ==
             LenraServices.JsonValidator.validate_json(schema, "hello world")
  end
end
