Effect = Class{}

function Effect:init(def)
    self.x = def.x 
    self.y = def.y 
    self.anime = nil


    self.animationDef = def.animationDef
    self.anime = Animation({
        texture = self.animationDef.texture,
        frames = self.animationDef.frames,
        interval = self.animationDef.interval,
        ratio = self.animationDef.ratio,
        special_frames = self.animationDef.special_frames or nil,
        special_interval = self.animationDef.special_interval or nil,
        offsetX = self.animationDef.offsetX,
        offsetY = self.animationDef.offsetY        
    })

    self.timer = #self.anime.frames * self.anime.interval
end


function Effect:update(dt)
    self.timer = self.timer - dt
    self.anime:update(dt)
end

function Effect:isFinished()
    return self.timer <= 0
end

function Effect:render()
    love.graphics.draw(gTextures[self.anime.texture], gFrames[self.anime.texture][self.anime:getCurrentFrame()],
        math.floor(self.x - self.anime.offsetX), math.floor(self.y - self.anime.offsetY), 0 , self.anime.ratio, self.anime.ratio)
end

