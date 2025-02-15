--[[
一些文字打印效果
--]]

--加载utf8库
local utf8=require "utf8"

--文字打印效果1：（单个）字符跳动
local function printEffect1(strings,x,y,r,sx,sy,ox,oy)
    for i, c in utf8.codes(strings) do
        --获取单个字符
        local char = utf8.char(c)
        --根据字符索引生成不同的跳动效果
        local offsetY = math.sin(timeline * 0.1 + i/2*3.14) * 2  
        --绘制字符，y 坐标加上偏移量
        love.graphics.print(char, x, y + offsetY, r, sx, sy, ox, oy)  
        --更新 x 坐标，确保下一个字符紧接着前一个字符
        x = x + love.graphics.getFont():getWidth(char)  
    end
end

--文字打印效果2：（整体）字符左右摇摆
local function printEffect2(strings,x,y,timeline)
    shader=(math.sin(timeline*0.08))*0.15
    love.graphics.print(strings, x, y, r, 1, 1, 0,0,shader, oy)
end

--文字打印效果3：结合效果1和效果2
local function printEffect3(strings,x,y,timeline)
    for i, c in utf8.codes(strings) do
        --获取单个字符
        local char = utf8.char(c)
        --根据字符索引生成不同的跳动效果
        local offsetY = math.sin(timeline * 0.1 + i/2*3.14) * 2  
        --绘制字符，y 坐标加上偏移量
        shader=(math.sin(timeline*0.08))*0.15
        love.graphics.print(char, x, y + offsetY, r, 1,1,0,0,shader,0)  
        --更新 x 坐标，确保下一个字符紧接着前一个字符
        x = x + love.graphics.getFont():getWidth(char)  
    end
end

--返回所有效果
Print={printEffect1,printEffect2,printEffect3}
return Print


