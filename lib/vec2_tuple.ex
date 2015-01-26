defmodule Vec2Tuple do
   @type vec2 :: {float, float}

   @spec sum(vec2, vec2) :: vec2
   def sum(lhs, rhs) do
      {lx,ly} = lhs
      {rx,ry} = rhs
      {lx + rx, ly + ry}
   end

   @spec sub(vec2, vec2) :: vec2
   def sub(lhs, rhs) do
       {lx,ly} = lhs
       {rx,ry} = rhs
       {lx - rx, ly - ry}
   end

   @spec squaredMagnitude(vec2) :: float
   def squaredMagnitude(v) do
       {x,y} = v
       x * x + y * y
   end

   @spec squaredDistance(vec2,vec2) :: float
   def squaredDistance(lhs, rhs) do
       squaredMagnitude( sub(lhs, rhs) )
   end

   @spec magnitude(vec2) :: float
   def magnitude(v) do
       {x,y} = v
       :math.sqrt( x * x + y * y )
   end

   @spec normalise(vec2) :: vec2
   def normalise(v) do
       {x,y} = v
       lenght = magnitude(v)

       if(lenght > 0.0) do
           invLength = 1.0 / lenght
           {x * invLength, y * invLength}
       else
           {x, y}
       end
   end
end
