defmodule LenraWeb.UserControllerTest do
  @moduledoc """
    Test the `LenraWeb.UserControllerTest` module
  """
  use LenraWeb.ConnCase
  use Bamboo.Test, shared: true

  @john_doe_user_params %{
    "first_name" => "John",
    "last_name" => "Doe",
    "email" => "john.doe@lenra.fr",
    "password" => "johndoethefirst"
  }

  test "register test", %{conn: conn} do
    conn = post(conn, Routes.user_path(conn, :register, @john_doe_user_params))

    assert %{"data" => data, "success" => true} = json_response(conn, 200)
    assert Map.has_key?(data, "access_token")
  end

  test "register error test", %{conn: conn} do
    conn =
      post(
        conn,
        Routes.user_path(conn, :register, %{
          "first_name" => "",
          "last_name" => "Doe",
          "email" => "john.doe@lenra.fr",
          "password" => "johndoethefirst"
        })
      )

    assert %{"errors" => [%{"code" => 0, "message" => "first_name : can't be blank"}]} = json_response(conn, 400)
  end

  test "login test", %{conn: conn} do
    post(conn, Routes.user_path(conn, :register, @john_doe_user_params))

    conn =
      post(
        conn,
        Routes.user_path(conn, :login, %{
          "email" => "john.doe@lenra.fr",
          "password" => "johndoethefirst"
        })
      )

    assert %{"data" => data, "success" => true} = json_response(conn, 200)
    assert Map.has_key?(data, "access_token")
  end

  test "login incorrect email or password test", %{conn: conn} do
    post(conn, Routes.user_path(conn, :register, @john_doe_user_params))

    conn =
      post(
        conn,
        Routes.user_path(conn, :login, %{
          "email" => "john.doe@lenra.fr",
          "password" => "incorrect"
        })
      )

    assert %{"errors" => [%{"code" => 4, "message" => "Incorrect email or password"}]} = json_response(conn, 200)
  end

  test "refresh not authenticated test", %{conn: conn} do
    conn = post(conn, Routes.user_path(conn, :refresh))

    assert %{"errors" => [%{"code" => 401, "message" => "You are not authenticated"}], "success" => false} =
             json_response(conn, 401)
  end

  test "refresh authenticated test", %{conn: conn} do
    conn_register = post(conn, Routes.user_path(conn, :register, @john_doe_user_params))

    conn = post(conn_register, Routes.user_path(conn_register, :refresh))

    assert %{"data" => data, "success" => true} = json_response(conn, 200)
    assert Map.has_key?(data, "access_token")
  end

  test "logout test", %{conn: conn} do
    conn = post(conn, Routes.user_path(conn, :register, @john_doe_user_params))

    conn = post(conn, Routes.user_path(conn, :logout))

    assert %{"success" => true} = json_response(conn, 200)
  end

  test "code verification test", %{conn: conn} do
    conn = post(conn, Routes.user_path(conn, :register, @john_doe_user_params))
    assert_receive({:delivered_email, _email})

    email = @john_doe_user_params["email"]
    user = Lenra.Repo.get_by(Lenra.User, email: email)

    user = Lenra.Repo.preload(user, :registration_code)

    conn =
      post(
        conn,
        Routes.user_path(conn, :check_registration_code, %{"code" => user.registration_code.code})
      )

    assert %{"data" => data, "success" => true} = json_response(conn, 200)
    assert Map.has_key?(data, "access_token")
  end

  test "code verification error test", %{conn: conn} do
    conn = post(conn, Routes.user_path(conn, :register, @john_doe_user_params))

    conn = post(conn, Routes.user_path(conn, :check_registration_code, %{"code" => "12345678"}))

    assert %{"errors" => [%{"code" => 5, "message" => "No such registration code"}]} = json_response(conn, 200)
  end
end
