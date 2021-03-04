defmodule LenraServices.ContainerValidatorTest do
  use ExUnit.Case, async: true

  @moduledoc """
    Test the "container_validator.schema.json" schema
  """

  @relative_path "components/container_validator.schema.json"

  test "valide container" do
    json = %{
      "type" => "container",
      "children" => [
        %{
          "type" => "text",
          "value" => "Txt test"
        }
      ]
    }

    assert :ok ==
             UIValidator.validate_for_schema(json, @relative_path, "")
  end

  test "valid empty container" do
    json = %{
      "type" => "container",
      "children" => []
    }

    assert :ok ==
             UIValidator.validate_for_schema(json, @relative_path, "")
  end

  test "invalid container type" do
    json = %{
      "type" => "containers",
      "children" => []
    }

    assert {:error, [{"Does not match pattern \"^container$\".", "/type"}]} ==
             UIValidator.validate_for_schema(json, @relative_path, "")
  end

  test "invalide component inside the container" do
    json = %{
      "root" => %{
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
    }

    assert {:error, [{"Invalid type", "/root/children/1"}]} ==
             UIValidator.validate(json)
  end

  test "invalid container with no children property" do
    json = %{
      "type" => "container"
    }

    assert {:error, [{"Required property children was not present.", ""}]} ==
             UIValidator.validate_for_schema(json, @relative_path, "")
  end
end
