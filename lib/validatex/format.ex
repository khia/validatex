defmodule Validatex.Format do
  defstruct allow_undefined: false,
            allow_nil: false,
            allow_list: false,
            allow_empty: false,
            re: ".*",
            default: ""

  defimpl Validatex.Validate do
    alias Validatex.Format, as: F

    def valid?(%F{allow_undefined: false}, :undefined), do: :undefined_not_allowed
    def valid?(%F{allow_undefined: true, default: default} = v, :undefined), do: valid?(v, default)
    def valid?(%F{allow_nil: false}, nil), do: :nil_not_allowed
    def valid?(%F{allow_nil: true, default: default} = v, nil), do: valid?(v, default)

    def valid?(%F{allow_list: false}, l) when is_list(l), do: :list_not_allowed
    def valid?(%F{allow_list: true} = v, l) when is_list(l), do: valid?(v, iolist_to_binary(l))

    def valid?(%F{allow_empty: false}, ""), do: :empty_not_allowed

    def valid?(%F{re: re}=v, s) when is_binary(re) do
        valid?(v.re(~r"#{re}"), s)
    end

    def valid?(%F{re: re}, s) when is_binary(s) do
        if Regex.match?(re, s), do: true, else: :no_match
    end

    def valid?(%F{}, _), do: :string_expected  end

end