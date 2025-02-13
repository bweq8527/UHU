--引用必要文件
require("initSrc")
require("func_Button")
require("func_Display")
require("class")
require("Class_Button/Button")
require("Class_Button/Buttons/src_Buttons")

--初始化
function love.load()
    love.graphics.setBackgroundColor(0.2, 0.6, 1.0)  -- 设置默认背景色为蓝色
    window_width = love.graphics.getWidth()
    window_height = love.graphics.getHeight()
    flag_FullScreen = false

    bts=buttonsSrcInit()
    bt_test=bts[1]
end

--循环更新
function love.update(dt)
    window_width = love.graphics.getWidth()
    window_height = love.graphics.getHeight()

    bt_test:update()
end

--循环绘制
function love.draw()
    love.graphics.setColor(1,1,1)

    --测试Button类
    love.graphics.print("bt_test.pos.x:"..bt_test.pos.x, 15,15)
    love.graphics.print("bt_test.pos.y:"..bt_test.pos.y, 15,30)
    love.graphics.print("bt_test.size:"..bt_test.size, 15,45)
    love.graphics.print("bt_test.icons:",15,60)
    love.graphics.draw(bt_test.icon_normal, 30, 80,0,Button:scaleCult(bt_test.icon_normal))
    love.graphics.draw(bt_test.icon_undermouse, 100, 80,0,Button:scaleCult(bt_test.icon_undermouse))
    love.graphics.draw(bt_test.icon_pressed, 170, 80,0,Button:scaleCult(bt_test.icon_pressed))
    love.graphics.print("bt_test.name:"..bt_test.name, 15,145)
    love.graphics.print("bt_test.MouseState:"..bt_test.MouseState, 15,170)
  
    bt_test.drawIcon(bt_test.MouseState)
end
