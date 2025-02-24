--动态图
Animation=class()

Animation.picSeries={}      --动图序列
Animation.frames=1          --动图序列中的图片数
Animation.currentFrame=1    --当前帧
Animation.x=0               --图片绘制位置
Animation.y=0               --图片绘制位置
Animation.Xscale=1          --图片缩放比例
Animation.Yscale=1          --图片缩放比例
Animation.bornTime=0        --动图创建时间
Animation.lastSleepTime=0   --动图上一次暂停播放时间
Animation.age=0             --动图存在时间
Animation.speed=60          --播放速度（此处是每个图形帧持续多少个游戏帧）
Animation.lastFlag=false    --上一帧是否播放动图
Animation.FLAG=false        --是否播放动图

function Animation:init(picSeries,x,y,Xscale,Yscale,timeline,speed,FLAG)
    self.picSeries=picSeries
    self.frames=#picSeries
    self.currentFrame=1
    self.x=x
    self.y=y
    self.Xscale=Xscale
    self.Yscale=Yscale
    self.bornTime=timeline
    self.lastSleepTime=self.bornTime    --首次显示动图视作其从暂停状态恢复播放
    self.age=0
    self.speed=speed
    self.lastFlag=FLAG
    self.FLAG=FLAG
end

function Animation:update()
    --1st.更新动图（实际）存在时间以供下一步计算当前帧率
    if self.FLAG then
        self.age=timeline-self.lastSleepTime
        self.lastFlag=true
    elseif self.lastFlag then
        self.lastSleepTime=timeline
        self.lastFlag=false
    end
    --2nd.计算当前帧
    self.currentFrame=math.floor(self.age/self.speed)+1
    --3rd.处理溢出
    self.currentFrame=self.currentFrame%self.frames+1
end

function Animation:drawAnimation()
    love.graphics.setColor(1,1,1)
    love.graphics.draw(self.picSeries[self.currentFrame],self.x,self.y,0,self.Xscale,self.Yscale)
end