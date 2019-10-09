tuba = Classe:extend()

function tuba:new(velocidade)
    --self.img = love.graphics.newImage("assets/imagem/inimigo.png")
    self.largura = love.graphics.getWidth()
    self.altura = love.graphics.getHeight()
    self.onde = love.math.random(0,1)
    self.quando = love.math.random(0,1)
    self.timetuba = 0;
    self.vazando = love.math.random(1,4)
    if self.onde == 0 then
    self.x = love.math.random(largura_tela, 2*largura_tela)
    end
    if self.onde == 1 then
    self.x = love.math.random(-largura_tela, 2*-largura_tela)
    end
    if self.quando == 0 then
    self.y = love.math.random(altura_tela, 2*altura_tela)
    end
    if self.quando == 1 then
    self.y = love.math.random(-altura_tela, 2*-altura_tela)
    end
    --Velocidade
  self.velocidade = 0
  self.aceleracao = 2
  self.tempoVel = 0
  self.coefatrito = 0
  --inNatura
  self.tempoGeral = 0
end

function tuba:update(dt)

  self.tempoGeral = self.tempoGeral + dt

  --Movimento
  if player1.x > self.x then
   self.x = self.x + self.velocidade
  end
  if player1.x < self.x then
   self.x = self.x - self.velocidade
  end
  if player1.y > self.y then
   self.y = self.y + self.velocidade
  end
  if player1.y < self.y then
   self.y = self.y - self.velocidade
  end
  --fim

  --Velocidade
  if self.tempoGeral > 3 then
        self.tempoVel = self.tempoVel + dt
        --delay
          self.velocidade = self.tempoVel * self.aceleracao
          if self.velocidade > 2 then
            self.velocidade = 2
            self.tempoVel = 1
          end
    --[[else --Caso a tempoGeral seja menor do que 60  pelo operador - Aqui deve ser implementado o atrito -- ele deve frear em 10 pixels que é a diferença entre 60 e 50
      if self.velocidade > 0 then
        self.tempoVel = self.tempoVel - dt --cálculo do par ordenado de (t, a)
        self.velocidade = self.tempoVel * self.aceleracao -- cálculo de v em função de t
      --elseif - aqui deve ficar a parte da desaceleração do player caso ele aperte a tecla para voltar 
      end
      if self.velocidade > 4 then
        self.velocidade = 4
        self.tempoVel = 2
      end
      --end
      ]]--
  end
    --Fim
 --Tempo de vida ;(
   self.timetuba = self.timetuba + dt;
   if self.timetuba > 10 then

      if self.vazando == 1 then
         self.x = self.x + 10
      elseif self.vazando == 2 then
        self.x = self.x - 10
      elseif self.vazando == 3 then
        self.y = self.y + 10
      else
        self.y = self.y - 10
      end
   end
    
end

function tuba:draw()
    love.graphics.rectangle("line", self.x, self.y, 8, 8)
    --[[Creditos
    love.graphics.print("posicao x -"..self.x.."p", 50, 100 + x)
    love.graphics.print("posicao y -"..self.y.."p", 50, 100 + y)
    ]]--
end
