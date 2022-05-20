defmodule ElixiratorTtWeb.FuelCalculateView do
  use ElixiratorTtWeb, :view
  # alias ElixiratorTtWeb.FuelCalculateView

  def render("index.json", _) do
    %{title: "Welcome to fuel consumption calculator"}
  end

  def render("result.json", %{result: result}) do
    %{
      data: %{
        result: result
      }
    }
  end

  # def render("show.json", %{fuel_calculate: fuel_calculate}) do
  #   %{data: render_one(fuel_calculate, FuelCalculateView, "fuel_calculate.json")}
  # end

  # def render("fuel_calculate.json", %{fuel_calculate: fuel_calculate}) do
  #   %{
  #     id: fuel_calculate.id,
  #     shipMass: fuel_calculate.shipMass,
  #     points: fuel_calculate.points
  #   }
  # end
end
