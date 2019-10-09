function love.load()
	Classe = require("classic")
	require("game")
	require("player")
	require("pupilos")
	require("tuba")
	game = game()
end

function love.update(dt)
	game:update(dt)
end

function love.draw()
	game:draw()
end