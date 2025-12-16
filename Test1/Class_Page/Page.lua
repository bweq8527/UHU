--引入依赖项
require("Func_Logic.func_MotionLogic")  --运动逻辑函数库
require("Func_Logic.func_MousePosLogics") --鼠标位置逻辑函数库

Page=class()

--页面信息相关参数
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
--页面元素相关参数
Page.elements={}            --页面元素，主要是按钮等一些交互控件
Page.elements.buttons={}    --├─页面上的按钮
Page.elements.textblocks={} --├─页面上的文本框
Page.elements.sprites={}    --└─页面上的精灵
Page.displayState="hide"    --页面显示状态，normal为正常显示，hide为隐藏（默认），blur为模糊
Page.operateState=true      --页面是否可操作，默认为假，当页面显示状态为normal时才可操作
Page.effectOpen="straight"  --页面切入时的动效，默认为straight直接出现
Page.effectExit="straight"  --页面退出时的动效，默认为straight直接消失
--页面动效相关参数
Page.MotionModes={"lissajous","hideOnEdge"}
Page.MotionMode=nil                 --页面运动模式，默认为不移动
-------lissajousParams
Page.lissajousParams={}             --李萨如曲线运动模式参数
Page.lissajousParams.speedX=10      --X方向振动速度
Page.lissajousParams.speedY=20      --Y方向振动速度
Page.lissajousParams.valueX=1       --X方向振幅
Page.lissajousParams.valueY=1       --Y方向振幅
-------hideOnEdgeParams
Page.hideOnEdgeParams={}                                            --靠边隐藏运动模式参数
Page.hideOnEdgeParams.FLAG=true                                     --页面是否处于隐藏状态，true为隐藏，false为显示，默认为true
Page.hideOnEdgeParams.AreaTrigger={0,window_width,0,40}             --定义触发区域,Xleft,Xright,Ytop,Ybottom
Page.hideOnEdgeParams.Goals={
    [1]={STATE="gonnaDisappear",POSX=0,POSY=0},
    [2]={STATE="gonnaAppear",POSX=0,POSY=0}                            
}                                                                   --定义页面的两种目标位置，隐藏时在窗口外，显示时在窗口内
Page.hideOnEdgeParams.CurrentGoal=Page.hideOnEdgeParams.Goals[1]    --定义页面当前的运动趋势，初始为隐藏
Page.hideOnEdgeParams.Speed=10                                      --定义页面移动的速度

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
    self.hideOnEdgeParams.Goals={
        [1]={STATE="gonnaDisappear",POSX=self.pos.x,POSY=self.pos.y-self.height},
        [2]={STATE="gonnaAppear",POSX=self.pos.x,POSY=self.pos.y}                            
    }
end

function Page:update()
    --更新页面位置
    self:setPos(self.MotionMode)  --此处可根据需要更改页面运动模式
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

function Page:setPos(Mode)
    --页面位置的更新函数
    local case=Mode                 --页面运动模式
    local function default() end     --默认不运动
    local cases=
    {
    --# 效果1：页面沿李萨如曲线运动
        lissajous=function()
            --页面沿李萨如曲线运动
            local speedX=self.lissajousParams.speedX      --X方向振动速度
            local speedY=self.lissajousParams.speedY      --Y方向振动速度
            local valueX=self.lissajousParams.valueX        --X方向振幅
            local valueY=self.lissajousParams.valueY        --Y方向振幅
            self.pos.x=self.pos.x+math.sin(timeline/speedX)*valueX
            self.pos.y=self.pos.y+math.cos(timeline/speedY)*valueY
        end,
    --# 效果2：页面模仿QQ靠边自动隐藏的效果
    --[[
        ·定义一个触发区域，当鼠标进入该区域时，页面从窗口外移入窗口（显示）；当鼠标离开该区域时，页面移出窗口（隐藏）
        ·触发之后由于页面移入，触发区域需要同步变为页面范围，否则如果预设的触发区域小于页面，则鼠标在页面中移动时有可能退出触发区域导致页面隐藏
        ·移动过程是平滑的，而不是瞬间完成的，因此只需定义页面隐藏/显示时的目标位置，然后根据鼠标是否处于触发区域来判定页面当前应该向哪个目标位置移动，然后进行线性插值即可
    --]]
        hideOnEdge=function()
            if isMouseInsideBox(self.hideOnEdgeParams.AreaTrigger) then
                self.hideOnEdgeParams.FLAG = false
                self.hideOnEdgeParams.AreaTrigger={0,self.width,0,self.height} -- 更新触发区域为页面范围
                self.hideOnEdgeParams.CurrentGoal = self.hideOnEdgeParams.Goals[2] -- 显示位置
            else
                self.hideOnEdgeParams.FLAG = true
                self.hideOnEdgeParams.AreaTrigger={0,window_width,0,40}             -- 恢复触发区域为预设值
                self.hideOnEdgeParams.CurrentGoal = self.hideOnEdgeParams.Goals[1] -- 隐藏位置
            end

            -- 3. 执行物理移动（这部分你写的没问题）
            local nextX, nextY = motionA2B_Uniform(
                self.pos.x, self.pos.y,
                self.hideOnEdgeParams.CurrentGoal.POSX,
                self.hideOnEdgeParams.CurrentGoal.POSY,
                self.hideOnEdgeParams.Speed
            )
            self.pos.x, self.pos.y = nextX, nextY
        end
            }
            (cases[case] or default)()
end