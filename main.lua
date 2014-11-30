assets={}
assets.__index=assets
--[[
  SETTINGS:
    * boolean skipsplashes - Skips splashes if true
    * number volume - Sets volume; see https://www.love2d.org/wiki/love.audio.setVolume
]]
settings={
}
function string:split(sep)
  local sep, fields = sep or ":", {}
  local pattern = string.format("([^%s]+)", sep)
  self:gsub(pattern, function(c) fields[#fields+1] = c end)
  return fields
end
function assets:setup(folder)
  local lfs = love.filesystem
  local filesTable = lfs.getDirectoryItems(folder)
  for i,v in ipairs(filesTable) do
    local file = folder.."/"..v
    if lfs.isFile(file) then
      self:addFile(file)
    elseif lfs.isDirectory(file) then
      self:setup(file)
    end
  end
  _G.filename=nil
end
function assets:addFile(filename)
  _G.filename=filename
  file=filename:split("/")
  table.remove(file,1)
  if #file == 1 then
    self[file[1]:split(".")[1]]=assert(self["get"..filename:split(".")[2]:sub(1,1):upper()..filename:split(".")[2]:sub(2)],"ERROR: invalid handle get"..filename:split(".")[2]:sub(1,1):upper()..filename:split(".")[2]:sub(2))()
  elseif #file == 2 then
    if not self[file[1]] then
      self[file[1]]={}
    end
    self[file[1]][file[2]:split(".")[1]]=assert(self["get"..filename:split(".")[2]:sub(1,1):upper()..filename:split(".")[2]:sub(2)],"ERROR: invalid handle get"..filename:split(".")[2]:sub(1,1):upper()..filename:split(".")[2]:sub(2))()
  else
    assert(false,"Maximum depth reached on "..filename.." (depth of "..#file..")")
  end
end
function assets:getPng() -- love.graphics.draw(assets.IMG, x-position, y-position, rotation-in-radians, scale-x, scale-y, offset-x, offset-y, shearing-x, shearing-y)
  return love.graphics.newImage(_G.filename)
end
function assets:getMp3() -- assets.SOUND:play()
  return love.audio.newSource(_G.filename,"static")
end
function love.load(t)
  require "config"
  settings=ldconfig()
  for i,v in ipairs(t) do
    if i ~= 1 then
      if v:match("=") then
        key,value=unpack(v:split("="))
        if value == "true" then
          settings[key]=true
        elseif value == "false" then
          settings[key]=false
        elseif value == "nil" then
          settings[key]=nil
        elseif tonumber(volume) ~= nil then
          settings[key]=tonumber(value)
        else
          settings[key]=value
        end
      else
        settings[v]=true
      end
    end
  end
  if settings.volume then
    love.audio.setVolume(settings.volume)
  end
  assets:setup("assets")
  if settings.skipsplashes then
    game=require "game"
  else
    splashes=require "splashes"
  end
end
