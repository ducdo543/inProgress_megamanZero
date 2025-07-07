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

end

function RectangleHitbox:isFinished()
    return BaseHitbox.isFinished(self)
end

function RectangleHitbox:collide_rectangle(target)

end

function RectangleHitbox:render()
    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
    love.graphics.setColor(1, 1, 1)
end