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

    bt_test=buttonsSrcInit()[1]
end

--循环更新
function love.update(dt)
    window_width = love.graphics.getWidth()
    window_height = love.graphics.getHeight()
    x,y=love.mouse.getPosition()
    flag=love.mouse.isDown(1)

    bt_test:update()
end

--循环绘制
function love.draw()
    --[[↓↓调试↓↓]]
    --Mouse
    love.graphics.setColor(0.2, 0, 0)
    love.graphics.circle("line", 695, 150, 80)
    love.graphics.print("MOUSE_X:"..x, 635, 130)
    love.graphics.print("MOUSE_Y:"..y, 635, 145)
    love.graphics.print("MOUSE_DOWN:"..tostring(flag), 635, 160)
    --Class
    love.graphics.setColor(0,0,0)
    love.graphics.rectangle("line",10,10,230,250)
    love.graphics.print("Button.pos.x:"..Button.pos.x,15,15)
    love.graphics.print("Button.pos.y:"..Button.pos.y,15,30)
    love.graphics.print("Button.size:"..Button.size,15,45)    
    love.graphics.print("Button.icons:",15,60)
    love.graphics.draw(Button.icon_normal, 30, 80,0,Button:scaleCult(Button.icon_normal))
    love.graphics.print("normal", 35, 135)
    love.graphics.draw(Button.icon_undermouse, 100, 80,0,Button:scaleCult(Button.icon_undermouse))
    love.graphics.print("undermouse", 85, 135)
    love.graphics.draw(Button.icon_pressed, 170, 80,0,Button:scaleCult(Button.icon_pressed))
    love.graphics.print("pressed", 170, 135)
    love.graphics.print("Button.name:"..Button.name,15,165)
    love.graphics.print("Button.MouseState:"..Button.MouseState,15,180)
    love.graphics.setColor(0.5,0.8,0)
    love.graphics.print("CLASS",50,200,0,3.5,3.5)
    --Instance
    love.graphics.setColor(0,0,0)
    love.graphics.rectangle("line",290,10,230,250)
    love.graphics.print("bt_test.pos.x:"..bt_test.pos.x, 295,15)
    love.graphics.print("bt_test.pos.y:"..bt_test.pos.y, 295,30)
    love.graphics.print("bt_test.size:"..bt_test.size, 295,45)
    love.graphics.print("bt_test.icons:", 295,60)
    love.graphics.draw(bt_test.icon_normal, 310, 80,0,Button:scaleCult(bt_test.icon_normal))
    love.graphics.print("normal", 315, 135)
    love.graphics.draw(bt_test.icon_undermouse, 380, 80,0,Button:scaleCult(bt_test.icon_undermouse))
    love.graphics.print("undermouse", 365, 135)
    love.graphics.draw(bt_test.icon_pressed, 450, 80,0,Button:scaleCult(bt_test.icon_pressed))
    love.graphics.print("pressed", 450, 135)
    love.graphics.print("bt_test.name:"..bt_test.name, 295,165)
    love.graphics.print("bt_test.MouseState:"..bt_test.MouseState, 295,180)
    love.graphics.setColor(0.7,0.1,0.2)
    love.graphics.print("INSTANCE",302,200,0,3.5,3.5)
    
    love.graphics.rectangle("line",bt_test.pos.x,bt_test.pos.y,bt_test.size,bt_test.size)
    --[[↑↑调试↑↑]]
    bt_test:drawIcon()
end
