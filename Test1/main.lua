--引用必要文件
require "utf8"
require("initSrc")
require("class")
require("Func_Logic/func_DrawLogics")
require("Func_Logic.func_ButtonPressedLogics")
require("Class_Button/Buttons/Src_Buttons")
require("Class_Mouse/Mouses/Src_Mouses")
require("Class_Animation/Animations/Src_Animations")
require("Class_Textblock/Textblocks/Src_Textblocks")
require("Func_Display/Src_DisplayFuncs")
--一些全局变量
white={1,1,1}
black={0,0,0}
red={0.9, 0.1, 0.2}
green={0.1, 0.85, 0.01}
blue={0.2, 0.1, 0.91}
yellow={0.91, 0.81, 0}
magenta={0.81, 0.05, 1}
cyan={0, 0.851, 1}
--初始化
function love.load()
    --[[窗体相关设置]]
    --设置默认背景色
    -----蓝色：love.graphics.setBackgroundColor(0.2, 0.6, 1.0)
    -----黑色：love.graphics.setBackgroundColor(0, 0, 0)
    love.graphics.setBackgroundColor(1, 1, 1)
    --设置窗口高dpi模式
    window_width = love.graphics.getWidth()
    window_height = love.graphics.getHeight()
    love.window.setMode(window_width,window_height,{highdpi = true,resizable=true})    
    flag_FullScreen = false
    --[[初始化用户资源]]
    -------------------------------------
    buttons=buttonsSrcInit()
    bt_test=buttons[1]
    bt_Fullscreen=buttons[2]
    bt_Exit=buttons[3]
    bt_Setting=buttons[4]
    bt_github=buttons[5]
    bt_Pause=buttons[6]
    bt_Next=buttons[7]
    -------------------------------------
    mouses=mousesSrcInit()
    ms_StartMenu=mouses[1]
    -------------------------------------
    animations=animationsSrcInit()
    an_mario=animations[1]
    an_bg1=animations[2]
    an_bg2=animations[3]
    an_bg3=animations[4]
    an_bg4=animations[5]
    an_bg5=animations[6]
    --背景轮换控制
    bg={an_bg1,an_bg2,an_bg3,an_bg4,an_bg5}
    i=1 --背景编号
    -------------------------------------
    textblocks=textblocksSrcInit()
    tb_buttonBG=textblocks[1]
    -------------------------------------
    --[[创建时间线以供游戏内时间使用]]
    timeline=1
end

--循环更新
function love.update(dt)
    --更新窗体大小
    window_width = love.graphics.getWidth()
    window_height = love.graphics.getHeight()
    --更新鼠标位置
    mouseX,mouseY=love.mouse.getPosition()
    --更新用户资源
    bt_Fullscreen:update()
    bt_Exit:update()
    bt_Setting:update()
    bt_github:update()
    bt_Pause:update()
    bt_Next:update()
    ms_StartMenu:update()
    an_mario:update()
    bg[i]:update()
    tb_buttonBG:update()
    --游戏内时间变动
    timeline=timeline+dt*60
end

--循环绘制
function love.draw()
    --绘制用户资源
    bg[i]:drawAnimation()
    tb_buttonBG:drawTextblock()
    bt_Fullscreen:drawButton()
    bt_Exit:drawButton()
    bt_Setting:drawButton()
    bt_github:drawButton()
    bt_Pause:drawButton()
    bt_Next:drawButton()
    ms_StartMenu:drawMouse()
end