Page=class()

Page.id=0                   --每个页面有一个唯一id，方便调用
Page.parent=nil             --每个页面有一个唯一父页面，方便返回（此处为父页面的id）
Page.child={}               --每个页面可有多个子页面，也可没有（此处为子页面的id数组）
Page.isFullScreen=true      --页面是否铺满窗口，默认为真（弹窗、悬浮球等也算页面，这一项即为false，当这一项为false时，页面渲染在前级页面顶部，这意味着前级页面也需要渲染且应用其他效果如模糊等）
Page.pos={}                 --页面位置
Page.pos.x=0                --├─页面左上角x坐标
Page.pos.y=0                --└─页面左上角y坐标
Page.width=window_width     --页面宽度，默认与窗口同宽
Page.height=window_height   --页面高度，默认与窗口同高
Page.name="page"            --页面名称
Page.background=GUIbg1      --页面背景,默认是动态图，静态图视作所有帧相同的动态图
Page.frame=0                --页面背景的当前帧数
Page.elements={}            --页面元素，主要是按钮等一些交互控件
Page.elements.buttons={}    --├─页面上的按钮
Page.elements.textblocks={} --├─页面上的文本框
Page.elements.sprites={}    --└─页面上的精灵
Page.displayState="hide"    --页面显示状态，normal为正常显示，hide为隐藏（默认），blur为模糊
Page.operateState=true      --页面是否可操作，默认为假，当页面显示状态为normal时才可操作
Page.effectOpen="straight"  --页面切入时的动效，默认为straight直接出现
Page.effectExit="straight"  --页面退出时的动效，默认为straight直接消失

function Page:init(id,parent,child,isFullScreen,pos,width,height,name,background,elements,displayState,operateState,effectOpen,effectExit)
    self.id=id
    self.parent=parent
    self.child=child
    self.isFullScreen=isFullScreen
    self.pos=pos
    self.width=width
    self.height=height
    self.name=name
    self.background=background
    self.elements=elements
    self.displayState=displayState
    self.operateState=operateState
    self.effectOpen=effectOpen
    self.effectExit=effectExit
end

function Page:update()
    --更新页面位置
    self:setPos()
    --更新页面背景
    self.background:update()
    --更新页面元素
    --基于页面当前位置更新所有页面元素的位置
    for _,button in ipairs(self.elements.buttons) do
        button.pos.x=self.pos.x+button.RelativePos.x --按钮当前x坐标
        button.pos.y=self.pos.y+button.RelativePos.y --按钮当前y坐标
        button:update()
    end --更新按钮
    
end

function Page:drawPage()
    --绘制页面背景(需要先用当前“背景”的位置参数覆盖“背景”本身的位置参数)
    self.background.x=self.pos.x
    self.background.y=self.pos.y
    self.background:drawAnimation()
    --绘制页面元素
    for _,button in ipairs(self.elements.buttons) do
        button:drawButton()
    end --绘制按钮
end

function Page:setPos()
    --页面位置的更新函数
    --[
    --# 效果1：页面沿李萨如曲线运动
    local speedX=80      --X方向振动速度
    local speedY=120      --Y方向振动速度
    local valueX=0.05        --X方向振幅
    local valueY=0.05        --Y方向振幅
    self.pos.x=self.pos.x+math.sin(timeline/speedX)*valueX
    self.pos.y=self.pos.y+math.cos(timeline/speedY)*valueY
    --]]
end