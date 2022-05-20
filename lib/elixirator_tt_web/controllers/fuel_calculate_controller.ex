defmodule ElixiratorTtWeb.FuelCalculateController do
  use ElixiratorTtWeb, :controller

  alias ElixiratorTt.FuelCalculate

  action_fallback ElixiratorTtWeb.FallbackController

  def index(conn, _params) do
    render(conn, :index)
  end

  def calculateFuel(conn, %{"shipMass" => shipMass, "points" => points}) do
    result = FuelCalculate.calculate(shipMass, points)

    render(conn, "result.json", result: result)
  end

  # def create(conn, %{"fuel_calculate" => fuel_calculate_params}) do
  #   with {:ok, %FuelCalculate{} = fuel_calculate} <- Nasa.create_fuel_calculate(fuel_calculate_params) do
  #     conn
  #     |> put_status(:created)
  #     |> put_resp_header("location", Routes.fuel_calculate_path(conn, :show, fuel_calculate))
  #     |> render("show.json", fuel_calculate: fuel_calculate)
  #   end
  # end

  # def show(conn, %{"id" => id}) do
    # fuel_calculate = Nasa.get_fuel_calculate!(id)
    # render(conn, "show.json", fuel_calculate: fuel_calculate)
  # end

  # def update(conn, %{"id" => id, "fuel_calculate" => fuel_calculate_params}) do
    # fuel_calculate = Nasa.get_fuel_calculate!(id)

    # with {:ok, %FuelCalculate{} = fuel_calculate} <- Nasa.update_fuel_calculate(fuel_calculate, fuel_calculate_params) do
    #   render(conn, "show.json", fuel_calculate: fuel_calculate)
    # end
  # end

  # def delete(conn, %{"id" => id}) do
    # fuel_calculate = Nasa.get_fuel_calculate!(id)

    # with {:ok, %FuelCalculate{}} <- Nasa.delete_fuel_calculate(fuel_calculate) do
    #   send_resp(conn, :no_content, "")
    # end
  # end
end
