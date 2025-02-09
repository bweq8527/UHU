--[[
功能：创建一个新“类”
参数：父类（可为空）
返回值：创建好的“类”，实际上是一个table
使用例：Animal=class()，Dog=class(Animal)
↓↓]]
function class(parent)
    --↓↓新建一个table“userClass”
    local userClass={}
    --↓↓若传入父类“parent”，则userClass继承parent
    if(parent)then
        --[[
        #0.myMetaTable、__index
            *元表：在 Lua 中，每个 table 都可以关联一个元表（metatable），其中存在许多字段（元方法）用以指定table的各种行为
            *元方法：存在一些以双下划线开头的字段，为Lua元表内置的元方法，用以实现相应的功能。若在元表中定义了这些名字对应的函数，当进行诸如运算符重载、索引访问等操作时，Lua 就会自动调用它们
            *myMetaTable的作用：定义了userClass的元表，在此处__index指向了parent，则在userClass中找不到的字段将会从parent中搜索，从而实现了OOP的继承功能
        #1.setmetatable(table,metatable)
            *对指定 table 设置元表(metatable)，如果元表(metatable)中存在 __metatable 键值，setmetatable 会失败。
        #2.userClass._parent
            *记录该类的父类，可用于显示调用父类方法，或者追溯类的继承关系
        ↓↓]]
        local myMetaTable= 
        {
            --↓↓__index作用：当访问一个不存在的字段时，指定Lua 应该如何查找该字段。如果 __index 是一个 table，当在 c 中找不到某个键时，Lua 就会在 base 表中查找这个键。
            __index = parent,
            --↓↓重载运算符时要根据自定义类所需的具体逻辑编写相应的函数操作例如__add=func(param1,param2,...)，但在此出于通用性考虑均不做处理
            __add=nil,__sub=nil,__mul=nil,__div=nil,__mod=nil,
            __unm=nil,__eq=nil,__lt=nil,__le=nil,__concat=nil,
            --↓↓还有其他很多内置元方法，在此同样不作定义
            __tostring=nil,__call=nil,__newdindex=nil,__gc=nil,
            __mode=nil,__metatable=nil,__len=nil,__band=nil,
            __bor=nil,__bxor=nil,__bnot=nil,__shl=nil,__shr=nil
        }   --#0（如上述）
        setmetatable(userClass,myMetaTable) --#1（如上述）
        userClass._parent=parent    --#2（如上述）
    end
    --↓↓将类的__index元方法设置为其自身，确保实例能够调用类方法
    userClass.__index=userClass
    --[[
    #0.userClass:new(...)
        *此处的“:”等价于“.”，是Lua的语法糖，相当于调用userClass的new()方法
        *Lua函数支持不定长参数，“...”表示传入函数的参数不定，此处应是用于初始化实例的参数
    #1.instance = setmetatable({},self)
        *此处的“self”指的是userClass，在Lua中，self通常有以下几种指向：方法里 self 指向实例、new() 里 self 指向类、继承时 self 仍指向实例
        *这一行将userClass作为一个空列表的元表，并将该列表赋值给实例，从而实现类的实例化
    #2.init()
        *用户在定义类的时候自定义的初始化方法，在实例化时就可以直接调用并初始化实例
        ↓↓定义类的构造函数new方法，用来实例化类
    ]]
    function userClass:new(...) --#0（如上述）
        local instance = setmetatable({},self)  --#1（如上述）
        if(instance.init)then   
            instance:init(...)
        end --#2（如上述）
        return instance
    end
end