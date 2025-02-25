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
-----------------------------------------------------------------------------
--加载字体
Pixel1_sml=love.graphics.newFont("Sources/Fonts/k8x12L-3.ttf",20)
Pixel1_mid=love.graphics.newFont("Sources/Fonts/k8x12L-3.ttf",40)
Pixel1_lrg=love.graphics.newFont("Sources/Fonts/k8x12L-3.ttf",60)
Pixel2_cn=love.graphics.newFont("Sources/Fonts/fusion-zh_hans.ttf",40)
-----------------------------------------------------------------------------
--加载动图
----|马里奥
Mario={}
table.insert(Mario,love.graphics.newImage("Sources/Animations/Mario/1.png"))
table.insert(Mario,love.graphics.newImage("Sources/Animations/Mario/2.png"))
table.insert(Mario,love.graphics.newImage("Sources/Animations/Mario/3.png"))
----|背景1
bg1={}
local path_bg1="Sources/Animations/bg1/frames"
local frames = love.filesystem.getDirectoryItems(path_bg1)
for _, frame in ipairs(frames) do
    table.insert(bg1, love.graphics.newImage(path_bg1 .. "/" .. frame))
end