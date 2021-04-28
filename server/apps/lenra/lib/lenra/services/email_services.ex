defmodule Lenra.EmailService do
  @moduledoc false

  import Bamboo.Email

  def welcome_text_email(email_address, user_name, code) do
    # base template ID : d-bd160809d9a04b07ac6925a823f8f61c
    new_email()
    |> to(email_address)
    |> from("subscription@lenra.me")
    |> subject("Bienvenue!")
    |> text_body("Bienvenue chez Lenra " <> user_name <> " ! " <> "Votre code: " <> code)
  end

  def recovery_email(email_address, user_name, code) do
    new_email()
    |> to(email_address)
    |> from("verification@lenra.me")
    |> subject("Votre code de vérification!")
    |> text_body("Bonjour " <> user_name <> " ! " <> "Votre code: " <> code)
  end
end
