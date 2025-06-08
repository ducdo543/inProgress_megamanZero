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
end

function Player:update(dt)
    Entity.update(self, dt)
end

function Player:render()
    Entity.render(self)
    
end
