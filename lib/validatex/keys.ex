defmodule Validatex.Keys do
  defstruct keys: []
  defimpl Validatex.Validate do
    alias Validatex.Keys, as: K
    def valid?(%K{keys: keys}, element) when is_map(element) do
      map = Map.keys(element) |> List.delete(:__struct__)
      Enum.sort(map) == Enum.sort(keys)
    end
    def valid?(%K{}, _), do: false
  end
end
