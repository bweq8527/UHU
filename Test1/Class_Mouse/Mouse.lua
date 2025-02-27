Mouse=class()

Mouse.pos={}
Mouse.pos.x=0
Mouse.pos.y=0
Mouse.size=45
--↓↓注：鼠标缩放后实际指向的位置可能会有所变动，因此需要一个偏移量来修正，这里的修正量8/30是经验值
Mouse.deltax=Mouse.size*(8/30)  
Mouse.icon_normal=mouse_0
Mouse.icon_onButton=mouse_1
Mouse.nowButtonName=" " --当前鼠标所悬停的按钮的名称

function Mouse:init(icon)
    self.pos={}
    self.pos.x=love.mouse.getX()
    self.pos.y=love.mouse.getY()
    self.icon_normal=icon[1]
    self.icon_onButton=icon[2]
end

function Mouse:update()
    self.pos.x=love.mouse.getX()
    self.pos.y=love.mouse.getY()
    self:drawMouse()
end

function Mouse:drawMouse()
    love.mouse.setVisible(false)        --隐藏系统鼠标
    love.graphics.setColor(1,1,1,1)
    if(self:onButton())then
        love.graphics.draw(self.icon_onButton,self.pos.x-self.deltax,self.pos.y,0,scaleCult(self.size,self.size,self.icon_onButton))   --光标位于按钮上方
        Print[3](self.nowButtonName,mouseX,mouseY+50,timeline,1)
    else
        love.graphics.draw(self.icon_normal,self.pos.x-self.deltax,self.pos.y,0,scaleCult(self.size,self.size,self.icon_normal))   --光标不位于按钮上方
    end
end

function Mouse:onButton()
    --判断鼠标与按钮交互关系的标记，常态0，一旦出现鼠标位于按钮上方，立刻置为1
    local flag_onAnyButton =false
    --遍历按钮列表（后续要改成遍历当前页面的按钮列表）
    for _,button in ipairs(buttons) do
        --调用button实例的MouseState私有变量，如果不是"normal"说明鼠标放在该按钮上，立刻将标记置1并退出循环
        if button.MouseState~="normal" then
            flag_onAnyButton=true
            self.nowButtonName=button.name  --获取当前按钮的名称
            break
        else
            flag_onAnyButton=false
        end

    end
    --返回标记
    return flag_onAnyButton
end
