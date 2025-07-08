PlayerIdleState = Class{__includes = EntityIdleState}

function PlayerIdleState:init(player)
    EntityIdleState.init(self, player)
    self.entity.offsetX = 4 -- 20/5
    self.entity.offsetY = 0

    -- attribute to delay Animation
    self.timeAnime_accumulate = 0
    self.flag_delayAnime = false
    self.delay_animation = nil

    -- attribute to delay flagDashJump
    self.timeDashJump_accumulate = 0
    self.delay_dashJump = nil

end

function PlayerIdleState:enter(params)
    if params then
        if params.delay_animation then
            self.delay_animation = params.delay_animation
            self.flag_delayAnime = true
        end
    end 

    if self.flag_delayAnime == false then
        self.entity:changeAnimation("idle")
    end

    -- delay flag_dashJump
    if params then 
        if params.delay_dashJump then 
            self.delay_dashJump = params.delay_dashJump
        end
    end

end
function PlayerIdleState:update(dt)
    -- delay anime
    if self.flag_delayAnime == true then
        self.timeAnime_accumulate = self.timeAnime_accumulate + dt
        if self.timeAnime_accumulate >= self.delay_animation then 
            self.entity:changeAnimation("idle")
            self.flag_delayAnime = false
        end
    end

    -- delay DashJump flag
    if self.delay_dashJump then
        if self.entity.flag_dashJump == true then 
            self.timeDashJump_accumulate = self.timeDashJump_accumulate + dt 
            if self.timeDashJump_accumulate >= self.delay_dashJump then 
                self.entity.flag_dashJump = false 
            end
        end
    end

    if love.keyboard.isDown('left') or love.keyboard.isDown('right') then
        self.entity:changeState('walk')
        -- self.entity:changeAnimation('walk-right') --maybe first frame of PlayerWalkState hasn't receive button so we must changeAnimation right here when we don't have any
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

    -- change to another normalSlash state after accumulate energy 
    if not love.keyboard.isDown('c') then 
        if self.entity.can_releaseEnergy == true then 
            self.entity:changeState('load1-slash')
            return
        end
    end
    -- check if collide
    -- ...
end
