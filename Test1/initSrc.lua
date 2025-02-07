iconSize={x=50,y=50}    --图标大小固定为50*50

--自动计算缩放比例
function scaleCult(image)
    initX,initY=image:getDimensions()
    scaleX=iconSize.x/initX
    scaleY=iconSize.y/initY
    return scaleX,scaleY
end

--加载图标
fullscreen=love.graphics.newImage("Icons/fullscreen.png")
unFullscreen=love.graphics.newImage("Icons/unFullscreen.png")
exit=love.graphics.newImage("Icons/exit.png")
mouse_0=love.graphics.newImage("Icons/mouse_0.png")
mouse_1=love.graphics.newImage("Icons/mouse_1.png")