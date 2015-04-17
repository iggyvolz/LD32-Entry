local assets,font,credits,game=require "assets",require "font",require "credits",require "game"
local self={
  ["btns"]={
    ["play"]={
      ["x"]=100,
      ["y"]=150,
      ["width"]=150,
      ["height"]=75
    },
    ["credits"]={
      ["x"]=100,
      ["y"]=250,
      ["width"]=260,
      ["height"]=75
    }
  }
}
self.__index=self
function self.go()
  assets.splashmusic:play()
  function love.draw()
    love.graphics.setBackgroundColor(255,255,255)
    love.graphics.setColor(0, 0, 0)
    love.graphics.setFont(font(72))
    love.graphics.print("A GORE-Y ELECTION",30,0)
    love.graphics.rectangle("line",self.btns.credits.x,self.btns.credits.y,self.btns.credits.width,self.btns.credits.height)
    love.graphics.print("Credits",self.btns.credits.x,self.btns.credits.y-8)
    love.graphics.rectangle("line",self.btns.play.x,self.btns.play.y,self.btns.play.width,self.btns.play.height)
    love.graphics.print("Play",self.btns.play.x,self.btns.play.y-8)
  end
  function love.mousepressed(x, y)
    if x>self.btns.credits.x and x<self.btns.credits.x+self.btns.credits.width and y>self.btns.credits.y and y<self.btns.credits.y+self.btns.credits.height then
      credits.go()
    end
    if x>self.btns.play.x and x<self.btns.play.x+self.btns.play.width and y>self.btns.play.y and y<self.btns.play.y+self.btns.play.height then
      assets.splashmusic:stop()
      game.go()
    end
  end
end
return self
