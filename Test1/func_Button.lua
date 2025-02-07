function onButton()
    nowX,nowY=love.mouse.getPosition()
    flag=false
    if  nowX>20 and nowX<20+50 and nowY>20 and nowY<20+50 then
        flag=true
    elseif nowX>20+80 and nowX<20+50+80 and nowY>20 and nowY<20+50 then
        flag=true
    end
    return flag
end

function buttonFunc()
    love.mousereleased = function(x, y, button, istouch, presses)
        if button == 1 then
            if  x>20 and x<20+50 and y>20 and y<20+50 then
                flag_FullScreen = not flag_FullScreen
                love.window.setFullscreen(flag_FullScreen)
            elseif x>20+80 and x<20+50+80 and y>20 and y<20+50 then
                love.event.quit()
            end
        end
    end
    
end