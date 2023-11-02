Control = Class{}

function Control:init()

end

function Control:update(dt)
    for k, sound in pairs(gSounds) do
        if k ~= 'music' then
            if Sound_effect then
                if gSoundPaused[k] then
                    sound:play()
                end
            else
                if sound:isPlaying() then
                    sound:pause()
                    gSoundPaused[k] = true
                end
            end
        end
    end
    
    if MUSIC then
        gSounds['music']:play()
    else
        gSounds['music']:pause()
    end    

    if gStateMachine:getCurrentStateName() == 'setting' then
        if love.keyboard.wasPressed('u') then
            Sound_effect = Sound_effect == false and true or false
        end
        if love.keyboard.wasPressed('t') then
            MUSIC = MUSIC == false and true or false
        end
    end

    notPause = {'start', 'begin-game', 'play'}

    if love.keyboard.wasPressed('p') then
        local currentState = gStateMachine:getCurrentStateName()
        local isNotPauseState = false
    
        for k, state in pairs(notPause) do
            if currentState == state then
                isNotPauseState = true
                break
            end
        end
    
        if not isNotPauseState then
            gStateMachine:change('pause', {
                state = currentState
            })
        end
    end    
end