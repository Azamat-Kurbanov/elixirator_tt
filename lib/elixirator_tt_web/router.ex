defmodule ElixiratorTtWeb.Router do
  use ElixiratorTtWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", ElixiratorTtWeb do
    pipe_through :api
  end
end
