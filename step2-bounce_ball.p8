pico-8 cartridge // http://www.pico-8.com
version 41
__lua__

-- add velocity
-- add gravity
-- detect hitting ground, add w, add h

function _init()
 plr = {
  x=64, -- x pos on screen
  y=64, -- y pos on screen
  vy=0, -- velocity
  grv=0.1,  -- gravity
  w=16, -- width
  h=16, -- height
 }
end

function _update60()
 if (btn(2)) plr.y -= 1

 plr.vy += plr.grv -- add gravity to current velocity
 plr.y += plr.vy -- calculate next position for y

 local ground = 128 - plr.h/2
 
 if plr.y > ground then -- hit the ground
  plr.vy *= -1 -- reverse velocity
  plr.y = ground -- 2. correction for below treshold
 end
end

function _draw()
 cls(12)
 circfill(plr.x,plr.y,plr.w/2,8)
end
