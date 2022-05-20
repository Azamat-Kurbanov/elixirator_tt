defmodule ElixiratorTtWeb.FuelCalculateController do
  use ElixiratorTtWeb, :controller

  alias ElixiratorTt.FuelCalculate

  action_fallback ElixiratorTtWeb.FallbackController

  def index(conn, _params) do
    render(conn, :index)
  end

  def calculateFuel(conn, %{"shipMass" => shipMass, "points" => points}) do
    with {:ok, result} <- FuelCalculate.calculate(shipMass, points) do
      render(conn, "result.json", result: result)
    end
  end
end
