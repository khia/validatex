defmodule Validatex.CustomTest do
  use ExUnit.Case
  alias Validatex.Validate, as: V

  defmodule MyValidator do
    defstruct q: nil
  end

  defimpl Validatex.Validate, for: MyValidator do
     alias MyValidator, as: V
     def valid?(%V{}, v), do: v
  end

  test :all do
    assert V.valid?(%MyValidator{}, true) == true
    assert V.valid?(%MyValidator{}, :something) == :something
  end

end
