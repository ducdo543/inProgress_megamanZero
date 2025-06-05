
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

-- game states
require 'src/states/BaseState'
require 'src/states/game/StartState'
require 'src/states/game/PlayState'

-- classes to create objects
require 'src/Entity'
require 'src/Player'


-- entity states
require 'src/states/entity/EntityIdleState'
require 'src/states/entity/EntityWalkState'
require 'src/states/entity/player/PlayerIdleState'
require 'src/states/entity/player/PlayerWalkState'


gTextures = {
    ['player-walk'] = love.graphics.newImage('graphics/player_walk.png')
}

gFrames = {
    ['player-walk'] = GenerateQuads(gTextures['player-walk'], 130, 150)
}

gFonts = {
    ['small'] = love.graphics.newFont('fonts/fipps.otf', 8),
    ['medium'] = love.graphics.newFont('fonts/fipps.otf', 16),
    ['large'] = love.graphics.newFont('fonts/fipps.otf', 32),
    ['title'] = love.graphics.newFont('fonts/ArcadeAlternate.ttf', 32)
}