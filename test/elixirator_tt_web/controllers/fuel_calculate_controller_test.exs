defmodule ElixiratorTtWeb.FuelCalculateControllerTest do
  use ElixiratorTtWeb.ConnCase

  import ElixiratorTt.NasaFixtures

  alias ElixiratorTt.Nasa.FuelCalculate

  @create_attrs %{
    points: [],
    shipMass: 42
  }
  @update_attrs %{
    points: [],
    shipMass: 43
  }
  @invalid_attrs %{points: nil, shipMass: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all fuel_calculates", %{conn: conn} do
      conn = get(conn, Routes.fuel_calculate_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create fuel_calculate" do
    test "renders fuel_calculate when data is valid", %{conn: conn} do
      conn = post(conn, Routes.fuel_calculate_path(conn, :create), fuel_calculate: @create_attrs)
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get(conn, Routes.fuel_calculate_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "points" => [],
               "shipMass" => 42
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.fuel_calculate_path(conn, :create), fuel_calculate: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update fuel_calculate" do
    setup [:create_fuel_calculate]

    test "renders fuel_calculate when data is valid", %{conn: conn, fuel_calculate: %FuelCalculate{id: id} = fuel_calculate} do
      conn = put(conn, Routes.fuel_calculate_path(conn, :update, fuel_calculate), fuel_calculate: @update_attrs)
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get(conn, Routes.fuel_calculate_path(conn, :show, id))

      assert %{
               "id" => ^id,
               "points" => [],
               "shipMass" => 43
             } = json_response(conn, 200)["data"]
    end

    test "renders errors when data is invalid", %{conn: conn, fuel_calculate: fuel_calculate} do
      conn = put(conn, Routes.fuel_calculate_path(conn, :update, fuel_calculate), fuel_calculate: @invalid_attrs)
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete fuel_calculate" do
    setup [:create_fuel_calculate]

    test "deletes chosen fuel_calculate", %{conn: conn, fuel_calculate: fuel_calculate} do
      conn = delete(conn, Routes.fuel_calculate_path(conn, :delete, fuel_calculate))
      assert response(conn, 204)

      assert_error_sent 404, fn ->
        get(conn, Routes.fuel_calculate_path(conn, :show, fuel_calculate))
      end
    end
  end

  defp create_fuel_calculate(_) do
    fuel_calculate = fuel_calculate_fixture()
    %{fuel_calculate: fuel_calculate}
  end
end
