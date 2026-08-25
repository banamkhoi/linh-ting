-- Banana Cat Hub - Compact UI (Auto-Close Notif & Fixed Icon)
local CoreGui = game:GetService("CoreGui")
local TweenService = game:GetService("TweenService")
local UserInputService = game:GetService("UserInputService")

if CoreGui:FindFirstChild("BananaCatHubUI") then
    CoreGui.BananaCatHubUI:Destroy()
end

local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "BananaCatHubUI"
ScreenGui.Parent = (gethui and gethui()) or CoreGui or game.Players.LocalPlayer:WaitForChild("PlayerGui")
ScreenGui.ResetOnSpawn = false

-- Link Icon rbxthumb của bro
local ICON_ASSET = "rbxthumb://type=Asset&id=110625942841371&w=150&h=150"

-- Bảng màu
local BG_COLOR = Color3.fromRGB(13, 13, 15)
local PANEL_COLOR = Color3.fromRGB(19, 19, 22)
local ITEM_COLOR = Color3.fromRGB(26, 26, 30)
local ACCENT_COLOR = Color3.fromRGB(250, 185, 15)
local TEXT_COLOR = Color3.fromRGB(240, 240, 245)
local SUBTEXT_COLOR = Color3.fromRGB(140, 140, 148)

----------------------------------------------------------------
-- 1. NÚT BẤM BẬT/TẮT MENU (HIỂN THỊ ẢNH CHUẨN)
----------------------------------------------------------------
local ToggleBtn = Instance.new("ImageButton")
ToggleBtn.Name = "ToggleButton"
ToggleBtn.Size = UDim2.new(0, 42, 0, 42)
ToggleBtn.Position = UDim2.new(0, 15, 1, -65)
ToggleBtn.BackgroundTransparency = 1 -- Sửa trong suốt để hiện rõ ảnh icon
ToggleBtn.Image = ICON_ASSET
ToggleBtn.Parent = ScreenGui

local ToggleCorner = Instance.new("UICorner")
ToggleCorner.CornerRadius = UDim.new(1, 0)
ToggleCorner.Parent = ToggleBtn

-- Kéo thả nút Toggle
local btnDragging, btnDragStart, btnStartPos
ToggleBtn.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        btnDragging = true
        btnDragStart = input.Position
        btnStartPos = ToggleBtn.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then btnDragging = false end
        end)
    end
end)
UserInputService.InputChanged:Connect(function(input)
    if btnDragging and (input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch) then
        local delta = input.Position - btnDragStart
        ToggleBtn.Position = UDim2.new(btnStartPos.X.Scale, btnStartPos.X.Offset + delta.X, btnStartPos.Y.Scale, btnStartPos.Y.Offset + delta.Y)
    end
end)

----------------------------------------------------------------
-- 2. KHUNG MENU CHÍNH (ĐÃ THU NHỎ SIÊU GỌN 420x250)
----------------------------------------------------------------
local MainFrame = Instance.new("Frame")
MainFrame.Name = "MainFrame"
MainFrame.Size = UDim2.new(0, 420, 0, 250) -- Kích thước thu nhỏ tối ưu
MainFrame.Position = UDim2.new(0.5, -210, 0.5, -125)
MainFrame.BackgroundColor3 = BG_COLOR
MainFrame.BorderSizePixel = 0
MainFrame.ClipsDescendants = true
MainFrame.Visible = false
MainFrame.Parent = ScreenGui

local MainCorner = Instance.new("UICorner")
MainCorner.CornerRadius = UDim.new(0, 6)
MainCorner.Parent = MainFrame

ToggleBtn.MouseButton1Click:Connect(function()
    MainFrame.Visible = not MainFrame.Visible
end)

-- Kéo thả Menu
local dragging, dragInput, dragStart, startPos
MainFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
        dragging = true
        dragStart = input.Position
        startPos = MainFrame.Position
        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then dragging = false end
        end)
    end
end)
MainFrame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then dragInput = input end
end)
UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        local delta = input.Position - dragStart
        MainFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

-- Title Bar
local TitleBar = Instance.new("Frame")
TitleBar.Size = UDim2.new(1, 0, 0, 26)
TitleBar.BackgroundTransparency = 1
TitleBar.Parent = MainFrame

local TitleText = Instance.new("TextLabel")
TitleText.Size = UDim2.new(1, 0, 1, 0)
TitleText.BackgroundTransparency = 1
TitleText.Text = "Banana Cat Hub  -  Blox Fruit"
TitleText.TextColor3 = ACCENT_COLOR
TitleText.TextSize = 12
TitleText.Font = Enum.Font.SourceSansBold
TitleText.Parent = TitleBar

-- Sidebar
local Sidebar = Instance.new("Frame")
Sidebar.Size = UDim2.new(0, 135, 1, -30)
Sidebar.Position = UDim2.new(0, 5, 0, 25)
Sidebar.BackgroundColor3 = PANEL_COLOR
Sidebar.BorderSizePixel = 0
Sidebar.Parent = MainFrame

local SidebarCorner = Instance.new("UICorner")
SidebarCorner.CornerRadius = UDim.new(0, 4)
SidebarCorner.Parent = Sidebar

local SearchFrame = Instance.new("Frame")
SearchFrame.Size = UDim2.new(1, -8, 0, 22)
SearchFrame.Position = UDim2.new(0, 4, 0, 4)
SearchFrame.BackgroundColor3 = BG_COLOR
SearchFrame.BorderSizePixel = 0
SearchFrame.Parent = Sidebar

local SearchCorner = Instance.new("UICorner")
SearchCorner.CornerRadius = UDim.new(0, 4)
SearchCorner.Parent = SearchFrame

local SearchBox = Instance.new("TextBox")
SearchBox.Size = UDim2.new(1, -6, 1, 0)
SearchBox.Position = UDim2.new(0, 3, 0, 0)
SearchBox.BackgroundTransparency = 1
SearchBox.PlaceholderText = "🔍 Search..."
SearchBox.PlaceholderColor3 = SUBTEXT_COLOR
SearchBox.Text = ""
SearchBox.TextColor3 = TEXT_COLOR
SearchBox.TextSize = 10
SearchBox.Font = Enum.Font.SourceSans
SearchBox.TextXAlignment = Enum.TextXAlignment.Left
SearchBox.Parent = SearchFrame

local TabScroll = Instance.new("ScrollingFrame")
TabScroll.Size = UDim2.new(1, -2, 1, -30)
TabScroll.Position = UDim2.new(0, 1, 0, 28)
TabScroll.BackgroundTransparency = 1
TabScroll.BorderSizePixel = 0
TabScroll.ScrollBarThickness = 2
TabScroll.ScrollBarImageColor3 = ACCENT_COLOR
TabScroll.Parent = Sidebar

local TabListLayout = Instance.new("UIListLayout")
TabListLayout.SortOrder = Enum.SortOrder.LayoutOrder
TabListLayout.Padding = UDim.new(0, 2)
TabListLayout.Parent = TabScroll

-- Content Panel
local ContentPanel = Instance.new("Frame")
ContentPanel.Size = UDim2.new(1, -150, 1, -30)
ContentPanel.Position = UDim2.new(0, 145, 0, 25)
ContentPanel.BackgroundColor3 = PANEL_COLOR
ContentPanel.BorderSizePixel = 0
ContentPanel.Parent = MainFrame

local ContentCorner = Instance.new("UICorner")
ContentCorner.CornerRadius = UDim.new(0, 4)
ContentCorner.Parent = ContentPanel

local Tabs = {}

local function CreateTab(name, isDefault)
    local TabButton = Instance.new("TextButton")
    TabButton.Size = UDim2.new(1, -2, 0, 22)
    TabButton.BackgroundTransparency = 1
    TabButton.Text = ""
    TabButton.Parent = TabScroll

    local Indicator = Instance.new("Frame")
    Indicator.Size = UDim2.new(0, 2, 0, 10)
    Indicator.Position = UDim2.new(0, 2, 0.5, -5)
    Indicator.BackgroundColor3 = ACCENT_COLOR
    Indicator.BorderSizePixel = 0
    Indicator.Visible = false
    Indicator.Parent = TabButton

    local Label = Instance.new("TextLabel")
    Label.Size = UDim2.new(1, -10, 1, 0)
    Label.Position = UDim2.new(0, 8, 0, 0)
    Label.BackgroundTransparency = 1
    Label.Text = name
    Label.TextColor3 = SUBTEXT_COLOR
    Label.TextSize = 11
    Label.Font = Enum.Font.SourceSansBold
    Label.TextXAlignment = Enum.TextXAlignment.Left
    Label.Parent = TabButton

    local ItemScroll = Instance.new("ScrollingFrame")
    ItemScroll.Size = UDim2.new(1, -8, 1, -8)
    ItemScroll.Position = UDim2.new(0, 4, 0, 4)
    ItemScroll.BackgroundTransparency = 1
    ItemScroll.BorderSizePixel = 0
    ItemScroll.ScrollBarThickness = 2
    ItemScroll.ScrollBarImageColor3 = ACCENT_COLOR
    ItemScroll.Visible = false
    ItemScroll.Parent = ContentPanel

    local ItemLayout = Instance.new("UIListLayout")
    ItemLayout.SortOrder = Enum.SortOrder.LayoutOrder
    ItemLayout.Padding = UDim.new(0, 3)
    ItemLayout.Parent = ItemScroll

    local function Select()
        for _, tab in pairs(Tabs) do
            tab.Indicator.Visible = false
            tab.Label.TextColor3 = SUBTEXT_COLOR
            tab.ItemScroll.Visible = false
        end
        Indicator.Visible = true
        Label.TextColor3 = TEXT_COLOR
        ItemScroll.Visible = true
    end

    TabButton.MouseButton1Click:Connect(Select)

    local tabData = {
        Indicator = Indicator,
        Label = Label,
        ItemScroll = ItemScroll,
        ItemLayout = ItemLayout
    }
    table.insert(Tabs, tabData)

    if isDefault then Select() end
    TabScroll.CanvasSize = UDim2.new(0, 0, 0, TabListLayout.AbsoluteContentSize.Y)
    return tabData
end

local function AddSectionTitle(tabData, text)
    local TitleLabel = Instance.new("TextLabel")
    TitleLabel.Size = UDim2.new(1, 0, 0, 18)
    TitleLabel.BackgroundTransparency = 1
    TitleLabel.Text = text
    TitleLabel.TextColor3 = ACCENT_COLOR
    TitleLabel.TextSize = 11
    TitleLabel.Font = Enum.Font.SourceSansBold
    TitleLabel.Parent = tabData.ItemScroll
    tabData.ItemScroll.CanvasSize = UDim2.new(0, 0, 0, tabData.ItemLayout.AbsoluteContentSize.Y)
end

local function AddButton(tabData, text, callback)
    local BtnFrame = Instance.new("Frame")
    BtnFrame.Size = UDim2.new(1, -2, 0, 28)
    BtnFrame.BackgroundColor3 = ITEM_COLOR
    BtnFrame.BorderSizePixel = 0
    BtnFrame.Parent = tabData.ItemScroll

    local BtnCorner = Instance.new("UICorner")
    BtnCorner.CornerRadius = UDim.new(0, 4)
    BtnCorner.Parent = BtnFrame

    local Title = Instance.new("TextLabel")
    Title.Size = UDim2.new(1, -70, 1, 0)
    Title.Position = UDim2.new(0, 8, 0, 0)
    Title.BackgroundTransparency = 1
    Title.Text = text
    Title.TextColor3 = TEXT_COLOR
    Title.TextSize = 11
    Title.Font = Enum.Font.SourceSansBold
    Title.TextXAlignment = Enum.TextXAlignment.Left
    Title.Parent = BtnFrame

    local ActionBtn = Instance.new("TextButton")
    ActionBtn.Size = UDim2.new(0, 58, 0, 20)
    ActionBtn.Position = UDim2.new(1, -64, 0.5, -10)
    ActionBtn.BackgroundColor3 = ACCENT_COLOR
    ActionBtn.Text = "Click"
    ActionBtn.TextColor3 = Color3.fromRGB(20, 20, 20)
    ActionBtn.TextSize = 10
    ActionBtn.Font = Enum.Font.SourceSansBold
    ActionBtn.Parent = BtnFrame

    local BtnCornerInner = Instance.new("UICorner")
    BtnCornerInner.CornerRadius = UDim.new(0, 3)
    BtnCornerInner.Parent = ActionBtn

    ActionBtn.MouseButton1Click:Connect(function()
        if callback then pcall(callback) end
    end)

    tabData.ItemScroll.CanvasSize = UDim2.new(0, 0, 0, tabData.ItemLayout.AbsoluteContentSize.Y)
end

-- TẠO TAB
local ShopTab = CreateTab("Shop", true)
CreateTab("Status And Server", false)
CreateTab("LocalPlayer", false)
CreateTab("Setting Farm", false)
CreateTab("Hold and Select Skill", false)
CreateTab("Farming", false)

AddSectionTitle(ShopTab, "Misc Shop")
AddButton(ShopTab, "Redeem Code", function() print("Redeem Code") end)
AddButton(ShopTab, "Teleport Old World", function() print("Teleport Old World") end)

----------------------------------------------------------------
-- 3. BẢNG THÔNG BÁO (TỰ ĐỘNG TẮT SAU 5 GIÂY)
----------------------------------------------------------------
local NotifFrame = Instance.new("Frame")
NotifFrame.Name = "Notification"
NotifFrame.Size = UDim2.new(0, 270, 0, 70)
NotifFrame.Position = UDim2.new(1, -280, 1, -80)
NotifFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 34)
NotifFrame.BorderSizePixel = 0
NotifFrame.Parent = ScreenGui

local NotifCorner = Instance.new("UICorner")
NotifCorner.CornerRadius = UDim.new(0, 6)
NotifCorner.Parent = NotifFrame

local NotifIcon = Instance.new("ImageLabel")
NotifIcon.Size = UDim2.new(0, 16, 0, 16)
NotifIcon.Position = UDim2.new(0, 8, 0, 8)
NotifIcon.BackgroundTransparency = 1
NotifIcon.Image = ICON_ASSET
NotifIcon.Parent = NotifFrame

local NotifTitle = Instance.new("TextLabel")
NotifTitle.Size = UDim2.new(1, -55, 0, 16)
NotifTitle.Position = UDim2.new(0, 28, 0, 8)
NotifTitle.BackgroundTransparency = 1
NotifTitle.Text = "Banana Cat Hub UI Library"
NotifTitle.TextColor3 = ACCENT_COLOR
NotifTitle.TextSize = 11
NotifTitle.Font = Enum.Font.SourceSansBold
NotifTitle.TextXAlignment = Enum.TextXAlignment.Left
NotifTitle.Parent = NotifFrame

local CloseNotif = Instance.new("TextButton")
CloseNotif.Size = UDim2.new(0, 18, 0, 18)
CloseNotif.Position = UDim2.new(1, -22, 0, 6)
CloseNotif.BackgroundTransparency = 1
CloseNotif.Text = "✕"
CloseNotif.TextColor3 = Color3.fromRGB(200, 200, 200)
CloseNotif.TextSize = 11
CloseNotif.Font = Enum.Font.SourceSansBold
CloseNotif.Parent = NotifFrame

local function DestroyNotification()
    if NotifFrame and NotifFrame.Parent then
        TweenService:Create(NotifFrame, TweenInfo.new(0.4), {BackgroundTransparency = 1}):Play()
        for _, descendant in pairs(NotifFrame:GetDescendants()) do
            if descendant:IsA("TextLabel") or descendant:IsA("TextButton") then
                TweenService:Create(descendant, TweenInfo.new(0.4), {TextTransparency = 1}):Play()
            elseif descendant:IsA("ImageLabel") then
                TweenService:Create(descendant, TweenInfo.new(0.4), {ImageTransparency = 1}):Play()
            end
        end
        task.wait(0.4)
        if NotifFrame then NotifFrame:Destroy() end
    end
end

CloseNotif.MouseButton1Click:Connect(DestroyNotification)

local NotifText = Instance.new("TextLabel")
NotifText.Size = UDim2.new(1, -16, 0, 36)
NotifText.Position = UDim2.new(0, 8, 0, 26)
NotifText.BackgroundTransparency = 1
NotifText.Text = "The UI automatically hides once executed.\nPress the button at the bottom-left of the screen to show the GUI."
NotifText.TextColor3 = Color3.fromRGB(220, 220, 220)
NotifText.TextSize = 10
NotifText.Font = Enum.Font.SourceSans
NotifText.TextWrapped = true
NotifText.TextXAlignment = Enum.TextXAlignment.Left
NotifText.TextYAlignment = Enum.TextYAlignment.Top
NotifText.Parent = NotifFrame

-- Tự động mờ dần và ẩn sau đúng 5 giây
task.delay(5, DestroyNotification)