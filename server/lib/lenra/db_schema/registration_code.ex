defmodule Lenra.RegistrationCode do
  @moduledoc """
    The registration_code shema.
  """
  use Ecto.Schema
  import Ecto.Changeset

  schema "registration_codes" do
    field(:code, :string)
    belongs_to(:user, Lenra.User)
    timestamps()
  end

  @spec changeset(
          {map, map} | %{:__struct__ => atom | %{__changeset__: map}, optional(atom) => any},
          :invalid | %{optional(:__struct__) => none, optional(atom | binary) => any}
        ) :: Ecto.Changeset.t()
  def changeset(registration_code, params \\ %{}) do
    registration_code
    |> cast(params, [:code])
    |> validate_required([:code])
    |> unique_constraint([:user_id, :code])
    |> validate_length(:code, min: 8, max: 8)
  end

  def new(user, code) do
    Ecto.build_assoc(user, :registration_code)
    |> changeset(%{code: code})
  end
end
