--[[
#引用必要文件#
*0.单独使用一个引用文件的目的是方便模块化管理以及减少main.lua的代码量
*1.这里不能使用相对路径，要用绝对路径（这里说的“绝对路径”其实是相对main.lua的相对路径）
*2.这里引用了所有在main.lua中将要使用到的Button类的实例，当然包括Button类本身Button.lua
--]]
require("Class_Button/Button")
require "Class_Button/Buttons/bt_test"
require "Class_Button/Buttons/bt_Fullscreen"
require "Class_Button/Buttons/bt_Exit"
require "Class_Button/Buttons/bt_Setting"

function buttonsSrcInit()
    local buttons={}
    table.insert(buttons,button_test())
    table.insert(buttons,button_fullscreen())
    table.insert(buttons,button_exit())
    table.insert(buttons,button_setting())
    return buttons
end