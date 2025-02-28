--[[
#引用必要文件#
*0.单独使用一个引用文件的目的是方便模块化管理以及减少main.lua的代码量
*1.这里不能使用相对路径，要用绝对路径（这里说的“绝对路径”其实是相对main.lua的相对路径）
*2.这里引用了所有在main.lua中将要使用到的Textblock类的实例，当然包括Textblock类本身Textblock.lua
--]]
require("Class_Textblock/Textblock")
require "Class_Textblock/Textblocks/tb_ButtonBackground"

function textblocksSrcInit()
    local textblocks={}
    table.insert(textblocks, textblock_ButtonBackground())
    return textblocks
end