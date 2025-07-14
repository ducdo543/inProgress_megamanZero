RectangleHitbox = Class{__includes = BaseHitbox}

function RectangleHitbox:init(def)
    BaseHitbox.init(self, def)

    if type(def) == 'function' then  
        def = def()
    end
    
    self.x = def.x 
    self.y = def.y 
    self.width = def.width 
    self.height = def.height 

end

function RectangleHitbox:update(dt)
    if self.movement == true then 
        self.x = self.x + self.dx * dt
        self.y = self.y + self.dy * dt 
    end
    if self.flag_stick == true then 
        local lazy_def = self.lazy_def()
        self.x = lazy_def.x 
        self.y = lazy_def.y 
    end
end

function RectangleHitbox:isFinished()
    return BaseHitbox.isFinished(self)
end

function RectangleHitbox:collide_rectangle(target)
    if target.x > self.x + self.width or target.x + target.width < self.x or 
        target.y > self.y + self.height or target.y + target.height < self.y then 
            return false 
    else
        return true 
    end
end

function RectangleHitbox:render()
    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
    love.graphics.setColor(1, 1, 1)
end