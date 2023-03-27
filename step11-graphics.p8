pico-8 cartridge // http://www.pico-8.com
version 41
__lua__

p = {}
m = {}
dust={}

function _init()
 m = init_map()
 p = init_player()
end

function _update60()  
 if not p.dead then
  update_map(m)
  update_player(p)
 end

 if p.dead then
  p.spr = 5
  for d in all(dust) do
   d:update()
  end

  if btn(4) and p.dead then 
   _init()
  end
 end
end

function _draw()
 cls(1)
 draw_map(m)
 
 if p.dead then
  add_new_dust(p.x+p.w/2,p.y+p.h/2,rnd(4)-2,rnd(4)-2,25,rnd(3)+1,0.05,{7,7,7,7,7,7,6,6,6,6,6,5,5,9,9,10,10,10,10,10,8,8,8,8})
  for d in all(dust) do
   d:draw()
 	end
 end
 
 draw_player(p)
end

-->8
-- player
function init_player()
 return {
  x=10, -- x position on screen
  y=64, -- y position on screen
  w=16, -- width
  h=16, -- height
  vy=0, -- velocity/speed on y position
  grv=0.01,  -- gravity on plr
  fri = 2, -- friction on bounce
  dead = false,
  vx=0.5,
  sprites={1,2,3,4},
  spr=1
 }
end

function update_player(plr)

 local flag, tile = collide(plr, abs(m.x))
 if (btnp(2)) then 
  plr.vy -= 1
  sfx(2) -- add
 end

 plr.vy += plr.grv 
 plr.y += plr.vy 

 local ground=128-plr.h-4 -- subtract 4
 
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
 end
 
 plr.x += plr.vx
end

function  draw_player(plr)
 spr(plr.spr, plr.x, plr.y, 2, 2) -- add plr.spr
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

-->8
-- explosions
--reduced character count
function add_new_dust(_x,_y,_dx,_dy,_l,_s,_g,_f)
  add(dust, {
  fade=_f,x=_x,y=_y,dx=_dx,dy=_dy,life=_l,orig_life=_l,rad=_s,col=0,grav=_g,draw=function(self)
  pal()palt()circfill(self.x,self.y,self.rad,self.col)
  end,update=function(self)
  self.x+=self.dx self.y+=self.dy
  self.dy+=self.grav self.rad*=0.9 self.life-=1
  if type(self.fade)=="table"then self.col=self.fade[flr(#self.fade*(self.life/self.orig_life))+1]else self.col=self.fade end
  if self.life<0then del(dust,self)end end})
  end

__gfx__
00000000000000007777700000000000000000000000000004400000000000000000011100000000000000000000000000000000000000000000000000000000
00000000000000071dddd700000000000000000000000000044000000000000000011b7b11000000000000000000000000000000000000000000000000000000
0000000000000071d77555700000000000000000000000049940004400000000001bc3777b100000000000000000000000000000000000000000000000000000
000000000000071d57ffff1700000aaaaaa0000000000049990000440000000001b333377b100000000000000000000000000000000000000000000000000000
0000000000000715ff1f1f1700099aaaaaaaa000009f9455994449940000000001b131333b100000000000000000000000000000000000000000000000000000
0000000000000a95ff1f1f17009aadddaaa1aa0009499449559999900000000001b1313733b10000000000000000000000000000000000000000000000000000
000000000000a999ffffff70009aad99daaaa88000004fff995999a00000000001b3333333b10110000000000000000000000000000000000000000000000000
00000000000099f95ffff47009aaaad99aaa888800045559f9999a0000000000001b3333333b1b71000000000000000000000000000000000000000000000000
0000000000a9999f9555400009aaaaaaaaaaaa80074ffff59f99000000000000001b33333333ccb1000000000000000000000000000000000000000000000000
000000000a999599fff4000009daaaaaaaaaaa9007ffffff999a0000000000000001b333333b1110000000000000000000000000000000000000000000000000
000000000999995594499490009daaaaaaaaad0071f1f1ff59a000000000000000001b3333b10000000000000000000000000000000000000000000000000000
00000000499444995549f900009ddaaaaaadd90071f1f1ff517000000000000000001c3bb3b71000000000000000000000000000000000000000000000000000
00000000440000999400000000099dddddd9900071ffff75d1700000000000000001b3c11cbb1000000000000000000000000000000000000000000000000000
00000000440004994000000000000999999000000755577d17000000000000000001331001110000000000000000000000000000000000000000000000000000
0000000000000440000000000000000000000000007dddd170000000000000000000110000000000000000000000000000000000000000000000000000000000
00000000000004400000000000000000000000000007777700000000000000000000000000000000000000000000000000000000000000000000000000000000
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
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000d00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__gff__
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000010204000005070707000000000000000101010000000007000000000000000000000000000007000700000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000008090000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000018190000000000000047484848490000000000000000000000000000000000000046000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000058585858580000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000047485849000000000000000000000058585858580000004600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000080900004600000058585858000000000000000000000000000058580000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000046000000000000000000000000000000000000000000000000000000000000000000444500000000
0000000000000000181900000000000067585869000000004600000000000000000058580000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000460000000000000000000000000000545500000000
0000000000460000000000000000000000000000000000000000000000000000000067690000000000000000000000000000000000000000000000000000000000004600000000460000000000000000000000000000000000000000000000460000000000000000000000000000000000000000000000000000646500000000
0000000000000000000000000000000046000008090000004748484848490000000000000000000000000000460000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000460000000000000000000000000000000000000000000000000000000000747500000000
0000000000000000000000000000000000000018190000005858585858580046000000000000000000000000000000000000000000000000000000004600000000000000000000000000000000000000000000004600000000000000000000000000000000000046000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000006758585858690000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000460000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
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
