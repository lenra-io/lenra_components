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
    "password" => "johndoethefirst",
    "password_confirmation" => "johndoethefirst"
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
        Routes.user_path(conn, :validate_user, %{"code" => user.registration_code.code})
      )

    assert %{"data" => data, "success" => true} = json_response(conn, 200)
    assert Map.has_key?(data, "access_token")
  end

  test "code verification error test", %{conn: conn} do
    conn = post(conn, Routes.user_path(conn, :register, @john_doe_user_params))

    conn = post(conn, Routes.user_path(conn, :validate_user, %{"code" => "12345678"}))

    assert %{"errors" => [%{"code" => 5, "message" => "No such registration code"}]} = json_response(conn, 200)
  end

  @tag :user_authentication
  test "change password test", %{conn: conn} do
    new_password = "newpassword"

    put(
      conn,
      Routes.user_path(conn, :password_modification, %{
        "old_password" => "johndoethefirst",
        "password" => new_password,
        "password_confirmation" => new_password
      })
    )

    conn =
      post(
        conn,
        Routes.user_path(conn, :login, %{
          "email" => "john.doe@lenra.fr",
          "password" => new_password
        })
      )

    assert %{"data" => data, "success" => true} = json_response(conn, 200)
    assert Map.has_key?(data, "access_token")
  end

  @tag :user_authentication
  test "change password error test", %{conn: conn} do
    conn =
      put(
        conn,
        Routes.user_path(conn, :password_modification, %{
          "old_password" => "johndoethefirst",
          "password" => "johndoethefirst",
          "password_confirmation" => "johndoethefirst"
        })
      )

    assert %{
             "success" => false,
             "errors" => [%{"code" => 8, "message" => "Your password cannot be equal to the last 3."}]
           } = json_response(conn, 200)
  end

  test "change lost password test", %{conn: conn} do
    new_password = "new_password"

    conn = post(conn, Routes.user_path(conn, :register, @john_doe_user_params))

    conn =
      post(
        conn,
        Routes.user_path(conn, :password_lost_code, %{
          "email" => @john_doe_user_params["email"]
        })
      )

    [user | _tails] = Lenra.Repo.all(Lenra.User)
    password_code = Lenra.Repo.get_by(Lenra.PasswordCode, user_id: user.id)

    conn =
      put(
        conn,
        Routes.user_path(conn, :password_lost_modification, %{
          "email" => @john_doe_user_params["email"],
          "code" => password_code.code,
          "password" => new_password,
          "password_confirmation" => new_password
        })
      )

    conn =
      post(
        conn,
        Routes.user_path(conn, :login, %{
          "email" => @john_doe_user_params["email"],
          "password" => new_password
        })
      )

    assert %{"data" => data, "success" => true} = json_response(conn, 200)
    assert Map.has_key?(data, "access_token")
  end

  test "change lost password wrong email test", %{conn: conn} do
    post(conn, Routes.user_path(conn, :register, @john_doe_user_params))

    conn = post(conn, Routes.user_path(conn, :password_lost_code, %{email: "wrong@email.me"}))

    assert %{"success" => false, "errors" => [%{"code" => 9, "message" => "Incorrect email"}]} =
             json_response(conn, 200)
  end

  test "change lost password error code test", %{conn: conn} do
    post(conn, Routes.user_path(conn, :register, @john_doe_user_params))

    post(conn, Routes.user_path(conn, :password_lost_code, @john_doe_user_params))

    conn =
      put(
        conn,
        Routes.user_path(conn, :password_lost_modification, %{
          "email" => @john_doe_user_params["email"],
          "code" => "00000000",
          "password" => "johndoethefirst",
          "password_confirmation" => "johndoethefirst"
        })
      )

    assert %{"success" => false, "errors" => [%{"code" => 6, "message" => "No such password lost code"}]} =
             json_response(conn, 200)
  end

  test "change lost password error password test", %{conn: conn} do
    post(conn, Routes.user_path(conn, :register, @john_doe_user_params))

    post(conn, Routes.user_path(conn, :password_lost_code, @john_doe_user_params))

    [user | _tails] = Lenra.Repo.all(Lenra.User)
    password_code = Lenra.Repo.get_by(Lenra.PasswordCode, user_id: user.id)

    conn =
      put(
        conn,
        Routes.user_path(conn, :password_lost_modification, %{
          "email" => @john_doe_user_params["email"],
          "code" => password_code.code,
          "password" => "johndoethefirst",
          "password_confirmation" => "johndoethefirst"
        })
      )

    assert %{
             "success" => false,
             "errors" => [%{"code" => 8, "message" => "Your password cannot be equal to the last 3."}]
           } = json_response(conn, 200)
  end

  @tag :user_authentication
  test "change password code 4 time with password 1 test", %{conn: conn} do
    new_password = "newpassword"
    new_password_2 = "newpassword2"
    new_password_3 = "newpassword3"

    conn =
      put(
        conn,
        Routes.user_path(conn, :password_modification, %{
          "old_password" => "johndoethefirst",
          "password" => new_password,
          "password_confirmation" => new_password
        })
      )

    conn =
      put(
        conn,
        Routes.user_path(conn, :password_modification, %{
          "old_password" => new_password,
          "password" => new_password_2,
          "password_confirmation" => new_password_2
        })
      )

    conn =
      put(
        conn,
        Routes.user_path(conn, :password_modification, %{
          "old_password" => new_password_2,
          "password" => new_password_3,
          "password_confirmation" => new_password_3
        })
      )

    conn =
      put(
        conn,
        Routes.user_path(conn, :password_modification, %{
          "old_password" => new_password_3,
          "password" => "johndoethefirst",
          "password_confirmation" => "johndoethefirst"
        })
      )

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
end
