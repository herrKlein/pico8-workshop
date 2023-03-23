pico-8 cartridge // http://www.pico-8.com
version 41
__lua__

p = {}
m = {}

function _init()
 m = init_map()
 p = init_player()
end

function _update60()
 if not p.dead then
  update_map(m)
  update_player(p)
 else
  if btn(4) and p.dead then 
   _init()
  end
 end
end

function _draw()
 cls(12)
 print(p.dead,-m.x,10)
 draw_map(m)
 draw_player(p)
end

-->8
-- player
function init_player()
 return {
  x=10, -- x position on screen
  y=10, -- y position on screen
  w=16, -- width
  h=16, -- height
  vy=0, -- velocity/speed on y position
  grv=0.1,  -- gravity on plr
  fri = 2, -- friction on bounce
  flpvel = 1, -- flap velocity
  flapping = false,
  dead = false,
  vx=0.5
 }
end

function update_player(plr)
 if btn(4) then 
  plr.y -= plr.flpvel
  plr.vy = 0 
 end

 if not btn(4) then
  plr.vy += plr.grv -- add gravity to current velocity
  plr.y += plr.vy -- calculate next position for y

  local ground=128-plr.h
  if plr.y > ground then -- hit the ground
   plr.vy *= -1 -- reverse velocity 
   plr.y = ground -- correction for below treshold

   local xtile = abs((plr.x+8)/1024*128)
   local flag = fget(mget(xtile, 15))
   if (flag == 1) plr.vy -= 2
   if (flag == 2) plr.vy += max(plr.fri, plr.vy)
   if (flag == 4) plr.dead = true

  end
 end

 plr.x += plr.vx
end

function  draw_player(plr)
 spr(1, plr.x, plr.y, 2, 2)
end

-->8
-- map
function init_map()
 return {
  x=0, -- x position on screen
 }
end

function update_map(m)
 if m.x > -(128*8-8*16) then
  m.x -= p.vx
 end
end

function draw_map(m)
 -- map(0, 0, m.x, 0, 128, 16)
 map(0, 0, 0, 0, 128, 16)
 camera(-m.x, 0)
end

__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000aaaaaa0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000099aaaaaaaa00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000009aaaaaaaa1aa0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000009aaaaaaaaaa88000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000009aaaadaaaaa888800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000009aaadaadaaaaa8000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000009daaddd9aaaaa9000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000009da999aaaaad0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000009ddaaaaaadd90000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000099dddddd9900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000009999990000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000bbbbbbbb3333333322262222000000e88820000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000bbbbbbbb333333332226222200000e888882000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000bbbbbbbb33333333226662220000e8800888200000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000bbbbbbbb3333333322666222000e88000088820000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000bbbbbbbb3333333326666622000e80000008820000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000bbbbbbbb3333333326666622000e80000008820000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000044444444444444444444444400e880000008882000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000044444444444444444444444400e800000000882000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000e800000000882000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000008800000000882000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000088800000000888200000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000088000000000088200000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000088000000000088200000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000088000000000088200000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000088000000000088200000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000088000000000088200000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000088000000000088200000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000088000000000088200000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000088000000000088200000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000088000000000088200000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000088000000000088200000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000088800000000888200000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000008800000000e82000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000008800000000e82000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000008800000000e82000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000888000000e882000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000088000000e820000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000088000000e820000000000000000000000000000000000000000000000000000000000000000000000000000000000
000000000000000000000000000000000008880000e8820000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000088800e88200000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000888e882000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000888820000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__gff__
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010204000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000444500000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000545500000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000646500000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000747500000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4242424242424242414141424243434342424241414141414242424343434343424242424242414142424242424242424242424242414141414141414242424242424242424242424242424141424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242424242
4040404040404040404040404040404000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
