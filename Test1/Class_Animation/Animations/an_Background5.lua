local an_Background5=Animation:new(bg5,0,0,1,1,timeline,4,true)

--重写背景的update方法，使其可以最佳适应窗口（居中显示，不拉伸）
function an_Background5:update()
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
    local pic_width=self.picSeries[self.currentFrame]:getWidth()
    local pic_height=self.picSeries[self.currentFrame]:getHeight()
    local maxPicSize=math.max(pic_height,pic_width)
    local minWinSize=math.min(window_height,window_width)
    local scale=minWinSize/maxPicSize
    self.Xscale=scale
    self.Yscale=scale
    self.x=(window_width-scale*pic_width)/2
    self.y=(window_height-scale*pic_height)/2
end

--↓↓由于文件作用域的限制，在这个文件中定义的局部变量an_Background5无法被外部访问，所以需要提供一个访问接口
function animation_Background5()
    return an_Background5
end
--↑↑这个接口的作用是返回实例化后的Animation类（an_Background5）