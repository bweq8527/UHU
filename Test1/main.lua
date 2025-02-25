--引用必要文件
require "utf8"
require("initSrc")
require("class")
require("Func_Logic/func_DrawLogics")
require("Func_Logic.func_ButtonPressedLogics")
require("Class_Button/Buttons/Src_Buttons")
require("Class_Mouse/Mouses/Src_Mouses")
require("Class_Animation/Animations/Src_Animations")
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
    bt_github=buttons[5]
    bt_Pause=buttons[6]
    mouses=mousesSrcInit()
    ms_StartMenu=mouses[1]
    animations=animationsSrcInit()
    an_mario=animations[1]
    --创建时间线以供游戏内时间使用
    timeline=1
end

--循环更新
function love.update(dt)
    --更新用户资源
    bt_Fullscreen:update()
    bt_Exit:update()
    bt_Setting:update()
    bt_github:update()
    bt_Pause:update()
    ms_StartMenu:update()
    an_mario:update()
    --游戏内时间变动
    timeline=timeline+dt*60
end

--循环绘制
function love.draw()
    --绘制用户资源
    bt_Fullscreen:drawButton()
    bt_Exit:drawButton()
    bt_Setting:drawButton()
    bt_github:drawButton()
    bt_Pause:drawButton()
    an_mario:drawAnimation()
    ms_StartMenu:drawMouse()
    
    Print[3]("frames:"..an_mario.frames, 400, 100, timeline, true)
    Print[3]("currentFrame:"..an_mario.currentFrame, 400, 200, timeline, true)
    Print[3]("bornTime:"..an_mario.bornTime, 400, 300, timeline, true)
    Print[3]("lastSleepTime:"..an_mario.lastSleepTime, 400, 400, timeline, true)
    Print[3]("age:"..an_mario.age, 400, 500, timeline, true)
    Print[3]("speed:"..an_mario.speed, 400, 600, timeline, true)
    --Print[3](an_mario.lastFlag, 400, 700, timeline, true)
    --Print[3](an_mario.Flag, 400, 800, timeline, true)
    Print[3]("timeline:"..timeline, 400, 700, timeline, true)


end
