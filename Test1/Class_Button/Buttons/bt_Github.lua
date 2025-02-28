local bt_github=Button:new(350,20,80,ProcessIcon(github),"Follow Me on Github")

--重写按钮的按下方法
function bt_github:func_UnderMouse()
    love.system.openURL("https://github.com/bweq8527")
end

--↓↓由于文件作用域的限制，在这个文件中定义的局部变量bt_test无法被外部访问，所以需要提供一个访问接口
function button_github()
    return bt_github
end
--↑↑这个接口的作用是返回实例化后的Button类（bt_test）