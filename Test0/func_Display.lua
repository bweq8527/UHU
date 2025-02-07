--将帧集合素材分割成单独的帧并存储起来的函数
function flashInit()
    for num = 1, 3 do
        table.insert(Mario,love.graphics.newQuad((num-1)*160,0,160,320,480,320))
    end
end

--显示截取后的每一帧（原始大小）
function showFrame()
    i=1
    for i = 1,3 do
        love.graphics.draw(Pic1,Mario[i],20+300*(i-1),350)
        love.graphics.rectangle("line",20+300*(i-1),350,160,320)
        love.graphics.print("Frame"..i,200+300*(i-1),380)
    end
end

--显示帧画面的函数
function show(frame)
    realFrame=math.floor(frame%3)   --根据当前帧数计算应该显示的帧
    local range=1/20                              --滑块变动范围
    local frequent=1+math.sin(sizeCtrl)*range     --滑块变动频率
    love.graphics.draw(Pic1,Mario[realFrame+1],rec_x,rec_y,0,0.3*frequent,0.3*frequent) --将帧显示在计算好的位置
    love.graphics.print("Mario",rec_x,rec_y-20)
end