--引用func.lua文件
require("func")

--初始化
function love.load()
    --边框大小
    outline_x1=20
    outline_y1=20
    outline_x2=520
    outline_y2=320
    --滑块移动方向，初始方向为向右下移动
    MoveStates={"RightDown","RightUp","LeftUp","LeftDown"}
    MoveState=MoveStates[1]
    --滑块大小
    rec_x1=20
    rec_y1=20
    rec_x2=rec_x1+20
    rec_y2=rec_y1+20
end

--循环更新
function love.update(dt)
    --更新滑块位置
    rec_x1,rec_y1=blockMove(rec_x1,rec_y1,MoveState,dt)
    --更新滑块大小
    rec_x2,rec_y2=blockSize(rec_x1,rec_y1,dt)
    
end

--循环绘制
function love.draw()
    --绘制边框
    love.graphics.rectangle("line",outline_x1,outline_y1,outline_x2,outline_y2)
    --绘制滑块
    love.graphics.rectangle("fill",rec_x1,rec_y1,rec_x2,rec_y2)
end
