defmodule LenraServices.TextValidatorTest do
  use ExUnit.Case, async: true

  @moduledoc """
    Test the "text_validator.schema.json" schema
  """

  @relative_path "components/text_validator.schema.json"

  test "valide text component" do
    json = %{
      "type" => "text",
      "value" => "Txt test"
    }

    assert :ok ==
             UIValidator.validate_for_schema(json, @relative_path, "")
  end

  test "valide text empty value" do
    json = %{
      "type" => "text",
      "value" => ""
    }

    assert :ok ==
             UIValidator.validate_for_schema(json, @relative_path, "")
  end

  test "invalide text type" do
    json = %{
      "type" => "texts",
      "value" => ""
    }

    assert {:error, [{"Does not match pattern \"^text$\".", "/type"}]} ==
             UIValidator.validate_for_schema(json, @relative_path, "")
  end

  test "invalid text no value" do
    json = %{
      "type" => "text"
    }

    assert {:error, [{"Required property value was not present.", ""}]} ==
             UIValidator.validate_for_schema(json, @relative_path, "")
  end

  test "invalid text no string value type" do
    json = %{
      "type" => "text",
      "value" => 42
    }

    assert {:error, [{"Type mismatch. Expected String but got Integer.", "/value"}]} ==
             UIValidator.validate_for_schema(json, @relative_path, "")
  end
end
