pico-8 cartridge // http://www.pico-8.com
version 16
__lua__

-- physics
-- game corrections

function _init()
 plr = {
  x=10, -- x position on screen
  y=10, -- y position on screen
  -- vy=0, -- velocity/speed on y position
  -- grv=0.48  -- gravity on plr
 }
end

function _update60()
 if (btn(4)) plr.y -= 1

 -- plr.vy += plr.grv -- add gravity to current velocity
 -- plr.y += plr.vy -- calculate next position for y

 -- if plr.y > 128 - 4 then -- hit the ground
  -- plr.vy *= -1 -- reverse velocity
  -- plr.y = 124 -- 2. correction for below treshold
 -- end
end

function _draw()
 cls()
 circfill(plr.x,plr.y,4,8)
end