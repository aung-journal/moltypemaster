Atom = Class{}

function Atom:init(world, sprite, atom, color, x, y, userData)
    self.world = world
    self.type = type

    self.body = love.physics.newBody(self.world, 
    x or math.random(VIRTUAL_WIDTH), y or math.random(VIRTUAL_HEIGHT - 35),
    'dynamic')

    self.shape = love.physics.newCircleShape(32)
    self.sprite = sprite

    self.atom = atom

    self.color = color

    self.fixture = love.physics.newFixture(self.body, self.shape)
    self.userData = userData or 'start'

    self.fixture:setUserData(userData)

    -- used to keep track of despawning the Alien and flinging it
    self.launched = false
end

function Atom:render()
    love.graphics.draw(gTextures['bubbles'], gFrames['bubbles'][self.sprite],
    math.floor(self.body:getX()), math.floor(self.body:getY()), self.body:getAngle(),
    1, 1, 32, 32)

    love.graphics.setFont(gFonts['small'])

    local text = self.atom
    local x = math.floor(self.body:getX())
    local y = math.floor(self.body:getY())
    local font = love.graphics.getFont()
    local width = font:getWidth(text)
    local height = font:getHeight()
    love.graphics.setColor(unpack(gBubbleColors[self.color]))
    love.graphics.printf(text, x - width / 2, y - height / 2, width, "center")
end