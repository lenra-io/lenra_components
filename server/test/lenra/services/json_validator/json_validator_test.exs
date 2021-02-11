defmodule LenraServices.JsonValidatorTest do
  use ExUnit.Case, async: true

  @moduledoc """
    Test the `LenraServer.JsonValidator` module
  """
  alias LenraServices.JsonValidator

  doctest JsonValidator

  setup do
    %{
      datastore:
        ExJsonSchema.Schema.resolve(%{
          "type" => "array",
          "items" => %{
            "properties" => %{
              "type" => %{
                "type" => "string"
              }
            }
          },
          "minItems" => 1,
          "maxItems" => 2
        })
    }
  end

  test "invalide schema" do
    schema =
      ExJsonSchema.Schema.resolve(%{
        "type" => "object",
        "allOf" => [
          %{
            "oneOf" => [
              %{
                "properties" => %{
                  "type" => %{
                    "type" => "string",
                    "pattern" => "^button$"
                  }
                }
              }
            ]
          },
          %{
            "anyOf" => [
              %{
                "properties" => %{
                  "value" => %{
                    "type" => "number",
                    "minimum" => 50,
                    "exclusiveMinimum" => true,
                    "maximum" => 30,
                    "exclusiveMaximum" => true,
                    "multipleOf" => 10
                  }
                },
                "minProperties" => 5,
                "maxProperties" => 1
              },
              %{
                "properties" => %{
                  "str" => %{
                    "type" => "string",
                    "minLength" => 10,
                    "maxLength" => 2
                  }
                },
                "dependencies" => %{
                  "str" => ["test"]
                }
              }
            ]
          }
        ]
      })

    json = %{
      "type" => "text",
      "value" => 42,
      "str" => "test"
    }

    assert {
             :error,
             [
               {"", "The component has incorrect type.", :type_invalid_found},
               {"", "Expected a maximum of 1 properties but got 3", :object_error},
               {"", "Expected a minimum of 5 properties but got 3", :object_error},
               {"", "Property \"str\" depends on property \"test\" to be present but it was not.", :object_error},
               {"/str", "Expected value to have a maximum length of 2 but was 4.", :object_error},
               {"/str", "Expected value to have a minimum length of 10 but was 4.", :object_error},
               {"/value", "Expected the value to be < 30", :object_error},
               {"/value", "Expected the value to be > 50", :object_error},
               {"/value", "Expected value to be a multiple of 10.", :object_error}
             ]
           } ==
             JsonValidator.validate_json(schema, json)
  end

  test "invalide empty datastore", %{datastore: schema} do
    json = []

    assert {:error, [{"", "Expected a minimum of 1 items but got 0.", :object_error}]} ==
             JsonValidator.validate_json(schema, json)
  end

  test "invalide toomuch datastores", %{datastore: schema} do
    json = [
      %{
        "type" => "local",
        "value" => "Txt test"
      },
      %{
        "type" => "ref",
        "value" => "Txt test"
      },
      %{
        "type" => "ref",
        "value" => "2"
      }
    ]

    assert {:error, [{"", "Expected a maximum of 2 items but got 3.", :object_error}]} ==
             JsonValidator.validate_json(schema, json)
  end
end
