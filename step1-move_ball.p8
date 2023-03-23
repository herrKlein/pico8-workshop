pico-8 cartridge // http://www.pico-8.com
version 16
__lua__

-- game loop
-- button press
-- player 'table'
-- cls and circfill

function _init()
 plr = {
  x=64,       -- x position on screen
  y=64,       -- y position on screen
 }
end

function _update60()
 if (btn(2)) plr.y -= 1
end

function _draw()
 cls()
 circfill(plr.x,plr.y,8,8)
end