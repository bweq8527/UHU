--根据滑块运动方向更新滑块位置的函数
function blockMove(rec_x1,rec_y1,MoveState,dt)
    local state=MoveState
    local switch=
    {
        [MoveStates[1]] = function ()
            rec_x1=rec_x1+15*dt
            rec_y1=rec_y1+15*dt
        end,
        [MoveStates[2]] = function ()
            rec_x1=rec_x1+15*dt
            rec_y1=rec_y1-15*dt
        end,
        [MoveStates[3]] = function ()
            rec_x1=rec_x1-15*dt
            rec_y1=rec_y1-15*dt
        end,
        [MoveStates[4]] = function ()
            rec_x1=rec_x1-15*dt
            rec_y1=rec_y1+15*dt
        end
    }
    
    local moveFunc=switch[MoveState]
    if moveFunc then
        moveFunc()
    else
    end
    return rec_x1,rec_y1
end
--控制滑块大小的函数
function blockSize(rec_x1,rec_y1,dt)
    rec_x2=rec_x1+20*dt
    rec_y2=rec_y1+20*dt
    return rec_x2,rec_y2
end
--判断滑块是否触碰边框的函数
--控制滑块运动方向的函数