--[[加载资源]]

--加载图标
-----------------------------------------------------------------------------
fullscreen=love.graphics.newImage("Sources/Icons/fullscreen.png")
unFullscreen=love.graphics.newImage("Sources/Icons/unFullscreen.png")
exit=love.graphics.newImage("Sources/Icons/exit.png")
setting=love.graphics.newImage("Sources/Icons/setting.png")
mouse_0=love.graphics.newImage("Sources/Icons/mouse_0.png")
mouse_1=love.graphics.newImage("Sources/Icons/mouse_1.png")
github=love.graphics.newImage("Sources/Icons/github.png")
pause=love.graphics.newImage("Sources/Icons/pause.png")
play=love.graphics.newImage("Sources/Icons/play.png")
nextbg=love.graphics.newImage("Sources/Icons/next.png")
-----------------------------------------------------------------------------
--加载字体
Pixel1_sml=love.graphics.newFont("Sources/Fonts/k8x12L-3.ttf",20)
Pixel1_mid=love.graphics.newFont("Sources/Fonts/k8x12L-3.ttf",40)
Pixel1_lrg=love.graphics.newFont("Sources/Fonts/k8x12L-3.ttf",60)
Pixel2_cn=love.graphics.newFont("Sources/Fonts/fusion-zh_hans.ttf",40)
-----------------------------------------------------------------------------
--加载动图
require "Func_Logic.func_FilesLoadingLogics"
----|马里奥
Mario={}
table.insert(Mario,love.graphics.newImage("Sources/Animations/Mario/1.png"))
table.insert(Mario,love.graphics.newImage("Sources/Animations/Mario/2.png"))
table.insert(Mario,love.graphics.newImage("Sources/Animations/Mario/3.png"))
----|背景1
local path_bg1="Sources/Animations/bg1/frames"
bg1 = loadAnimationFrames(path_bg1)
----|背景2
local path_bg2="Sources/Animations/bg2/frames"
bg2 = loadAnimationFrames(path_bg2)
----|背景3
local path_bg3="Sources/Animations/bg3/frames"
bg3 = loadAnimationFrames(path_bg3)