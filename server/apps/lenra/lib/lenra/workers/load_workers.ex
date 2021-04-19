defmodule LenraServices.LoadWorker do
  @moduledoc """
    function to load worker in eventQueue
  """
  alias LenraServices.EmailWorker

  def load do
    EventQueue.add_worker(EmailWorker, :email_verification)
    EventQueue.add_worker(EmailWorker, :email_password_lost)
  end
end
