defmodule LenraWeb.AppChannelTest do
  @moduledoc """
    Test the `LenraWeb.AppChannel` module
  """
  use LenraWeb.ChannelCase
  alias LenraWeb.AppStub, as: AppStub

  setup do
    socket = socket(LenraWeb.UserSocket, "socket_id", %{})

    owstub = AppStub.create_owstub()

    %{socket: socket, owstub: owstub}
  end

  test "No app called, should return an error", %{socket: socket} do
    res = my_subscribe_and_join(socket)
    assert {:error, %{reason: "No App Name"}} == res
    refute_push "ui", _
  end

  @app_name "Counter"
  @listener_name "HiBob"
  @listener_code "42:#{@app_name}:#{@listener_name}:{}"

  @data %{"user" => %{"name" => "World"}}
  @data2 %{"user" => %{"name" => "Bob"}}

  @listeners %{"onClick" => %{"name" => @listener_name}}
  @transformed_listeners %{"onClick" => %{"code" => @listener_code}}

  @textfield %{
    "type" => "textfield",
    "value" => "Hello {{user.name}}",
    "listeners" => @listeners
  }

  @transformed_textfield %{
    "type" => "textfield",
    "value" => "Hello World",
    "listeners" => @transformed_listeners
  }

  @ui %{"root" => @textfield}

  @expected_ui %{"root" => @transformed_textfield}
  @expected_patch_ui %{
    patch: [%{"op" => "replace", "path" => "/root/value", "value" => "Hello Bob"}]
  }

  test "Base use case with simple app", %{socket: socket, owstub: owstub} do
    # Base use case. Call InitData then MainUI then call the listener
    # and the next MainUI should not be called but taken from cache instead
    owstub
    |> AppStub.stub_app(@app_name)
    |> AppStub.stub_action_once("InitData", @data)
    |> AppStub.stub_action_once("MainUi", @ui)
    |> AppStub.stub_action_once(@listener_name, @data2)

    # Join the channel
    {:ok, _, socket} = my_subscribe_and_join(socket, %{"app" => @app_name})

    # Check that the correct data is stored into the socket
    assert socket.assigns == %{app_name: @app_name, client_id: 42}

    # Check that we receive a "ui" event with the final UI
    assert_push "ui", @expected_ui

    # We simulate an event from the UI
    push(socket, "run", %{"code" => @listener_code})

    # Check that we receive a "patchUi" event with corresponding patch
    assert_push "patchUi", @expected_patch_ui
  end

  defp my_subscribe_and_join(socket, params \\ %{}) do
    subscribe_and_join(socket, LenraWeb.AppChannel, "app", params)
  end
end
