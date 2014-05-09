defmodule Validatex.All do
  alias Validatex.Validate

  defstruct options: []

  defimpl Validatex.Validate do
    alias Validatex.All, as: All

    def valid?(%All{options: options}, value) do
      results =
      Enum.reduce options, [],
                  fn(v, acc) ->
                    unless (res = Validate.valid?(v, value)) == true do
                      [{v, res}|acc]
                    else
                      acc
                    end
                  end
      case results do
        [] -> true
        _ -> results
      end
    end
  end

end