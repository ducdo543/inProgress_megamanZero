PartCircleHitbox = Class{}

function PartCircleHitbox:init(def)
    self.cx = def.cx -- central point of circle
    self.cy = def.cy
    self.radius = def.radius 

    self.start_angle = math.rad(def.start_angle)
    self.cover_angle = math.rad(def.cover_angle)

    assert(-math.pi <= self.start_angle and self.start_angle <= math.pi, "start_angle must be in [-π, π]")
    assert(0 < self.cover_angle and self.cover_angle <= math.pi, "cover_angle must be in (0, π]")

    self.end_angle = self.start_angle + self.cover_angle

    self.dx = def.dx 
    self.dy = def.dy 

    -- flag movement target like bullet
    self.movement = def.movement 
    -- flag stick hitbox with player during slash state
    self.flag_stick = def.flag_stick
    self.entity = def.entity -- receive player position

    -- to delete hitbox after some time 
    self.time_disappear = def.time_disappear or nil
    self.time_accumulate = 0

    -- what type of slash is mark in hitbox
    self.type_slash = def.type_slash or nil

    -- retent entities that being hit cause we just want this hitbox hit each entity 1 time.
    self.wasHitted_entities = {} -- structure lookup like self.wasHitted_entities[enermy] = true
end

function PartCircleHitbox:update(dt)

    if self.movement == true then 
        self.cx = self.cx + self.dx * dt
        self.cy = self.cy + self.dy * dt 
    end

    if self.flag_stick == true then 
        if self.type_slash == 'sting' then
            self.cx = self.entity.direction == 'right' and (self.entity.x) or (self.entity.x + self.entity.width)
            self.cy = self.entity.y + self.entity.height * 2/3
            self.start_angle = self.entity.direction == 'right' and math.rad(-5) or math.rad(175)
            self.end_angle = self.start_angle + self.cover_angle
        end
    end
end

function PartCircleHitbox:delete(dt)
    self.time_accumulate = self.time_accumulate + dt 
    if self.time_disappear and self.time_accumulate >= self.time_disappear then
        return true 
    end
end

function PartCircleHitbox:collide_rectangle(target)
    -- angle for comparison
    local compare_angle = 0
    -- 1/4 circle top left corner for start_angle
    if (-math.pi <= self.start_angle and self.start_angle <= -math.pi/2) or
        (0 <= self.start_angle and self.start_angle <= math.pi/2) then --(góc phần tư thứ 3 kim đồng hồ cách cái này) then 
        -- consider left Ox axis
        -- point at start_angle is the first point collide with left side of window, 
        -- because as assert, always self.start_angle < self.end_angle < self.start_angle + math.pi, 
        -- (assert means that we just draw <= 1/2 circle) 

        -- px means point x position
        self.horizontal_px= self.cx + self.radius * math.cos(self.start_angle)
        self.horizontal_py= self.cy + self.radius * math.sin(self.start_angle)

        if self.start_angle + math.pi/2 >= math.pi/2 then
            compare_angle = math.pi/2
        elseif self.start_angle + math.pi/2 >= -math.pi/2 then
            compare_angle = - math.pi/2
        end
        if self.end_angle <= compare_angle then 
        -- consider up Oy axis
        -- point at end_angle is the first point collide with up side of window
            self.vertical_px = self.cx + self.radius * math.cos(self.end_angle)
            self.vertical_py = self.cy + self.radius * math.sin(self.end_angle)
        -- consider right Ox and down Oy axis 
        -- central point is the first point collide with right and down of window
            self.opposite_horizontal_px = self.cx 
            self.opposite_horizontal_py = self.cy 

            self.opposite_vertical_px = self.cx 
            self.opposite_vertical_py = self.cy 
        elseif (compare_angle < self.end_angle and self.end_angle <= compare_angle + math.pi/2) then 
        -- highest up point is the first point collide with up side of window
            self.vertical_px = self.cx
            self.vertical_py = self.cy + self.radius * math.sin(compare_angle)
        -- point at end_angle is the first point collide with right side of window
            self.opposite_horizontal_px = self.cx + self.radius * math.cos(self.end_angle)
            self.opposite_horizontal_py = self.cy + self.radius * math.sin(self.end_angle)
        -- central point is the first point collide with down of window
            self.opposite_vertical_px = self.cx 
            self.opposite_vertical_py = self.cy
        elseif (compare_angle + math.pi/2 < self.end_angle and self.end_angle <= compare_angle + math.pi) then 
        -- highest up point is the first point collide with up side of window
            self.vertical_px = self.cx
            self.vertical_py = self.cy + self.radius * math.sin(compare_angle)
        -- highest right point is the first point collide with right side of window
            self.opposite_horizontal_px = self.cx + self.radius * math.cos(compare_angle + math.pi/2)
            self.opposite_horizontal_py = self.cy
        -- point at end_angle is the first point collide with down side of window
            self.opposite_vertical_px = self.cx + self.radius * math.cos(self.end_angle)
            self.opposite_vertical_py = self.cy + self.radius * math.sin(self.end_angle)                   
        end
    
    elseif (-math.pi/2 <= self.start_angle and self.start_angle <= 0) or
        (math.pi/2 <= self.start_angle and self.start_angle <= math.pi) then
        
        self.vertical_px= self.cx + self.radius * math.cos(self.start_angle)
        self.vertical_py= self.cy + self.radius * math.sin(self.start_angle)

        if self.start_angle + math.pi/2 >= math.pi then
            compare_angle = math.pi
        elseif self.start_angle + math.pi/2 >= 0 then
            compare_angle = 0
        end

        if self.end_angle <= compare_angle then 
        -- point at end_angle is the first point collide with right side of window
            self.horizontal_px = self.cx + self.radius * math.cos(self.end_angle)
            self.horizontal_py = self.cy + self.radius * math.sin(self.end_angle)
        -- central point is the first point collide with down and left side of window
            self.opposite_vertical_px = self.cx 
            self.opposite_vertical_py = self.cy 

            self.opposite_horizontal_px = self.cx 
            self.opposite_horizontal_py = self.cy 
        elseif (compare_angle < self.end_angle and self.end_angle <= compare_angle + math.pi/2) then 
        -- highest right point is the first point collide with right side of window
            self.horizontal_px = self.cx + self.radius * math.cos(compare_angle)
            self.horizontal_py = self.cy 
        -- point at end_angle is the first point collide with down side of window
            self.opposite_vertical_px = self.cx + self.radius * math.cos(self.end_angle)
            self.opposite_vertical_py = self.cy + self.radius * math.sin(self.end_angle)
        -- central point is the first point collide with left side of window
            self.opposite_horizontal_px = self.cx 
            self.opposite_horizontal_py = self.cy
        elseif (compare_angle + math.pi/2 < self.end_angle and self.end_angle <= compare_angle + math.pi) then 
        -- highest right point is the first point collide with right side of window
            self.horizontal_px = self.cx + self.radius * math.cos(compare_angle)
            self.horizontal_py = self.cy 
        -- highest down point is the first point collide with down side of window
            self.opposite_vertical_px = self.cx
            self.opposite_vertical_py = self.cy + self.radius * math.sin(compare_angle + math.pi/2)
        -- point at end_angle is the first point collide with left side of window
            self.opposite_horizontal_px = self.cx + self.radius * math.cos(self.end_angle)
            self.opposite_horizontal_py = self.cy + self.radius * math.sin(self.end_angle)                   
        end
    end

    -- arrange x, y values larger, smaller
    self.upY = math.min(self.vertical_py, self.opposite_vertical_py)
    self.upX = (self.upY == self.vertical_py) and self.vertical_px or self.opposite_vertical_px

    self.downY = math.max(self.vertical_py, self.opposite_vertical_py)
    self.downX = (self.downY == self.vertical_py) and self.vertical_px or self.opposite_vertical_px

    self.rightX = math.max(self.horizontal_px, self.opposite_horizontal_px)
    self.rightY = (self.rightX == self.horizontal_px) and self.horizontal_py or self.opposite_horizontal_py

    self.leftX = math.min(self.horizontal_px, self.opposite_horizontal_px)
    self.leftY = (self.leftX == self.horizontal_px) and self.horizontal_py or self.opposite_horizontal_py   

    -- check collide side up, down, left, right
    if self.upY <= 0 then 

    end
    if self.downY >= VIRTUAL_HEIGHT then

    end
    if self.leftX <= 0 then

    end
    if self.rightX >= VIRTUAL_WIDTH then

    end    

    -- check collide
    local flag_collide = false 

    -- topLeft, topRight, downRight, downLeft
    local corner_table = {
        topLeft = {distanceY = target.y - self.cy, distanceX = target.x - self.cx},
        topRight = {distanceY = target.y - self.cy, distanceX = target.x + target.width - self.cx},
        downRight = {distanceY = target.y + target.height - self.cy, distanceX = target.x + target.width - self.cx},
        downLeft = {distanceY = target.y + target.height - self.cy, distanceX = target.x - self.cx}
    }
    -- add corner data
    for _, cornerData in pairs(corner_table) do
        cornerData.angle = math.atan2(cornerData.distanceY, cornerData.distanceX)
    end

    -- see if 4 angles of rectangle are in partCircle then turn on the flag
    for _, cornerData in pairs(corner_table) do
        -- first condition
        if (self.start_angle <= cornerData.angle and cornerData.angle <= self.end_angle) then 
            -- second condition is that distance between corner point of rectangle and central point of circle <= radius circle
            if cornerData.distanceY ^ 2 + cornerData.distanceX ^ 2 <= self.radius ^ 2 then 
                flag_collide = true
                break
            end
        end
    end

    -- see if 4 highest point up, right, down, left of partCircle collide with rectangle edge
    -- consider up partCircle
        -- first condition
    if (self.downY >= target.y + target.height and target.y + target.height >= self.upY) then 
        -- second condition
        if (target.x <= self.upX and self.upX <= target.x + target.width) then 
            flag_collide = true
        end
    end
    -- consider right partCircle
    if (self.leftX <= target.x and target.x <= self.rightX) then 
        if (target.y <= self.rightY and self.rightY <= target.y + target.height) then
            flag_collide = true
        end
    end
    -- consider down partCircle
    if (self.upY <= target.y and target.y <= self.downY) then 
        if (target.x < self.downX and self.downX <= target.x + target.width) then
            flag_collide = true 
        end
    end
    -- consider left partCircle
    if (self.leftX <= target.x + target.width and target.x + target.width <= self.rightX) then
        if (target.y <= self.leftY and self.leftY <= target.y + target.height) then 
            flag_collide = true 
        end
    end

    if flag_collide == true then 
        return true
    end
        
    
    -- check if each value of variable is correct (test cases)
    -- if self.flag_print == nil then 
    --     print(compare_angle)
    --     print(self.horizontal_px)
    --     print(self.horizontal_py)
    --     print(self.vertical_px)
    --     print(self.vertical_py)
    --     print(self.opposite_vertical_px)
    --     print(self.upY)
    --     print(self.upX)
    --     print(self.downY)
    --     print(self.downX)
    --     print(self.rightX)
    --     print(self.rightY)
    --     print(self.leftX)
    --     print(self.leftY)
    --     print(topLeft_corner)
    --     print(flag_collide)
    --     self.flag_print = true
    -- end
end

function PartCircleHitbox:render()
    love.graphics.setColor(1, 0, 0)
    love.graphics.arc('fill', self.cx, self.cy, self.radius, self.start_angle, self.end_angle)
    love.graphics.setColor(1, 1, 1)
end
