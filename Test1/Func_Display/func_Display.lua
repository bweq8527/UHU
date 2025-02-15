function drawIcons(flag_FullScreen)
    if(flag_FullScreen)then    
        love.graphics.draw(unFullscreen,20,20,0,scaleCult(fullscreen))
        love.graphics.draw(exit,20+80,20,0,scaleCult(exit))
    else
        love.graphics.draw(fullscreen,20,20,0,scaleCult(fullscreen))
        love.graphics.draw(exit,20+80,20,0,scaleCult(exit))
    end
end

function drawMouse(onButton)
    love.mouse.setVisible(false)                                    --隐藏系统鼠标
    nowX,nowY=love.mouse.getPosition()                              --获取鼠标位置
    --绘制游戏内鼠标
    if(onButton)then
        love.graphics.draw(mouse_1,nowX-18,nowY,0,scaleCult(mouse_1))   --光标位于按钮上方
    else
        love.graphics.draw(mouse_0,nowX-15,nowY,0,scaleCult(mouse_0))   --光标不位于按钮上方
    end
end

