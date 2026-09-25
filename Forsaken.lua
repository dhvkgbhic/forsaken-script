local UserInputService = game:GetService("UserInputService")

--// ============================================
--// 在这里填入你两个脚本的加载地址
--// ============================================
local SCRIPT_AGREE    = "https://raw.githubusercontent.com/dhvkgbhic/forsaken/refs/heads/main/forsaken1"    -- 点「同意」后执行的脚本
local SCRIPT_DISAGREE = "https://raw.githubusercontent.com/dhvkgbhic/forsaken/refs/heads/main/forsaken"  -- 点「不同意」后执行的脚本

--// 备用：如果你不想用网址，也可以写成函数
--// 例如：local SCRIPT_AGREE = function() loadstring(...)() end
--// 然后下面用 type() 判断

local function RunScript(scriptSource)
    if type(scriptSource) == "function" then
        pcall(scriptSource)
    elseif type(scriptSource) == "string" and scriptSource ~= "" then
        local ok, err = pcall(function()
            loadstring(game:HttpGet(scriptSource))()
        end)
        if not ok then
            warn("[脚本执行失败] " .. tostring(err))
        end
    else
        warn("[未配置脚本地址]")
    end
end

local function CreateGUI(title)
    local gui = Instance.new("ScreenGui")
    gui.Name = "MyGUI"
    gui.ResetOnSpawn = false
    gui.DisplayOrder = 10
    gui.Parent = game.Players.LocalPlayer.PlayerGui

    local frame = Instance.new("Frame")
    frame.Name = "MainFrame"
    frame.BackgroundTransparency = 0
    frame.BackgroundColor3 = Color3.fromRGB(240, 248, 255)
    frame.BorderSizePixel = 0
    frame.Position = UDim2.new(0, 110, 0, -20)
    frame.Size = UDim2.new(0, 500, 0, 280)
    frame.Parent = gui

    local corner = Instance.new("UICorner")
    corner.CornerRadius = UDim.new(0, 10)
    corner.Parent = frame

    -- 拖动逻辑
    local dragging = false
    local startPos, startOffset
    frame.InputBegan:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = true
            startPos = input.Position
            startOffset = frame.Position
            gui.Active = true
        end
    end)
    frame.InputEnded:Connect(function(input)
        if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
            dragging = false
            startPos = nil
            startOffset = nil
            gui.Active = false
        end
    end)
    UserInputService.InputChanged:Connect(function(input)
        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
            local delta = input.Position - startPos
            frame.Position = UDim2.new(
                startOffset.X.Scale,
                startOffset.X.Offset + delta.X,
                startOffset.Y.Scale,
                startOffset.Y.Offset + delta.Y
            )
        end
    end)

    -- 标题
    local titleLabel = Instance.new("TextLabel")
    titleLabel.Name = "TitleLabel"
    titleLabel.Size = UDim2.new(1, 0, 0.05, 0.15 * frame.Size.Y.Offset)
    titleLabel.Position = UDim2.new(0, 0, 0.01, 0)
    titleLabel.BackgroundTransparency = 1
    titleLabel.Text = title
    titleLabel.TextColor3 = Color3.new(0, 0, 0)
    titleLabel.TextSize = math.floor(frame.Size.Y.Offset * 0.1)
    titleLabel.Parent = frame

    -- 不同意按钮
    local disagreeButton = Instance.new("TextButton")
    disagreeButton.Name = "DisagreeButton"
    disagreeButton.Size = UDim2.new(0, 0.4 * frame.Size.X.Offset, 0, 0.15 * frame.Size.Y.Offset)
    disagreeButton.Position = UDim2.new(0, 0.1 * frame.Size.X.Offset, 0, frame.Size.Y.Offset - 0.25 * frame.Size.Y.Offset)
    disagreeButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    disagreeButton.Text = "orionlib ui"
    disagreeButton.TextColor3 = Color3.new(255, 0, 0)
    disagreeButton.TextSize = math.floor(frame.Size.Y.Offset * 0.08)
    disagreeButton.Font = Enum.Font.SourceSans
    disagreeButton.Parent = frame
    local disagreeCorner = Instance.new("UICorner")
    disagreeCorner.CornerRadius = UDim.new(0, 10)
    disagreeCorner.Parent = disagreeButton

    -- 同意按钮
    local agreeButton = Instance.new("TextButton")
    agreeButton.Name = "AgreeButton"
    agreeButton.Size = UDim2.new(0, 0.4 * frame.Size.X.Offset, 0, 0.15 * frame.Size.Y.Offset)
    agreeButton.Position = UDim2.new(0, frame.Size.X.Offset - 0.5 * frame.Size.X.Offset, 0, frame.Size.Y.Offset - 0.25 * frame.Size.Y.Offset)
    agreeButton.BackgroundColor3 = Color3.fromRGB(106, 159, 255)
    agreeButton.Text = "wind ui"
    agreeButton.TextColor3 = Color3.new(255, 255, 255)
    agreeButton.TextSize = math.floor(frame.Size.Y.Offset * 0.08)
    agreeButton.Font = Enum.Font.SourceSans
    agreeButton.Parent = frame
    local agreeCorner = Instance.new("UICorner")
    agreeCorner.CornerRadius = UDim.new(0, 10)
    agreeCorner.Parent = agreeButton

    -- 中间说明文字
    local agreeFrame = Instance.new("TextLabel")
    agreeFrame.Size = UDim2.new(0.8, 0, 0.5, 0)
    agreeFrame.Position = UDim2.new(0.1, 0, 0.22, 0)
    agreeFrame.BackgroundColor3 = Color3.fromRGB(240, 240, 240)
    agreeFrame.Text = "1.by⭐️星喵~.\n2.forsaken."
    agreeFrame.TextWrapped = true
    agreeFrame.TextSize = 16
    agreeFrame.Parent = frame
    local corner2 = Instance.new("UICorner")
    corner2.CornerRadius = UDim.new(0, 10)
    corner2.Parent = agreeFrame

    -- 最小化按钮
    local minimizeButton = Instance.new("TextButton")
    minimizeButton.Name = "MinimizeButton"
    minimizeButton.Size = UDim2.new(0, 40, 0, 40)
    minimizeButton.Position = UDim2.new(1, -65, 0, 10)
    minimizeButton.BackgroundColor3 = Color3.fromRGB(199, 199, 199)
    minimizeButton.Text = "-"
    minimizeButton.TextSize = 28
    minimizeButton.TextColor3 = Color3.new(0, 0, 0)
    minimizeButton.Font = Enum.Font.SourceSans
    minimizeButton.Parent = frame
    local minimizeCorner = Instance.new("UICorner")
    minimizeCorner.CornerRadius = UDim.new(0, 5)
    minimizeCorner.Parent = minimizeButton

    local isMinimized = false
    minimizeButton.MouseButton1Click:Connect(function()
        if isMinimized then
            frame.Size = UDim2.new(0, 500, 0, 280)
            titleLabel.Position = UDim2.new(0, 0, 0.01, 0)
            minimizeButton.Text = "-"
            minimizeButton.TextSize = 28
            isMinimized = false
            disagreeButton.Visible = true
            agreeButton.Visible = true
            agreeFrame.Visible = true
        else
            frame.Size = UDim2.new(0, 500, 0, 60)
            titleLabel.Position = UDim2.new(0, 0, 0, 0)
            minimizeButton.Text = "+"
            minimizeButton.TextSize = 28
            isMinimized = true
            disagreeButton.Visible = false
            agreeButton.Visible = false
            agreeFrame.Visible = false
        end
    end)

    -- 退出动画
    local function AnimateExit()
        local duration = 1
        local startTime = tick()
        local initialSize = frame.Size
        while (tick() - startTime) < duration do
            local elapsedTime = tick() - startTime
            local scale = 1 - elapsedTime / duration
            frame.Size = UDim2.new(
                initialSize.X.Scale * scale, initialSize.X.Offset * scale,
                initialSize.Y.Scale * scale, initialSize.Y.Offset * scale
            )
            frame.Position = frame.Position + UDim2.new((1 - scale) / 2, 0, (1 - scale) / 2, 0)
            task.wait()
        end
        gui:Destroy()
    end

    -- 防止重复点击
    local clicked = false
    local function HandleClick(which)
        if clicked then return end
        clicked = true
        disagreeButton.Active = false
        agreeButton.Active = false

        -- 先执行脚本，再播放退场动画
        if which == "agree" then
            RunScript(SCRIPT_AGREE)
        else
            RunScript(SCRIPT_DISAGREE)
        end

        task.spawn(AnimateExit)
    end

    -- ============ 关键改动：两个按钮分别执行不同脚本 ============
    agreeButton.MouseButton1Click:Connect(function()
        HandleClick("agree")
    end)

    disagreeButton.MouseButton1Click:Connect(function()
        HandleClick("disagree")
    end)
end

local myTitle = "喵喵星forsaken"
CreateGUI(myTitle)