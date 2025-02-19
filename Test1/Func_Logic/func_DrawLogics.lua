--[[
此处记录了一些处理绘制过程中需要的通用逻辑，因此均为全局方法
]]

--将图片处理为统一大小
function scaleCult(sizeX,sizeY,pic)
    local iconSize={x=sizeX,y=sizeY}            --图标大小固定
    local initX,initY=pic:getDimensions()       --获取图标原始大小
    local scaleX=iconSize.x/initX               --计算x缩放比例
    local scaleY=iconSize.y/initY               --计算y缩放比例
    return scaleX,scaleY 
end

--将图片对象处理为按钮三个不同状态时显示的图标（原图、半透明、缩小，对应通常状态、悬停状态、按下状态）
function ProcessIcon(image)
    -- 创建原图
    local original = image
    
    -- 创建灰色蒙版图
    local width, height = original:getDimensions()
    local maskCanvas = love.graphics.newCanvas(width, height)
    love.graphics.setCanvas(maskCanvas)
    love.graphics.clear(0, 0, 0, 0)  -- 清空画布
    -- 将图片绘制到画布上，并加上灰色蒙版
    love.graphics.setColor(0.7, 0.7, 0.7, 0.3)  -- 设置为半透明的灰色
    love.graphics.draw(original, 0, 0)
    love.graphics.setCanvas()  -- 结束绘制
    love.graphics.setColor(1,1,1)   --恢复默认颜色
    -- 将 Canvas 转换为 Image 类型
    local mask = maskCanvas:newImageData():encode("png")
    mask = love.graphics.newImage(mask)

    -- 创建缩小图
    local smallCanvas = love.graphics.newCanvas(width, height)
    love.graphics.setCanvas(smallCanvas)
    local scale=0.8                 --缩小比例
    local position=(1-scale)/2      --重新绘制的位置，使缩小后的图标相比原图居中
    love.graphics.draw(original, width*position, height*position, 0, scale, scale)  -- 缩小一半
    love.graphics.setCanvas()
    -- 将缩小的 Canvas 转换为 Image 类型
    local smallImage = smallCanvas:newImageData():encode("png")
    smallImage = love.graphics.newImage(smallImage)

    local icons={original, mask, smallImage}
    return icons
end