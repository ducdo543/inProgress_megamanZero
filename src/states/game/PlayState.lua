PlayState = Class{__includes = BaseState}

function PlayState:init()
    self.entities = {} -- to include enermies

    self.gravityAmount = GRAVITY
    self.player = Player({
        animations = ENTITY_DEFS['player'].animations,
        x = 120, y = 100,
        width = 10, height = 25, -- windowsize of player: width = 50, height = 125. We need to /5 to calculate virtual size
        stateMachine = StateMachine {
            ['idle'] = function() return PlayerIdleState(self.player) end,
            ['walk'] = function() return PlayerWalkState(self.player) end,
            ['dash'] = function() return PlayerDashState(self.player) end,
            ['normal-slash'] = function() return PlayerNormalSlashState(self.player) end,
            ['jump'] = function() return PlayerJumpState(self.player, self.gravityAmount) end,
            ['fall'] = function() return PlayerFallState(self.player, self.gravityAmount) end
        },
        jump_velocity = ENTITY_DEFS['player'].jump_velocity,
        walkSpeed = ENTITY_DEFS['player'].walkSpeed,
        dashSpeed = ENTITY_DEFS['player'].dashSpeed
    })

    self.player:changeState('idle')

    self:generateEntities()
end

function PlayState:generateEntities()
    local type1 = {time_accumulate = 0, time_create = 10, enemies = { --enemies means number of enemy
        Enermy1({
            animations = ENTITY_DEFS['player'].animations,
            x = 200, y = 100,
            width = 10, height = 25,
            stateMachine = StateMachine {
            ['idle'] = function() return EntityIdleState(self.entities.type1.enemies[1]) end,
            ['walk'] = function() return EntityWalkState(self.entities.type1.enemies[1]) end
            },
            walkSpeed = ENTITY_DEFS['player'].walkSpeed
        })
    }}
    self.entities.type1 = type1
    -- entities structure: self.entities = {type1 = {...}, type2 = {...}}

    for type, enermyData in pairs(self.entities) do 
        for __, enermy in ipairs(enermyData.enemies) do
            enermy:changeState('idle')
        end
    end
end

function PlayState:update(dt)
    self.player:update(dt)

    -- update entities.enemies
    for type, enermyData in pairs(self.entities) do 
        for __, enermy in ipairs(enermyData.enemies) do
            enermy:update(dt)
        end
    end
    
    -- check if hitbox collide with entities.enermies
    for k, hitbox in ipairs(self.player.hitboxes) do 
        for type, enermyData in pairs(self.entities) do 
            for i, enermy in ipairs(enermyData.enemies) do
                if hitbox:collide_rectangle(enermy) then
                    -- table.remove(enermyData.enemies, i)
                    enermy:changeState('walk')
                end
            end
        end
    end
                
end

function PlayState:render()
    self.player:render()

    for type, enermyData in pairs(self.entities) do 
        for __, enermy in ipairs(enermyData.enemies) do
            enermy:render()
        end
    end
end