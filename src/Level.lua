Level = Class{}

function Level:init()
    self.world = love.physics.newWorld(0, LEVEL_DEFS['easy'][1])

    --these are the ones that you have typed
    self.destroyedAtoms = {}

    function beginContact(a, b, coll)
        local types = {}
        types[a:getUserData()] = true
        types[b:getUserData()] = true

        if types['Player'] and types['Atom'] then

            --grab the body that belongs to the player
            local playerFixture = a:getUserData() == 'Player' and a or b
            local atomFixture = a:getUserData() == 'Atom' and a or b

            table.insert(self.destroyedAtoms, atomFixture:getBody())
        end

        if types['Ground'] and types['Atom'] then
            gSounds['bounce']:play()
            gSounds['pop']:play()
        end
    end

    -- the remaining three functions here are sample definitions, but we are not
    -- implementing any functionality with them in this demo; use-case specific
    -- http://www.iforce2d.net/b2dtut/collision-anatomy
    function endContact(a, b, coll)
        
    end

    function preSolve(a, b, coll)

    end

    function postSolve(a, b, coll, normalImpulse, tangentImpulse)

    end

    -- register just-defined functions as collision callbacks for world
    self.world:setCallbacks(beginContact, endContact, preSolve, postSolve)

    -- simple edge shape to represent collision for ground
    self.edgeShape = love.physics.newEdgeShape(0, 0, VIRTUAL_WIDTH * 3, 0)

    -- ground data
    self.groundBody = love.physics.newBody(self.world, -VIRTUAL_WIDTH, VIRTUAL_HEIGHT - 35, 'static')
    self.groundFixture = love.physics.newFixture(self.groundBody, self.edgeShape)
    self.groundFixture:setFriction(0.5)
    self.groundFixture:setUserData('Ground')

    -- background graphics
    self.background = Background()
end

function Level:update(dt)
    self.world:update(dt)

    for k, atom in pairs(self.destroyedAtoms) do
        if not atom:isDestroyed() then
            atom:destroy()
        end
    end
end