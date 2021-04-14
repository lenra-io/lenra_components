defmodule LenraServices.UIValidatorTest do
  use ExUnit.Case, async: true

  @moduledoc """
    Test the `LenraServer.JsonValidator` module
  """

  doctest UIValidator

  test "valide basic UI" do
    ui = %{
      "root" => %{
        "type" => "text",
        "value" => "Txt test"
      }
    }

    assert :ok ==
             UIValidator.validate(ui)
  end

  test "A UI must have a root property" do
    ui = %{}

    assert {:error, [{"Required property root was not present.", ""}]} ==
             UIValidator.validate(ui)
  end

  test "the root property of a UI have to be a component" do
    ui = %{
      "root" => "any"
    }

    assert {:error,
            [
              {"Type mismatch. Expected Object but got String.", "/root"}
            ]} ==
             UIValidator.validate(ui)

    ui = %{
      "root" => %{}
    }

    assert {:error,
            [
              {"No type found", "/root"}
            ]} ==
             UIValidator.validate(ui)
  end

  test "bug LENRA-130" do
    ui = %{
      "root" => %{
        "type" => "container",
        "children" => [
          %{
            "type" => "container",
            "children" => [
              %{
                "type" => "textfield",
                "value" => "",
                "listeners" => %{
                  "onChange" => %{
                    "name" => "Category.setName"
                  }
                }
              },
              %{
                "type" => "button",
                "value" => "Save",
                "listeners" => %{
                  "onClick" => %{
                    "name" => "Category.save"
                  }
                }
              }
            ]
          },
          %{
            "type" => "container",
            "children" => [
              %{
                "type" => "button",
                "value" => "+",
                "listeners" => %{
                  "onClick" => %{
                    "name" => "Category.addField"
                  }
                }
              }
            ]
          }
        ]
      }
    }

    assert {
             :error,
             [
               {"Schema does not allow additional properties.", "/root/children/0/children/0/listeners/onChange/name"},
               {"Required property action was not present.", "/root/children/0/children/0/listeners/onChange"},
               {"Schema does not allow additional properties.", "/root/children/0/children/1/listeners/onClick/name"},
               {"Required property action was not present.", "/root/children/0/children/1/listeners/onClick"},
               {"Schema does not allow additional properties.", "/root/children/1/children/0/listeners/onClick/name"},
               {"Required property action was not present.", "/root/children/1/children/0/listeners/onClick"}
             ]
           } ==
             UIValidator.validate(ui)
  end

  test "multiple type error" do
    ui = %{
      "root" => %{
        "type" => "container",
        "children" => [
          %{"value" => "machin"},
          %{"value" => "truc"},
          %{"type" => "truc"},
          %{"type" => "machin"},
          %{"type" => "text"}
        ]
      }
    }

    assert {
             :error,
             [
               {"No type found", "/root/children/0"},
               {"No type found", "/root/children/1"},
               {"Invalid type", "/root/children/2"},
               {"Invalid type", "/root/children/3"},
               {"Required property value was not present.", "/root/children/4"}
             ]
           } ==
             UIValidator.validate(ui)
  end
end
