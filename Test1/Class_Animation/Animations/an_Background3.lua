local an_Background3=Animation:new(bg3,0,0,1,1,timeline,6,true)

--重写背景的update方法，使其可以贴合窗口大小
function an_Background3:update()
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
    self.x=0
    self.y=0
    local pic_width=self.picSeries[self.currentFrame]:getWidth()
    local pic_height=self.picSeries[self.currentFrame]:getHeight()
    self.Xscale=window_width/pic_width
    self.Yscale=window_height/pic_height
end

--↓↓由于文件作用域的限制，在这个文件中定义的局部变量an_Background3无法被外部访问，所以需要提供一个访问接口
function animation_Background3()
    return an_Background3
end
--↑↑这个接口的作用是返回实例化后的Animation类（an_Background3）