
-- libraries
--
Class = require 'lib/class'
push = require 'lib/push'
Timer = require 'lib/knife.timer'



-- in the code

-- utility
require 'src/constants'
require 'src/StateMachine'

-- game states
require 'src/states/BaseState'
require 'src/states/game/StartState'
require 'src/states/game/PlayState'

-- classes to create objects
require 'src/Entity'
require 'src/Player'


-- entity states
require 'src/states/entity/EntityIdleState'
require 'src/states/entity/player/PlayerIdleState'





gFonts = {
    ['small'] = love.graphics.newFont('fonts/fipps.otf', 8),
    ['medium'] = love.graphics.newFont('fonts/fipps.otf', 16),
    ['large'] = love.graphics.newFont('fonts/fipps.otf', 32),
    ['title'] = love.graphics.newFont('fonts/ArcadeAlternate.ttf', 32)
}