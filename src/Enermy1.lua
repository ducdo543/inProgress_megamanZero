Enermy1 = Class{__includes = Entity}

function Enermy1:init(def)
    Entity.init(self, def)


    self.walkSpeed = def.walkSpeed 
    self.can_bePushed = true

    self.heart = 1

    -- at death state, enermy can not be hitted
    self.flag_deathState = false 
    -- if already dead, remove enermy from table entities
    self.dead = false

end

function Enermy1:update(dt)
    Entity.update(self, dt)
end

function Enermy1:render()
    Entity.render(self)
end