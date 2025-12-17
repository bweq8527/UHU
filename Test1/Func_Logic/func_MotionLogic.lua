--A到B的匀速运动
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

--A到B的匀减速运动（通过线性插值实现）
function motionA2B_Decelerate(nowX, nowY, targetX, targetY,smoothness)
    local dx = targetX - nowX
    local dy = targetY - nowY
    --smoothness越大，减速效果越明显
    local nextY = nowY + dy * smoothness
    local nextX = nowX + dx * smoothness
    -- 阈值检测
    if math.abs(dx) < 0.1 and math.abs(dy) < 0.1 then
        return targetX, targetY
    end
    return nextX, nextY
end

function motionA2B_Spring(nowX, nowY, targetX, targetY, velocityX, velocityY, stiffness, damping)
    local dx = targetX - nowX
    local dy = targetY - nowY

    -- 计算加速度
    local ax = stiffness * dx - damping * velocityX
    local ay = stiffness * dy - damping * velocityY

    -- 更新速度
    velocityX = velocityX + ax
    velocityY = velocityY + ay

    -- 更新位置
    local nextX = nowX + velocityX
    local nextY = nowY + velocityY

    return nextX, nextY, velocityX, velocityY
end