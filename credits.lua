local font=require "font"
local gamesplash=require "gamesplash"
local self={
  ["btns"]={
    ["back"]={
      ["x"]=50,
      ["y"]=500,
      ["width"]=180,
      ["height"]=75
    }
  },
  ["creditstext"]="Splash Music - Courtesy of Robert del Naja\nCode licensed by Eternity Incurakai under the MIT license - some assets may not be compatible with this license so please check before redistributing."
}
self.__index=self
function self.go()
  function love.draw()
    love.graphics.setBackgroundColor(255,255,255)
    love.graphics.setColor(0, 0, 0)
    love.graphics.setFont(font(32))
    love.graphics.printf(self.creditstext,0,0,800)
    love.graphics.rectangle("line",self.btns.back.x,self.btns.back.y,self.btns.back.width,self.btns.back.height)
    love.graphics.setFont(font(72))
    love.graphics.print("Back",self.btns.back.x,self.btns.back.y-8)
  end
  function love.mousepressed(x, y)
    if x>self.btns.back.x and x<self.btns.back.x+self.btns.back.width and y>self.btns.back.y and y<self.btns.back.y+self.btns.back.height then
      gamesplash.go()
    end
  end
end
return self
