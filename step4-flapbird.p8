pico-8 cartridge // http://www.pico-8.com
version 39
__lua__

-- flap the bird
-- reset velocity
-- improve on simulation ??

function _init()
 plr = {
  x=10, -- x position on screen
  y=10, -- y position on screen
  vy=0, -- velocity/speed on y position
  grv=0.48,  -- gravity on plr
  --[[
   fri = 0.5, -- friction on bounce
   flpvel = 1, -- flap velocity
   flapping = true,
   nrg = 0,
  --]]
 }
end

function _update60()
 if (btn(4)) plr.y -= 1
   --[[
  if btn(4) then 
   plr.y -= plr.flpvel
   plr.move.vy = 0 
  end
   --]]
  if not btn(4) then
  plr.vy += plr.grv -- add gravity to current velocity
  plr.y += plr.vy -- calculate next position for y

  if plr.y > 128 - 4 then -- hit the ground
   plr.vy *= -1 -- reverse velocity 
   plr.y = 124 -- correction for below treshold
   plr.vy += plr.fri -- add friction
  end
 end
end

function _draw()
 cls()
 spr(1, plr.x, plr.y, 2, 2)
end

__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000ccccc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000cccccccc0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000aaaaaa000000000ccc6666666000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000099aaaaaaaa000000cccc6666666600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000009aaaaaaaa1aa00000ccc66666666600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000009aaaaaaaaaa88000cccc66666666600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000009aaaadaaaaa888800ccccc666cc66100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000009aaadaadaaaaa8000cccccccccccc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000009daaddd9aaaaa9000cccccccccccc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000009da999aaaaad0000cccccccccccc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000009ddaaaaaadd90000cccccccccccc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000099dddddd9900000ccccccccccc0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000099999900000000ccccccccc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000ccccccc000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
