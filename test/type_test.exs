defmodule Validatex.TypeTest do
  use ExUnit.Case
  alias Validatex.Validate, as: V
  alias Validatex.Type, as: T

  defmodule S1 do
    defstruct foo: nil, bar: nil
  end

  defmodule S2 do
    defstruct baz: nil, name: nil
  end

  test :integer do
    assert V.valid?(%T{is: :number},1) == true
    assert V.valid?(%T{is: :integer},1) == true
  end

  test :float do
    assert V.valid?(%T{is: :number},1.1) == true
    assert V.valid?(%T{is: :float},1.1) == true
  end

  test :atom, do: assert V.valid?(%T{is: :atom}, :atom) == true
  test :binary, do: assert V.valid?(%T{is: :binary}, <<>>) == true
  test :string, do: assert V.valid?(%T{is: :string}, "") == true
  test :ref, do: assert V.valid?(%T{is: :reference}, make_ref()) == true
  test :fun, do: assert V.valid?(%T{is: :function}, fn () -> :ok end) == true
  test :port, do: assert V.valid?(%T{is: :port}, hd(:erlang.ports)) == true
  test :pid, do: assert V.valid?(%T{is: :pid}, self) == true
  test :tuple, do: assert V.valid?(%T{is: :tuple}, {}) == true
  test :list, do: assert V.valid?(%T{is: :list}, []) == true
  test :boolean do
    assert V.valid?(%T{is: :boolean}, true) == true
    assert V.valid?(%T{is: :boolean}, false) == true
  end
  test :nil, do: assert V.valid?(%T{is: :nil}, nil) == true

  test :allow_nil_atom do
    assert V.valid?(%T{is: :atom, allow_nil: true}, nil) == true
    assert V.valid?(%T{is: :atom, allow_nil: false}, nil) == :nil_not_allowed
  end

  test :allow_undefined_atom do
    assert V.valid?(%T{is: :atom, allow_undefined: true}, :undefined) == true
    assert V.valid?(%T{is: :atom, allow_undefined: false}, :undefined) == :undefined_not_allowed
  end

  test :allow_nil do
    assert not V.valid?(%T{is: :string}, nil) == true
    assert V.valid?(%T{is: :string, allow_nil: true}, nil)
  end

  test :allow_undefined do
    assert not V.valid?(%T{is: :string}, :undefined) == true
    assert V.valid?(%T{is: :string, allow_undefined: true}, :undefined)
  end


  test :map do
    assert not V.valid?(%T{is: :map}, nil) == true
    assert V.valid?(%T{is: :map}, %{})
    assert V.valid?(%T{is: :map}, %S1{})
  end

  test :struct do
    assert not V.valid?(%T{is: :struct, name: S2}, %S1{}) == true
    assert V.valid?(%T{is: :struct, name: S1}, %S1{})
  end

end
