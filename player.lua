--[[
	Como iniciar uma classe? / Uso o arquivo classic.lua e dentro do arquivo uso a declaração de classe como o package do java como o mesmo nome do arquivo.
	Como declarar uma classe dentro do arquivo?
	nomeArquivo = Classe:extend()
]]--
player = Classe:extend()

function player:new(x, y)
	--coordenadas
	self.x = x
	self.y = y
	--conteúdo
	self.largura = 8
	self.altura = 8
	--Velocidade
	self.tempoVel = 0
	self.aceleracao = 2
	self.coeficienteAtrito = 0.2
	self.velocidade = 0 -- a Velocidade máxima é 10
	--self.velocidadeY = 120
	--funções de evento
	self.cima = 'w'
	self.baixo = 's'
	self.esquerda = 'a'
	self.direita = 'd'
	--funções de evento Velocidade
	self.cimaVel = 0
	self.baixoVel = 0
	self.esquerdaVel = 0
	self.direitaVel = 0
	self.vidas = 5
end

function player:update(dt)
	--self.x = self.x + self.velocidadeX*dt

	--Não ultrapassagem
	if self.x < 0 then
		self.x = love.graphics.getWidth()-8
	end
	if self.x > love.graphics.getWidth()-8 then
		self.x = 0
	end

	if self.y < 0 then
		self.y = love.graphics.getHeight()-8
	end
	if self.y > love.graphics.getHeight()-8 then
		self.y = 0
	end
	--Fim

    --Graduação da velocidade - Aceleração e Atrito Eixo X && Y
    if love.keyboard.isDown(self.direita) or love.keyboard.isDown(self.esquerda) or love.keyboard.isDown(self.cima) or love.keyboard.isDown(self.baixo) then
    	self.tempoVel = self.tempoVel + dt --cálculo do par ordenado de (t, a)
		self.velocidade = self.tempoVel * self.aceleracao -- cálculo de v em função de t
		--parte superior do gráfico
		if self.velocidade > 9 then
			self.velocidade = 10
		end
	else --Caso nada seja pressionado pelo operador - Aqui deve ser implementado o atrito
		if self.velocidade > 0 then
			self.tempoVel = self.tempoVel - dt --cálculo do par ordenado de (t, a)
			self.velocidade = self.tempoVel * self.aceleracao -- cálculo de v em função de t
		--elseif - aqui deve ficar a parte da desaceleração do player caso ele aperte a tecla para voltar
		end
		--parte inferior do gráfico
		if self.velocidade < 0 then
			self.velocidade = 0
			self.tempoVel = 0
			self.direitaVel = 0
			self.esquerdaVel = 0
			self.cimaVel = 0
			self.baixoVel = 0
		end
		if self.velocidade > 9 then
			self.velocidade = 10
		end
		if self.velocidade > 5 then
			self.tempoVel = 2
		end
    end
    --Fim

    --Pressionamento de teclas da direita e da esquerda
    if love.keyboard.isDown(self.direita) then
    	self.direitaVel = 1
    	self.esquerdaVel = 0
    	self.x = self.x + self.velocidade -- Pontuação recursiva do movimento
    elseif self.direitaVel == 1 then
    	self.x = self.x + self.velocidade -- Pontuação recursiva do movimento atritado
	end


    if love.keyboard.isDown(self.esquerda) then
    	self.esquerdaVel = 1
    	self.direitaVel = 0
    	self.x = self.x - self.velocidade -- Pontuação recursiva do movimento
    elseif self.esquerdaVel == 1 then
    	self.x = self.x - self.velocidade -- Pontuação recursiva do movimento atritado
    end
    --Fim

    --Pressionamento de teclas para cima e para baixo
    if love.keyboard.isDown(self.cima) then
    	self.cimaVel = 1
    	self.baixoVel = 0
    	self.y = self.y - self.velocidade -- Pontuação recursiva do movimento
    elseif self.cimaVel == 1 then
    	self.y = self.y - self.velocidade -- Pontuação recursiva do movimento atritado - Se esse valor tiver sinal diferente do sinal de cima teremos a simulação do movimento elástico
    end

    if love.keyboard.isDown(self.baixo) then
    	self.baixoVel = 1
    	self.cimaVel = 0
    	self.y = self.y + self.velocidade -- Pontuação recursiva do movimento
    elseif self.baixoVel == 1 then
    	self.y = self.y + self.velocidade -- Pontuação recursiva do movimento atritado
	end
    --Fim
end

function player:draw()
	love.graphics.rectangle("fill", self.x, self.y, self.largura, self.altura)
	--love.graphics.print("tempoVel = "..self.tempoVel.." s", 40, 60)
	--love.graphics.print("velocidade = "..self.velocidade.." p/s", 40, 80)
	--love.graphics.print("velocidadeY = "..self.velocidade.." p/s", 40, 100)
	--love.graphics.print("x = "..self.x.." p", 40, 120)
	--love.graphics.print("y = "..self.y.." p", 40, 140)
end