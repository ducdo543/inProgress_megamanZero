Enermy1BeHittedState = Class{__includes = EntityBeHittedState}

function Enermy1BeHittedState:init(entity)
    EntityBeHittedState.init(self, entity)

    self.entity.offsetX = 6
    self.entity.offsetY = 1
end