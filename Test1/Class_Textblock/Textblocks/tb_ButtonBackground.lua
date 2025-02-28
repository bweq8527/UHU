local tb_ButtonBackground=Textblock:new("ButtonName",80, 180, 250, 250, buttonBG,true)

--↓↓由于文件作用域的限制，在这个文件中定义的局部变量tb_ButtonBackground无法被外部访问，所以需要提供一个访问接口
function textblock_ButtonBackground()
    return tb_ButtonBackground
end
--↑↑这个接口的作用是返回实例化后的Mouse类（tb_ButtonBackground）  