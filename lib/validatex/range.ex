defmodule Validatex.Range do
  defstruct from: nil,
            to: nil,
            exclusive: false

  defimpl Validatex.Validate do
    alias Validatex.Range, as: R

    def valid?(%R{from: nil, to: nil}, _), do: true
    def valid?(%R{from: from, to: nil, exclusive: false}, v) when from !== nil and v < from, do: :lesser
    def valid?(%R{from: from, to: nil, exclusive: true}, v) when from !== nil and v <= from, do: :lesser
    def valid?(%R{from: nil, to: to, exclusive: false}, v) when to !== nil and v > to, do: :greater
    def valid?(%R{from: nil, to: to, exclusive: true}, v) when to !== nil and v >= to, do: :greater
    def valid?(%R{to: to, exclusive: false}, v) when to !== nil and v > to, do: :greater
    def valid?(%R{from: from, exclusive: false}, v) when from !== nil and v < from, do: :lesser
    def valid?(%R{from: from, exclusive: true}, v) when from !== nil and v <= from, do: :lesser
    def valid?(%R{to: to, exclusive: false}, v) when to !== nil and v > to, do: :greater
    def valid?(%R{to: to, exclusive: true}, v) when to !== nil and v >= to, do: :greater
    def valid?(%R{}, _), do: true

  end

end