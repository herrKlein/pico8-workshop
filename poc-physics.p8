pico-8 cartridge // http://www.pico-8.com
version 39
__lua__

t=0
tps=10

function _init()
 plr = {
  x=10, 
  y=10,
  vy = 0,
  grv = 0.48 -- 1. adapt to game gravity
 }
end

function _update60()
 t+=1
 if (t%tps!=0) return

 if btn(4) then
  plr.pos.y -= 1
 end
 plr.vy += plr.grv 
 plr.y += plr.vy
 if plr.y > 128 - 4 then 
  plr.vy *= -1
  -- plr.y = 124 -- 2. correction for below treshold
 end
end

function _draw()
 cls()
 circfill(plr.x,plr.y,4,8)
 print("y      : " .. plr.y,64,10)
 print("vy     : " .. plr.vy,64,20)
end
