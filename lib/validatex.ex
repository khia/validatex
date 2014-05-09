defmodule Validatex do

  defexception ValidationFailure, name: nil, value: nil, validation: nil, error: nil do
    def message(__MODULE__[name: name, value: value, validation: validation, error: error]) do
      "Validation error on #{name}, #{inspect value} does not pass the validation " <>
      "of #{inspect validation} with a reason of #{inspect error}"
    end
  end

  defexception MultipleValidationFailures, failures: [] do
    def message(__MODULE__[failures: failures]) do
      Enum.join((for failure <- failures, do: failure.message), "\n")
    end
  end

  def validate(plan) do
      results = for {name, value, spec} <- plan do
        {name, value, spec, Validatex.Validate.valid?(spec, value)}
      end
      only_errors = fn
          {_, _, _, true} -> false
          _ -> true
      end
      Enum.filter results, only_errors
  end

  def validate!(plan, options \\ [report_all_errors: false]) do
    case validate(plan) do
      [] -> true
      [{name, value, validation, error}|_] = errors ->
        if options[:report_all_errors] do
          exceptions =
          for {name, value, validation, error} <- errors do
            ValidationFailure.new(name: name, value: value, validation: validation, error: error)
          end
          raise MultipleValidationFailures, failures: exceptions
        else
          raise ValidationFailure, name: name, value: value, validation: validation, error: error
        end
    end
  end


  defprotocol Validate do
    @fallback_to_any true
    def valid?(validator, data)
  end

  defimpl Validate, for: Any do
    def valid?(a,a), do: true
    def valid?(a,b) when a > b, do: :lesser
    def valid?(a,b) when b > a, do: :greater
  end

end