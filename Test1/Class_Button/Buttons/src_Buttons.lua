local bt_test=Button:new(550,150,30,{exit,fullscreen,unFullscreen},"Func_test")

local buttons={}
table.insert(buttons,bt_test)

function buttonsSrcInit()
    return buttons
end