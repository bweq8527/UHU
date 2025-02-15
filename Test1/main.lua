--引用必要文件
require "utf8"
require("initSrc")
require("class")
require("Class_Button/Buttons/Src_Buttons")
require("Func_Display/Src_DisplayFuncs")

--初始化
function love.load()
    --[[窗体相关设置]]
    --设置默认背景色为蓝色
    love.graphics.setBackgroundColor(0.2, 0.6, 1.0)
    --设置窗口高dpi模式
    window_width = love.graphics.getWidth()
    window_height = love.graphics.getHeight()
    love.window.setMode(window_width,window_height,{highdpi = true,resizable=true})    
    flag_FullScreen = false
    --初始化用户资源
    bt_test=buttonsSrcInit()[1]
    --创建时间线以供游戏内时间使用
    timeline=1
end

--循环更新
function love.update(dt)
    --更新用户资源
    bt_test:update()
    --游戏内时间变动
    timeline=timeline+dt*50
end

--循环绘制
function love.draw()
    --绘制用户资源
   bt_test:drawIcon()
   Print[3]("字体效果示例",100,100,timeline)
end
