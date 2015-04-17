local _font = {

}
return function(size)
  if _font[size] then return _font[size] end
  _font[size] = love.graphics.newFont(size)
  return _font[size]
end
