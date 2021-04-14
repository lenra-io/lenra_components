defmodule LenraServices.ActionValidatorTest do
  use ExUnit.Case, async: true

  @moduledoc """
    Test the "action_validator.schema.json" schema
  """

  @relative_path "action_validator.schema.json"

  test "valid action name" do
    assert :ok = UIValidator.validate_for_schema("test", @relative_path, "")

    assert :ok ==
             UIValidator.validate_for_schema("test_hello", @relative_path, "")

    assert :ok ==
             UIValidator.validate_for_schema("TestHello", @relative_path, "")

    assert :ok ==
             UIValidator.validate_for_schema("TEST_HELLO", @relative_path, "")

    assert :ok ==
             UIValidator.validate_for_schema("test42hello", @relative_path, "")

    assert :ok == UIValidator.validate_for_schema("test42", @relative_path, "")
  end

  test "invalid action name" do
    err_pattern = [{"Does not match pattern \"^[a-zA-Z_$][a-zA-Z_$0-9]*$\".", ""}]
    err_integer = [{"Type mismatch. Expected String but got Integer.", ""}]

    assert {:error, err_pattern} == UIValidator.validate_for_schema("", @relative_path, "")
    assert {:error, err_pattern} == UIValidator.validate_for_schema("42", @relative_path, "")

    assert {:error, err_integer} == UIValidator.validate_for_schema(42, @relative_path, "")

    assert {:error, err_pattern} == UIValidator.validate_for_schema("42test", @relative_path, "")

    assert {:error, err_pattern} ==
             UIValidator.validate_for_schema("test space", @relative_path, "")

    assert {:error, err_pattern} ==
             UIValidator.validate_for_schema("test_spécial_char", @relative_path, "")
  end
end
