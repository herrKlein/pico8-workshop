pico-8 cartridge // http://www.pico-8.com
version 16
__lua__

-- game loop
-- button press
-- player 'table'
-- cls and circfill

function _init()
 plr = {
  x=10,       -- x position on screen
  y=10,       -- y position on screen
 }
end

function _update60()
 if (btn(4)) plr.y -= 1
end

function _draw()
 cls()
 circfill(plr.x,plr.y,4,8)
end