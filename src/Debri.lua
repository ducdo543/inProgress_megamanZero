-- use when enermy die 

Debri = Class{}

function Debri:init(def)
    self.anim = def.anim
    self.x = def.x 
    self.y = def.y 
    self.width = def.width 
    self.height = def.height 
    self.angle = def.angle or 0 -- def.angle must be rad
    self.w = def.w  -- def.w must be rad
    self.dx = def.dx 
    self.dy = def.dy 
    self.frame = def.frame 
    self.gravity = def.gravity

    --flag for method isFinished()
    self.flag_finished = false
end

function Debri:update(dt)
    if self.w then 
        self.angle = self.angle + self.w * dt
    end

    if self.dx then 
        self.x = self.x + self.dx * dt
    end

    if self.dy then
        self.dy = self.dy + self.gravity
        self.y = self.y + self.dy * dt
    end

end


function Debri:isFinished()
    return self.flag_finished
end

function Debri:render()
    if self.anim.texture == 'enermy2-death1' then
        love.graphics.draw(gTextures[self.anim.texture], gFrames[self.anim.texture][self.frame],
            math.floor(self.x - self.width * 1/4), math.floor(self.y + self.height), 
            self.angle, self.anim.ratio, self.anim.ratio,
            math.floor((self.width * 1/4) * 5 ), math.floor((self.height) * 5))
    end
end