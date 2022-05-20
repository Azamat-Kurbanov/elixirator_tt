defmodule ElixiratorTt.FuelCalculate do
  @moduledoc """
  Main module for calculating fuel consumtion
  """

  # Data preparation
  # This part could be another modue due SOLID principles
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
  defp convert([head|tail]) do
    [map_to_keyword_list(head)|convert(tail)]
  end

  defp map_to_keyword_list(map) do
    Enum.map(
      map,
      fn({key, value}) -> {String.to_atom(key), value} end
    )
  end

  # Main part of the app
  @spec mainCalc(integer, [[{atom, number}]]) :: number
  def mainCalc(_, []), do: 0
  def mainCalc(shipMass, [head|tail]) do
    with {:ok, launch} <- Keyword.fetch(head, :launch),
         {:ok, land} <- Keyword.fetch(head, :land)
    do
      action(shipMass, [land: land], 0) + action(shipMass, [launch: launch], 0) + mainCalc(shipMass, tail)
    else
      :error -> raise RuntimeError
    end
  end

  defp launch_formula(mass, gravity) do
    Float.floor(mass * gravity * 0.042 - 33)
  end

  defp land_formula(mass, gravity) do
    Float.floor(mass * gravity * 0.033 - 42)
  end

  defp action(mass, _, summ) when mass <= 0, do: summ
  defp action(mass, gr = [launch: gravity], summ) do
    res = launch_formula(mass, gravity)

    if res <= 0 do
      action(0, gr, summ)
    else
      action(res, gr, summ + res)
    end
  end
  defp action(mass, gr = [land: gravity], summ) do
    res = land_formula(mass, gravity)

    if res <= 0 do
      action(0, gr, summ)
    else
      action(res, gr, summ + res)
    end
  end
  defp action(_, _, _summ) do
    raise RuntimeError
  end
end
