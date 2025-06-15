
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

-- game states
require 'src/states/BaseState'
require 'src/states/game/StartState'
require 'src/states/game/PlayState'

-- classes to create objects
require 'src/Entity'
require 'src/Player'
require 'src/Enermy1'


-- entity states
require 'src/states/entity/EntityIdleState'
require 'src/states/entity/EntityWalkState'
require 'src/states/entity/EntityBeHittedState'

require 'src/states/entity/player/PlayerIdleState'
require 'src/states/entity/player/PlayerWalkState'
require 'src/states/entity/player/PlayerJumpState'
require 'src/states/entity/player/PlayerFallState'
require 'src/states/entity/player/PlayerDashState'
require 'src/states/entity/player/PlayerNormalSlashState'

require 'src/states/entity/enermy/Enermy1BeHittedState'


gTextures = {
    ['player-walk'] = love.graphics.newImage('graphics/player_walk.png'),
    ['player-idle'] = love.graphics.newImage('graphics/player_idle.png'),
    ['player-jump-fall'] = love.graphics.newImage('graphics/player_jump_fall.png'),
    ['player-dash'] = love.graphics.newImage('graphics/player_dash.png'),
    ['player-normal-slash'] = love.graphics.newImage('graphics/player_normalSlash.png'),
    ['player-beHitted'] = love.graphics.newImage('graphics/player_beHitted.png')

}

gFrames = {
    ['player-walk'] = GenerateQuads(gTextures['player-walk'], 150, 150),
    ['player-idle'] = GenerateQuads(gTextures['player-idle'], 130, 1000),
    ['player-jump-fall'] = GenerateQuads(gTextures['player-jump-fall'], 130, 215),
    ['player-dash'] = GenerateQuads(gTextures['player-dash'], 150, 150),
    ['player-normal-slash'] = GenerateQuads(gTextures['player-normal-slash'], 280, 220),
    ['player-beHitted'] = GenerateQuads(gTextures['player-beHitted'], 140, 140)
}

gFonts = {
    ['small'] = love.graphics.newFont('fonts/fipps.otf', 8),
    ['medium'] = love.graphics.newFont('fonts/fipps.otf', 16),
    ['large'] = love.graphics.newFont('fonts/fipps.otf', 32),
    ['title'] = love.graphics.newFont('fonts/ArcadeAlternate.ttf', 32)
}