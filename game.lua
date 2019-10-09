game = Classe:extend()

function game:new()
    largura_tela = love.graphics.getWidth()
    altura_tela = love.graphics.getHeight()
    player1 = player(largura_tela/2, altura_tela/2)
    player1.x = player1.x-player1.largura/2
    player1.y = player1.y-player1.altura/2
    seguidor = pupilos(player1.x, player1.y)


    pupilos:new(player1.x, player1.y)
    --temporizador = 0
    tabelaPupilos = {}
    controlePupins = 0
    timing = 0
    basePupilos = 3

    --Tuba
    tuba:new(dt)
    tabelatuba = {}
  	dttuba = 1
    --creditos
  	self.posiX = 0
    self.posiY = 0
end

function game:update(dt)
	delta=1/dt


  --pupilos
  timing = timing + dt


  
  if timing >= 2 then -- se o contador alcançar 2 segundos um pupilo será criado
    controlePupins = controlePupins + 1 --Essa é a variável de controle dos pupilos

    if controlePupins == 1 then --Se for o primeiro pupilo então ele receberá as coordenadas do jogador

        seguidor = pupilos(player1.x, player1.y) --Um objeto chamado seguidor é criado
        table.insert(tabelaPupilos, seguidor) -- O objeto é inserido dentro da table
    elseif controlePupins < 15 then  

        seguidor = pupilos(tabelaPupilos[controlePupins-1].xB, tabelaPupilos[controlePupins-1].yB)
        table.insert(tabelaPupilos, seguidor)
    end

      if controlePupins > 5 then
        controlePupins = 5
      end
      timing=0 --O timing é zerado para que outro pupilo seja criado

    --seguidor:update(dt, player1.x, player1.y)
  end


  for i, seguidor in pairs(tabelaPupilos) do  --Essa é a função de atualização dos pupilos da tabela
    if i == 1 then
      seguidor:update(dt, player1.x, player1.y)
    elseif i < 15 then
      seguidor:update(dt, tabelaPupilos[i-1].xB, tabelaPupilos[i-1].yB)
    end
  end

  --fim


  player1:update(dt)
  
	--Inimigos
	dttuba = dttuba - dt
    if dttuba < 0 then
      local tuba = tuba(1000 * dt)
      table.insert(tabelatuba, tuba)
        dttuba = 1

    end
     for j, tuba in pairs(tabelatuba) do
      tuba:update(dt)
     end 
  --checando as colisões

end

function game:draw()
	player1:draw()
  love.graphics.print("fps: "..delta.." fps", 40, 40)
  love.graphics.print("time: "..timing.." s", 40, 60)
  love.graphics.print("controlePupins: "..controlePupins.." pupilos", 40, 80)
	for i, seguidor in pairs(tabelaPupilos) do
		seguidor:draw()
  	end
	--love.graphics.print("")
	--Tuba
	--for i, tuba in pairs(tabelatuba) do
  -- 		tuba:draw()
 	--end
end
--tuba para x e y

function colisao(pup, ant)
  if pup.xB > ant.x and pup.xB < ant.largura and pup.yB > ant.y and pup.yB < ant.largura then
    return true
  else
    return false
  end
end
