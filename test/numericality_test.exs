defmodule Validatex.NumericalityTest do
  use ExUnit.Case
  alias Validatex.Validate, as: V
  alias Validatex.Numericality, as: N

  test :undefined do
    assert V.valid?(%N{}, :undefined) == :undefined_not_allowed
    assert V.valid?(%N{allow_undefined: false}, :undefined) == :undefined_not_allowed
    assert V.valid?(%N{allow_undefined: true}, :undefined) == true
  end

  test :nil do
    assert V.valid?(%N{}, nil) == :nil_not_allowed
    assert V.valid?(%N{allow_nil: false}, nil) == :nil_not_allowed
    assert V.valid?(%N{allow_nil: true}, nil) == true
  end

  test :list do
    assert V.valid?(%N{}, '') == :list_not_allowed
    assert V.valid?(%N{allow_list: false}, '') == :list_not_allowed
    assert V.valid?(%N{allow_list: true, allow_empty: true, allow_string: true}, '') == true
  end

  test :empty do
    assert V.valid?(%N{allow_empty: true}, "") == :string_not_allowed
    assert V.valid?(%N{allow_empty: true, allow_string: true}, "") == true
    assert V.valid?(%N{allow_empty: false, allow_string: true}, "") == :empty_not_allowed
    assert V.valid?(%N{allow_string: true}, "") == :empty_not_allowed
  end

  test :string do
    assert V.valid?(%N{allow_string: true}, "1") == true
    assert V.valid?(%N{allow_string: true, allow_rest: true}, "1a")
    assert V.valid?(%N{allow_string: true}, "1a") == :rest_not_allowed
    assert V.valid?(%N{allow_string: true}, "1.1") == true
    assert V.valid?(%N{allow_string: true, allow_rest: true}, "1.1a")
    assert V.valid?(%N{allow_string: true}, "garbage") == :number_expected
  end

  test :allow_float do
    assert V.valid?(%N{}, 1.1) == true
    assert V.valid?(%N{allow_float: false}, 1.1) == :float_not_allowed
  end

  test :default do
    assert V.valid?(%N{allow_undefined: true}, :undefined) == true
    assert V.valid?(%N{allow_nil: true}, nil) == true
    assert V.valid?(%N{allow_string: true, allow_empty: true}, "")
    assert V.valid?(%N{allow_list: true, allow_string: true, allow_empty: true}, '')

    assert V.valid?(%N{default: 1, allow_undefined: true}, :undefined) == true
    assert V.valid?(%N{default: 1, allow_nil: true}, nil) == true
    assert V.valid?(%N{default: 1, allow_string: true, allow_empty: true}, "") == true
    assert V.valid?(%N{default: 1, allow_list: true, allow_string: true, allow_empty: true}, '')

    assert V.valid?(%N{default: :x, allow_undefined: true}, :undefined) == :number_expected
    assert V.valid?(%N{default: :x, allow_nil: true}, nil) == :number_expected
    assert V.valid?(%N{default: :x, allow_string: true, allow_empty: true}, "") == :number_expected
    assert V.valid?(%N{default: :x, allow_list: true, allow_string: true, allow_empty: true}, '') == :number_expected
  end



end
