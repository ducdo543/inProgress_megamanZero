Effect = Class{}

function Effect:init(def)
    if type(def) == 'function' then 
        self.lazy_def = def 
        def = def()
    end

    self.x = def.x 
    self.y = def.y 
    self.anime = nil

    if def.disappear == false then
        self.disappear = def.disappear
    else 
        self.disappear = true 
    end

    self.flag_stick = def.flag_stick or false
    if self.flag_stick == true then 
        assert(self.lazy_def, 'missing lazy_def, def must be a call-back function')
    end

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

    if self.disappear then
        self.timer = #self.anime.frames * self.anime.interval
    end

    -- remove from table effectsAfterPlayer when true
    self.flag_finished = false

end


function Effect:update(dt)
    if self.disappear then
        self.timer = self.timer - dt
        if self.timer <= 0 then 
            self.flag_finished = true 
        end
    end

    if self.flag_stick == true then 
        local lazy_def = self.lazy_def()
        self.x = lazy_def.x 
        self.y = lazy_def.y 
    end
    
    self.anime:update(dt)
end

function Effect:isFinished()
    return self.flag_finished
end

function Effect:render()
    love.graphics.draw(gTextures[self.anime.texture], gFrames[self.anime.texture][self.anime:getCurrentFrame()],
        math.floor(self.x - self.anime.offsetX), math.floor(self.y - self.anime.offsetY), 0 , self.anime.ratio, self.anime.ratio)
end

