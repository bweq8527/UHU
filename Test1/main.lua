--引用必要文件
require "utf8"
require("initSrc")
require("class")
require("Func_Logic/func_DrawLogics")
require("Func_Logic.func_ButtonPressedLogics")
require("Class_Button/Buttons/Src_Buttons")
require("Class_Mouse/Mouses/Src_Mouses")
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
    buttons=buttonsSrcInit()
    bt_test=buttons[1]
    bt_Fullscreen=buttons[2]
    bt_Exit=buttons[3]
    bt_Setting=buttons[4]
    mouses=mousesSrcInit()
    ms_StartMenu=mouses[1]
    --创建时间线以供游戏内时间使用
    timeline=1
end

--循环更新
function love.update(dt)
    --更新用户资源
    bt_Fullscreen:update()
    bt_Exit:update()
    bt_Setting:update()
    ms_StartMenu:update()
    --游戏内时间变动
    timeline=timeline+dt*60
end

--循环绘制
function love.draw()
    --绘制用户资源
   bt_Fullscreen:drawButton()
   bt_Exit:drawButton()
   bt_Setting:drawButton()
   ms_StartMenu:drawMouse()
end
