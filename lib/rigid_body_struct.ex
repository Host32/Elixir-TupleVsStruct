defmodule RigidBodyStruct do
   #Circle struct
   defmodule CircleStruct do
      defstruct radius: 0.0, position: %Vec2Struct{}, velocity: %Vec2Struct{}

      def new(radius, position = %Vec2Struct{}, velocity = %Vec2Struct{}) when is_number(radius) do
        %CircleStruct{radius: radius, position: position, velocity: velocity}
      end
   end
   defmodule BoundingBoxStruct do
     defstruct min: %Vec2Struct{}, max: %Vec2Struct{}

     def new(min = %Vec2Struct{}, max = %Vec2Struct{}) do
       %BoundingBoxStruct{min: min, max: max}
     end
   end


   def resolve_all_collisions([], _, _) do
       []
   end

   def resolve_all_collisions([h|t], pops, world = %BoundingBoxStruct{}) do
       h = resolve_collisions(h,pops)
       h = loop(h, world)
       [h|resolve_all_collisions(t,pops, world)]
   end

   def resolve_collisions(h = %CircleStruct{}, [])  do
       h
   end
   def resolve_collisions(lhs = %CircleStruct{}, rhs) when is_list(rhs) do
       [h|t] = rhs
       if collide?(lhs,h) do
          resolve_collision(lhs,h)
       else
           resolve_collisions(lhs, t)
       end
   end

   def collide?(lhs = %CircleStruct{}, rhs = %CircleStruct{}) do
      r = lhs.radius + rhs.radius
      r = r*r
      r >= Vec2Struct.squaredDistance(lhs.position, rhs.position)
   end

   def resolve_collision(lhs = %CircleStruct{}, rhs = %CircleStruct{}) do
      btw = Vec2Struct.sub(rhs.position, lhs.position)
      new_vel = Vec2Struct.new(-btw.x, -btw.y)
      %CircleStruct{lhs|velocity: Vec2Struct.normalise(new_vel)}
   end

   def loop(c = %CircleStruct{}, world = %BoundingBoxStruct{}) do
     new_pos = Vec2Struct.sum(c.position, c.velocity)
     new_vel = c.velocity
     if new_pos.x > world.max.x or new_pos.x < world.min.x do
       new_vel = Vec2Struct.new(-c.velocity.x, c.velocity.y)
     end
     if new_pos.y > world.max.y or new_pos.y < world.min.y do
       new_vel = Vec2Struct.new(c.velocity.x, -c.velocity.y)
     end

     %CircleStruct{c|position: new_pos, velocity: new_vel}
   end
end
