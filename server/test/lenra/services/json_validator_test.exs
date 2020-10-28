defmodule LenraServices.JsonValidatorTest do
  @moduledoc """
    Test the `LenraServices.JsonValidator` module
  """
  use ExUnit.Case, async: true
  doctest LenraServices.JsonValidator

  test "Validator correctly handle valide text" do
    schema_valide = %{
      type: "text",
      value: "Txt test"
    }

    assert {:ok, "Schema valide"} ==
             LenraServices.JsonValidator.validate_json("text", schema_valide)
  end

  test "Validator correctly handle invalide text" do
    schema_invalide = %{
      type: "Test",
      value: "Txt test"
    }

    assert {:error, %{properties: %{"type" => %{pattern: ~r/text/, value: "Test"}}}} ==
             LenraServices.JsonValidator.validate_json("text", schema_invalide)
  end

  test "Validator correctly handle valide container" do
    schema_valide = %{
      type: "container",
      children: [
        %{
          type: "text",
          value: "Txt test"
        }
      ]
    }

    assert {:ok, "Schema valide"} ==
             LenraServices.JsonValidator.validate_json("container", schema_valide)
  end

  test "Validator correctly handle empty container" do
    schema_valide = %{
      type: "container",
      children: []
    }

    assert {:ok, "Schema valide"} ==
             LenraServices.JsonValidator.validate_json("container", schema_valide)
  end

  test "Validator correctly handle invalide container" do
    schema_invalide = %{
      type: "container",
      children: [
        %{
          type: "text",
          value: "Txt test"
        },
        %{
          type: "New"
        }
      ]
    }

    assert {:error,
            %{
              properties: %{
                "children" => %{
                  items: %{
                    1 => %{
                      anyOf: [
                        %{required: ["listeners", "value"]},
                        %{required: ["value"]},
                        %{required: ["listeners", "value"]},
                        %{required: ["children"]}
                      ],
                      value: %{"type" => "New"}
                    }
                  }
                }
              }
            }} ==
             LenraServices.JsonValidator.validate_json("container", schema_invalide)
  end

  test "Validator correctly handle valide textfield" do
    schema_valide = %{
      type: "textfield",
      value: "",
      listeners: %{
        onChange: %{
          name: "",
          props: %{
            number: 10,
            value: "value"
          }
        }
      }
    }

    assert {:ok, "Schema valide"} ==
             LenraServices.JsonValidator.validate_json("textfield", schema_valide)
  end

  test "Validator correctly handle invalide textfield" do
    schema_invalide = %{
      type: "textfield",
      value: "",
      listeners: %{
        onChange: %{
          name: 10,
          props: %{
            number: 10,
            value: "value"
          }
        }
      }
    }

    assert {:error,
            %{
              properties: %{
                "listeners" => %{
                  oneOf:
                    {:error,
                     [
                       %{properties: %{"onChange" => %{additionalProperties: false}}},
                       %{
                         properties: %{
                           "onChange" => %{properties: %{"name" => %{type: "string", value: 10}}}
                         }
                       }
                     ]},
                  value: %{
                    "onChange" => %{
                      "name" => 10,
                      "props" => %{"number" => 10, "value" => "value"}
                    }
                  }
                }
              }
            }} ==
             LenraServices.JsonValidator.validate_json("textfield", schema_invalide)
  end

  test "Validator correctly handle valide button" do
    schema_valide = %{
      type: "button",
      value: "",
      listeners: %{
        onChange: %{
          name: "",
          props: %{
            number: 10,
            value: "value"
          }
        }
      }
    }

    assert {:ok, "Schema valide"} ==
             LenraServices.JsonValidator.validate_json("button", schema_valide)
  end

  test "Validator correctly handle invalide button" do
    schema_invalide = %{
      type: "button",
      value: "",
      listeners: %{
        onChange: %{
          name: 10,
          props: %{
            number: 10,
            value: "value"
          }
        }
      }
    }

    assert {:error,
            %{
              properties: %{
                "listeners" => %{
                  oneOf:
                    {:error,
                     [
                       %{properties: %{"onChange" => %{additionalProperties: false}}},
                       %{
                         properties: %{
                           "onChange" => %{properties: %{"name" => %{type: "string", value: 10}}}
                         }
                       }
                     ]},
                  value: %{
                    "onChange" => %{
                      "name" => 10,
                      "props" => %{"number" => 10, "value" => "value"}
                    }
                  }
                }
              }
            }} ==
             LenraServices.JsonValidator.validate_json("button", schema_invalide)
  end

  test "Validator correctly handle valide ui" do
    schema_valide = %{
      type: "ui",
      name: "MyUimethod",
      props: %{
        val: "Myval",
        val2: 06
      }
    }

    assert {:ok, "Schema valide"} ==
             LenraServices.JsonValidator.validate_json("ui", schema_valide)
  end

  test "Validator correctly handle invalide ui" do
    schema_invalide = %{
      type: "Ui",
      name: "MyUimethod",
      props: %{
        val: "Myval",
        val2: 06
      }
    }

    assert {:error, %{properties: %{"type" => %{pattern: ~r/ui/, value: "Ui"}}}} ==
             LenraServices.JsonValidator.validate_json("ui", schema_invalide)
  end
end
