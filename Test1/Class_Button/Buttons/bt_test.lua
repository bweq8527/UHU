local bt_test=Button:new(400,400,80,{exit,fullscreen,unFullscreen},"Func_test")

--↓↓由于文件作用域的限制，在这个文件中定义的局部变量bt_test无法被外部访问，所以需要提供一个访问接口
function button_test()
    return bt_test
end
--↑↑这个接口的作用是返回实例化后的Button类（bt_test）