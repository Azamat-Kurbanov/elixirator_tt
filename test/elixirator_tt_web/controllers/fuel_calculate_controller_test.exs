defmodule ElixiratorTtWeb.FuelCalculateControllerTest do
  use ElixiratorTtWeb.ConnCase

  alias ElixiratorTtWeb.FuelCalculateView

  @nilData %{ship_mass: nil, points: nil}
  @wrongFieldName %{
    ship_mass: 28880,
    pointc: [%{launch: 2.3,land: 2.3}]
  }

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "content-type", "application/json")}
  end

  describe "index" do
    test "welcome text", %{conn: conn} do
      conn = get(conn, Routes.fuel_calculate_path(conn, :index))
      assert json_response(conn, 200)["title"] == FuelCalculateView.getWelcomeText()
    end
  end

  describe "calculate fuel consumption" do
    test "with valid data", %{conn: conn} do
      request_body = OpenApiSpex.Schema.example(ElixiratorTtWeb.Schemas.FuelConsumptionRequest.schema())

      conn = post(conn, Routes.fuel_calculate_path(conn, :calculateFuel), request_body)

      assert is_number(json_response(conn, 200)["fuel_consumption"])
    end

    test "renders error when data is nil", %{conn: conn} do
      conn = post(conn, Routes.fuel_calculate_path(conn, :calculateFuel), @nilData)

      assert json_response(conn, 422)["errors"] != %{}
    end

    test "renders error when field name is not correct", %{conn: conn} do
      conn = post(conn, Routes.fuel_calculate_path(conn, :calculateFuel), @wrongFieldName)

      assert json_response(conn, 422)["errors"] != %{}
    end
  end
end
