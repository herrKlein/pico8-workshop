pico-8 cartridge // http://www.pico-8.com
version 41
__lua__
-- initialize variables
points = {}
sticks = {}
num_points = 10
point_size = 2

function init()
  -- create points
  for i=1,num_points do
    local x = flr(rnd(128))
    local y = flr(rnd(128))
    add(points, {x=x, y=y, oldx=x, oldy=y})
  end

  -- create sticks
  for i=1,#points-1 do
    add(sticks, {p1=i, p2=i+1, length=dist(points[i], points[i+1])})
  end
end

function update()
  -- update points
  for i=1,#points do
    local p = points[i]
    local vx = p.x - p.oldx
    local vy = p.y - p.oldy
    p.oldx = p.x
    p.oldy = p.y
    p.x = p.x + vx
    p.y = p.y + vy + 0.1

    -- contain points within screen bounds
    p.x = mid(0, p.x, 127)
    p.y = mid(0, p.y, 127)
  end

  -- constrain sticks to their original length
  for i=1,#sticks do
    local s = sticks[i]
    local p1 = points[s.p1]
    local p2 = points[s.p2]

    local dx = p2.x - p1.x
    local dy = p2.y - p1.y
    local d = dist(p1, p2)
    local diff = (s.length - d) / d

    if i > 1 then
      -- prevent the first stick from moving
      p1.x = p1.x - dx * 0.5 * diff
      p1.y = p1.y - dy * 0.5 * diff
    end

    p2.x = p2.x + dx * 0.5 * diff
    p2.y = p2.y + dy * 0.5 * diff
  end
end

function draw()
  cls()

  -- draw sticks
  for i=1,#sticks do
    local s = sticks[i]
    local p1 = points[s.p1]
    local p2 = points[s.p2]

    line(p1.x, p1.y, p2.x, p2.y, 7)
  end

  -- draw points
  for i=1,#points do
    local p = points[i]
    circfill(p.x, p.y, point_size, 7)
  end
end

-- helper function to calculate distance between two points
function dist(p1, p2)
  return sqrt((p2.x-p1.x)^2 + (p2.y-p1.y)^2)
end

init()

function _update60() update() end
function _draw() draw() end
__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
