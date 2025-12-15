local an_GUIBackground1=Animation:new(GUIbg1,0,0,1,1,timeline,15,true)

--重写背景的update方法，使其可以贴合窗口大小
function an_GUIBackground1:update()
    if self.FLAG then
        if not(self.lastFlag) then
            self.lastPlayTime = timeline
        end
        self.age = self.lastPauseAge + (timeline - self.lastPlayTime)
        self.lastFlag = true
    elseif self.lastFlag then
        self.lastPauseTime=timeline
        self.lastPauseAge=self.age
        self.lastFlag=false
    end
    self.currentFrame=math.floor(self.age/self.speed)+1
    self.currentFrame=self.currentFrame%self.frames+1
    self.x=20
    self.y=0
    self.Xscale=1
    self.Yscale=0.8
end

--↓↓由于文件作用域的限制，在这个文件中定义的局部变量an_GUIBackground1无法被外部访问，所以需要提供一个访问接口
function animation_GUIBackground1()
    return an_GUIBackground1
end
--↑↑这个接口的作用是返回实例化后的Animation类（an_GUIBackground1）