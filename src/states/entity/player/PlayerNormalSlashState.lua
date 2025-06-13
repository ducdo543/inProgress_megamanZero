PlayerNormalSlashState = Class{__includes = BaseState}

function PlayerNormalSlashState:init(player)
    self.entity = player 

    self.entity.offsetX = 14 -- 70/5
    self.entity.offsetY = 14 -- 70/5

    -- reset flag_dashJump
    self.entity.flag_dashJump = false

    -- flag for three normal slash state
    self.flag_normalSlash = {
        [1] = true,
        [2] = false,
        [3] = false
    }
    self.counter_normalSlash = 1
    self.flag_continueSlash = false

    self.entity:changeAnimation('normal-slash1')

    self.time_accumulate = 0
end

function PlayerNormalSlashState:update(dt)
    self.time_accumulate = self.time_accumulate + dt 

    if self.flag_normalSlash[1] == true then 
        self.entity:changeAnimation('normal-slash1')
        table.insert(self.entity.hitboxes, PartCircleHitbox({
            cx = self.entity.direction == 'right' and (self.entity.x + self.entity.width) or self.entity.x,
            cy = self.entity.y + self.entity.height,
            radius = self.entity.height + 2,
            start_angle = self.entity.direction == 'right' and (-120) or (-150),
            cover_angle = 90,
            dx = 0,
            dy = 0,
            movement = false,
            time_disappear = 0.15
        }))

        self.flag_normalSlash[1] = false
    end

    if self.flag_normalSlash[2] == true then 
        self.entity:changeAnimation('normal-slash2')
        table.insert(self.entity.hitboxes, PartCircleHitbox({
            cx = self.entity.direction == 'right' and (self.entity.x + self.entity.width + 2) or (self.entity.x - 2),
            cy = self.entity.y + self.entity.height + 2,
            radius = self.entity.height + 7,
            start_angle = self.entity.direction == 'right' and (-130) or (-140),
            cover_angle = 90,
            dx = 0,
            dy = 0,
            movement = false,
            time_disappear = 0.3
        }))
        -- add arc
        table.insert(self.entity.hitboxes, PartCircleHitbox({
            cx = self.entity.direction == 'right' and (self.entity.x + self.entity.width + 2) or (self.entity.x - 2),
            cy = self.entity.y + self.entity.height + 2,
            radius = self.entity.height + 2,
            start_angle = self.entity.direction == 'right' and (-40) or (-165),
            cover_angle = 25,
            dx = 0,
            dy = 0,
            movement = false,
            time_disappear = 0.3
        }))

        self.flag_normalSlash[2] = false
    end        

    if self.flag_normalSlash[3] == true then 
        self.entity:changeAnimation('normal-slash3')
        table.insert(self.entity.hitboxes, PartCircleHitbox({
            cx = self.entity.direction == 'right' and (self.entity.x + self.entity.width) or self.entity.x,
            cy = self.entity.y + self.entity.height,
            radius = self.entity.height + 7,
            start_angle = self.entity.direction == 'right' and (-165) or (-180),
            cover_angle = 165,
            dx = 0,
            dy = 0,
            movement = false,
            time_disappear = 0.3
        }))

        self.flag_normalSlash[3] = false
    end
    
    if love.keyboard.wasPressed('c') then 
        self.flag_continueSlash = true
    end

    -- convert to the next normal slash
    if self.flag_continueSlash == true and self.counter_normalSlash < 3 then 
        if self.time_accumulate >= 0.3 then 
            self.counter_normalSlash = self.counter_normalSlash + 1
            self.flag_normalSlash[self.counter_normalSlash] = true
            self.time_accumulate = 0
            self.flag_continueSlash = false
        end
    end

    -- end the slash state if we don't press 'c' before time out
    if self.time_accumulate >= 0.3 then 
        self.entity:changeState('idle')
    end

    if love.keyboard.wasPressed('x') then
        self.entity:changeState('jump')
    end

    if love.keyboard.wasPressed('z') then
        self.entity:changeState('dash')
    end
end

function PlayerNormalSlashState:render()
    local anim = self.entity.currentAnimation
    love.graphics.draw(gTextures[anim.texture], gFrames[anim.texture][anim:getCurrentFrame()],
        math.floor(self.entity.direction == 'left' and self.entity.x + self.entity.offsetX + self.entity.width  or self.entity.x - self.entity.offsetX), math.floor(self.entity.y - self.entity.offsetY), 0 , self.entity.direction == "left" and -anim.ratio or anim.ratio, anim.ratio)

    -- love.graphics.setColor(1, 0, 0)
    -- love.graphics.rectangle("fill", self.entity.x, self.entity.y, self.entity.width, self.entity.height)
    -- love.graphics.setColor(1, 1, 1)
end