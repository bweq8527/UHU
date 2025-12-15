--[[
#引用必要文件#
*0.单独使用一个引用文件的目的是方便模块化管理以及减少main.lua的代码量
*1.这里不能使用相对路径，要用绝对路径（这里说的“绝对路径”其实是相对main.lua的相对路径）
*2.这里引用了所有在main.lua中将要使用到的Mouse类的实例，当然包括Mouse类本身Mouse.lua
--]]
require("Class_Page/Page")
require "Class_Page/Pages/pg_GUItest"

function pagesSrcInit()
    local pages={}
    table.insert(pages,page_GUItest())
    return pages
end