defmodule LenraServices.TextfieldValidatorTest do
  use ExUnit.Case, async: true

  @moduledoc """
    Test the "textfield_validator.schema.json" schema
  """

  @relative_path "components/textfield_validator.schema.json"

  test "valide textfield" do
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

    assert :ok ==
             UIValidator.validate_for_schema(json, @relative_path, "")
  end

  test "valide textfield with no listener" do
    json = %{
      "type" => "textfield",
      "value" => "test"
    }

    assert :ok ==
             UIValidator.validate_for_schema(json, @relative_path, "")
  end

  test "invalide type textfield" do
    json = %{
      "type" => "textfields",
      "value" => "test"
    }

    assert {:error, [{"Does not match pattern \"^textfield$\".", "/type"}]} ==
             UIValidator.validate_for_schema(json, @relative_path, "")
  end

  test "invalid textfield with no value" do
    json = %{
      "type" => "textfield"
    }

    assert {:error, [{"Required property value was not present.", ""}]} ==
             UIValidator.validate_for_schema(json, @relative_path, "")
  end

  test "invalid textfield with invalid action and props in listener" do
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
              {"Type mismatch. Expected String but got Integer.", "/listeners/onChange/action"},
              {"Type mismatch. Expected Object but got String.", "/listeners/onChange/props"}
            ]} ==
             UIValidator.validate_for_schema(json, @relative_path, "")
  end

  test "invalid textfield with invalid listener key" do
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
              {"Schema does not allow additional properties.", "/listeners/onClick"}
            ]} ==
             UIValidator.validate_for_schema(json, @relative_path, "")
  end

  test "valid textfield with empty value" do
    json = %{
      "type" => "textfield",
      "value" => ""
    }

    assert :ok ==
             UIValidator.validate_for_schema(json, @relative_path, "")
  end

  test "invalide textfield with empty listeners" do
    json = %{
      "type" => "textfield",
      "value" => "test",
      "listeners" => %{}
    }

    assert {:error, [{"Expected a minimum of 1 properties but got 0", "/listeners"}]} ==
             UIValidator.validate_for_schema(json, @relative_path, "")
  end
end
