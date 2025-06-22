Explode = Class{}

function Explode:init(def)
    self.x = def.x 
    self.y = def.y 
    self.timer = 0.25
    self.anime = nil


    local animationDef = ENTITY_DEFS['effects'].animations['explode']
    self.anime = Animation({
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

function Explode:update(dt)
    self.timer = self.timer - dt
    self.anime:update(dt)
end

function Explode:isFinished()
    return self.timer <= 0
end

function Explode:render()
    love.graphics.draw(gTextures[self.anime.texture], gFrames[self.anime.texture][self.anime:getCurrentFrame()],
        math.floor(self.x - self.anime.offsetX), math.floor(self.y), 0 , self.anime.ratio, self.anime.ratio)
end

