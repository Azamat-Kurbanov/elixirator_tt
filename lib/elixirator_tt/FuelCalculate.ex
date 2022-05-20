defmodule ElixiratorTt.FuelCalculate do
  def calculate(shipMass, points) do
    mainCalc(shipMass, convert(points))
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

  def mainCalc(shipMass, points) do
    IO.inspect(points)
    shipMass
  end

  defp launch_formula(mass, gravity) do
    Float.floor(mass * gravity * 0.042 - 33)
  end

  defp land_formula(mass, gravity) do
    Float.floor(mass * gravity * 0.033 - 42)
  end

  def action(mass, _, summ) when mass <= 0, do: summ
  def action(mass, gr = [launch: gravity], summ) do
    res = launch_formula(mass, gravity)

    if res <= 0 do
      action(0, gr, summ)
    else
      action(res, gr, summ + res)
    end
  end
  def action(mass, gr = [land: gravity], summ) do
    res = land_formula(mass, gravity)

    if res <= 0 do
      action(0, gr, summ)
    else
      action(res, gr, summ + res)
    end
  end
end
