local bt_Exit=Button:new(150,20,80,ProcessIcon(exit),"退出游戏 ")

--重写按钮的按下方法
function bt_Exit:func_UnderMouse()
    love.event.quit()
end

--↓↓由于文件作用域的限制，在这个文件中定义的局部变量bt_test无法被外部访问，所以需要提供一个访问接口
function button_exit()
    return bt_Exit
end
--↑↑这个接口的作用是返回实例化后的Button类（bt_test）