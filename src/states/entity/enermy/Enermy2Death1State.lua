Enermy2Death1State = Class{__includes = BaseState}

function Enermy2Death1State:init(entity, gravity)
    self.entity = entity
    self.gravity = gravity

    self.time_accumulate = 0

    -- debrises of enermy 

    self.debri1 = {x = self.entity.x + 3, y = self.entity.y + 6, width = self.entity.width, height = self.entity.height - 6, angle = 0, w = - math.rad(180), frame = 2}
    self.debri2 = {x = self.entity.x, y = self.entity.y, width = self.entity.width, height = self.entity.height * 1/2, dx = -20, dy = -50, frame = 3}
    self.debri3 = nil 
    self.debri4 = nil

    -- explode 
    self.explode1 = Explode({x = self.entity.x + self.entity.width * 1/2, y = self.entity.y})

end

function Enermy2Death1State:enter(params)
    self.player = params.player
    table.insert(self.player.effectsAfterPlayer, self.explode1)

end

function Enermy2Death1State:update(dt)

    -- debri1
    if self.debri1 then
        self.debri1.angle = self.debri1.angle + self.debri1.w * dt
        if math.abs(self.debri1.angle) >= math.rad(90) then 
            self.explode2 = Explode({
                x = self.debri1.x - self.debri1.width * 2/3,
                y = self.debri1.y + self.debri1.height * 1/3
            })
            table.insert(self.player.effectsAfterPlayer, self.explode2)
            self.debri1 = nil 
        end
    end

    -- debri2
    if self.debri2 then 
        self.debri2.x = self.debri2.x + self.debri2.dx * dt

        self.debri2.dy = self.debri2.dy + self.gravity
        self.debri2.y = self.debri2.y + self.debri2.dy * dt

        if self.debri2.y >= 100 + self.entity.height then  
            self.debri3 = {x = self.debri2.x, y = self.debri2.y, width = 6, height = 6, dx = -30, dy = -140, frame = 4}
            self.debri4 = {x = self.debri2.x + 10, y = self.debri2.y + 6, width = 6, height = 6, dx = -30, dy = -120, frame = 5}
            self.debri2 = nil 
        end
    end

    -- debri3
    if self.debri3 then 
        self.debri3.x = self.debri3.x + self.debri3.dx * dt

        self.debri3.dy = self.debri3.dy + self.gravity
        self.debri3.y = self.debri3.y + self.debri3.dy * dt
    end

    -- debri4
    if self.debri4 then 
        self.debri4.x = self.debri4.x + self.debri4.dx * dt

        self.debri4.dy = self.debri4.dy + self.gravity
        self.debri4.y = self.debri4.y + self.debri4.dy * dt
    end    

end

function Enermy2Death1State:render()
    local anim = ENTITY_DEFS['enermy2'].animations['death1']

    -- debri1
    if self.debri1 then
        love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][self.debri1.frame],
            math.floor(self.debri1.x - self.debri1.width * 1/4), math.floor(self.debri1.y + self.debri1.height), 
            self.debri1.angle, anim.ratio, anim.ratio,
            math.floor((self.debri1.width * 1/4) * 5 ), math.floor((self.debri1.height) * 5))
        -- love.graphics.setColor(1, 0, 0)
        -- love.graphics.rectangle("fill", self.debri1.x, self.debri1.y, self.entity.width, self.entity.height)
        -- love.graphics.setColor(1, 1, 1)
    end
    -- debri2
    if self.debri2 then
        love.graphics.setColor(1, 0, 0)
        love.graphics.rectangle("fill", self.debri2.x, self.debri2.y, self.debri2.width, self.debri2.height)
        love.graphics.setColor(1, 1, 1)    
    end
    -- debri3
    if self.debri3 then 
        love.graphics.setColor(1, 0, 0)
        love.graphics.rectangle("fill", self.debri3.x, self.debri3.y, self.debri3.width, self.debri3.height)
        love.graphics.setColor(1, 1, 1)   
    end
    -- debri4
    if self.debri4 then 
        love.graphics.setColor(1, 0, 0)
        love.graphics.rectangle("fill", self.debri4.x, self.debri4.y, self.debri4.width, self.debri4.height)
        love.graphics.setColor(1, 1, 1)   
    end

end