PlayerWalkState = Class{__includes = EntityWalkState}

function PlayerWalkState:init(player)
    self.entity = player
    self.entity.offsetX = 10 -- windowsize offsetX = 50 -> virtual offsetX 50 / 5 = 10
    self.entity:changeAnimation('walk')

    -- attribute to delay flagDashJump
    self.timeDashJump_accumulate = 0
    self.delay_dashJump = nil
end

function PlayerWalkState:enter(params)
    -- delay flag_dashJump
    if params then 
        if params.delay_dashJump then 
            self.delay_dashJump = params.delay_dashJump
        end
    end
end

function PlayerWalkState:update(dt) 
    -- delay DashJump flag
    if self.delay_dashJump then
        print(self.delay_dashJump)
        if self.entity.flag_dashJump == true then 
            self.timeDashJump_accumulate = self.timeDashJump_accumulate + dt 
            if self.timeDashJump_accumulate >= self.delay_dashJump then 
                self.entity.flag_dashJump = false 
            end
        end
    end


    if love.keyboard.isDown('left') then 
        self.entity.direction = 'left'
        self.entity.x = self.entity.x - self.entity.walkSpeed * dt
    elseif love.keyboard.isDown('right') then 
        self.entity.direction = 'right'
        self.entity.x = self.entity.x + self.entity.walkSpeed * dt
    else
        self.entity:changeState('idle')
        return
    end

    if love.keyboard.wasPressed('x') then
        self.entity:changeState('jump')
        return
    end

    if love.keyboard.wasPressed('z') then
        self.entity:changeState('dash', {delay_animation = 0.07})
        self.entity:changeAnimation('special_idlewalkToDash')
        return
    end

    if love.keyboard.wasPressed('c') then
        self.entity:changeState('normal-slash')
        return
    end

end

