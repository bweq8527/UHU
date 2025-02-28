Textblock = class()

Textblock.txtContent = ""       -- 文字内容
Textblock.font = Pixel2_cn      -- 文字字体
Textblock.size = 40             -- 文字大小
Textblock.maxWidth = 300        -- 文字框的最大宽度
Textblock.x = 0                 -- 文字框的位置 x
Textblock.y = 0                 -- 文字框的位置 y
Textblock.pic_BLOCK = {}        -- 九宫格背景图片（1-9分别对应左上、上、右上、左、中、右、左下、下、右下）
Textblock.BLOCK=nil             -- 最终生成的背景图片
Textblock.finalWidth=0          -- 最终生成的背景图片的宽度
Textblock.finalHeight=0         -- 最终生成的背景图片的高度


--[[
    关于九宫格背景：
    由于文本框大小不确定，所以将文本框的背景图片拆分成左上、上、右上、左、中、右、左下、下、右下九个区域，
    其中左上、右上、左下、右下四角的区块不随文字变化而缩放
    上、下、左、右四边的区块随文字变化而只进行单一方向的拉伸
    中间的区块随文字变化而进行双向拉伸
    最终生成的背景图片是由这九个区块各自缩放后的图块拼接而成的
]]
Textblock.flag_editable = false -- 文本框是否可编辑

function Textblock:init(txtContent, size , maxWidth, x, y, pic_BLOCK,flag_editable)
    self.txtContent = txtContent
    self.size=size
    self.maxWidth = maxWidth
    self.x = x
    self.y = y
    self.pic_BLOCK = pic_BLOCK
    self.flag_editable = flag_editable
    --初步缩放
    self:BGscale1()
end

--更新
function Textblock:update()
    -- 如果文本框可编辑，则监听键盘输入
    if self.flag_editable then
        -- 监听键盘输入
        local key = love.keyboard.textinput
        if key then
            self.txtContent = self.txtContent .. key
        end
    end
    --根据文本内容生成背景图片
    self.BLOCK,self.finalWidth,self.finalHeight= self:blockGenerate()
end

--绘制
function Textblock:drawTextblock()
    local inclination = (math.sin(timeline * 0.08)) * 0.03
    love.graphics.draw(self.BLOCK,self.x+self.finalWidth/2,self.y+self.finalHeight/2,0, 1, 1, self.finalWidth/2, self.finalHeight/2, inclination, 0)
    Print[4](self.txtContent,self.x+self.font:getWidth("A")*0.4,self.y+self.font:getHeight("A")*0.4,timeline,true,self.maxWidth)
end

--根据字体大小对文本框背景图进行初步缩放处理，这一次缩放将使文本框背景的高度缩放至字体高度，宽度跟随高度同比例缩放
function Textblock:BGscale1()
    --0.字体宽度和高度
    local font_width=self.font:getWidth("A")
    local font_height=self.font:getHeight("A")
    --1.计算文本框背景图的原始宽度和高度
    local BG_width=self.pic_BLOCK[1]:getWidth()+self.pic_BLOCK[2]:getWidth()+self.pic_BLOCK[3]:getWidth()       --文本框背景图原始宽度 
    local BG_height=self.pic_BLOCK[1]:getHeight()+self.pic_BLOCK[4]:getHeight()+self.pic_BLOCK[7]:getHeight()   --文本框背景图原始高度
    --2.计算缩放比例
    local scale1=font_height/BG_height  --初步缩放比例
    --3.逐一处理背景图九宫格
    for i = 1, 9 do
        self.pic_BLOCK[i]=scaleImage(self.pic_BLOCK[i],scale1)
    end
end

--生成文本框背景图
function Textblock:blockGenerate()
    --[[初始数据]]
    --字体宽度和高度
    local font_width=self.font:getWidth("A")
    local font_height=self.font:getHeight("A")
    --经自动换行处理后文本块的宽和高
    local TXT_width=0
    local TXT_height=0
    --[[第一步：计算文本框自动换行后的宽度]]
    --获取文本原始宽度（此处指像素数）
    local originalTXT_Width= self.font:getWidth(self.txtContent)
    --根据原始长度判断是否需要换行
    if originalTXT_Width>self.maxWidth then
        --需要换行，则最终宽度=最大宽度，最终高度=（行数+1）*字体高度
        TXT_width=self.maxWidth
        TXT_height=font_height*(math.floor(originalTXT_Width/self.maxWidth)+1)
    else
        --无需换行，则最终宽度=原始宽度，最终高度= 字体高度
        TXT_width=originalTXT_Width
        TXT_height=self.font:getHeight(self.txtContent)
    end
    --[[第二步：计算生成最终文本框背景图所需的缩放比例]]
    --为使得文本框完全包裹文字，需要设置一个额外的放大比例
    local scale_naughtyX=1.2
    local scale_naughtyY=1.1
    ----第一类：四个角块纵横均不缩放（可不定义，以下为定义）
    local scale2_TopLeft_X=1
    local scale2_TopLeft_Y=1
    local scale2_TopRight_X=1
    local scale2_TopRight_Y=1
    local scale2_BottomLeft_X=1
    local scale2_BottomLeft_Y=1
    local scale2_BottomRight_X=1
    local scale2_BottomRight_Y=1
    ----第二类：四个边块仅在一个方向上缩放。其中：上边块与下边块仅在x方向缩放，且缩放比例相同；左边块与右边块仅在y方向缩放，且缩放比例相同
    local scale2_Top_X=(TXT_width-self.pic_BLOCK[1]:getWidth()-self.pic_BLOCK[3]:getWidth())/(self.pic_BLOCK[5]:getWidth())*scale_naughtyX
    local scale2_Top_Y=1
    local scale2_Bottom_X=scale2_Top_X
    local scale2_Bottom_Y=scale2_Top_Y
    local scale2_Left_X=1
    local scale2_Left_Y=(TXT_height-self.pic_BLOCK[1]:getHeight()-self.pic_BLOCK[7]:getHeight())/(self.pic_BLOCK[5]:getHeight())*scale_naughtyY
    local scale2_Right_X=scale2_Left_X
    local scale2_Right_Y=scale2_Left_Y
    ----第三类：中心块在两个方向均需要缩放，且x方向缩放比例与上、下边块一致，y方向缩放比例与左、右边块一致
    local scale2_middle_X=scale2_Bottom_X
    local scale2_middle_Y=scale2_Right_Y
    --[[第三步：在画布上绘制最终的背景图]]
    -- 计算最终所需的画布尺寸
    local totalWidth=
        self.pic_BLOCK[1]:getWidth()*scale2_TopLeft_X
        +self.pic_BLOCK[2]:getWidth()*scale2_Top_X
        +self.pic_BLOCK[3]:getWidth()*scale2_TopRight_X
    local totalHeight=
        self.pic_BLOCK[3]:getHeight()*scale2_TopRight_Y
        +self.pic_BLOCK[4]:getHeight()*scale2_Left_Y
        +self.pic_BLOCK[7]:getHeight()*scale2_BottomRight_Y
    -- 创建并清理画布
    local canvas = love.graphics.newCanvas(totalWidth, totalHeight)
    love.graphics.setCanvas(canvas)
    love.graphics.setColor(1,1,1,0.8)
    love.graphics.clear()
    -- 绘制九宫格
    -- 左上角
    love.graphics.draw(self.pic_BLOCK[1], 0, 0)
    -- 上边（x拉伸）
    love.graphics.draw(self.pic_BLOCK[2], self.pic_BLOCK[1]:getWidth(), 0, 0, scale2_Top_X, 1)
    -- 右上角
    love.graphics.draw(self.pic_BLOCK[3], self.pic_BLOCK[1]:getWidth() + self.pic_BLOCK[2]:getWidth() * scale2_Top_X, 0)
    -- 左边（y拉伸）
    love.graphics.draw(self.pic_BLOCK[4], 0, self.pic_BLOCK[1]:getHeight(), 0, 1, scale2_Left_Y)
    -- 中间（双向拉伸）
    love.graphics.draw(self.pic_BLOCK[5], self.pic_BLOCK[1]:getWidth(), self.pic_BLOCK[1]:getHeight(), 0, scale2_middle_X, scale2_middle_Y)
    -- 右边（y拉伸）
    love.graphics.draw(self.pic_BLOCK[6], self.pic_BLOCK[1]:getWidth() + self.pic_BLOCK[2]:getWidth() * scale2_Top_X, self.pic_BLOCK[3]:getHeight(), 0, 1, scale2_Right_Y)
    -- 左下角
    love.graphics.draw(self.pic_BLOCK[7], 0, self.pic_BLOCK[1]:getHeight() + self.pic_BLOCK[4]:getHeight() * scale2_Left_Y)
    -- 下边（x拉伸）
    love.graphics.draw(self.pic_BLOCK[8], self.pic_BLOCK[7]:getWidth(), self.pic_BLOCK[1]:getHeight() + self.pic_BLOCK[4]:getHeight() * scale2_Left_Y, 0, scale2_Bottom_X, 1)
    -- 右下角
    love.graphics.draw(self.pic_BLOCK[9], self.pic_BLOCK[7]:getWidth() + self.pic_BLOCK[8]:getWidth() * scale2_Bottom_X, self.pic_BLOCK[1]:getHeight() + self.pic_BLOCK[4]:getHeight() * scale2_Left_Y)

    -- 恢复默认 Canvas
    love.graphics.setCanvas()
    return canvas, totalWidth, totalHeight
end
