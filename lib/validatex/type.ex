defmodule Validatex.Type do
  defstruct is: nil,
            allow_nil: false,
            allow_undefined: false

  defimpl Validatex.Validate do
    alias Validatex.Type, as: T

    def valid?(%T{ is: :atom, allow_nil: false }, nil) , do: :nil_not_allowed
    def valid?(%T{ is: :atom, allow_undefined: false }, :undefined) , do: :undefined_not_allowed
    def valid?(%T{ is: :atom }, a) when is_atom(a), do: true
    def valid?(%T{ allow_nil: true}, nil), do: true
    def valid?(%T{ allow_undefined: true}, :undefined), do: true
    def valid?(%T{ is: :nil}, nil), do: true
    def valid?(%T{ is: :number }, a) when is_number(a), do: true
    def valid?(%T{ is: :integer }, a) when is_integer(a), do: true
    def valid?(%T{ is: :float }, a) when is_float(a), do: true
    def valid?(%T{ is: :boolean }, a) when is_boolean(a), do: true
    def valid?(%T{ is: :binary }, a) when is_binary(a), do: true
    def valid?(%T{ is: :string }, a) when is_binary(a), do: true
    def valid?(%T{ is: :reference }, a) when is_reference(a), do: true
    def valid?(%T{ is: :function }, a) when is_function(a), do: true
    def valid?(%T{ is: :port }, a) when is_port(a), do: true
    def valid?(%T{ is: :pid }, a) when is_pid(a), do: true
    def valid?(%T{ is: :tuple }, a) when is_tuple(a), do: true
    def valid?(%T{ is: :list }, a) when is_list(a), do: true
    def valid?(%T{}, _), do: false
  end

end