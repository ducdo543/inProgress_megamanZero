Enermy1 = Class{__includes = Entity}

function Enermy1:init(def)
    Entity.init(self, def)

    self.walkSpeed = def.walkSpeed 
    self.can_bePushed = true

end

function Enermy1:update(dt)
    Entity.update(self, dt)
end

function Enermy1:render()
    Entity.render(self)
end