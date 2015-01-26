defmodule Vec2Struct do
   defstruct x: 0.0, y: 0.0

   def sum(lhs = %Vec2Struct{}, rhs = %Vec2Struct{}) do
      %Vec2Struct{x: lhs.x + rhs.x, y: lhs.y + rhs.y}
   end

   def sub(lhs = %Vec2Struct{}, rhs = %Vec2Struct{}) do
      %Vec2Struct{x: lhs.x - rhs.x, y: lhs.y - rhs.y}
   end

   def new(x,y) when is_number(x) and is_number(y) do
      %Vec2Struct{x: x, y: y}
   end

   def squaredMagnitude(v = %Vec2Struct{}) do
      v.x * v.x + v.y * v.y
   end

   def magnitude(v = %Vec2Struct{}) do
       :math.sqrt( v.x * v.x + v.y * v.y )
   end

   def squaredDistance(lhs = %Vec2Struct{}, rhs = %Vec2Struct{}) do
      squaredMagnitude( sub(lhs, rhs) )
   end
   def normalise(v = %Vec2Struct{}) do
     lenght = magnitude(v)

     if(lenght > 0.0) do
       invLength = 1.0 / lenght
       %Vec2Struct{x: v.x * invLength, y: v.y * invLength}
     else
       %Vec2Struct{x: v.x, y: v.y}
     end
   end
end
