pico-8 cartridge // http://www.pico-8.com
version 41
__lua__

--help
--save game.p8
--load game.p8
--run
--splore

a=nil
x=23
local s="text"
t={name="joe", age="32"}

print("a".."b") -- and or not


function add(a,b)
 return a+b
end

if (x  < 33) then
 print("hallo")
else
 print("hey")
end

--up
for i = 1,10 do
 print(i)
end
--down
for a=10,0,-2 do
 print(a)
end
--array
for s in all(ships) do
 print(s.name)
end
--table
for k,v in pairs(m) do
 print("k:"..k..",v:"..v)
end

--table
t={a="x",b=1}
add(t, v)
del(t, v)
t={1,2,3,4}
print(t[1]) --1-based!!


-- DRAWGAMETHINGIES

-- sprites
spr(n, x, y, [w, h],
  [flip_x], [flip_y])

circfill(x, y, r, [c])

abs(x),atan2(dx, dy),
cos(x),sin(x),
flr(x),max(x,y),min(x,y),
rnd(x),sgn(x),sqrt(x)