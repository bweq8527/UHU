--经过排查，动图帧序列的命名方式是从1，2，3到最大帧数，而love.filesystem.getDirectoryItems对这一情况的排序有问题，导致实际加载的帧序列为：
---“1，10，11，12，13，14，15，16，17，18，19，2，20，21，22，23，24，25，26，27，28，29，3，30，31，32，33，34，35，36，37，38，39，4，40，41，42，43，44，45，5，6，7，8，9”这样的顺序
---为使帧序列排列正确，使用以下函数进行手动排序及加载

function loadAnimationFrames(path)
    local frames = love.filesystem.getDirectoryItems(path)
    -- 提取数值并排序
    local sortedFrames = {}
    for _, frame in ipairs(frames) do
        local num = frame:match("(%d+)")
        if num then
            table.insert(sortedFrames, { filename = frame, index = tonumber(num) })
        end
    end
    -- 按数值排序
    table.sort(sortedFrames, function(a, b) return a.index < b.index end)
    -- 逐个加载图片
    local images = {}
    for _, item in ipairs(sortedFrames) do
        local imgPath = path .. "/" .. item.filename
        local success, img = pcall(love.graphics.newImage, imgPath)
        if success then
            table.insert(images, img)
        else
            print("Warning: Failed to load image - " .. imgPath)
        end
    end
    return images
end

function loadTextblock_9BG(path)
    local frames = love.filesystem.getDirectoryItems(path)
    -- 提取数值并排序
    local sortedFrames = {}
    for _, frame in ipairs(frames) do
        local num = frame:match("(%d+)")
        if num then
            table.insert(sortedFrames, { filename = frame, index = tonumber(num) })
        end
    end
    -- 按数值排序
    table.sort(sortedFrames, function(a, b) return a.index < b.index end)
    -- 逐个加载图片
    local images = {}
    for _, item in ipairs(sortedFrames) do
        local imgPath = path .. "/" .. item.filename
        local success, img = pcall(love.graphics.newImage, imgPath)
        if success then
            table.insert(images, img)
        else
            print("Warning: Failed to load image - " .. imgPath)
        end
    end
    return images
end