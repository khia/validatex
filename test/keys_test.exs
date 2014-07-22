defmodule Validatex.KeysTest do
  use ExUnit.Case
  alias Validatex.Validate, as: V
  alias Validatex.Keys, as: K

  defmodule S1 do
    defstruct foo: nil, bar: nil
  end

  defmodule S2 do
    defstruct baz: nil, name: nil
  end

  test :map do
    assert not V.valid?(%K{keys: []}, nil) == true
    assert not V.valid?(%K{keys: [:foo, :bar]}, %{}) == true
    assert V.valid?(%K{keys: [:foo, :bar]}, %{foo: 1, bar: 2})
  end

  test :struct do
    assert not V.valid?(%K{keys: []}, nil) == true
    assert not V.valid?(%K{keys: [:foo, :bar]}, %S2{}) == true
    assert V.valid?(%K{keys: [:foo, :bar]}, %S1{})
  end
end