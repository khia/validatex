defmodule Validatex.Element do
  defstruct list: nil

  defimpl Validatex.Validate do
    alias Validatex.Element, as: E

    def valid?(%E{list: nil}, _), do: false
    def valid?(%E{list: list}, element) when is_list(list) do
      element in list
    end

  end

end