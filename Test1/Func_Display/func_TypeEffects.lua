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

--文字打印效果3：结合效果1和效果2，且可以设置炫彩模式
local function printEffect3(strings, x, y, timeline, isColorful)
    --颜色表
    local Colors = 
    {
        {0.9, 0.1, 0.2},  -- 红色 (Red)
        {0.1, 0.85, 0.01},  -- 绿色 (Green)
        {0.2, 0.1, 0.91},  -- 蓝色 (Blue)
        {0.91, 0.81, 0},  -- 黄色 (Yellow)
        {0.81, 0.05, 1},  -- 品红色 (Magenta)
        {0, 0.851, 1},  -- 青色 (Cyan)
        {0.5, 0.2, 0.7},
        {0.7, 0.2, 0.5}
    }
    --默认字符颜色为白色
    local default = {1, 1, 1}
    --获取字符串长度
    local length = utf8.len(strings)  
    --*仅当炫彩模式时使用：获取开始颜色索引，为表现随机性，根据字符串长度获取开始颜色的索引
    local start=length%8
    --*仅当炫彩模式时使用：用来存储每个字符颜色的新表           
    local Color_String = {}  
    --所有字符默认白色（传入的参数不是1或未传入参数）
    for j=1,length do
        table.insert(Color_String,default)
    end

    --如果需要炫彩模式
        if isColorful == 1 then  --炫彩模式
            local seed=length+utf8.codepoint(strings, start)    --随机种子
            math.randomseed(seed)                               --设置随机种子
            --为每个字符分配伪随机的颜色
            for i = 1, length do
                --使用模运算确保颜色在颜色表内循环
                local index = math.random(1, #Colors)           -- 随机选择一个颜色
                Color_String[i] = Colors[index]                 -- 为字符分配颜色
            end                                    
        end
    -- 遍历字符串中的每个字符并绘制
    local charIndex = 1     --字符索引计数器
    for pos, c in utf8.codes(strings) do
        local char = utf8.char(c)
        -- 根据字符索引生成不同的跳动效果
        local offsetY = math.random(1,2)*math.sin(charIndex+timeline * 0.1 +pos*3.14/2) * 1.2  
        -- 计算倾斜量
        local inclination = (math.sin(timeline * 0.08)) * 0.08
        -- 设置当前字符的颜色
        local colorChangeScale=0.15  --颜色微变范围
        local colorChangeValue=0.2   --颜色微变速率
        local currentColor=Color_String[charIndex]
        COLOR=
        {
            currentColor[1]+colorChangeScale*math.sin(charIndex+timeline*colorChangeValue),
            currentColor[2]+colorChangeScale*math.sin(charIndex+timeline*colorChangeValue),
            currentColor[3]+colorChangeScale*math.sin(charIndex+timeline*colorChangeValue)
        }
        love.graphics.setColor(COLOR)  -- 如果是炫彩模式则用对应的颜色，否则用白色
        -- 绘制字符，y 坐标加上偏移量
        love.graphics.print(char, x, y + offsetY, 0, 1, 1, 0, 0, inclination, 0)  
        -- 更新 x 坐标，确保下一个字符紧接着前一个字符
        x = x + love.graphics.getFont():getWidth(char)  
        charIndex=charIndex+1
    end
end


--返回所有效果
Print={printEffect1,printEffect2,printEffect3}
return Print


