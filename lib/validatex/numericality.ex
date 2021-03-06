defmodule Validatex.Numericality do
  defstruct allow_undefined: false,
            allow_nil: false,
            allow_list: false,
            allow_string: false,
            allow_empty: false,
            allow_rest: false,
            allow_float: true,
            default: 0

  defimpl Validatex.Validate  do
    alias Validatex.Numericality, as: N
    def valid?(%N{ allow_undefined: false }, :undefined), do: :undefined_not_allowed
    def valid?(%N{ allow_undefined: true, default: default } = v, :undefined), do: valid?(v, default)

    def valid?(%N{ allow_nil: false }, nil), do: :nil_not_allowed
    def valid?(%N{ allow_nil: true, default: default } = v, nil), do: valid?(v, default)

    def valid?(%N{ allow_list: false}, l) when is_list(l), do: :list_not_allowed
    def valid?(%N{ allow_list: true} = v, l) when is_list(l), do: valid?(v, IO.iodata_to_binary(l))

    def valid?(%N{ allow_string: true, allow_empty: false}, ""), do: :empty_not_allowed
    def valid?(%N{ allow_string: true, allow_empty: true, default: default} = v,  ""), do: valid?(v, default)
    def valid?(%N{ allow_string: false }, s) when is_binary(s), do: :string_not_allowed
    def valid?(%N{ allow_string: true, allow_rest: rest } = v, s) when is_binary(s) do
      str = String.to_char_list(s)
      case :string.to_integer(str) do
        {:error, :no_integer} ->
          :number_expected
        {value, []} ->
          valid?(v, value)
        {value, _} ->
          case :string.to_float(str) do
            {:error, _} ->
              if rest, do: valid?(v, value), else: :rest_not_allowed
            {value_f, []} ->
              valid?(v, value_f)
            {value_f, _} ->
              if rest, do: valid?(v, value_f), else: :rest_not_allowed
          end
      end
    end
    def valid?(%N{ allow_float: false }, f) when is_float(f), do: :float_not_allowed
    def valid?(%N{}, v) when is_number(v), do: true
    def valid?(%N{}, _), do: :number_expected

  end
end
