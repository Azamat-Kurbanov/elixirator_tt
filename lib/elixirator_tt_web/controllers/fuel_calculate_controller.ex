defmodule ElixiratorTtWeb.FuelCalculateController do
  use ElixiratorTtWeb, :controller
  use OpenApiSpex.ControllerSpecs

  alias ElixiratorTt.FuelCalculate
  alias ElixiratorTtWeb.Schemas.{FuelConsumptionRequest, FuelConsumptionResponse}
  alias ElixiratorTtWeb.Schemas.{IndexResponse, FuelConsumptionError}

  plug OpenApiSpex.Plug.CastAndValidate, json_render_error_v2: true

  action_fallback ElixiratorTtWeb.FallbackController

  operation :index,
    summary: "Welcome text",
    description: "Welcome text",
    responses: [
      ok: {"Index response", "application/json", IndexResponse}
    ]

  def index(conn, _params) do
    render(conn, :index)
  end

  operation :calculateFuel,
    summary: "Calculate fuel consumption",
    request_body: {"Fuel consumption params", "application/json", FuelConsumptionRequest, required: true},
    responses: [
      ok: {"Fuel consumption response", "application/json", FuelConsumptionResponse},
      bad_request: {"Bad request", "application/json", FuelConsumptionError},
      internal_server_error: {"Internal Server Error", "application/json", FuelConsumptionError}
    ]
  def calculateFuel(conn = %{body_params: %FuelConsumptionRequest{ship_mass: ship_mass, points: points}}, _params) do
    with {:ok, result} <- FuelCalculate.calculate(ship_mass, points) do
      render(conn, "result.json", result: result)
    end
  end
end
