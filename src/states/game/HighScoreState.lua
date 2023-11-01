HighScoreState = Class{__includes = BaseState}

--it will input the text that you inputted
function HighScoreState:enter(params)
    self.highscore = params.highscore
end

function HighScoreState:update(dt)
    -- return to the start screen if we press escape
    if love.keyboard.wasPressed('escape') then
        gSounds['selection']:play()
        
        gStateMachine:change('start')
    end
end

function HighScoreState:render()
    love.graphics.setFont(gFonts['large'])
    love.graphics.printf('High Scores', 0, 0, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(gFonts['small'])

    -- iterate over all high score indices in our high scores table
    for i = 1, 10 do
        local name = self.highScores[i][2]
        local score = self.highScores[i][1]

        -- score number (1-10)
        love.graphics.printf(tostring(i) .. '.', VIRTUAL_WIDTH / 4, 
            35 + i * 20, 50, 'left')

        -- score name
        love.graphics.printf(name, VIRTUAL_WIDTH / 4 + 38, 
            35 + i * 20, 50, 'right')
        
        -- score itself
        love.graphics.printf(tostring(score), VIRTUAL_WIDTH / 2,
            35 + i * 20, 100, 'right')
    end

    love.graphics.setFont(gFonts['small'])
    love.graphics.printf("Press Escape to return to the main menu!",
        0, VIRTUAL_HEIGHT - 28, VIRTUAL_WIDTH, 'center')
end
function HighScoreState:load()
    local scores

    -- Attempt to open the file for reading
    local file = io.open('files/high_scores.lst', 'r')

    if file then
        -- If the file exists, read the serialized data and deserialize it
        local serializedData = file:read('*a')
        scores = knife.deserialize(serializedData)

        -- Close the file
        file:close()
    else
        -- If the file doesn't exist, initialize default high scores
        scores = {}

        for i = 1, 10 do
            table.insert(scores, {i * 1000, "CTO"})
        end

        -- Serialize and save the default high scores
        local data = knife.serialize(scores)

        -- Open the file for writing
        file = io.open('files/high_scores.lst', 'w')

        if file then
            file:write(data)
            file:close()
        else
            print("Error: Could not open the file for writing.")
        end
    end

    -- At this point, the `scores` table is either loaded from the file or initialized with default data.
end