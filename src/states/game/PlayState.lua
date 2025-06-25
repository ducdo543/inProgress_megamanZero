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
            ['sting'] = function() return PlayerStingState(self.player) end,
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
    local enermy1 = nil
    enermy1 = Enermy1({
            animations = ENTITY_DEFS['player'].animations,
            x = 200, y = 100,
            width = 10, height = 25,
            stateMachine = StateMachine {
            ['idle'] = function() return EntityIdleState(enermy1) end,
            ['walk'] = function() return EntityWalkState(enermy1) end,
            ['beHitted'] = function() return Enermy1BeHittedState(enermy1) end,
            ['bePushed'] = function() return EntityBePushedState(enermy1, GRAVITY) end
            },
            walkSpeed = ENTITY_DEFS['player'].walkSpeed
        })

    local enermy2 = nil
    enermy2 = Enermy1({
            animations = ENTITY_DEFS['enermy2'].animations,
            x = 20, y = 100,
            width = 10, height = 25,
            stateMachine = StateMachine {
            ['idle'] = function() return EntityIdleState(enermy2) end,
            
            ['beHitted'] = function() return Enermy1BeHittedState(enermy2) end,
            ['bePushed'] = function() return EntityBePushedState(enermy2, GRAVITY) end,
            ['death1'] = function() return Enermy2Death1State(enermy2, GRAVITY) end
            },
            walkSpeed = ENTITY_DEFS['player'].walkSpeed
        })

    
    table.insert(self.entities, enermy1)
    table.insert(self.entities, enermy2)
    -- entities structure: self.entities = {..., ...}

    -- entities don't use structure: self.entities = {type1 = {...}, type2 = {...}}
    -- specific don't use:           self.entities = {type1 = {time_accumulate = , timer_create = , enemies = {..., ...}, type2 = {...}}

    for __, enermy in ipairs(self.entities) do
        enermy:changeState('idle')
    end

end

function PlayState:update(dt)
    self.player:update(dt)

    -- update enemies and delete if enermy is nil
    for i = #self.entities, 1, -1 do
        local enermy = self.entities[i]
        if enermy then
            enermy:update(dt)
        elseif enermy == false then 
            table.remove(self.entities, i)
            print("remove work")
        end
    end
    
    -- check if hitbox collide with entities.enermies
    for k, hitbox in ipairs(self.player.hitboxes) do 
        for i, enermy in ipairs(self.entities) do
            -- local wasHitted = false
            -- for j, wasHitted_enermy in ipairs(hitbox.wasHitted_entities) do 
            --     if wasHitted_enermy == enermy then 
            --         wasHitted = true 
            --         break 
            --     end
            
            if not hitbox.wasHitted_entities[enermy] and 
                hitbox:collide_rectangle(enermy) and 
                enermy.flag_deathState == false    
            then

                -- one hitbox just can hit each enermy 1 time
                hitbox.wasHitted_entities[enermy] = true 
                
                enermy.heart = enermy.heart - hitbox.damage
                
                -- table.remove(enermyData.enemies, i)
                if enermy.heart <= 0 then
                    enermy:changeState('death1', {player = self.player})
                elseif enermy.heart > 0 then 
                    if hitbox.can_push == true and enermy.can_bePushed == true then
                        enermy:changeState('bePushed', {player = self.player, hurtbox = hitbox})
                    else 
                        enermy:changeState('beHitted')    
                    end
                end

                -- one slash may contain 2 or 3 hitboxes (close to each other), we must find them and also assign those hitboxes.wasHitted to true
                if hitbox.attack_id then
                    for j = k-2, k+2 do 
                        if j > 0 and j <= #self.player.hitboxes then
                            if self.player.hitboxes[j].attack_id == hitbox.attack_id then
                                self.player.hitboxes[j].wasHitted_entities[enermy] = true 
                            end
                        end
                    end
                end
            end
        end
    end
                
end

function PlayState:render()
    for __, enermy in ipairs(self.entities) do
        enermy:render()
    end

    self.player:render()

end