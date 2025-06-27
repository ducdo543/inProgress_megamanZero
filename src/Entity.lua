Entity = Class{}

function Entity:init(def)
    -- offset to center the real_entity in the sprite_entity
    self.offsetX = def.offsetX or 0
    self.offsetY = def.offsetY or 0
    
    self.x = def.x
    self.y = def.y

    self.dx = 0
    self.dy = 0

    self.width = def.width
    self.height = def.height

    self.stateMachine = def.stateMachine

    self.direction = "right"

    self.animations = def.animations
    self.animations_motion = self:createAnimations(self.animations)
end

function Entity:createAnimations(animations)
    local animationsReturned = {}

    for k, animationDef in pairs(animations) do
        animationsReturned[k] = Animation {
            texture = animationDef.texture,
            frames = animationDef.frames,
            interval = animationDef.interval,
            ratio = animationDef.ratio,
            looping = animationDef.looping,
            special_frames = animationDef.special_frames or nil,
            special_interval = animationDef.special_interval or nil,
            offsetX = animationDef.offsetX,
            offsetY = animationDef.offsetY
        }
    end

    return animationsReturned
end

function Entity:changeState(state, params)
    self.stateMachine:change(state, params)
end

function Entity:changeAnimation(name)
    self.animations_motion = self:createAnimations(self.animations) -- recreate Animation() for animations to turn back frame 1 first
    self.currentAnimation = self.animations_motion[name]
end

function Entity:update(dt)
    self.stateMachine:update(dt)
    if self.currentAnimation then
        self.currentAnimation:update(dt)
    end
end

function Entity:collides(entity)
    return not (self.x > entity.x + entity.width or entity.x > self.x + self.width or
                self.y > entity.y + entity.height or entity.y > self.y + self.height)
end

function Entity:render()
    self.stateMachine:render()

    -- for checking positions
    -- love.graphics.setColor(1, 0, 0)
    -- love.graphics.rectangle("fill", self.x, self.y, self.width, self.height)
    -- love.graphics.setColor(1, 1, 1)
end