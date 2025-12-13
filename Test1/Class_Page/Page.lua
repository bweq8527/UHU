Page=class()

Page.id=0                   --每个页面有一个唯一id，方便调用
Page.parent=nil             --每个页面有一个唯一父页面，方便返回
Page.child={}               --每个页面可有多个子页面
Page.isFullScreen=true      --页面是否铺满窗口，默认为真（弹窗、悬浮球等也算页面，这一项即为false，当这一项为false时，页面渲染在前级页面顶部，这意味着前级页面也需要渲染且应用其他效果如模糊等）
Page.pos={}                 --页面位置
Page.pos.x=0                --├─页面左上角x坐标
Page.pos.y=0                --└─页面左上角y坐标
Page.width=window_width     --页面宽度，默认与窗口同宽
Page.height=window_height   --页面高度，默认与窗口同高
Page.name="page"            --页面名称
Page.background=bg1[1]      --页面背景,可以是动态图，静态图视作只有一帧的动态图
Page.frame=0                --页面背景的当前帧数
Page.elements={}            --页面元素，主要是按钮等一些交互控件
Page.elements.buttons={}    --├─页面上的按钮
Page.elements.textblocks={} --├─页面上的文本框
Page.elements.sprites={}    --└─页面上的精灵
Page.displayState="hide"    --页面显示状态，normal为正常显示，hide为隐藏（默认），blur为模糊
Page.operable=true          --页面是否可操作，默认为假，当页面显示状态不为hide时才可操作
Page.effectOpen="straight"  --页面切入时的动效，默认为straight直接切换
Page.effectExit="straight"  --页面退出时的动效，默认为straight直接切换

function Page:init(id,parent,child,isFullScreen,pos,width,height,name,background,elements,displayState)
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
end

function Page:update()
    --更新页面位置、大小
    self.pos=self.setPos()
    self.width=self.setWidth()
    self.height=self.setHeight()
    --更新页面元素
    for _,button in ipairs(self.elements.buttons) do
        button:update()
    end --更新按钮
    for _,textblock in ipairs(self.elements.textblocks) do
        textblock:update()
    end --更新文本框
    for _,spirit in ipairs(self.elements.spirits) do
        spirit:update()
    end --更新精灵
end

function Page:draw()
    --绘制背景
    love.graphics.draw(self.background[self.setFrame()],self.pos.x,self.pos.y)
    --绘制页面元素
    for _,button in ipairs(self.elements.buttons) do
        button:drawButton()
    end --绘制按钮
    for _,textblock in ipairs(self.elements.textblocks) do
        textblock:drawTextblock()
    end --绘制文本框
    for _,spirit in ipairs(self.elements.spirits) do
        spirit:drawSpirit()
    end --绘制精灵
end