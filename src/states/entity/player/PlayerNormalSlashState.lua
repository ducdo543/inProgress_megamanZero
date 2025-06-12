PlayerNormalSlashState = Class{__includes = BaseState}

function PlayerNormalSlashState:init(player)
    self.entity = player 
    -- reset flag_dashJump
    self.entity.flag_dashJump = false

    -- flag for three normal slash state
    self.flag_normalSlash1 = true 
    self.flag_normalSlash2 = false 
    self.flag_normalSlash3 = false

    self.time_accumulate = 0
end

function PlayerNormalSlashState:update(dt)
    self.time_accumulate = self.time_accumulate + dt 

    if self.flag_normalSlash1 == true then 
        table.insert(self.entity.hitboxes, PartCircleHitbox({
            cx = self.entity.x + self.entity.width,
            cy = self.entity.y + self.entity.height,
            radius = self.entity.height + 2,
            start_angle = -120,
            cover_angle = 90,
            dx = 0,
            dy = 0,
            movement = false,
            time_disappear = 0.4
        }))

        self.flag_normalSlash1 = false
    end
        



    if love.keyboard.wasPressed('x') then
        self.entity:changeState('jump')
    end

    if love.keyboard.wasPressed('z') then
        self.entity:changeState('dash')
    end
end

function PlayerNormalSlashState:render()
    love.graphics.setColor(1, 0, 0)
    love.graphics.rectangle("fill", self.entity.x, self.entity.y, self.entity.width, self.entity.height)
    love.graphics.setColor(1, 1, 1)
end