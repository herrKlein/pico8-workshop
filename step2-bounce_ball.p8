pico-8 cartridge // http://www.pico-8.com
version 41
__lua__

function _init()
 plr = {
  x=64, -- x pos on screen
  y=64, -- y pos on screen

  vy=0, -- velocity
  grv=0.1,  -- gravity
  flapping=false
 }
end

function _update60()
 if (btn(4)) plr.y -= 1

 plr.vy += plr.grv -- add gravity to current velocity
 plr.y += plr.vy -- calculate next position for y

 if plr.y > 128 - 4 then -- hit the ground
   plr.vy *= -1 -- reverse velocity
  plr.y = 124 -- 2. correction for below treshold
 end
end

function _draw()
 cls()
 circfill(plr.x,plr.y,4,8)
end
