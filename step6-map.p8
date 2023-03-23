pico-8 cartridge // http://www.pico-8.com
version 41
__lua__

-- draw map elements
-- draw map
-- eplain with drawing (map and camera)
-- create a new tab
-- add init/update/draw methods
-- draw map, position camera
-- sync x pos with map
-- on end map stop camera

p = {}
m = {}

function _init()
 m = init_map()
 p = init_player()
end

function _update60()
 update_map(m)
 update_player(p)
end

function _draw()
 cls(12)
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
  fri = 0.5, -- friction on bounce
  vx=0.5
 }
end

function update_player(plr)
 if (btnp(2)) then 
  plr.vy = -2
 end

 plr.vy += plr.grv 
 plr.y += plr.vy 

 local ground=128-plr.h-8 -- subtract 8
 if plr.y > ground then 
  plr.vy *= -1 
  plr.y = ground 
  plr.vy += plr.fri 
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
 -- print(m.x,-m.x+20,10)
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
00000000bbbbbbbb0000000033333333000000e88820000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000bbbbbbbb000000003333333300000e888882000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000bbbbbbbb00000000333333330000e8800888200000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000bbbbbbbb0000000033333333000e88000088820000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000bbbbbbbb0000000033333333000e80000008820000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000bbbbbbbb0000000033333333000e80000008820000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000044444444000000004444444400e880000008882000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000044444444000000004444444400e800000000882000000000000000000000000000000000000000000000000000000000000000000000000000000000
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
4343434343434343414141434343434343434341414141414343434343434343434343434343414143434343434343434343434343414141414141414343434343434343434343434343434141434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343434343
4040404040404040404040404040404000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
