defmodule ElixiratorTtWeb.Router do
  use ElixiratorTtWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ElixiratorTtWeb do
    pipe_through :api

    get "/fuelcalculate", FuelCalculateController, :index
    post "/fuelcalculate", FuelCalculateController, :calculateFuel
  end
end
