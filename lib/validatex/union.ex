defmodule Validatex.Union do
  alias Validatex.Validate

  defstruct options: []

  defimpl Validatex.Validate do
    alias Validatex.Union, as: Union

    def valid?(%Union{options: options}, value) do
      results =
      Enum.reduce options, [],
                  fn(v, acc) ->
                    unless (res = Validate.valid?(v, value)) == true do
                      [{v, res}|acc]
                    else
                      acc
                    end
                  end
      noptions = length(options)
      case length(results) do
        ^noptions -> results
        _ -> true
      end
    end
  end

end