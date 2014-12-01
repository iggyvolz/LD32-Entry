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
function love.load(t)
  if love.filesystem then require "assets" else require "assets-websafe" end
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
