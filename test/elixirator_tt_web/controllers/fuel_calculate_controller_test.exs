defmodule ElixiratorTtWeb.FuelCalculateControllerTest do
  use ElixiratorTtWeb.ConnCase

  alias ElixiratorTt.FuelCalculate
  alias ElixiratorTtWeb.FuelCalculateView

  @validPayload %{
    shipMass: 28801,
    points: [
      %{
        launch: 9.807,
        land: 1.62
      },
      %{
        launch: 1.62,
        land: 9.807
      }
    ]
  }

  @payload400Error %{shipMass: nil, points: nil}
  @payload500Error %{
    shipMass: 28880,
    points: [%{launcho: 2.3}]
  }

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "welcome text", %{conn: conn} do
      conn = get(conn, Routes.fuel_calculate_path(conn, :index))
      assert json_response(conn, 200)["title"] == FuelCalculateView.getWelcomeText()
    end
  end

  describe "calculate fuel consumption" do
    test "calculate with valid data", %{conn: conn} do
      conn = post(conn, Routes.fuel_calculate_path(conn, :calculateFuel), @validPayload)

      assert json_response(conn, 200)["fuelConsumption"] == 36778
    end

    test "renders bad request errors when data is nil", %{conn: conn} do
      conn = post(conn, Routes.fuel_calculate_path(conn, :calculateFuel), @payload400Error)

      assert json_response(conn, 400)["errors"] != %{}
    end

    test "renders inernal server error when atom is not correct", %{conn: conn} do
      conn = post(conn, Routes.fuel_calculate_path(conn, :calculateFuel), @payload500Error)

      assert json_response(conn, 500)["errors"] != %{}
    end
  end

  # describe "create fuel_calculate" do
  #   test "renders fuel_calculate when data is valid", %{conn: conn} do
  #     conn = post(conn, Routes.fuel_calculate_path(conn, :create), fuel_calculate: @create_attrs)
  #     assert %{"id" => id} = json_response(conn, 201)["data"]

  #     conn = get(conn, Routes.fuel_calculate_path(conn, :show, id))

  #     assert %{
  #              "id" => ^id,
  #              "points" => [],
  #              "shipMass" => 42
  #            } = json_response(conn, 200)["data"]
  #   end

  #   test "renders errors when data is invalid", %{conn: conn} do
  #     conn = post(conn, Routes.fuel_calculate_path(conn, :create), fuel_calculate: @invalid_attrs)
  #     assert json_response(conn, 422)["errors"] != %{}
  #   end
  # end

  # describe "update fuel_calculate" do
  #   setup [:create_fuel_calculate]

  #   test "renders fuel_calculate when data is valid", %{conn: conn, fuel_calculate: %FuelCalculate{id: id} = fuel_calculate} do
  #     conn = put(conn, Routes.fuel_calculate_path(conn, :update, fuel_calculate), fuel_calculate: @update_attrs)
  #     assert %{"id" => ^id} = json_response(conn, 200)["data"]

  #     conn = get(conn, Routes.fuel_calculate_path(conn, :show, id))

  #     assert %{
  #              "id" => ^id,
  #              "points" => [],
  #              "shipMass" => 43
  #            } = json_response(conn, 200)["data"]
  #   end

  #   test "renders errors when data is invalid", %{conn: conn, fuel_calculate: fuel_calculate} do
  #     conn = put(conn, Routes.fuel_calculate_path(conn, :update, fuel_calculate), fuel_calculate: @invalid_attrs)
  #     assert json_response(conn, 422)["errors"] != %{}
  #   end
  # end

  # describe "delete fuel_calculate" do
  #   setup [:create_fuel_calculate]

  #   test "deletes chosen fuel_calculate", %{conn: conn, fuel_calculate: fuel_calculate} do
  #     conn = delete(conn, Routes.fuel_calculate_path(conn, :delete, fuel_calculate))
  #     assert response(conn, 204)

  #     assert_error_sent 404, fn ->
  #       get(conn, Routes.fuel_calculate_path(conn, :show, fuel_calculate))
  #     end
  #   end
  # end

  # defp create_fuel_calculate(_) do
  #   fuel_calculate = fuel_calculate_fixture()
  #   %{fuel_calculate: fuel_calculate}
  # end
end
