pico-8 cartridge // http://www.pico-8.com
version 41
__lua__

t=0
tps=1

p = {}
m = {}

function _init()
 m = init_map()
 p = init_player()
end

function _update60()

 t+=1
 if (t%tps!=0) return
  
 if not p.dead then
  update_map(m)
  update_player(p)
 else
  if btn(2) and p.dead then 
   _init()
  end
 end
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
  fri = 2, -- friction on bounce
  dead = false,
  vx=0.5
 }
end

function update_player(plr)

 local flag, tile = collide(plr, abs(m.x))
 if (btnp(2)) then 
  plr.vy = -2
  sfx(2) -- add
 end

 plr.vy += plr.grv 
 plr.y += plr.vy 

 local ground=128-plr.h
 
 if (flag == 1) then -- friction
  plr.vy += plr.fri 
  sfx(0) -- add
 end 
 if (flag == 2) then -- bounce
  plr.vy -= 1 
  sfx(1) -- add
 end
 if (flag == 4) then -- spikes
  plr.dead = true 
  sfx(4) -- add
 end
 if (flag == 7) then -- rock
  plr.dead = true 
  sfx(4) -- add
 end
 if flag == 5 then -- coin
  mset(tile.x,tile.y,0) -- remove coin
  sfx(3,1)
 end
 
 if plr.y > ground then -- move to here
  plr.vy *= -1 
  plr.y = ground 
  plr.vy += plr.fri -- remove this line 
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
 map(0, 0, 0, 0, 128, 16)
 camera(-m.x, 0)
end

-->8
-- hit collission

function collide(plr) -- returns flag,tile if hit
-- Calculate the tile indices of the four corners of the sprite
 local corners = {
  { x = flr(plr.x / 8), y = flr(plr.y / 8) },
  { x = flr((plr.x + plr.w - 1) / 8), y = flr(plr.y / 8) },
  { x = flr((plr.x + plr.w - 1) / 8), y = flr((plr.y + plr.h - 1) / 8) },
  { x = flr(plr.x / 8), y = flr((plr.y + plr.h - 1) / 8) },
 }
 for i, tile in ipairs(corners) do
  -- Calculate the tile index of the current corner
  local flag = fget(mget(tile.x, tile.y))

  if flag>0 then
   return flag, {x=tile.x, y=tile.y}
  end
 end

 -- No collision detected
 return nil, nil
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
00000000666666663131313122262222000000e888200000007aa900000000006666666600000000000000000000000000000000000000000000000000000000
0000000066666666313131312226222200000e888882000007aaaa90000000666666666666000000000000000000000000000000000000000000000000000000
000000005555555531313131226662220000e880088820007aaaaaa9000006666666666666600000000000000000000000000000000000000000000000000000
00000000b55bb55b3333333322666222000e880000888200aaaaaaa9000666666666666666666000000000000000000000000000000000000000000000000000
00000000bbb55bbb3333333326666622000e800000088200aaaaaaa9000666666666666666666000000000000000000000000000000000000000000000000000
00000000b55bb55b3333333326666622000e800000088200aaaaaaa9006666666666666666666600000000000000000000000000000000000000000000000000
0000000044444444444444444444444400e88000000888200aaaaa90066666666666666666666660000000000000000000000000000000000000000000000000
0000000044444444444444444444444400e800000000882000aaa900066666666666666666666660000000000000000000000000000000000000000000000000
0000000000000000000000000000000000e800000000882000000000000000006666666600000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000008800000000882000000000000000006666666600000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000088800000000888200000000000000006666666600000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000088000000000088200000000000000006666666600000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000088000000000088200000000000000006666666600000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000088000000000088200000000000000006666666600000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000088000000000088200000000000000006666666600000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000088000000000088200000000000000006666666600000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000088000000000088200000000066666660000000066666660000000000000000000000000000000000000000000000000
00000000000000000000000000000000088000000000088200000000066666660000000066666660000000000000000000000000000000000000000000000000
00000000000000000000000000000000088000000000088200000000006666660000000066666600000000000000000000000000000000000000000000000000
00000000000000000000000000000000088000000000088200000000000666660000000066666000000000000000000000000000000000000000000000000000
00000000000000000000000000000000088000000000088200000000000666660000000066666000000000000000000000000000000000000000000000000000
00000000000000000000000000000000088800000000888200000000000006660000000066600000000000000000000000000000000000000000000000000000
00000000000000000000000000000000008800000000e82000000000000000660000000066000000000000000000000000000000000000000000000000000000
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
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010204000005070707000000000000000000000000000007000000000000000000000000000007000700000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000046000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000047485849000000000000000000000000000000000000004600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000004600000058585858000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000046000000000000000000000000000000000000000000000000000000000000000000444500000000
0000000000000000000000000000000067585869000000004600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000460000000000000000000000000000545500000000
0000000000460000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000004600000000460000000000000000000000000000000000000000000000460000000000000000000000000000000000000000000000000000646500000000
0000000000000000000000000000000046000000000000000000000000000000000000000000000000000000460000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000460000000000000000000000000000000000000000000000000000000000747500000000
0000000000000000000000000000000000000000000000000000000000000046000000000000000000000000000000000000000000000000000000004600000000000000000000000000000000000000000000004600000000000000000000000000000000000046000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000460000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
4242424242424242414141424243434342424241414141414242424343434343424242424242414142424242424242424242424242414141414141414242424242424242424243434342424141424242424242424242434343434242424242424343434342424242424242424242424242424242424242424242424242424242
4040404040404040404040404040404000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
0001000011050100500f0500d0500b050080500605004050010500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000100001e0501e0501d0501b0501a0501805016050130500f0500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00020000135500f5500e55008550035500155001550075500e55010550105500c550065500255002550045500b5000e5000e5000d500095000350001500045000d5000f5000f5000d5000450002500075000c500
000400002c3502c3502c3503435034340343403434034330343303433034320343203432034310343103431034300343000010000100001000010000100001000010000100001000010000100001000010000100
000200000e4500545002450004500045000450144001440013400114000d400084000240000400004000040000400004000040000400004000040000400004000040000400004000040000400004000040000400
