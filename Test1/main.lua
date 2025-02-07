--引用必要文件
require("initSrc")
require("func_Button")
require("func_Display")

--初始化
function love.load()
    love.graphics.setBackgroundColor(0.2, 0.6, 1.0)  -- 设置默认背景色为蓝色
    window_width = love.graphics.getWidth()
    window_height = love.graphics.getHeight()
    flag_FullScreen = false
end

--循环更新
function love.update(dt)
    window_width = love.graphics.getWidth()
    window_height = love.graphics.getHeight()
    flag_onButton = onButton()
    buttonFunc()
end

--循环绘制
function love.draw()
    love.graphics.setColor(1,1,1)
    drawIcons(flag_FullScreen)
    drawMouse(flag_onButton)
end
