defmodule ElixiratorTtWeb.Router do
  use ElixiratorTtWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
    plug OpenApiSpex.Plug.PutApiSpec, module: ElixiratorTtWeb.ApiSpec
  end

  scope "/api" do
    pipe_through :api

    get "/fuelcalculate", ElixiratorTtWeb.FuelCalculateController, :index
    post "/fuelcalculate", ElixiratorTtWeb.FuelCalculateController, :calculateFuel
    get "/openapi", OpenApiSpex.Plug.RenderSpec, []
  end
end
