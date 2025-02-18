local bt_Fullscreen=Button:new(50,20,80,ProcessIcon(fullscreen),"全屏")

--重写按钮的按下方法
function bt_Fullscreen:func_UnderMouse()
    flag_FullScreen = not flag_FullScreen
    love.window.setFullscreen(flag_FullScreen)
end

--↓↓由于文件作用域的限制，在这个文件中定义的局部变量bt_test无法被外部访问，所以需要提供一个访问接口
function button_fullscreen()
    return bt_Fullscreen
end
--↑↑这个接口的作用是返回实例化后的Button类（bt_test）