-- I will use assets from https://dreammix.itch.io/keyboard-keys-for-ui, 
--https://opengameart.org/content/bubbles-1
-- I use sounds from https://pixabay.com/sound-effects/keyboard-153960/ and from src7 from GD50
--I use flipps.otf as my main font

require 'src/Dependencies'

function love.load()
    math.randomseed(os.time())
    love.window.setTitle('Legend of Azimuth')
    love.graphics.setDefaultFilter('nearest', 'nearest')

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        fullscreen = false,
        vsync = true,
        resizable = true
    })

    love.graphics.setFont(gFonts['small'])

    gStateMachine = StateMachine {
        ['begin-game'] = function() return BeginGameState() end,
        ['pause'] = function() return PauseState() end,
        ['start'] = function() return StartState() end,
        ['play'] = function() return PlayState() end,
        ['enter-highscores'] = function() return EnterHighScoreState() end,
        ['instructions'] = function() return InstructionState() end,
        ['highscores'] = function() return HighScoreState() end,
        ['settings'] = function() return SettingState() end,
        ['achievements'] = function() return AchievementState() end,
        ['game-over'] = function() return GameOverState() end
    }
    gStateMachine:change('begin-game')

    gSounds['music']:setLooping(true)
    gSounds['music']:play()

    love.keyboard.keysPressed = {}
    love.mouse.keysPressed = {}
    love.mouse.keysReleased = {}
    love.keyboard.TextInput = {}

    paused = false
    MUSIC = true
    Sound_effect = true
end

function love.resize(w, h)
    push:resize(w, h)
end

function love.mousepressed(x, y, key)
    love.mouse.keysPressed[key] = true
end

function love.mousereleased(x, y, key)
    love.mouse.keysReleased[key] = true 
end

function love.keypressed(key, scancode, isrepeat)
    love.keyboard.keysPressed[key] = true
end

function love.textinput(text)
    love.keyboard.TextInput[text] = true
end

function love.keyboard.wasPressed(key, scancode, isrepeat)
    scancode = scancode or false
    isrepeat = isrepeat or false
    return love.keyboard.keysPressed[key]
end

function love.mouse.wasPressed(x,y,key)
    return love.mouse.keysPressed[key]
end

function love.mouse.wasReleased(key)
    return love.mouse.keysReleased[key]
end

function love.keyboard.textInputted(text)
    return love.keyboard.TextInput[text]
end

function love.update(dt)
    if not paused then
        Timer.update(dt)
        Control:update(dt)
        gStateMachine:update(dt)

        love.keyboard.keysPressed = {}
        love.mouse.keysPressed = {}
        love.mouse.keysReleased = {}
        love.keyboard.TextInput = {}
    end
end

function love.draw()
    push:start()
    gStateMachine:render()
    push:finish()
end