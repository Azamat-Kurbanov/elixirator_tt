# ElixiratorTt REST API

You need to have installed docker machine. Use `make _command_` (Makefile) commands for convenience.

To start application on **docker container**:
  * Build docker image with `make build`
  * Install dependencies with `make deps.get`
  * Start application with `make start`
  * Run tests with `make test`
  * Stop container with `make stop`
  * Run other "mix" commands with `make mix command="your command"`. For example: `make mix command="ecto.create"`

`Makefile` contains other commands.

To start application on **local machine**:
  * Install dependencies with `mix deps.get`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

Now you can visit [`localhost:4000/api/fuelcalculate`](http://localhost:4000/api/fuelcalculate) from your browser/postman. This application didn't developed for browser (html), you can use it for REST requests. See `./openapi/swagger.yaml` for endpoints documentation. Fell free to import `./openapi/postman_collection.json` file and directly use endpoints in Postman.

If you want to test main function with params as mentioned in [test task](https://docs.google.com/document/d/1iRytYuAfUaih8fQHFZVfZwanQZjegFm9ulsMvmqENwM/edit). Start application on local machine inside IEx. Run the `ElixiratorTt.FuelCalculate.mainCalc` method with params.

Example:
>`iex> ElixiratorTt.FuelCalculate.mainCalc(28801,[{:launch, 9.807},{:land, 1.62},{:launch, 1.62},{:land, 9.807}])`