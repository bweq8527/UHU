local ms_StartMenu=Mouse:new({mouse_0,mouse_1})

--↓↓由于文件作用域的限制，在这个文件中定义的局部变量ms_StartMenu无法被外部访问，所以需要提供一个访问接口
function mouse_StartMenu()
    return ms_StartMenu
end
--↑↑这个接口的作用是返回实例化后的Mouse类（ms_StartMenu）