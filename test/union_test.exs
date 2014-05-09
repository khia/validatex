defmodule Validatex.UnionTest do
  use ExUnit.Case
  alias Validatex.Validate, as: V
  alias Validatex.Union, as: Union

  test :positive do
    is_number = %Validatex.Numericality{}
    is_string = %Validatex.Type{is: :string}
    is_atom = %Validatex.Type{is: :atom}
    assert V.valid?(%Union{options: [is_number, is_string, is_atom]}, 1) == true
    assert V.valid?(%Union{options: [is_number, is_string, is_atom]}, "1") == true
  end

  test :negative do
    is_number = %Validatex.Numericality{}
    is_string = %Validatex.Type{is: :string}
    assert Enum.sort(V.valid?(%Union{options: [is_number, is_string]}, make_ref)) ==
           Enum.sort([{is_number, :number_expected},{is_string,false}])
  end

  test :non_false do
    is_atom = %Validatex.Type{is: :atom, allow_nil: false}
    assert V.valid?(%Union{options: [is_atom]}, nil) == [{is_atom, :nil_not_allowed}]
  end

end
