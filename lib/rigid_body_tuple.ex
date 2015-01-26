defmodule RigidBodyTuple do
   @type vec2 :: {float, float}
   @type circle :: {float, vec2, vec2}

   @type boundingBox :: {vec2, vec2}

   def resolve_all_collisions([], _, _) do
       []
   end

   def resolve_all_collisions([h|t], pops, world) do
       h = resolve_collisions(h,pops)
       h = loop(h, world)
       [h|resolve_all_collisions(t,pops, world)]
   end

   @spec resolve_collisions(circle, []) :: circle
   def resolve_collisions(h, [])  do
       h
   end
   @spec resolve_collisions(circle, [circle|[]]) :: circle
   def resolve_collisions(lhs, rhs) when is_list(rhs) do
       [h|t] = rhs
       if collide?(lhs,h) do
          resolve_collision(lhs,h)
       else
           resolve_collisions(lhs, t)
       end
   end

   @spec collide?(circle, circle) :: boolean
   def collide?(lhs, rhs) do
      {l_radius,l_pos,_} = lhs
      {r_radius,r_pos,_} = rhs
      r = l_radius + r_radius
      r = r*r
      r >= Vec2Tuple.squaredDistance(l_pos, r_pos)
   end

   @spec resolve_collision(circle, circle) :: circle
   def resolve_collision(lhs, rhs) do
      {lrad,lpos,_} =lhs
      {_,rpos,_} =rhs
      btw = Vec2Tuple.sub(lpos, rpos)
      {x,y} = btw
      new_vel = {-x, -y}

      {lrad, lpos, Vec2Tuple.normalise(new_vel)}
   end

   @spec loop(circle, boundingBox) :: circle
   def loop(c, world) do
     {rad, pos, vel} = c
     new_pos = Vec2Tuple.sum(pos, vel)
     new_vel = vel

     {x,y} = new_pos

     {vel_x, vel_y} = vel

     {w_max, w_min} = world
     {w_max_x, w_max_y} = w_max
     {w_min_x, w_min_y} = w_min

     if x > w_max_x or x < w_min_x do
       new_vel = {-vel_x, vel_y}
     end
     if y > w_max_y or y < w_min_y do
       new_vel = {vel_x, -vel_y}
     end
     {rad, new_pos, new_vel}
   end
end
