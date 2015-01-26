defmodule ElxPhysics do

    ### - STRUCT SIMULATION
    def struct_simulation do
        population = populate_struct(1000)
        world = RigidBodyStruct.BoundingBoxStruct.new(Vec2Struct.new(0,0),Vec2Struct.new(20000,20000))
        loop_struct(population, world, 60)
    end

    def loop_struct(_, _, 0) do
        true
    end
    def loop_struct(pop, world = %RigidBodyStruct.BoundingBoxStruct{}, frames) do
        pop = RigidBodyStruct.resolve_all_collisions(pop, pop, world)
        loop_struct(pop,world, frames-1)
    end

    def populate_struct(0) do
        []
    end
    def populate_struct(x) do
        direction = Vec2Struct.normalise(Vec2Struct.new(1,1))
        [RigidBodyStruct.CircleStruct.new(1, Vec2Struct.new(x,x), direction)] ++ populate_struct(x-1)
    end

    ### - TUPLE SIMULATION

    def tuple_simulation do
        population = populate_tuple(1000)
        world = {{0,0},{20000,20000}}
        loop_tuple(population, world, 60)
    end

    def loop_tuple(_, _, 0) do
        true
    end
    def loop_tuple(pop, world, frames) do
        pop = RigidBodyTuple.resolve_all_collisions(pop, pop, world)
        loop_tuple(pop,world, frames-1)
    end

    def populate_tuple(0) do
        []
    end
    def populate_tuple(x) do
        direction = Vec2Tuple.normalise({1,1})
        [{1, {x,x}, direction}] ++ populate_tuple(x-1)
    end
end
