--由于Page类的成员变量Page.background实例化时需要Animation类的实例存在，故实例化Page前需要确保Animation类的实例已存在
require("Class_Animation.Animations.an_GUIBackground1")
local an_GUIbg1=animation_GUIBackground1()

--这个页面用于测试GUI，将一些按钮放入此页面，做出类似QQ靠边自动隐藏的效果
local pg_GUItest=Page:new(
    1,                  --id
    0,                  --parent
    nil,                --child
    false,              --isFullScreen
    {x=0,y=0},      --pos
    550,                --width
    120,                --height
    "GUI测试页面",       --name
    an_GUIbg1,           --background
    {
        buttons={
            button_exit(),
            button_setting(),
            button_fullscreen(),
            button_github(),
            button_next(),
            button_pause()
        },
        textblocks={},
        sprites={}
    },                  --elements
    "normal",           --displayState
    true,               --operateState
    "fadein",           --effectOpen
    "fadeout"           --effectExit
)

function pg_GUItest:update()
---为了调整该页面中按钮的具体位置重写了更新函数
    self:setPos()
    self.background:update()
    for _,button in ipairs(self.elements.buttons) do
        button.pos.x=110+self.pos.x+button.RelativePos.x --按钮当前x坐标还要再加110的偏移量
        button.pos.y=8+self.pos.y+button.RelativePos.y --按钮当前y坐标还要再加8的偏移量
        button:update()
    end
    
end

--↓↓由于文件作用域的限制，在这个文件中定义的局部变量pg_GUItest无法被外部访问，所以需要提供一个访问接口
function page_GUItest()
    return pg_GUItest
end
--↑↑这个接口的作用是返回实例化后的Page类（pg_GUItest）  