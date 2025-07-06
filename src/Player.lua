Player = Class{__includes = Entity}

function Player:init(def)
    Entity.init(self, def)
    self.jump_velocity = def.jump_velocity
    self.walkSpeed = def.walkSpeed
    self.dashSpeed = def.dashSpeed

    -- see if we can double jump 
    self.flag_doubleJump = true

    -- see if we have a dash speed
    self.flag_dashJump = false

    -- retent hitboxes in table
    self.hitboxes = {}

    -- to render effects after player so that effects image overwritten player
    self.effectsAfterPlayer = {}

    -- attribute for energyAbsorb and release
    self.can_releaseEnergy = false 
    self.process_energyAbsorb = false
    self.time_releaseEnergy = 2 
    self.timeEnergy_accumulate = 0
    self.animeEnergyAbsorb = nil
    self.animationDef = ENTITY_DEFS['effects'].animations['explode']
    self.hitbox1 = nil

end

function Player:update(dt)
    -- for energyAbsorb and release
    if love.keyboard.isDown('c') then 
        self.timeEnergy_accumulate = self.timeEnergy_accumulate + dt 

        if self.process_energyAbsorb == false then  
            self.process_energyAbsorb = true  
            -- add anime
            self.animeEnergyAbsorb = Animation({
                texture = self.animationDef.texture,
                frames = self.animationDef.frames,
                interval = self.animationDef.interval,
                ratio = self.animationDef.ratio,
                special_frames = self.animationDef.special_frames or nil,
                special_interval = self.animationDef.special_interval or nil,
                offsetX = self.animationDef.offsetX,
                offsetY = self.animationDef.offsetY        
            })            
        end
        
        if self.time_accumulate >= self.time_releaseEnergy then 
            -- self:insertHitbox()
        end

        self.animeEnergyAbsorb:update(dt)

    elseif not love.keyboard.isDown('c') then 
        self.process_energyAbsorb = false 
        self.time_accumulate = 0 
        self.animeEnergyAbsorb = nil
        self.hitbox1 = nil
    end

    Entity.update(self, dt)

    for i = #self.hitboxes, 1, -1 do 
        local hitbox = self.hitboxes[i]
        hitbox:update(dt)

        -- hitbox disappear when reach time out
        if hitbox:isFinished() then 
            table.remove(self.hitboxes, i)
        end
    end

    for i = #self.effectsAfterPlayer, 1, -1 do
        local effect = self.effectsAfterPlayer[i]
        if effect then
            effect:update(dt)
            if effect:isFinished() then
                table.remove(self.effectsAfterPlayer, i)
            end
        else
            table.remove(self.effectsAfterPlayer, i)  -- optional: clean nils
        end
    end
end

function Player:render()
    Entity.render(self)
    -- for _, hitbox in ipairs(self.hitboxes) do 
    --     hitbox:render()
    -- end

    for i, effect in ipairs(self.effectsAfterPlayer) do
        effect:render()
    end

    -- effect render test
    if self.animeEnergyAbsorb then
        love.graphics.draw(gTextures[self.animeEnergyAbsorb.texture], gFrames[self.animeEnergyAbsorb.texture][self.animeEnergyAbsorb:getCurrentFrame()],
            math.floor(self.x - self.animeEnergyAbsorb.offsetX), math.floor(self.y - self.animeEnergyAbsorb.offsetY), 0 , self.animeEnergyAbsorb.ratio, self.animeEnergyAbsorb.ratio)
    end
end
