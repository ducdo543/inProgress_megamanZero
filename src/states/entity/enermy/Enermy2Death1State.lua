Enermy2Death1State = Class{__includes = BaseState}

function Enermy2Death1State:init(entity, gravity)
    self.entity = entity
    self.gravity = gravity

    self.time_accumulate = 0

    -- debrises of enermy 

    self.debri1 = {x = self.entity.x, y = self.entity.y, angle = 0, w = - math.rad(30)}
    self.debri2 = {x = self.entity.x, y = self.entity.y, width = self.entity.width, height = self.entity.height * 1/2, dx = -20, dy = -50}
    self.debri3 = nil 
    self.debri4 = nil

    -- explode 
    self.explode1 = {x = self.entity.x + self.entity.width * 1/2, y = self.entity.y,
        anime = nil, timer = 0.25,
        render = function(self) 
            love.graphics.draw(gTextures[self.anime.texture], gFrames[self.anime.texture][self.anime:getCurrentFrame()],
                math.floor(self.x - self.anime.offsetX), math.floor(self.y), 0 , self.anime.ratio, self.anime.ratio)
        end,

        update = function(self, dt)
            self.timer = self.timer - dt
            self.anime:update(dt)
        end,

        isFinished = function(self)
            return self.timer <= 0
        end
    }

    local animationDef = ENTITY_DEFS['enermy2'].animations['explode']
    self.explode1.anime = Animation({
        texture = animationDef.texture,
        frames = animationDef.frames,
        interval = animationDef.interval,
        ratio = animationDef.ratio,
        special_frames = animationDef.special_frames or nil,
        special_interval = animationDef.special_interval or nil,
        offsetX = animationDef.offsetX,
        offsetY = animationDef.offsetY        
    })

end

function Enermy2Death1State:enter(params)
    self.player = params.player
    table.insert(self.player.effectsAfterPlayer, self.explode1)

end

function Enermy2Death1State:update(dt)

    -- debri1
    if self.debri1 then
        self.debri1.angle = self.debri1.angle + self.debri1.w * dt
    end

    -- debri2
    if self.debri2 then 
        self.debri2.x = self.debri2.x + self.debri2.dx * dt

        self.debri2.dy = self.debri2.dy + self.gravity
        self.debri2.y = self.debri2.y + self.debri2.dy * dt

        if self.debri2.y >= 100 + self.entity.height then  
            self.debri3 = {x = self.debri2.x, y = self.debri2.y, width = 3, height = 3, dx = -30, dy = -140}
            self.debri4 = {x = self.debri2.x, y = self.debri2.y, width = 3, height = 3, dx = -30, dy = -120}
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
    -- debri1
    if self.debri1 then
        love.graphics.setColor(1, 0, 0)
        love.graphics.rectangle("fill", self.debri1.x, self.debri1.y, self.entity.width, self.entity.height)
        love.graphics.setColor(1, 1, 1)
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