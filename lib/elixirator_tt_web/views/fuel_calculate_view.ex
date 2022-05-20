defmodule ElixiratorTtWeb.FuelCalculateView do
  use ElixiratorTtWeb, :view

  @welcomeText "Welcome to fuel consumption calculator"

  def getWelcomeText do
    @welcomeText
  end

  def render("index.json", _) do
    %{title: @welcomeText}
  end

  def render("result.json", %{result: result}) do
    %{fuelConsumption: result}
  end
end
