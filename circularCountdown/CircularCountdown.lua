CircularCountdown = {}

local rad = math.rad
local sin = math.sin
local cos = math.cos
local abs = math.abs


CircularCountdown.newCircularCountdown = function(radius, second, callback)
    local _ring = display.newGroup()
    local _ticks = {}
    local _timer = second
    local _label
    local _thandle
    
    
    for i=180-6,-180,-6 do
        local rd = rad(i)
        local sinrd = sin(rd)
        local cosrd = cos(rd)        
        
        local c = display.newRect(sinrd * radius, cosrd * radius, 4, 10)
        c.rotation = -i
        c:setFillColor(0, 0, 0, 0.2)
        _ring:insert(c)
        _ticks[#_ticks + 1] = c
    end
    
    _label = display.newText(""..second, 0, 0, native.systemFont, 96)
    _label:setFillColor(0.3, 0.3, 0.3)
    _ring:insert(_label)
    
        
    local timeStamp, now, dt
    local ms = 0
    local interval
    local i = 0
    
    local sec = 0
    local function update()
        now = system.getTimer()
        dt = now - timeStamp
        timeStamp = now
        
        ms = ms + dt
        if ms > interval then
            i = i + 1
            if _ticks[i] then
                _ticks[i]:setFillColor(0, 0, 0)
            end
            ms = ms - interval
        end
        
        sec = sec + dt
        if sec > 1000 then
            _timer = _timer - 1
            _label.text = "" .. _timer
            callback(_ring, _timer)
            if _timer == 0 then
                Runtime:removeEventListener("enterFrame", update)
            end
            sec = sec - 1000
        end
    end
    
    function _ring:start()
        interval = (second * 1000) / #_ticks
        timeStamp = system.getTimer()
        Runtime:addEventListener("enterFrame", update)
    end
        
    
    return _ring
end
