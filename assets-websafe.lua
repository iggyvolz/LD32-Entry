--[[
  Version of ld31 that is safe for LÖVELINESS - https://chrome.google.com/webstore/detail/l%C3%B6veliness/mompnkcmpbopandjnddeecgeeojegohc
  May not work in development - last commit checked was 1 after 63374c8c891399d175c207bedbe1cebec675e4c6 (obviously we can't give the name of this commit's hash or it would change the hash :P
]]
assets={
    ["eijingle"] = love.audio.newSource("assets/eijingle.mp3","static"),
    ["eilogo"] = love.graphics.newImage("assets/eilogo.png"),
    ["love"] = love.graphics.newImage("assets/love.png"),
    ["lua"] = love.graphics.newImage("assets/lua.png"),
    ["setup"] = function(...) return end
}