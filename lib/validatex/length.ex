defmodule Validatex.Length do
  defstruct is: nil

  defimpl Validatex.Validate do
    alias Validatex.Length, as: L

    def valid?(%L{is: validator}, l) when is_list(l) do
        Validatex.Validate.valid?(validator, length(l))
    end

    def valid?(%L{is: validator}, v) when is_binary(v) or is_tuple(v) do
        Validatex.Validate.valid?(validator, size(v))
    end

    def valid?(%L{is: _validator}, _data), do: :bad_argument

  end

end