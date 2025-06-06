StartState = Class{__includes = BaseState}

function StartState:init()

end

function StartState:update(dt)
    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') then
        gStateMachine:change('play')
    end
end    

function StartState:render()
    love.graphics.setFont(gFonts['medium'])
    love.graphics.setColor(1, 0, 0)
    love.graphics.printf('Megaman zero 2.0', 0, VIRTUAL_HEIGHT / 2 - 40 + 1, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gFonts['small'])
    love.graphics.setColor(1, 1, 0)
    love.graphics.printf('Press Enter', 0, VIRTUAL_HEIGHT / 2 + 16, VIRTUAL_WIDTH, 'center')

    love.graphics.setColor(1, 1, 1)
end

