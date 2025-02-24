local an_Mario=Animation:new(Mario,200,200,1,1,timeline,10,true)

--↓↓由于文件作用域的限制，在这个文件中定义的局部变量an_Mario无法被外部访问，所以需要提供一个访问接口
function animation_Mario()
    return an_Mario
end
--↑↑这个接口的作用是返回实例化后的Animation类（an_Mario）