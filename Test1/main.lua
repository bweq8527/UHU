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
    --初始化用户资源
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
    --背景轮换控制
    bg={an_bg1,an_bg2,an_bg3}
    i=1 --背景编号
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
    bt_Next:update()
    ms_StartMenu:update()
    an_mario:update()
    bg[i]:update()
    --游戏内时间变动
    timeline=timeline+dt*60
end

--循环绘制
function love.draw()
    --绘制用户资源
    bg[i]:drawAnimation()
    bt_Fullscreen:drawButton()
    bt_Exit:drawButton()
    bt_Setting:drawButton()
    bt_github:drawButton()
    bt_Pause:drawButton()
    bt_Next:drawButton()
    --an_mario:drawAnimation()
    ms_StartMenu:drawMouse()

    --↓↓调试
    -------------------------------------------------------------------------------------
    --[[测试1：证明currentFrame的更新是正确的，问题不在Animation类本身
    Print[3]("frames:"..bg[i].frames,200,200,timeline,0)
    Print[3]("currentFrame:"..bg[i].currentFrame,200,250,timeline,0)
    Print[3]("bornTime:"..bg[i].bornTime,200,300,timeline,0)
    Print[3]("lastPauseTime:"..bg[i].lastPauseTime,200,350,timeline,0)
    Print[3]("lastPlayTime:"..bg[i].lastPlayTime,200,400,timeline,0)
    Print[3]("age:"..bg[i].age,200,450,timeline,0)
    Print[3]("lastPauseAge:"..bg[i].lastPauseAge,200,500,timeline,0)
    --]]
    -------------------------------------------------------------------------------------
    --[[测试2：将bg2逐帧打印发现第1、12、23、34、45等帧不符合预期，证明问题出在加载文件的时候
    s=2*0.6
    love.graphics.draw(bg2[1],0,0*s,0,0.5,0.5)
    love.graphics.draw(bg2[2],0,100*s,0,0.5,0.5)
    love.graphics.draw(bg2[3],0,200*s,0,0.5,0.5)
    love.graphics.draw(bg2[4],0,300*s,0,0.5,0.5)
    love.graphics.draw(bg2[5],0,400*s,0,0.5,0.5)
    love.graphics.draw(bg2[6],0,500*s,0,0.5,0.5)
    love.graphics.draw(bg2[7],0,600*s,0,0.5,0.5)
    love.graphics.draw(bg2[8],0,700*s,0,0.5,0.5)
    love.graphics.draw(bg2[9],0,800*s,0,0.5,0.5)
    love.graphics.draw(bg2[10],200,0*s,0,0.5,0.5)
    love.graphics.draw(bg2[11],200,100*s,0,0.5,0.5)
    love.graphics.draw(bg2[12],200,200*s,0,0.5,0.5)
    love.graphics.draw(bg2[13],200,300*s,0,0.5,0.5)
    love.graphics.draw(bg2[14],200,400*s,0,0.5,0.5)
    love.graphics.draw(bg2[15],200,500*s,0,0.5,0.5)
    love.graphics.draw(bg2[16],200,600*s,0,0.5,0.5)
    love.graphics.draw(bg2[17],200,700*s,0,0.5,0.5)
    love.graphics.draw(bg2[18],200,800*s,0,0.5,0.5)
    love.graphics.draw(bg2[19],400,0*s,0,0.5,0.5)
    love.graphics.draw(bg2[20],400,100*s,0,0.5,0.5)
    love.graphics.draw(bg2[21],400,200*s,0,0.5,0.5)
    love.graphics.draw(bg2[22],400,300*s,0,0.5,0.5)
    love.graphics.draw(bg2[23],400,400*s,0,0.5,0.5)
    love.graphics.draw(bg2[24],400,500*s,0,0.5,0.5)
    love.graphics.draw(bg2[25],400,600*s,0,0.5,0.5)
    love.graphics.draw(bg2[26],400,700*s,0,0.5,0.5)
    love.graphics.draw(bg2[27],400,800*s,0,0.5,0.5)
    love.graphics.draw(bg2[28],600,0*s,0,0.5,0.5)
    love.graphics.draw(bg2[29],600,100*s,0,0.5,0.5)
    love.graphics.draw(bg2[30],600,200*s,0,0.5,0.5)
    love.graphics.draw(bg2[31],600,300*s,0,0.5,0.5)
    love.graphics.draw(bg2[32],600,400*s,0,0.5,0.5)
    love.graphics.draw(bg2[33],600,500*s,0,0.5,0.5)
    love.graphics.draw(bg2[34],600,600*s,0,0.5,0.5)
    love.graphics.draw(bg2[35],600,700*s,0,0.5,0.5)
    love.graphics.draw(bg2[36],600,800*s,0,0.5,0.5)
    love.graphics.draw(bg2[37],800,0*s,0,0.5,0.5)
    love.graphics.draw(bg2[38],800,100*s,0,0.5,0.5)
    love.graphics.draw(bg2[39],800,200*s,0,0.5,0.5)
    love.graphics.draw(bg2[40],800,300*s,0,0.5,0.5)
    love.graphics.draw(bg2[41],800,400*s,0,0.5,0.5)
    love.graphics.draw(bg2[42],800,500*s,0,0.5,0.5)
    love.graphics.draw(bg2[43],800,600*s,0,0.5,0.5)
    love.graphics.draw(bg2[44],800,700*s,0,0.5,0.5)
    love.graphics.draw(bg2[45],800,800*s,0,0.5,0.5)
    --]]
    -------------------------------------------------------------------------------------
    ---经过排查，动图帧序列的命名方式是从1，2，3到最大帧数，而love.filesystem.getDirectoryItems对这一情况的排序有问题，导致实际加载的帧序列为：
    ---“1，10，11，12，13，14，15，16，17，18，19，2，20，21，22，23，24，25，26，27，28，29，3，30，31，32，33，34，35，36，37，38，39，4，40，41，42，43，44，45，5，6，7，8，9”这样的顺序
    ---因此需要对帧序列进行排序例如重新编号001，002，003...065等
    ---解决方式有两个思路：一是用批处理文件批量重命名帧序列，如将1.png改写为001.png；二是加载文件的时候正确地排序
    ---考虑到可移植性等因素，应当选择重写一个加载方法使其正确地排序帧序列
    -------------------------------------------------------------------------------------
    --↑↑调试

end