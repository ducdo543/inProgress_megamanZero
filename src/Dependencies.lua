
-- libraries
--
Class = require 'lib/class'
push = require 'lib/push'
Timer = require 'lib/knife.timer'



-- in the code

-- utility
require 'src/constants'
require 'src/StateMachine'
require 'src/entity_defs'
require 'src/Animation'
require 'src/Util'
require 'src/PartCircleHitbox'
require 'src/BaseHitbox'
require 'src/RectangleHitbox'

-- game states
require 'src/states/BaseState'
require 'src/states/game/StartState'
require 'src/states/game/PlayState'

-- classes to create objects
require 'src/Entity'
require 'src/Player'
require 'src/Enermy1'
require 'src/Effect'
require 'src/Debri'


-- entity states
require 'src/states/entity/EntityIdleState'
require 'src/states/entity/EntityWalkState'
require 'src/states/entity/EntityBeHittedState'
require 'src/states/entity/EntityBePushedState'

require 'src/states/entity/player/PlayerIdleState'
require 'src/states/entity/player/PlayerWalkState'
require 'src/states/entity/player/PlayerJumpState'
require 'src/states/entity/player/PlayerFallState'
require 'src/states/entity/player/PlayerDashState'
require 'src/states/entity/player/PlayerNormalSlashState'
require 'src/states/entity/player/PlayerStingState'
require 'src/states/entity/player/PlayerDashSlashState'
require 'src/states/entity/player/PlayerLoad1SlashState'
require 'src/states/entity/player/PlayerBaseJumpState'
require 'src/states/entity/player/PlayerLoad2SlashState'

require 'src/states/entity/enermy/Enermy1BeHittedState'
require 'src/states/entity/enermy/Enermy2Death1State'


gTextures = {
    ['player-walk'] = love.graphics.newImage('graphics/player_walk.png'),
    ['player-idle'] = love.graphics.newImage('graphics/player_idle.png'),
    ['player-jump-fall'] = love.graphics.newImage('graphics/player_jump_fall.png'),
    ['player-dash'] = love.graphics.newImage('graphics/player_dash.png'),
    ['player-sting'] = love.graphics.newImage('graphics/player_sting.png'),
    ['player-dash-slash'] = love.graphics.newImage('graphics/player_dashSlash.png'),
    ['player-air-slash'] = love.graphics.newImage('graphics/player_airSlash.png'),
    ['player-normal-slash'] = love.graphics.newImage('graphics/player_normalSlash.png'),
    ['player-load1-slash'] = love.graphics.newImage('graphics/player_load1Slash.png'),
    ['player-beHitted'] = love.graphics.newImage('graphics/player_beHitted.png'),

    ['enermy2-idle-beHitted'] = love.graphics.newImage('graphics/enermy2_idleHitted.png'),
    ['enermy2-death1'] = love.graphics.newImage('graphics/enermy2_death1.png'),
    ['effect-explode'] = love.graphics.newImage('graphics/effect_explode.png'),
    ['effect-smoke'] = love.graphics.newImage('graphics/effect_smoke.png'),
    ['effect-energyAbsorb'] = love.graphics.newImage('graphics/effect_energyAbsorb.png')


}

gFrames = {
    ['player-walk'] = GenerateQuads(gTextures['player-walk'], 150, 150),
    ['player-idle'] = GenerateQuads(gTextures['player-idle'], 130, 1000),
    ['player-jump-fall'] = GenerateQuads(gTextures['player-jump-fall'], 130, 215),
    ['player-dash'] = GenerateQuads(gTextures['player-dash'], 150, 150),
    ['player-sting'] = GenerateQuads(gTextures['player-sting'], 270, 170),
    ['player-dash-slash'] = GenerateQuads(gTextures['player-dash-slash'], 300, 200),
    ['player-air-slash'] = GenerateQuads(gTextures['player-air-slash'], 250, 200),
    ['player-normal-slash'] = GenerateQuads(gTextures['player-normal-slash'], 280, 220),
    ['player-beHitted'] = GenerateQuads(gTextures['player-beHitted'], 140, 140),
    ['player-load1-slash'] = GenerateQuads(gTextures['player-load1-slash'], 350, 300),

    ['enermy2-idle-beHitted'] = GenerateQuads(gTextures['enermy2-idle-beHitted'], 130, 150),
    ['enermy2-death1'] = GenerateQuads(gTextures['enermy2-death1'], 200, 150),
    ['effect-explode'] = GenerateQuads(gTextures['effect-explode'], 200, 150),
    ['effect-smoke'] = GenerateQuads(gTextures['effect-smoke'], 50, 100),
    ['effect-energyAbsorb'] = GenerateQuads(gTextures['effect-energyAbsorb'], 200, 250)
}

gFonts = {
    ['small'] = love.graphics.newFont('fonts/fipps.otf', 8),
    ['medium'] = love.graphics.newFont('fonts/fipps.otf', 16),
    ['large'] = love.graphics.newFont('fonts/fipps.otf', 32),
    ['title'] = love.graphics.newFont('fonts/ArcadeAlternate.ttf', 32)
}