defmodule ElixiratorTtWeb.Schemas do
  require OpenApiSpex
  alias OpenApiSpex.Schema

  defmodule IndexResponse do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      title: "IndexResponse",
      description: "Response for index route",
      type: :object,
      properties: %{
        title: %Schema{description: "Welcome text", type: :string}
      },
      example: %{
        title: "Welcome text"
      }
    })
  end

  defmodule Point do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      title: "Point",
      description: "Flying planet gravities",
      type: :object,
      properties: %{
        launch: %Schema{type: :number, description: "Launch planet gravity"},
        land: %Schema{type: :number, description: "Landing planet gravity"}
      },
      required: [:launch, :land],
      example: %{
        launch: 9.807,
        land: 1.62
      }
    })
  end

  defmodule FuelConsumptionRequest do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      title: "FuelConsumptionRequest",
      description: "POST body for calculating fuel consumption",
      type: :object,
      properties: %{
        ship_mass: %Schema{type: :integer, description: "Flying ship mass"},
        points: %Schema{description: "Planet gravities", type: :array, items: Point}
      },
      required: [:ship_mass, :points],
      example: %{
        ship_mass: 28801,
        points: [
          %{
            launch: 9.807,
            land: 1.62
          },
          %{
            launch: 9.807,
            land: 1.62
          }
        ]
      }
    })
  end

  defmodule FuelConsumptionResponse do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      title: "FuelConsumptionResponse",
      description: "Response schema for calculated fuel consumption",
      type: :object,
      properties: %{
        fuel_consumption: %Schema{type: :number, description: "Calculated fuel consumption"}
      },
      example: %{
        fuel_consumption: 36778.0
      }
    })
  end

  defmodule FuelConsumptionError do
    require OpenApiSpex

    OpenApiSpex.schema(%{
      title: "FuelConsumptionError",
      description: "Response schema for errors",
      type: :object,
      properties: %{
        errors: %Schema{
          description: "Error messages",
          type: :object,
          properties: %{
            detail: %Schema{type: :string, description: "Error message"}
          }
        }
      },
      example: %{
        errors: %{
          detail: "Internal Server Error"
        }
      }
    })
  end
end
