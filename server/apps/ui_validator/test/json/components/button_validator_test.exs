defmodule UiValidator.ButtonValidatorTest do
  use ExUnit.Case, async: true

  @moduledoc """
    Test the "button_validator.schema.json" schema
  """
  @relative_path "components/button_validator.schema.json"

  test "valide button" do
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

    assert :ok ==
             UIValidator.validate_for_schema(json, @relative_path, "")
  end

  test "valide button with no listener" do
    json = %{
      "type" => "button",
      "value" => "test"
    }

    assert :ok ==
             UIValidator.validate_for_schema(json, @relative_path, "")
  end

  test "invalide button type" do
    json = %{
      "type" => "buttons",
      "value" => "test"
    }

    assert {:error, [{"Does not match pattern \"^button$\".", "/type"}]} ==
             UIValidator.validate_for_schema(json, @relative_path, "")
  end

  test "invalid button with no value" do
    json = %{
      "type" => "button"
    }

    assert {:error, [{"Required property value was not present.", ""}]} ==
             UIValidator.validate_for_schema(json, @relative_path, "")
  end

  test "invalid button with invalid action and props in listener" do
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
              {"Type mismatch. Expected String but got Integer.", "/listeners/onClick/action"},
              {"Type mismatch. Expected Object but got String.", "/listeners/onClick/props"}
            ]} ==
             UIValidator.validate_for_schema(json, @relative_path, "")
  end

  test "invalid button with invalid listener key" do
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
              {"Schema does not allow additional properties.", "/listeners/onChange"}
            ]} ==
             UIValidator.validate_for_schema(json, @relative_path, "")
  end

  test "valid button with empty value" do
    json = %{
      "type" => "button",
      "value" => ""
    }

    assert :ok ==
             UIValidator.validate_for_schema(json, @relative_path, "")
  end

  test "invalide button with empty listeners" do
    json = %{
      "type" => "button",
      "value" => "test",
      "listeners" => %{}
    }

    assert {:error, [{"Expected a minimum of 1 properties but got 0", "/listeners"}]} ==
             UIValidator.validate_for_schema(json, @relative_path, "")
  end

  test "invalide button with empty listeners and no value" do
    json = %{
      "type" => "button",
      "listeners" => %{}
    }

    assert {:error,
            [
              {"Expected a minimum of 1 properties but got 0", "/listeners"},
              {"Required property value was not present.", ""}
            ]} ==
             UIValidator.validate_for_schema(json, @relative_path, "")
  end
end
