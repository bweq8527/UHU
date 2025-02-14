local bt_test=Button:new(400,100,80,{exit,fullscreen,unFullscreen},"Func_test")

local buttons={}
table.insert(buttons,bt_test)

function buttonsSrcInit()
    return buttons
end