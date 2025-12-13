local bt_next=Button:new(550,20,80,ProcessIcon(nextbg),"下一张")

--重写按钮的按下方法
function bt_next:func_UnderMouse()
    bgID=bgID+1
    if bgID>#bg then bgID=1 end
end

--↓↓由于文件作用域的限制，在这个文件中定义的局部变量bt_next无法被外部访问，所以需要提供一个访问接口
function button_next()
    return bt_next
end
--↑↑这个接口的作用是返回实例化后的Button类（bt_next）