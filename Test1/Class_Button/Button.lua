require("Func_Display/Src_DisplayFuncs")--|引用文字处理控件
local MouseStates={}                    --|鼠标状态（与按钮的交互关系）
MouseStates[1]="normal"
MouseStates[2]="underMouse"
MouseStates[3]="pressed"
--[[
·按钮类
↓↓]]
Button=class()
--[[
·类参数
↓↓]]
Button.pos={}
Button.pos.x=0                          --|位置x
Button.pos.y=0                          --|位置y
Button.size=50                          --|大小
Button.icon_normal=fullscreen           --|图标（通常情况）
Button.icon_undermouse=unFullscreen     --|图标（鼠标悬停）
Button.icon_pressed=exit                --|图标（鼠标按下）
Button.name="Func"                      --|名称 
Button.MouseState=MouseStates[1]        --|鼠标状态
--[[
·类方法
↓↓]]
--#1.1初始化
function Button:init(x,y,size,icon,name)
    self.pos={}
    self.pos.x=x
    self.pos.y=y
    self.size=size
    self.icon_normal=icon[1]
    self.icon_undermouse=icon[2]
    self.icon_pressed=icon[3]
    self.name=name
    self.MouseState="normal"

    self:drawIcon(self.MouseState)
end
--#1.2更新
function Button:update()
    self:mouseState()                   --|判断鼠标与按钮的交互关系
    self:action_dodge()                 --|实现躲闪效果
    self:drawIcon()                     --|根据交互关系绘制相应图标
end
--#1.3判断鼠标与按钮交互关系
function Button:mouseState()
    --↓↓调试↓↓
    --love.graphics.print("pos.x"..self.pos.x,500,535)
    --love.graphics.print("pos.y"..self.pos.y,500,550)
    --love.graphics.rectangle("line",self.pos.x,self.pos.y,self.size,self.size)
    --↑↑调试↑↑
    local nowX, nowY = love.mouse.getPosition() --|鼠标位置
    local nowMouse = love.mouse.isDown(1)       --|鼠标左键是否按下
    local mouseState=MouseStates[1]             --|鼠标状态
    if  nowX>self.pos.x and nowX<self.pos.x+self.size and nowY>self.pos.y and nowY<self.pos.y+self.size then
        if nowMouse then
            mouseState= MouseStates[3]               --*1.鼠标按下按钮
        else
            mouseState= MouseStates[2]               --*2.鼠标悬停在按钮上    
        end
    else
        mouseState= MouseStates[1]                   --*3.鼠标与按钮无交互
    end
    self.MouseState = mouseState
    --↓↓调试↓↓
    --love.graphics.print("mouseState():"..mouseState,500,500)
    --love.graphics.print("MouseState:"..self.MouseState,500,520)
    --↑↑调试↑↑
    
end
--#1.4绘制按钮的图标
function Button:drawIcon()
    --[[
    实现switch-case语句
    #1.cases
        *这个表记录了swicth-case语句中的各个case，每一个case对应一个匿名函数
        *这个表的键是MouseStates表中的元素，值是一个匿名函数
    #2.( cases[case]() or function()print("Error: Invalid MouseState")end )()
        *这一行实现了switch-case语句：首先通过cases[case]找到对应的匿名函数；然后通过()调用这个匿名函数；若传入的参数在表cases中不被记录，则通过or实现了default语句
        *这一行的最后的()是为了调用匿名函数
    #3. love.graphics.draw*()参数详解
        *第一个参数是要绘制的图像对象
        *第二个参数是图像的位置，这里调用了Button:action_dodge()函数，返回了处理后的图标位置，实际上这里是两个参数
        *第三个参数是图像的旋转角度，默认0
        *第四个参数是图像的缩放比例，这里调用了Button:scaleCult()函数，返回了缩放比例，实际上这里是两个参数
    ↓↓]]
    local X,Y=love.mouse.getPosition()
    case=self.MouseState
    local cases=
    {
        [MouseStates[1]]=function()
            love.graphics.draw(self.icon_normal,self:action_dodge(self.pos).x,self:action_dodge(self.pos).y,0,self:scaleCult(self.icon_normal))
        end,
        [MouseStates[2]]=function()
            love.graphics.draw(self.icon_undermouse,self:action_dodge(self.pos).x,self:action_dodge(self.pos).y,0,self:scaleCult(self.icon_undermouse))
            Print[3](self.name,X-50,Y+20,timeline,"adasd")
            Print[3](self.name,X-50,Y+50,timeline,1)
            Print[3](self.name,X-50,Y+80,timeline)
        end,
        [MouseStates[3]]=function()
            love.graphics.draw(self.icon_pressed,self:action_dodge(self.pos).x,self:action_dodge(self.pos).y,0,self:scaleCult(self.icon_pressed))
        end
    }   --#1（如上述）
    ((cases[case]) or function()print("Error: Invalid MouseState")end) ()

end
--#1.5计算图标缩放比例
function Button:scaleCult(image)
    local iconSize={x=self.size,y=self.size}    --图标大小固定
    local initX,initY=image:getDimensions()     --获取图标原始大小
    local scaleX=iconSize.x/initX               --计算x缩放比例
    local scaleY=iconSize.y/initY               --计算y缩放比例
    return scaleX,scaleY 
end
--#1.6图标“躲闪”动效的逻辑实现
function Button:action_dodge()
    local trueX,trueY=love.mouse.getPosition()                                              --获取鼠标位置
    local icon_basePoint={self.pos.x+self.size/2,self.pos.y+self.size/2}                    --按钮中心
    local ProcessedPos={}                                                                   --处理后的图标位置
    --*1.1如果鼠标位于按钮附近（图标外围50%区域）,执行以下代码以使图标向鼠标相对中心的方向远离。但距离中心特别近将会导致缩放比例过大，设置一个上限
    if  trueX>icon_basePoint[1]-self.size and trueX<icon_basePoint[1]+self.size and trueY>icon_basePoint[2]-self.size and trueY<icon_basePoint[2]+self.size then
        local distance=math.sqrt((trueX-icon_basePoint[1])^2+(trueY-icon_basePoint[2])^2)   --计算鼠标与按钮中心的距离
        local scale=math.min(20/distance^1.25,20)                                            --计算缩放比例（按照引力场的平方反比关系），上限为5倍    
        local delta_x=-scale*(trueX-icon_basePoint[1])                                      --计算x方向的位移
        local delta_y=-scale*(trueY-icon_basePoint[2])                                      --计算y方向的位移
        ProcessedPos.x=self.pos.x+delta_x                                                 
        ProcessedPos.y=self.pos.y+delta_y
    --*2.其他情况
    else
        ProcessedPos.x=self.pos.x
        ProcessedPos.y=self.pos.y
    end
        --↓↓调试↓↓
        --love.graphics.print("ProcessedPosition_Y:"..ProcessedPos.x,130,420)
        --love.graphics.print("ProcessedPosition_X:"..ProcessedPos.y,130,435)
        --↑↑调试↑↑
        return ProcessedPos                                                                  --返回图标的绘制位置
end
--#2.1鼠标与按钮交互的功能
function Button:func_UnderMouse()

end
