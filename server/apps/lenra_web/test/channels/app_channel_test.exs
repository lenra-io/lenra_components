defmodule LenraWeb.AppChannelTest do
  @moduledoc """
    Test the `LenraWeb.AppChannel` module
  """
  use LenraWeb.ChannelCase
  alias LenraWeb.UserSocket
  alias Lenra.FaasStub, as: AppStub
  alias Lenra.LenraApplicationServices

  setup do
    {:ok, %{inserted_user: user}} = register_john_doe()
    socket = socket(UserSocket, "socket_id", %{user_id: user.id})

    owstub = AppStub.create_faas_stub()

    %{socket: socket, owstub: owstub, user: user}
  end

  test "No app called, should return an error", %{socket: socket} do
    res = my_subscribe_and_join(socket)
    assert {:error, %{reason: "No App Name"}} == res
    refute_push("ui", _)
  end

  @app_name "Counter"
  @listener_name "HiBob"
  @listener_code "#{@listener_name}:{}"

  @data %{"user" => %{"name" => "World"}}
  @data2 %{"user" => %{"name" => "Bob"}}

  @listeners %{"onChange" => %{"action" => @listener_name}}
  @transformed_listeners %{"onChange" => %{"code" => @listener_code}}

  @textfield %{
    "type" => "textfield",
    "value" => "Hello World",
    "listeners" => @listeners
  }

  @textfield2 %{
    "type" => "textfield",
    "value" => "Hello Bob",
    "listeners" => @listeners
  }

  @transformed_textfield %{
    "type" => "textfield",
    "value" => "Hello World",
    "listeners" => @transformed_listeners
  }

  @ui %{"root" => %{"type" => "container", "children" => [@textfield]}}
  @ui2 %{"root" => %{"type" => "container", "children" => [@textfield2]}}

  @expected_ui %{"root" => %{"type" => "container", "children" => [@transformed_textfield]}}
  @expected_patch_ui %{
    patch: [%{"op" => "replace", "path" => "/root/children/0/value", "value" => "Hello Bob"}]
  }

  test "Base use case with simple app", %{socket: socket, owstub: owstub, user: user} do
    # owstub
    # |> AppStub.expect_deploy_app_once(%{"ok" => "200"})

    LenraApplicationServices.create(user.id, %{
      name: "Counter",
      service_name: "counter",
      color: "FFFFFF",
      icon: "60189"
    })

    # Base use case. Call InitData then MainUI then call the listener
    # and the next MainUI should not be called but taken from cache instead
    owstub
    |> AppStub.stub_app(@app_name)
    |> AppStub.stub_action_once("InitData", %{"data" => @data, "ui" => @ui})
    |> AppStub.stub_action_once(@listener_name, %{"data" => @data2, "ui" => @ui2})

    # Join the channel
    {:ok, _, socket} = my_subscribe_and_join(socket, %{"app" => @app_name})

    # Check that the correct data is stored into the socket
    assert socket.assigns == %{app_name: @app_name, user_id: user.id}

    # Check that we receive a "ui" event with the final UI
    assert_push("ui", @expected_ui)

    # We simulate an event from the UI
    push(socket, "run", %{"code" => @listener_code})

    # Check that we receive a "patchUi" event with corresponding patch
    assert_push("patchUi", @expected_patch_ui)

    Process.unlink(socket.channel_pid)
    ref = leave(socket)

    assert_reply(ref, :ok)

    # Waiting for monitor to write measurements in db
    :timer.sleep(500)
  end

  defp my_subscribe_and_join(socket, params \\ %{}) do
    subscribe_and_join(socket, LenraWeb.AppChannel, "app", params)
  end
end
