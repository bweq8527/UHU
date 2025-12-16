function motionA2B_Uniform(nowX,nowY,targetX,targetY,speed)
    local dx = targetX - nowX
    local dy = targetY - nowY
    local distance = math.sqrt(dx*dx + dy*dy)
    local Dmin = 1 -- 当距离小于该值时，认为已经到达目标点
    local nextX, nextY
    if distance < Dmin then
        nextX = targetX
        nextY = targetY
    else
        nextX = nowX+(dx/distance)*speed
        nextY = nowY+(dy/distance)*speed
    end
    return nextX, nextY
end