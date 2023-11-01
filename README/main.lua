local typedText = ""
local startTime = 0
local endTime = 0
local wpm = 0

function love.keypressed(key, scancode, isrepeat)
    if not isrepeat then
        if key == "backspace" then
            typedText = typedText:sub(1, -2) -- Remove the last character
        elseif key == "return" then
            -- Calculate WPM when Enter is pressed
            endTime = love.timer.getTime()
            local elapsedTime = endTime - startTime
            local wordsTyped = #typedText:gsub('%S+', '') + 1
            wpm = math.floor((wordsTyped / 5) / elaspedTime)
        end
    end
end
--I can deal this with isrepeat in the love.keyboard.keyspressed[{isrepeat, key}]

function love.textinput(text)
    if text:len() == 1 then
        typedText = typedText .. text
        -- Start the timer if it's the first character typed
        if startTime == 0 then
            startTime = love.timer.getTime()
        end
    end
end

function love.draw()
    love.graphics.print("Typed Text: " .. typedText, 10, 10)
    love.graphics.print("WPM: " .. wpm, 10, 30)
end

