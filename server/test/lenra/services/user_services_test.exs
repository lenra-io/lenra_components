defmodule UserServicesTest do
  use Lenra.RepoCase
  alias Lenra.User
  alias LenraServices.UserServices

  test "register user should succeed" do
    {:ok, %{user: user, registration_code: registration_code}} = register_john_doe()

    assert user.first_name == "John"
    assert user.last_name == "Doe"
    assert user.email == "john.doe@lenra.fr"
    assert user.role == User.const_unvalidated_user_role()

    assert String.length(registration_code.code) == 8
  end

  test "register should fail if email already exists" do
    {:ok, _} = register_john_doe()

    {:error, _step, changeset, _} = register_john_doe()

    assert not changeset.valid?

    assert changeset.errors == [
             {:email,
              {"has already been taken",
               [constraint: :unique, constraint_name: "users_email_index"]}}
           ]
  end

  test "register should fail if email malformated" do
    {:error, _step, changeset, _} = register_john_doe(%{"email" => "johnlenra.fr"})

    assert not changeset.valid?

    assert changeset.errors == [
             email: {"has invalid format", [validation: :format]}
           ]
  end

  test "register should fail if first_name not specified" do
    {:error, _step, changeset, _} = register_john_doe(%{"first_name" => ""})

    assert not changeset.valid?

    assert changeset.errors == [
             {:first_name, {"can't be blank", [validation: :required]}}
           ]
  end

  test "register should fail if last_name not specified" do
    {:error, _step, changeset, _} = register_john_doe(%{"last_name" => ""})

    assert not changeset.valid?

    assert changeset.errors == [
             {:last_name, {"can't be blank", [validation: :required]}}
           ]
  end

  test "register should fail if email not specified" do
    {:error, _step, changeset, _} = register_john_doe(%{"email" => ""})

    assert not changeset.valid?

    assert changeset.errors == [
             {:email, {"can't be blank", [validation: :required]}}
           ]
  end

  test "login user should succeed event with caps" do
    {:ok, _} = register_john_doe()

    {:ok, user} = UserServices.login("John.Doe@Lenra.FR", "johndoethefirst")

    assert %User{
             first_name: "John",
             last_name: "Doe",
             email: "john.doe@lenra.fr"
           } = user
  end

  test "sign_in user should fail with wrong email" do
    {:ok, _} = register_john_doe()

    assert {:error, :email_or_password_incorrect} ==
             UserServices.login("John@Lenra.FR", "johndoethefirst")
  end

  test "sign_in user should fail with wrong password" do
    {:ok, _} = register_john_doe()

    assert {:error, :email_or_password_incorrect} ==
             UserServices.login("John.Doe@Lenra.FR", "johndoethesecond")
  end
end
