local splashes=require "splashes"
local gamesplash=require "gamesplash"
--[[
  SETTINGS:
    * boolean skipsplashes - Skips splashes if true
    * number volume - Sets volume; see https://www.love2d.org/wiki/love.audio.setVolume
  Specify like: love . setting1=setting2 setting3[=true]
  Not setting at runtime produces the default setting in config.lua
  Specifying without an equals sign makes the setting equal to "true".
  Please set a default value in config.lua if you intend to add a setting.
  If you wish to make changes to the configuration settings without influencing the server default, you may wish to git update-index --assume-unchanged config.lua.
  Please undo this with git update-index --no-assume-unchanged config.lua if you wish to commit changes on this file to the repo - remember to stash your local changes first.
  If config.lua is updated and you are assuming it unchanged, you may want to do: git update-index --no-assume-unchanged config.lua && git stash && git pull origin master && git stash apply && git update-index --assume-unchanged config.lua.
]]
local settings=require "config"()
local function split(s,sep)
  if not sep then sep=":" end
  local fields={}
  local pattern = string.format("([^%s]+)", sep)
  s:gsub(pattern, function(c) fields[#fields+1] = c end)
  return fields
end
function love.load(t)
  for i,v in ipairs(t) do
    if i ~= 1 then
      if v:match("=") then
        local key,value=table.unpack(split(v,"="))
        if value == "true" then
          settings[key]=true
        elseif value == "false" then
          settings[key]=false
        elseif value == "nil" then
          settings[key]=nil
        elseif tonumber(settings.volume) ~= nil then
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
  if settings.skipsplashes then
    gamesplash.go()
  else
    splashes.go()
  end
end
