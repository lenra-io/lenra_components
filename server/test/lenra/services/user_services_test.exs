defmodule LenraServices.UserTest do
  use Lenra.RepoCase

  test "sign_up user should succeed with no password field returned" do
    {:ok, user} =
      LenraServices.User.sign_up("John", "Doe", "john.doe@lenra.fr", "johndoethefirst")

    assert %LenraSchema.User{
             first_name: "John",
             last_name: "Doe",
             email: "john.doe@lenra.fr"
           } = user

    assert not Map.has_key?(user, :password)
  end

  test "sign_up should fail if email already exists" do
    {:ok, _} = LenraServices.User.sign_up("John", "Doe", "john@lenra.fr", "johndoethefirst")

    {:error, changeset} =
      LenraServices.User.sign_up("John", "Snow", "john@lenra.fr", "johndoethefirst")

    assert not changeset.valid?

    assert changeset.errors == [
             {:email,
              {"has already been taken",
               [constraint: :unique, constraint_name: "users_email_index"]}}
           ]
  end

  test "sign_up should fail if email malformated" do
    {:error, changeset} =
      LenraServices.User.sign_up("John", "Snow", "johnlenra.fr", "johndoethefirst")

    assert not changeset.valid?

    assert changeset.errors == [
             email: {"has invalid format", [validation: :format]}
           ]
  end

  test "sign_up should fail if password too short" do
    {:error, changeset} = LenraServices.User.sign_up("John", "Snow", "john@lenra.fr", "johndoe")

    assert not changeset.valid?

    assert changeset.errors == [
             password:
               {"should be at least %{count} character(s)",
                [{:count, 8}, {:validation, :length}, {:kind, :min}, {:type, :string}]}
           ]
  end

  test "sign_up should fail if first_name not specified" do
    {:error, changeset} = LenraServices.User.sign_up("", "Snow", "john@lenra.fr", "johndoedu59")

    assert not changeset.valid?

    assert changeset.errors == [
             {:first_name, {"can't be blank", [validation: :required]}}
           ]
  end

  test "sign_up should fail if last_name not specified" do
    {:error, changeset} = LenraServices.User.sign_up("John", "", "john@lenra.fr", "johndoedu59")

    assert not changeset.valid?

    assert changeset.errors == [
             {:last_name, {"can't be blank", [validation: :required]}}
           ]
  end

  test "sign_up should fail if email not specified" do
    {:error, changeset} = LenraServices.User.sign_up("John", "Doe", "", "johndoedu59")

    assert not changeset.valid?

    assert changeset.errors == [
             {:email, {"can't be blank", [validation: :required]}}
           ]
  end

  test "sign_in user should succeed with no password field returned event with caps" do
    {:ok, _} = LenraServices.User.sign_up("John", "Doe", "john.doe@lenra.fr", "johndoethefirst")

    {:ok, user} = LenraServices.User.sign_in("John.Doe@Lenra.FR", "johndoethefirst")

    assert %LenraSchema.User{
             first_name: "John",
             last_name: "Doe",
             email: "john.doe@lenra.fr"
           } = user

    assert not Map.has_key?(user, :password)
  end

  test "sign_in user should fail with no wrong email" do
    {:ok, _} = LenraServices.User.sign_up("John", "Doe", "john.doe@lenra.fr", "johndoethefirst")

    assert {:error, "Email or password incorrect."} ==
             LenraServices.User.sign_in("John@Lenra.FR", "johndoethefirst")
  end

  test "sign_in user should fail with no wrong password" do
    {:ok, _} = LenraServices.User.sign_up("John", "Doe", "john.doe@lenra.fr", "johndoethefirst")

    assert {:error, "Email or password incorrect."} ==
             LenraServices.User.sign_in("John.Doe@Lenra.FR", "johndoethesecond")
  end
end
