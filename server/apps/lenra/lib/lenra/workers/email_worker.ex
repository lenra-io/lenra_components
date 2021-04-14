defmodule LenraServices.EmailWorker do
  @moduledoc """
    Worker to use for send email
  """
  require Logger

  alias Lenra.User

  def add_email_verification_event(user, code) do
    EventQueue.add_event(:email_verification, [user, code])
  end

  def email_verification(
        %User{} = user,
        code
      ) do
    LenraServices.EmailService.welcome_text_email(user.email, user.first_name, code)
    |> Lenra.Mailer.deliver_now()
  end
end
