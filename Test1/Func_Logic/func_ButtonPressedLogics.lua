--[[
*mousereleased()和mousepressed()是全局回调函数，不能作为某一个字段的私有方法
*因此需要为每一个Button实例重写鼠标按下和松开时的事件逻辑，用mousereleased()和mousepressed()监听并调用所有button实例
*这样写的好处在于：统一编写调用逻辑后，只需要在实例化时重写需要被调用的方法即可，无需重新编写该方法如何被调用
--]]
function love.mousereleased(x, y, mouseKey, istouch)
    for _,button in ipairs(buttons) do
        if button:checkMouse() then
            button:func_UnderMouse()
        end
    end
end