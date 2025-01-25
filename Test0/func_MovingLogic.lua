--根据滑块运动方向更新滑块位置的函数
function blockMove(rec_x,rec_y,MoveState,dt)
    local speed=100   --滑块运动速度
    local switch=
    {
        [MoveStates[1]] = function ()
            rec_x=rec_x+speed*dt
            rec_y=rec_y+speed*dt
        end,    --向右下移动
        [MoveStates[2]] = function ()
            rec_x=rec_x+speed*dt
            rec_y=rec_y-speed*dt
        end,    --向右上移动
        [MoveStates[3]] = function ()
            rec_x=rec_x-speed*dt
            rec_y=rec_y-speed*dt
        end,    --向左上移动
        [MoveStates[4]] = function ()
            rec_x=rec_x-speed*dt
            rec_y=rec_y+speed*dt
        end     --向左下移动
    }
    
    local moveFunc=switch[MoveState]    --根据滑块运动方向选择相应的函数
    if moveFunc then                    --如果函数存在则执行
        moveFunc()
    else
    end
    return rec_x,rec_y
end
--控制滑块大小变化的函数
function blockSize()
    local range=1/20                              --滑块变动范围
    local initSize=48                             --滑块基础大小
    local frequent=1+math.sin(sizeCtrl)*range     --滑块变动频率
    local rec_width=initSize*frequent
    local rec_length=initSize*frequent*2
    return rec_width,rec_length
end
--控制滑块颜色变化的函数
function blockColor(frame)
    R=math.sin(0.5*frame-math.pi/2)
    G=math.sin(0.5*frame)
    B=math.sin(0.5*frame+math.pi/2)
    return R,G,B
end
--判断滑块是否触碰边框的函数
function isColliding(rec_x,rec_y,rec_width,rec_length)
    if rec_x<=outline_x then
        return sides[3]
    elseif rec_x+rec_width>=outline_x+outline_width then
        return sides[4]
    elseif rec_y<=outline_y then
        return sides[1]
    elseif rec_y+rec_length>=outline_y+outline_length then
        return sides[2]
    else
        return sides[5]
    end
end
--控制滑块运动方向的函数
function changeMoveState(side,MoveState)
    local switch=
    {
        [sides[1]] = function ()
            if MoveState==MoveStates[2] then
                MoveState=MoveStates[1]
            elseif MoveState==MoveStates[3] then
                MoveState=MoveStates[4]
            end
        end,    --滑块与边框顶部相撞时，下变上
        [sides[2]] = function ()
            if MoveState==MoveStates[1] then
                MoveState=MoveStates[2]
            elseif MoveState==MoveStates[4] then
                MoveState=MoveStates[3]
            end
        end,    --滑块与边框底部相撞时，上变下
        [sides[3]] = function ()
            if MoveState==MoveStates[4] then
                MoveState=MoveStates[1]
            elseif MoveState==MoveStates[3] then
                MoveState=MoveStates[2]
            end
        end,    --滑块与边框左侧相撞时，右变左
        [sides[4]] = function ()
            if MoveState==MoveStates[1] then
                MoveState=MoveStates[4]
            elseif MoveState==MoveStates[2] then
                MoveState=MoveStates[3]
            end
        end,    --滑块与边框右侧相撞时，左变右
        [sides[5]] = function ()
            MoveState=MoveState
        end     --滑块与边框不相撞时，不变
    }
    local changeFunc=switch[side]
    if changeFunc then
        changeFunc()
    else
    end
    return MoveState
end