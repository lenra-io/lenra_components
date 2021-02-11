defmodule LenraWeb.BaseView do
  use LenraWeb, :view
  require Logger

  # def render("success.json", %{}) do
  #   %{"ok" => "200"}
  # end

  def render("success.json", %{data: data}) do
    %{
      "ok" => "200",
      "data" => data
    }
  end

  def render("success.json", _) do
    %{
      "ok" => "200"
    }
  end

  def render("error.json", %{errors: errors}) do
    %{"errors" => translate_errors(errors)}
  end
end
