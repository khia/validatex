defmodule Validatex.Neg do
  alias Validatex.Validate

  defstruct validation: nil,
            message: false

  defimpl Validatex.Validate do
    alias Validatex.Neg, as: Neg

    def valid?(%Neg{validation: v, message: m},val) do
      case Validate.valid?(v, val) do
        true -> m
        _ -> true
      end
    end
  end

end