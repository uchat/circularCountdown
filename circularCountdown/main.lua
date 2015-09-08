require "CircularCountdown"

display.setDefault( "background", 1, 1, 1 ) 

local onCountdown = function(o, timeLeft)
   if timeLeft > 0 then
      print("time left: " .. timeLeft)
   else
      print("time expires")
--      transition.to(o, {time=200, xScale=4, yScale=4, alpha=0})
   end
end


local cirCountdown = CircularCountdown.newCircularCountdown(100, 5, onCountdown)
cirCountdown.x = display.contentCenterX
cirCountdown.y = display.contentCenterY
cirCountdown:start()
