--判断鼠标是否在某个矩形区域内
function isMouseInsideBox(Rectangle)
    local StartX=Rectangle[1]
    local EndX=Rectangle[2]
    local StartY=Rectangle[3]
    local EndY=Rectangle[4]
    local nowX, nowY = love.mouse.getPosition() --|鼠标位置
    if  nowX>StartX and nowX<EndX and nowY>StartY and nowY<EndY then
        return true
    end
end