--[[
#引用必要文件#
*0.单独使用一个引用文件的目的是方便模块化管理以及减少main.lua的代码量
*1.这里不能使用相对路径，要用绝对路径（这里说的“绝对路径”其实是相对main.lua的相对路径）
*2.这里引用了所有在main.lua中将要使用到的Animation类的实例，当然包括Animation类本身Animation.lua
--]]
require("Class_Animation/Animation")
require "Class_Animation/Animations/an_Mario"
require "Class_Animation.Animations.an_Background1"
require "Class_Animation.Animations.an_Background2"
require "Class_Animation.Animations.an_Background3"
require "Class_Animation.Animations.an_Background4"
require "Class_Animation.Animations.an_Background5"
require "Class_Animation.Animations.an_GUIBackground1"

function animationsSrcInit()
    local animations={}
    table.insert(animations,animation_Mario())
    table.insert(animations,animation_Background1())
    table.insert(animations,animation_Background2())
    table.insert(animations,animation_Background3())
    table.insert(animations,animation_Background4())
    table.insert(animations,animation_Background5())
    table.insert(animations,animation_GUIBackground1())
    return animations
end