Enermy2Death1State = Class{__includes = BaseState}

function Enermy2Death1State:init(entity, gravity)
    self.entity = entity
    self.gravity = gravity

    self.time_accumulate = 0

    self.entity.flag_deathState = true   

    -- debrises of enermy 

    self.debri1 = Debri({
        x = self.entity.x + 3, y = self.entity.y + 6, 
        width = self.entity.width, height = self.entity.height - 6, 
        angle = 0, w = - math.rad(270), frame = 2,
        gravity = self.gravity,
        anim = ENTITY_DEFS['enermy2'].animations['death1']
    })
    self.debri2 = Debri({
        x = self.entity.x, y = self.entity.y,
        width = self.entity.width, height = self.entity.height * 1/2,
        dx = -40, dy = -20, frame = 3,  
        gravity = self.gravity,
        anim = ENTITY_DEFS['enermy2'].animations['death1']
    })
    self.debri3 = nil 
    self.debri4 = nil
    self.smoke1 = nil 
    self.smoke2 = nil

    -- explode 
    self.explode1 = Effect({
        x = self.entity.x + self.entity.width * 1/2, 
        y = self.entity.y,
        animationDef = ENTITY_DEFS['effects'].animations['explode']
    })

end

function Enermy2Death1State:enter(params)
    self.player = params.player
    table.insert(self.player.effectsAfterPlayer, self.explode1)

end

function Enermy2Death1State:update(dt)

    -- debri1
    if self.debri1 then
        self.debri1:update(dt)
        if math.abs(self.debri1.angle) >= math.rad(90) then 
            self.explode2 = Effect({
                x = self.debri1.x - self.debri1.width * 2/3,
                y = self.debri1.y + self.debri1.height * 1/3,
                animationDef = ENTITY_DEFS['effects'].animations['explode']
            })
            table.insert(self.player.effectsAfterPlayer, self.explode2)
            self.debri1 = nil 
        end
    end

    -- debri2
    if self.debri2 then 
        if self.insert_debri2 == nil then
            table.insert(self.player.effectsAfterPlayer, self.debri2)
            -- self.debri2:update(dt) -- update debri2 in Class Player
            self.insert_debri2 = true
        end
        if self.debri2.y >= 106 + self.debri2.height then  
            self.debri2.flag_finished = true 
            self.debri2.y = 106 + self.debri2.height - 1

            self.debri3 = Debri({
                x = self.debri2.x, y = self.debri2.y,
                width = 6, height = 6, 
                dx = -30, dy = -140, frame = 4,
                gravity = self.gravity,
                anim = ENTITY_DEFS['enermy2'].animations['death1']
            })
            self.debri4 = Debri({
                x = self.debri2.x + 10, y = self.debri2.y + 6, 
                width = 6, height = 6, 
                dx = -30, dy = -120, frame = 5,
                gravity = self.gravity,
                anim = ENTITY_DEFS['enermy2'].animations['death1']
            })
            self.debri2 = nil
            
        end
    end

    -- debri3
    if self.debri3 then 
        if self.insert_debri3 == nil then
            table.insert(self.player.effectsAfterPlayer, self.debri3)
            self.insert_debri3 = true
        end

        if self.debri3.y >= 125 - 6 then
            self.debri3.flag_finished = true 
            self.debri3.y = 125 - 6

            self.smoke1 = Effect({
                x = self.debri3.x + self.debri3.width / 2,
                y = self.debri3.y + self.debri3.height / 2,
                animationDef = ENTITY_DEFS['effects'].animations['smoke']
            })
            table.insert(self.player.effectsAfterPlayer, self.smoke1)
            self.debri3 = nil
        end
    end

    -- debri4
    if self.debri4 then 
        if self.insert_debri4 == nil then
            table.insert(self.player.effectsAfterPlayer, self.debri4)
            self.insert_debri4 = true
        end

        if self.debri4.y >= 125 - 6 and self.debri4.dy > 0 then
            self.debri4.flag_finished = true 
            self.debri4.y = 125 - 6

            self.smoke2 = Effect({
                x = self.debri4.x + self.debri4.width / 2,
                y = self.debri4.y + self.debri4.height / 2,
                animationDef = ENTITY_DEFS['effects'].animations['smoke']
            })
            table.insert(self.player.effectsAfterPlayer, self.smoke2)
            self.debri4 = nil
        end
        
    end    

    -- to delete enermy from table entities when it done
    if self.smoke1 and self.smoke2 then
        self.entity.dead = true
    end

end

function Enermy2Death1State:render()

    -- debri1
    if self.debri1 then
        self.debri1:render()
        -- love.graphics.setColor(1, 0, 0)
        -- love.graphics.rectangle("fill", self.debri1.x, self.debri1.y, self.entity.width, self.entity.height)
        -- love.graphics.setColor(1, 1, 1)
    end
    -- debri2
    -- if self.debri2 then
    --     self.debri2:render()
    --     -- love.graphics.setColor(1, 0, 0)
    --     -- love.graphics.rectangle("fill", self.debri2.x, self.debri2.y, self.debri2.width, self.debri2.height)
    --     -- love.graphics.setColor(1, 1, 1)    
    -- end
    -- debri3
    -- if self.debri3 then 
    --     self.debri3:render()
    --     -- love.graphics.setColor(1, 0, 0)
    --     -- love.graphics.rectangle("fill", self.debri3.x, self.debri3.y, self.debri3.width, self.debri3.height)
    --     -- love.graphics.setColor(1, 1, 1)   
    -- end
    -- debri4
    -- if self.debri4 then 
    --     self.debri4:render()
    --     -- love.graphics.setColor(1, 0, 0)
    --     -- love.graphics.rectangle("fill", self.debri4.x, self.debri4.y, self.debri4.width, self.debri4.height)
    --     -- love.graphics.setColor(1, 1, 1)   
    -- end

end

function Enermy2Death1State:exit()
    if self.debri4 ~= nil then 
        self.debri4.flag_finished = true 
    end
    if self.debri3 ~= nil then 
        self.debri3.flag_finished = true 
    end 
    if self.debri2 ~= nil then 
        self.debri2.flag_finished = true 
    end
end