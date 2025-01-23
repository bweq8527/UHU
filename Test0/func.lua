--根据滑块运动方向更新滑块位置的函数
function blockMove(rec_x,rec_y,MoveState,dt)
    local state=MoveState
    speed=100
    local switch=
    {
        [MoveStates[1]] = function ()
            rec_x=rec_x+speed*dt
            rec_y=rec_y+speed*dt
        end,
        [MoveStates[2]] = function ()
            rec_x=rec_x+speed*dt
            rec_y=rec_y-speed*dt
        end,
        [MoveStates[3]] = function ()
            rec_x=rec_x-speed*dt
            rec_y=rec_y-speed*dt
        end,
        [MoveStates[4]] = function ()
            rec_x=rec_x-speed*dt
            rec_y=rec_y+speed*dt
        end
    }
    
    local moveFunc=switch[MoveState]
    if moveFunc then
        moveFunc()
    else
    end
    return rec_x,rec_y
end
--控制滑块大小的函数
function blockSize()
    rec_width=25*(1+math.sin(sizeCtrl)/10)
    rec_length=25*(1+math.sin(sizeCtrl)/10)
    return rec_width,rec_length
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
        end,
        [sides[2]] = function ()
            if MoveState==MoveStates[1] then
                MoveState=MoveStates[2]
            elseif MoveState==MoveStates[4] then
                MoveState=MoveStates[3]
            end
        end,
        [sides[3]] = function ()
            if MoveState==MoveStates[4] then
                MoveState=MoveStates[1]
            elseif MoveState==MoveStates[3] then
                MoveState=MoveStates[2]
            end
        end,
        [sides[4]] = function ()
            if MoveState==MoveStates[1] then
                MoveState=MoveStates[4]
            elseif MoveState==MoveStates[2] then
                MoveState=MoveStates[3]
            end
        end,
        [sides[5]] = function ()
        end
    }
    local changeFunc=switch[side]
    if changeFunc then
        changeFunc()
    else
    end
    return MoveState
end