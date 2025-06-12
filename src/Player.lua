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
end

function Player:update(dt)
    Entity.update(self, dt)

    for i = #self.hitboxes, 1, -1 do 
        local hitbox = self.hitboxes[i]
        hitbox:update(dt)

        if hitbox:delete(dt) then 
            table.remove(self.hitboxes, i)
        end
    end
end

function Player:render()
    Entity.render(self)
    for _, hitbox in ipairs(self.hitboxes) do 
        hitbox:render()
    end
end
