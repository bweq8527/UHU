--引用func_MovingLogic.lua文件
require("func_MovingLogic")

--初始化
function love.load()
    --边框位置、大小
    outline_x=20
    outline_y=20
    outline_width=500
    outline_length=300
    --滑块位置、大小
    rec_x=20
    rec_y=20
    rec_width=20
    rec_length=20
    sizeCtrl=1
    --滑块移动方向，初始方向为向右下移动
    MoveStates={"RightDown","RightUp","LeftUp","LeftDown"}
    MoveState=MoveStates[1]
    --滑块与边框相撞时所处位置（不接触时为“NONE”）
    sides={"TOP","BOTTOM","LEFT","RIGHT","NONE"}
    side=sides[5]
end

--循环更新
function love.update(dt)
    --判断滑块是否与边框相撞
    side=isColliding(rec_x,rec_y,rec_width,rec_length)
    --根据滑块与边框相撞的位置更新滑块运动方向
    MoveState=changeMoveState(side,MoveState)
    --更新滑块位置
    rec_x,rec_y=blockMove(rec_x,rec_y,MoveState,dt)
    --更新滑块大小
    sizeCtrl=sizeCtrl+12*dt --提供一个时间变量以供产生尺寸控制函数中正弦量的变化，但是这个值可能会溢出导致崩溃
    rec_width,rec_length=blockSize()
    
end

--循环绘制
function love.draw()
    --绘制边框
    love.graphics.rectangle("line",outline_x,outline_y,outline_width,outline_length)
    --绘制滑块
    love.graphics.rectangle("fill",rec_x,rec_y,rec_width,rec_length)
end
