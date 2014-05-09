defmodule Validatex.AllTest do
  use ExUnit.Case
  alias Validatex.Validate, as: V
  alias Validatex.All, as: All

  test :positive do
    format = %Validatex.Format{re: ~r/.*/i}
    is_string = %Validatex.Type{is: :string}
    assert V.valid?(%All{options: [format, is_string]}, "1") == true
  end

  test :negative do
    is_number = %Validatex.Numericality{}
    is_string = %Validatex.Type{is: :string}
    assert V.valid?(%All{options: [is_number, is_string]}, "1") ==
           [{is_number, :string_not_allowed}]
  end
end