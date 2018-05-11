defmodule SteembotPrototypeTest do
  use ExUnit.Case
  doctest SteembotPrototype

  test "greets the world" do
    assert SteembotPrototype.hello() == :world
  end
end
