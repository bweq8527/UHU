--这个按钮比较特殊，在点击暂停或者继续播放后，按钮的名称和图标会发生变化
local NAME={"暂停播放","继续播放"}
local ICONS={ProcessIcon(pause),ProcessIcon(play)}
local bt_Pause=Button:new(450,20,80,ICONS[1],NAME[1])

--逻辑“取反”函数：按下按钮时除实现了具体功能，还要改变按钮的名称和图标
function bt_Pause:NOT(element)
    if type(element)=="string" then
        --针对self.name的取反
        if element==NAME[1] then return NAME[2]
        elseif element==NAME[2] then return NAME[1]
        end
    elseif type(element)~=string then
        --针对self.icon_normal的取反
        if element==ICONS[1][1] then return ICONS[2][1]
        elseif element==ICONS[2][1] then return ICONS[1][1]     
        --针对self.icon_undermouse的取反
        elseif element==ICONS[1][2] then return ICONS[2][2]
        elseif element==ICONS[2][2] then return ICONS[1][2]
        --针对self.icon_pressed的取反
        elseif element==ICONS[1][3] then return ICONS[2][3]
        elseif element==ICONS[2][3] then return ICONS[1][3]
        end
    end
end


--重写按钮的按下方法
function bt_Pause:func_UnderMouse()
    an_mario:stateExchange()
    --更改名称
    self.name=self:NOT(self.name)
    --更改图标
    self.icon_normal=self:NOT(self.icon_normal)
    self.icon_undermouse=self:NOT(self.icon_undermouse)
    self.icon_pressed=self:NOT(self.icon_pressed)
end

--↓↓由于文件作用域的限制，在这个文件中定义的局部变量bt_Pause无法被外部访问，所以需要提供一个访问接口
function button_pause()
    return bt_Pause
end
--↑↑这个接口的作用是返回实例化后的Button类（bt_pause）