defmodule ElxPhysicsTest do
  use ExUnit.Case

  test "performance comparison" do
      Benchwarmer.benchmark [fn -> ElxPhysics.struct_simulation end, fn -> ElxPhysics.tuple_simulation end]
  end
end
