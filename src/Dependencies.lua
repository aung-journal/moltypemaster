--virtual resolution library
push = require 'lib/push'
Timer = require 'lib/knife.timer'
Event = require 'lib/knife.event'
Serialize = require 'lib/knife.serialize'
Class = require 'lib/class'

--own code
--general
require 'src/Animation'
require 'src/Util'
require 'src/Control'
require 'src/constants'
--classes for things in playState
require 'src/Atom'
require 'src/Background'

--defs
require 'src/defs'

--states
require 'src/StateMachine'
require 'src/states/BaseState'

require 'src/states/game/BeginGameState'
require 'src/states/game/PauseState'
require 'src/states/game/StartState'
require 'src/states/game/PlayState'
require 'src/states/game/EnterHighScoreState'
require 'src/states/game/InstructionState'
require 'src/states/game/HighScoreState'
require 'src/states/game/SettingState'
require 'src/states/game/AchievementState'
require 'src/states/game/GameOverState'

gBubbleIDs = {
    'darkblue',
    'gray',
    'green',
    'neonblue',
    'red',
    'violet',
    'yellow'
}

gBubbleColors = {
    ['darkblue'] = {0, 0, 139/255, 1},   -- darkblue
    ['gray'] = {128/255, 128/255, 128/255, 255/255},   -- gray
    ['green'] = {0, 128/255, 0, 1},   -- green
    ['neonblue'] = {70/255, 102/255, 1, 1},   -- neonblue
    ['red'] = {1, 0, 0, 1},   -- red
    ['violet'] = {238/255, 130/255, 238/255, 1},   -- violet
    ['yellow'] = {1, 1, 0, 1}   -- yellow
}  

gTextures = {
    --utilities
    ['logo'] = love.graphics.newImage('graphics/logo.jpeg'),
    ['background'] = love.graphics.newImage('graphics/output.png'),
    ['start'] = love.graphics.newImage('graphics/start.png'),

    ['bubbles'] = love.graphics.newImage('graphics/bubbles.png')
}

gFrames = {
    ['bubbles'] = GenerateQuads(gTextures['bubbles'], 64, 64)
}

gSounds = {
    ['music'] = love.audio.newSource('sounds/music.mp3', 'stream'),

    ['selection'] = love.audio.newSource('sounds/selection.wav', 'static'),
    ['turn'] = love.audio.newSource('sounds/turn.mp3', 'static'),
    ['typed'] = love.audio.newSource('sounds/typed.mp3', 'static'),
    ['pop'] = love.audio.newSource('sounds/pop.mp3', 'static'),
    ['bounce'] = love.audio.newSource('sounds/bounce.wav', 'static')
}

gSoundPaused = {}

for key,value in pairs(gSounds) do
    gSoundPaused[key] = false
end

gFonts = {
    ['small'] = love.graphics.newFont('fonts/font.otf', 12),
    ['medium'] = love.graphics.newFont('fonts/font.otf', 24),
    ['instructions'] = love.graphics.newFont('fonts/font.otf', 36), 
    ['large'] = love.graphics.newFont('fonts/font.otf', 48),
    ['arial-instructions'] = love.graphics.newFont('fonts/Arial.ttf', 24)
}
