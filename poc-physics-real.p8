pico-8 cartridge // http://www.pico-8.com
version 39
__lua__

t=0

-- tps = ticks per (game) step
-- increase it to slow the
-- game down
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

 if (sgn(plr.vy) == 1) plr.flapping = false
 if btn(2) and plr.flapping == false then
  plr.vy -= 3
  plr.y = min(plr.y, 128 - 1)
  plr.flapping = true
	else
  plr.y += plr.vy
 end

 if plr.y < 128 then
  plr.vy += plr.grv
 else
  plr.vy *= -1 -- reverse velocity
 end
end

function _draw()
 cls()
 circfill(plr.x,plr.y,4,8)
 print("vy:   " .. plr.vy,20,10)
 print("sgn:  " .. sgn(plr.vy),20,20)
 print("flp:   " .. plr.flapping,20,30)
end
