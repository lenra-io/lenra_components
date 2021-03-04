defmodule LenraServices.PropsValidatorTest do
  use ExUnit.Case, async: true

  @moduledoc """
    Test the "props_validator.schema.json" schema
  """

  @relative_path "props_validator.schema.json"

  test "Valid props" do
    json = %{
      "idx" => 42,
      "any" => "Txt test",
      "obj" => %{}
    }

    assert :ok ==
             UIValidator.validate_for_schema(json, @relative_path, "")
  end

  test "invalid not an object props" do
    assert {:error, [{"Type mismatch. Expected Object but got Integer.", ""}]} ==
             UIValidator.validate_for_schema(42, @relative_path, "")

    assert {:error, [{"Type mismatch. Expected Object but got String.", ""}]} ==
             UIValidator.validate_for_schema("hello world", @relative_path, "")
  end
end
