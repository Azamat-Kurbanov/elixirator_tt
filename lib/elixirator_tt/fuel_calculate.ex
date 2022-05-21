defmodule ElixiratorTt.FuelCalculate do
  @moduledoc """
  Main module for calculating fuel consumtion
  """

  # Data preparation
  # This part could be another modue due SOLID principles

  @doc """
  Convert data and calculate

  ## Examples

    iex> ElixiratorTt.FuelCalculate.calculate(28801, [%ElixiratorTtWeb.Schemas.Point{land: 1.62, launch: 9.807}, %ElixiratorTtWeb.Schemas.Point{land: 9.807, launch: 1.62}])
    {:ok, 36778.0}

  """
  @spec calculate(integer, list) :: {:ok, number}
  def calculate(shipMass, points) do
    try do
      res = mainCalc(shipMass, convert(points))
      {:ok, res}
    rescue
      FunctionClauseError -> {:error, :bad_request}
      RuntimeError -> {:error, :internal_server_error}
    end
  end

  defp convert([]), do: []
  defp convert([point|tail]) do
    [{:launch, point.launch}, {:land, point.land} | convert(tail)]
  end

  # Main part of the app

  @doc """
  Calculator with main logic

  ## Examples

    iex> ElixiratorTt.FuelCalculate.mainCalc(28801, [{:launch, 9.807}, {:land, 1.62}, {:launch, 1.62}, {:land, 9.807}])
    36778.0

  """
  @spec mainCalc(integer, [[{atom, number}]]) :: number
  def mainCalc(_, []), do: 0
  def mainCalc(shipMass, [head|tail]) do
    action(shipMass, head, 0) + mainCalc(shipMass, tail)
  end

  defp launch_formula(mass, gravity) do
    Float.floor(mass * gravity * 0.042 - 33)
  end

  defp land_formula(mass, gravity) do
    Float.floor(mass * gravity * 0.033 - 42)
  end

  defp action(mass, _, summ) when mass <= 0, do: summ
  defp action(mass, gr = {:launch, gravity}, summ) do
    res = launch_formula(mass, gravity)

    if res <= 0 do
      action(0, gr, summ)
    else
      action(res, gr, summ + res)
    end
  end
  defp action(mass, gr = {:land, gravity}, summ) do
    res = land_formula(mass, gravity)

    if res <= 0 do
      action(0, gr, summ)
    else
      action(res, gr, summ + res)
    end
  end
  defp action(_, _, _summ) do
    raise RuntimeError, "Error occured: bad args"
  end
end
