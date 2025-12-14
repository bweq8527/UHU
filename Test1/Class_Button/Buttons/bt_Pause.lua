--这个按钮比较特殊，在点击暂停或者继续播放后，按钮的名称和图标会发生变化
local NAME={"暂停播放","继续播放"}
local ICONS={ProcessIcon(pause),ProcessIcon(play)}
local bt_Pause=Button:new(450,20,80,ICONS[1],NAME[1])

--[[由于每张背景图的播放状态是独立的，所以在切换背景后暂停/播放按钮的状态需要根据当前背景图的状态进行更新，而不是简单地“取反”，否则会出现状态错乱的问题]]
--[[
↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓原“取反”逻辑↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓
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
↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑原“取反”逻辑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑
--]]

--[[改进后的逻辑：根据当前播放背景的播放状态（FLAG）更新按钮的名称和图标，暂停/播放按钮的当前状态完全依赖于当前播放背景的状态，从而避免按钮状态错乱的问题]]
--重写按钮的按下方法
function bt_Pause:func_UnderMouse()
    --按下后更改当前播放背景的播放状态（FLAG）
    bg[bgID]:stateExchange()
end
--重写按钮的更新方法
function bt_Pause:update()
    --1st.根据当前播放背景的播放状态（FLAG）更新按钮的名称和图标
    if bg[bgID].FLAG==true then
        self.name=NAME[1]
        self.icon_normal=ICONS[1][1]
        self.icon_undermouse=ICONS[1][2]
        self.icon_pressed=ICONS[1][3]
    else
        self.name=NAME[2]
        self.icon_normal=ICONS[2][1]
        self.icon_undermouse=ICONS[2][2]
        self.icon_pressed=ICONS[2][3]
    end
    --2nd.调用父类的更新方法
    Button.update(self)
end

--↓↓由于文件作用域的限制，在这个文件中定义的局部变量bt_Pause无法被外部访问，所以需要提供一个访问接口
function button_pause()
    return bt_Pause
end
--↑↑这个接口的作用是返回实例化后的Button类（bt_pause）