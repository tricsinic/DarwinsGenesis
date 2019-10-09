--aqui estarão as configurações dos pupilos

pupilos = Classe:extend()

function pupilos:new(x, y)
	self.xA = x --O primeiro apareçerá na posição do jogador. Por isso a classe recebe como parâmetros a posição inicial do jogador
	self.yA = y --Os valores de A são referentes ao player
	self.xB = x --Os valores de B são referentes ao pupilo
	self.yB = y
	self.deltax = math.abs(self.xA - self.xB)
	self.deltay = math.abs(self.yA - self.yB)
	self.timePup = 0
	--Velocidades
	self.velocidade = 0
	self.aceleracao = 2
	self.tempoVel = 0
	self.coefatrito = 0
	--descrição do pupilo
	self.largura = 8
	self.altura = 8
	--Movimento
	self.distancia = 0
	self.distanciaFalta = 0
	self.alvoX = 0
	self.alvoY=0
	self.longe = 0
	self.delay = 1
	--inNatura
	self.tempoGeral = 0

	--distcancias]
	self.distanciaMax = 60
	self.distanciaMin = 50
end

function pupilos:update(dt, x, y) --Talvez seja necessario passar os parametros da posição atualizada do player dentro da update

	--Variavel mestra
	self.tempoGeral = self.tempoGeral + dt
	--fim

	--Distancia entre os pontos
    self.xA = x
	self.yA = y
	self.deltax = math.abs(self.xA - self.xB)
	self.deltay = math.abs(self.yA - self.yB)
    self.distancia = math.floor(math.sqrt(self.deltax * self.deltax + self.deltay * self.deltay))
    --FIM

    --Perseguição do Player pelo Pupilo
    if self.distancia > self.distanciaMax then
    	self.longe = 1
    	self.distanciaFalta = self.distancia - self.distanciaMax
    	self.alvoY = math.floor(self.distanciaFalta*(self.yB - self.yA)/self.distancia)
    	self.alvoX = math.floor(self.distanciaFalta * (self.xB - self.xA)/self.distancia)
    elseif self.distancia < self.distanciaMin then -- Para quando o pupilo estiver muito perto do player e de quebra para quando ele surgir na tela
    	self.longe = 0
    	self.distanciaFalta = self.distanciaMin - self.distancia
    	self.alvoY = math.floor(self.distancia*(self.yB - self.yA)/self.distanciaFalta)
    	self.alvoX = math.floor(self.distancia*(self.xB - self.xA)/self.distanciaFalta)


    	if self.xB - self.xA > 0 then
	    	if self.xB ~= self.alvoX then
	    		self.xB = self.xB + self.velocidade
	    	end
	    end

	    if self.xB - self.xA < 0 then
	    	if self.xB ~= self.alvoX then
	    		self.xB = self.xB - self.velocidade
	    	end
	    end

	    if self.yB - self.yA > 0 then
	    	if self.yB ~= self.alvoY then
	    		self.yB = self.yB + self.velocidade
	    	end
	    end

	    if self.yB - self.yA < 0 then
	    	if self.yB ~= self.alvoY then
	    		self.yB = self.yB - self.velocidade
	    	end
	    end
    end
    if self.longe == 1 then --A ideia de longe e perto é simples. Do jeito que estão agora os sinais de xB o pupilo se aproxima. Basta que eu mude os sinais para poder fazer o pupilo se afastar
	    if self.xB - self.xA > 0 then
	    	if self.xB ~= self.alvoX then
	    		self.xB = self.xB - self.velocidade
	    	end
	    end

	    if self.xB - self.xA < 0 then
	    	if self.xB ~= self.alvoX then
	    		self.xB = self.xB + self.velocidade
	    	end
	    end

	    if self.yB - self.yA > 0 then
	    	if self.yB ~= self.alvoY then
	    		self.yB = self.yB - self.velocidade
	    	end
	    end

	    if self.yB - self.yA < 0 then
	    	if self.yB ~= self.alvoY then
	    		self.yB = self.yB + self.velocidade
	    	end
	    end
	end
    --Fim
   	if self.tempoGeral >= self.delay then --O pupilo só seguirá o mestre depois do delay

	    --Implementação da Velocidade
	    if self.distancia > self.distanciaMax or self.distancia < self.distanciaMin then
	    	self.tempoVel = self.tempoVel + dt
	    	--delay
		    	self.velocidade = self.tempoVel * self.aceleracao
		    	if self.velocidade > 4 then
					self.velocidade = 4
					self.tempoVel = 2
				end
		else --Caso a distancia seja menor do que self.distanciaMax  pelo operador - Aqui deve ser implementado o atrito -- ele deve frear em 10 pixels que é a diferença entre self.distanciaMax e self.distanciaMin
			if self.velocidade > 0 then
				self.tempoVel = 1
				self.tempoVel = self.tempoVel - dt --cálculo do par ordenado de (t, a)
				self.velocidade = self.tempoVel * self.aceleracao -- cálculo de v em função de t
			--elseif - aqui deve ficar a parte da desaceleração do player caso ele aperte a tecla para voltar 
			end
			if self.velocidade > 4 then
				self.velocidade = 4
			end
	    end

	    if self.velocidade <= 0 then
	    	self.tempoGeral = 0
	    end

	end
    --Fim
end

function pupilos:draw()
	love.graphics.rectangle("fill", self.xB, self.yB, self.largura, self.altura)
	--love.graphics.print("distancia entre player = ("..math.floor(self.xA)..","..math.floor(self.yA)..")  e pupilo = ("..self.xB..","..self.yB..")          é = "..self.distancia.." p", 40, self.distanciaMax)
	--love.graphics.print("valor da distancia que falta até o meu alvo = "..self.distanciaFalta.."p", 40, 80)
	--love.graphics.print("valor que devo percorrer em x (alvoX) = "..math.floor(self.alvoX).."p", 40, 100)
	--love.graphics.print("valor que devo percorrer em y (alvoY) = "..math.floor(self.alvoY).."p", 40, 120)
	--love.graphics.print("tempoVel = "..math.floor(self.tempoVel).." s", 40, 140)
	--love.graphics.print("tempoGeral = "..math.floor(self.tempoGeral).." s", 40, 160)
	--love.graphics.print("velocidade = "..math.floor(self.velocidade).." p/s", 40, 180)
	--love.graphics.print("diferença X = "..math.floor(self.xB - self.xA).." p", 40, 200)
	--love.graphics.print("diferença Y = "..math.floor(self.yB - self.yA).." p", 40, 220)
end

--[[
	O meu pupilo precisa estar a uma distância bem definida do personagem, ele deve ter os mesmos conceitos de movimento que o personagem e, se estiver próximo demais deve se afastar, se estiver muito longe deve se aproximar. Sempre na mesma distância

	O principal problema é saber qual será a forma mais rápida e eficiente de fazer a direção pela qual o pupilo se aproximar ou se afastar do operador ser randômica e desordenada

	A distância base deve ser de self.distanciaMin pixels
	A ideia base é pegar o par da posição do pupilo e fazê-lo chegar a 50 pixels do player
	Em seguida irei implementar um conceito com randomização que não deixará os pupilos parados
]]--