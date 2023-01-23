
do  local ui =  game:GetService("CoreGui"):FindFirstChild("SwX-Lib")  if ui then ui:Destroy() end end
do  local blur =  game:GetService("Lighting"):FindFirstChild("Blurrr")  if blur then blur:Destroy() end end

local UserInputService = game:GetService("UserInputService")
local TweenService = game:GetService("TweenService")
local RunService = game:GetService("RunService")
local LocalPlayer = game:GetService("Players").LocalPlayer
local Mouse = LocalPlayer:GetMouse()
local SwXLib = Instance.new("ScreenGui")

local function tablefound(ta, object)
    for i,v in pairs(ta) do
        if v == object then
            return true
        end
    end
    return false
end


local function Tween(instance, properties,style,wa)
    if style == nil or "" then
        return Back
    end
    tween:Create(instance,TweenInfo.new(wa,Enum.EasingStyle[style]),{properties}):Play()
end

local ActualTypes = {
    RoundFrame = "ImageLabel",
    Shadow = "ImageLabel",
    Circle = "ImageLabel",
    CircleButton = "ImageButton",
    Frame = "Frame",
    Label = "TextLabel",
    Button = "TextButton",
    SmoothButton = "ImageButton",
    Box = "TextBox",
    ScrollingFrame = "ScrollingFrame",
    Menu = "ImageButton",
    NavBar = "ImageButton"
}

local Properties = {
    RoundFrame = {
        BackgroundTransparency = 1,
        Image = "http://www.roblox.com/asset/?id=5554237731",
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(3,3,297,297)
    },
    SmoothButton = {
        AutoButtonColor = false,
        BackgroundTransparency = 1,
        Image = "http://www.roblox.com/asset/?id=5554237731",
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(3,3,297,297)
    },
    Shadow = {
        Name = "Shadow",
        BackgroundTransparency = 1,
        Image = "http://www.roblox.com/asset/?id=5554236805",
        ScaleType = Enum.ScaleType.Slice,
        SliceCenter = Rect.new(23,23,277,277),
        Size = UDim2.fromScale(1,1) + UDim2.fromOffset(30,30),
        Position = UDim2.fromOffset(-15,-15)
    },
    Circle = {
        BackgroundTransparency = 1,
        Image = "http://www.roblox.com/asset/?id=5554831670"
    },
    CircleButton = {
        BackgroundTransparency = 1,
        AutoButtonColor = false,
        Image = "http://www.roblox.com/asset/?id=5554831670"
    },
    Frame = {
        BackgroundTransparency = 1,
        BorderSizePixel = 0,
        Size = UDim2.fromScale(1,1)
    },
    Label = {
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(5,0),
        Size = UDim2.fromScale(1,1) - UDim2.fromOffset(5,0),
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left
    },
    Button = {
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(5,0),
        Size = UDim2.fromScale(1,1) - UDim2.fromOffset(5,0),
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left
    },
    Box = {
        BackgroundTransparency = 1,
        Position = UDim2.fromOffset(5,0),
        Size = UDim2.fromScale(1,1) - UDim2.fromOffset(5,0),
        TextSize = 14,
        TextXAlignment = Enum.TextXAlignment.Left
    },
    ScrollingFrame = {
        BackgroundTransparency = 1,
        ScrollBarThickness = 0,
        CanvasSize = UDim2.fromScale(0,0),
        Size = UDim2.fromScale(1,1)
    },
    Menu = {
        Name = "More",
        AutoButtonColor = false,
        BackgroundTransparency = 1,
        Image = "http://www.roblox.com/asset/?id=5555108481",
        Size = UDim2.fromOffset(20,20),
        Position = UDim2.fromScale(1,0.5) - UDim2.fromOffset(25,10)
    },
    NavBar = {
        Name = "SheetToggle",
        Image = "http://www.roblox.com/asset/?id=5576439039",
        BackgroundTransparency = 1,
        Size = UDim2.fromOffset(20,20),
        Position = UDim2.fromOffset(5,5),
        AutoButtonColor = false
    }
}

local Types = {
    "RoundFrame",
    "Shadow",
    "Circle",
    "CircleButton",
    "Frame",
    "Label",
    "Button",
    "SmoothButton",
    "Box",
    "ScrollingFrame",
    "Menu",
    "NavBar"
}

function FindType(String)
    for _, Type in next, Types do
        if Type:sub(1, #String):lower() == String:lower() then
            return Type
        end
    end
    return false
end

local Objects = {}

function Objects.new(Type)
    local TargetType = FindType(Type)
    if TargetType then
        local NewImage = Instance.new(ActualTypes[TargetType])
        if Properties[TargetType] then
            for Property, Value in next, Properties[TargetType] do
                NewImage[Property] = Value
            end
        end
        return NewImage
    else
        return Instance.new(Type)
    end
end

local function GetXY(GuiObject)
    local Max, May = GuiObject.AbsoluteSize.X, GuiObject.AbsoluteSize.Y
    local Px, Py = math.clamp(Mouse.X - GuiObject.AbsolutePosition.X, 0, Max), math.clamp(Mouse.Y - GuiObject.AbsolutePosition.Y, 0, May)
    return Px/Max, Py/May
end

local function CircleAnim(GuiObject, EndColour, StartColour)
    local PX, PY = GetXY(GuiObject)
    local Circle = Objects.new("Circle")
    Circle.Size = UDim2.fromScale(0,0)
    Circle.Position = UDim2.fromScale(PX,PY)
    Circle.ImageColor3 = StartColour or GuiObject.ImageColor3
    Circle.ZIndex = 200
    Circle.Parent = GuiObject
    local Size = GuiObject.AbsoluteSize.X
    TweenService:Create(Circle, TweenInfo.new(0.5), {Position = UDim2.fromScale(PX,PY) - UDim2.fromOffset(Size/2,Size/2), ImageTransparency = 1, ImageColor3 = EndColour, Size = UDim2.fromOffset(Size,Size)}):Play()
    spawn(function()
        wait(0.5)
        Circle:Destroy()
    end)
end

SwXLib.Name = "SwX-Lib"
SwXLib.Parent = game.CoreGui
SwXLib.ZIndexBehavior = Enum.ZIndexBehavior.Sibling


local lib = {}

function lib:main()

    local blur = Instance.new('BlurEffect')
    blur.Name = "Blurrr"
    blur.Parent = game.Lighting
    blur.Size = 0

    TweenService:Create(
        blur,
        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out,0.1),
        {Size = 30}
    ):Play()

    local Top = Instance.new("Frame")
        
    Top.Name = "Top"
    Top.Parent = SwXLib
    Top.BackgroundColor3 = Color3.fromRGB(52, 52, 52)
    Top.BackgroundTransparency = 0.500
    Top.BorderSizePixel = 0
    Top.Size = UDim2.new(0, 0, 0, 65)
    Top.ClipsDescendants = true
    TweenService:Create(Top,TweenInfo.new(0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{Size = UDim2.new(0, 1679, 0, 65)}):Play()    

    local HomeButton = Instance.new("ImageButton")
    local ScrollingTab = Instance.new("ScrollingFrame")
    local UIListLayout_Tab = Instance.new("UIListLayout")
    local UIPadding_Tab = Instance.new("UIPadding")

    HomeButton.Name = "HomeButton"
    HomeButton.Parent = Top
    HomeButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    HomeButton.BackgroundTransparency = 1.000
    HomeButton.Position = UDim2.new(0.00892857183, 0, 0.0461538471, 0)
    HomeButton.Size = UDim2.new(0, 59, 0, 59)
    HomeButton.Image = "rbxassetid://11940135535"
    
    ScrollingTab.Name = "ScrollingTab"
    ScrollingTab.Parent = Top
    ScrollingTab.Active = true
    ScrollingTab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ScrollingTab.BackgroundTransparency = 1.000
    ScrollingTab.BorderSizePixel = 0
    ScrollingTab.Position = UDim2.new(0.1586501, 0, 0.200000003, 0)
    ScrollingTab.Size = UDim2.new(0, 1146, 0, 39)
    ScrollingTab.CanvasSize = UDim2.new(0, 0, 0, 0)
    ScrollingTab.ScrollBarThickness = 0

    UIListLayout_Tab.Name = "UIListLayout_Tab"
    UIListLayout_Tab.Parent = ScrollingTab
    UIListLayout_Tab.FillDirection = Enum.FillDirection.Horizontal
    UIListLayout_Tab.SortOrder = Enum.SortOrder.LayoutOrder
    UIListLayout_Tab.Padding = UDim.new(0, 10)
    
    UIPadding_Tab.Name = "UIPadding_Tab"
    UIPadding_Tab.Parent = ScrollingTab
    UIPadding_Tab.PaddingLeft = UDim.new(0, 10)

    local Main = Instance.new("Frame")
    local UICornerMain = Instance.new("UICorner")
    local ImageLabel = Instance.new("ImageLabel")
    local Page = Instance.new("Frame")
    local UICorner = Instance.new("UICorner")

        
    Main.Name = "Main"
    Main.Parent = SwXLib
    Main.AnchorPoint = Vector2.new(0.5, 0.5)
    Main.BackgroundColor3 = Color3.fromRGB(17, 17, 17)
    Main.ClipsDescendants = true
    Main.Position = UDim2.new(0.499702215, 0, 0.5, 0)
    Main.Size = UDim2.new(0, 0, 0, 0)
    Main.ClipsDescendants = true
    TweenService:Create(Main,TweenInfo.new(0.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out),{Size = UDim2.new(0, 1441, 0, 810)}):Play() 

    UICornerMain.CornerRadius = UDim.new(0, 10)
    UICornerMain.Name = "UICorner-Main"
    UICornerMain.Parent = Main

    ImageLabel.Parent = Main
    ImageLabel.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
    ImageLabel.BackgroundTransparency = 1.000
    ImageLabel.Position = UDim2.new(0.0117973629, 0, -0.476543188, 0)
    ImageLabel.Size = UDim2.new(0, 1407, 0, 1518)
    ImageLabel.Image = "http://www.roblox.com/asset/?id=11960621607"
    ImageLabel.ImageTransparency = 0.500

    Page.Name = "Page"
    Page.Parent = Main
    Page.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
    Page.BackgroundTransparency = 0.150
    Page.Position = UDim2.new(0.0138792507, 0, 0.0320987664, 0)
    Page.Size = UDim2.new(0, 1400, 0, 758)
    Page.ClipsDescendants = true

    UICorner.CornerRadius = UDim.new(0, 10)
    UICorner.Parent = Page

    local FolderPage = Instance.new("Folder")
    local UIPageLayout = Instance.new("UIPageLayout")

    FolderPage.Name = "FolderPage"
    FolderPage.Parent = Page

    UIPageLayout.Parent = FolderPage
    UIPageLayout.SortOrder = Enum.SortOrder.LayoutOrder
    UIPageLayout.Padding = UDim.new(0, 15)
    UIPageLayout.TweenTime = 0.500
    uihide = false
    UserInputService.InputBegan:Connect(function(input)
		if input.KeyCode == Enum.KeyCode.RightControl then
			if uihide == false then
				uihide = true
                pcall(Main:TweenSize(UDim2.new(0, 0, 0, 0),"In","Quad",0.4,true)) wait()
                pcall(Top:TweenSize(UDim2.new(0, 0, 0, 65),"In","Quad",0.2,true)) wait()
                TweenService:Create(
                    blur,
                    TweenInfo.new(.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out,0.1),
                    {Size = 0}
                ):Play()
			else
				uihide = false
				pcall(Main:TweenSize(UDim2.new(0, 1441, 0, 810),"Out","Back",0.4,true)) wait()
				pcall(Top:TweenSize(UDim2.new(0, 1679, 0, 65),"Out","Back",0.2,true)) wait()
                TweenService:Create(
                    blur,
                    TweenInfo.new(.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out,0.1),
                    {Size = 30}
                ):Play()
			end
		end
	end)

    local tabs = {}

    function tabs:Tab(options)
        local TitleHander = options.titel
        local LogoIcon = options.logo

        if LogoIcon == nil then
            LogoIcon = '11960621607'
        end

        local TabFrame = Instance.new("Frame")
        local TabUICorner = Instance.new("UICorner")
        local IconTab = Instance.new("ImageLabel")
        local TabHeadle = Instance.new("TextLabel")
        local TabButton = Instance.new("TextButton")

        TabFrame.Name = "TabFrame"
        TabFrame.Parent = ScrollingTab
        TabFrame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
        TabFrame.BackgroundTransparency = 0.150
        TabFrame.ClipsDescendants = true
        TabFrame.Size = UDim2.new(0, 185, 0, 39)

        TabUICorner.CornerRadius = UDim.new(0, 5)
        TabUICorner.Name = "TabUICorner"
        TabUICorner.Parent = TabFrame

        IconTab.Name = "IconTab"
        IconTab.Parent = TabFrame
        IconTab.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        IconTab.BackgroundTransparency = 1.000
        IconTab.Position = UDim2.new(0.0396396443, 0, 0.0769230798, 0)
        IconTab.Size = UDim2.new(0, 35, 0, 33)
        IconTab.Image = "rbxassetid://"..LogoIcon

        TabHeadle.Name = "TabHeadle"
        TabHeadle.Parent = TabFrame
        TabHeadle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabHeadle.BackgroundTransparency = 1.000
        TabHeadle.BorderColor3 = Color3.fromRGB(27, 42, 53)
        TabHeadle.Position = UDim2.new(0.266723961, 0, 0.128205135, 0)
        TabHeadle.Size = UDim2.new(0, 135, 0, 28)
        TabHeadle.Font = Enum.Font.GothamBold
        TabHeadle.Text = TitleHander
        TabHeadle.TextColor3 = Color3.fromRGB(193, 193, 193)
        TabHeadle.TextSize = 14.000
        TabHeadle.TextXAlignment = Enum.TextXAlignment.Left

        TabButton.Name = "TabButton"
        TabButton.Parent = TabFrame
        TabButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        TabButton.BackgroundTransparency = 1.000
        TabButton.Size = UDim2.new(0, 185, 0, 39)
        TabButton.Font = Enum.Font.SourceSans
        TabButton.Text = ""
        TabButton.TextColor3 = Color3.fromRGB(0, 0, 0)
        TabButton.TextSize = 14.000

        local PageMain = Instance.new("Frame")
        local ScrollingPage = Instance.new("ScrollingFrame")
        local UIListLayoutPage = Instance.new("UIListLayout")
        local UIPaddingPage = Instance.new("UIPadding")

        PageMain.Name = "PageMain"
        PageMain.Parent = FolderPage
        PageMain.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        PageMain.BackgroundTransparency = 1.000
        PageMain.Position = UDim2.new(0.0138792507, 0, 0.0320987664, 0)
        PageMain.Size = UDim2.new(0, 1400, 0, 758)
        
        ScrollingPage.Name = "Scrolling Page"
        ScrollingPage.Parent = PageMain
        ScrollingPage.Active = true
        ScrollingPage.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        ScrollingPage.BackgroundTransparency = 1.000
        ScrollingPage.BorderSizePixel = 0
        ScrollingPage.Size = UDim2.new(0, 1400, 0, 758)
        ScrollingPage.ScrollBarThickness = 0
        ScrollingPage.CanvasSize = UDim2.new(0, 0, 0, 0)

        UIListLayoutPage.Name = "UIListLayout Page"
        UIListLayoutPage.Parent = ScrollingPage
        UIListLayoutPage.FillDirection = Enum.FillDirection.Horizontal
        UIListLayoutPage.SortOrder = Enum.SortOrder.LayoutOrder

        UIPaddingPage.Name = "UIPadding Page"
        UIPaddingPage.Parent = ScrollingPage
        UIPaddingPage.PaddingLeft = UDim.new(0, 10)
        UIPaddingPage.PaddingTop = UDim.new(0, 10)

        local Pageleft = Instance.new("Frame")
        local UIListLayoutPageleft = Instance.new("UIListLayout")
        local UIPaddingPageleft = Instance.new("UIPadding")

        Pageleft.Name = "Pageleft"
        Pageleft.Parent = ScrollingPage
        Pageleft.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Pageleft.BackgroundTransparency = 1.000
        Pageleft.Size = UDim2.new(0, 693, 0, 755)

        UIListLayoutPageleft.Name = "UIListLayout Pageleft"
        UIListLayoutPageleft.Parent = Pageleft
        UIListLayoutPageleft.SortOrder = Enum.SortOrder.LayoutOrder
        UIListLayoutPageleft.Padding = UDim.new(0, 5)

        UIPaddingPageleft.Name = "UIPadding Pageleft"
        UIPaddingPageleft.Parent = Pageleft
        UIPaddingPageleft.PaddingLeft = UDim.new(0, 5)
        UIPaddingPageleft.PaddingTop = UDim.new(0, 10)

        local Pageright = Instance.new("Frame")
        local UIListLayoutPageright = Instance.new("UIListLayout")
        local UIPaddingPageright = Instance.new("UIPadding")
        
        Pageright.Name = "Pageright"
        Pageright.Parent = ScrollingPage
        Pageright.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
        Pageright.BackgroundTransparency = 1.000
        Pageright.Size = UDim2.new(0, 693, 0, 755)

        UIListLayoutPageright.Name = "UIListLayout Pageright"
        UIListLayoutPageright.Parent = Pageright
        UIListLayoutPageright.SortOrder = Enum.SortOrder.LayoutOrder
        UIListLayoutPageright.Padding = UDim.new(0, 5)

        UIPaddingPageright.Name = "UIPadding Pageright"
        UIPaddingPageright.Parent = Pageright
        UIPaddingPageright.PaddingLeft = UDim.new(0, 5)
        UIPaddingPageright.PaddingTop = UDim.new(0, 10)

        game:GetService("RunService").Stepped:Connect(function()
            if UIListLayoutPageleft.AbsoluteContentSize.Y > UIListLayoutPageright.AbsoluteContentSize.Y then
                ScrollingPage.CanvasSize = UDim2.new(0, 0, 0, UIListLayoutPageleft.AbsoluteContentSize.Y + 10)
            end
        end)
        game:GetService("RunService").Stepped:Connect(function()
            if UIListLayoutPageright.AbsoluteContentSize.Y > UIListLayoutPageleft.AbsoluteContentSize.Y then
                ScrollingPage.CanvasSize = UDim2.new(0, 0, 0, UIListLayoutPageright.AbsoluteContentSize.Y + 10)
            end
        end)

        game:GetService("RunService").Stepped:Connect(function()
            Pageleft.Size = UDim2.new(0, 693, 0, UIListLayoutPageleft.AbsoluteContentSize.Y + 5)
        end)
        game:GetService("RunService").Stepped:Connect(function()
            Pageright.Size = UDim2.new(0, 693, 0, UIListLayoutPageright.AbsoluteContentSize.Y + 5)
        end)

        game:GetService("RunService").Stepped:Connect(function()
            pcall(function()
                ScrollingTab.CanvasSize = UDim2.new(0,UIListLayout_Tab.AbsoluteContentSize.X + 10,0,0)
            end)
        end)

        local currenttab = ""
        abc = false
        TabButton.MouseButton1Click:connect(function()
            for i,v in next, ScrollingTab:GetChildren() do
                if v:IsA("Frame") then
                    TweenService:Create(
                        v,
                        TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}
                    ):Play()
                end
                TweenService:Create(
                    TabFrame,
                    TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                    {BackgroundColor3 = Color3.fromRGB(20, 20, 20)}
                ):Play()
            end
            for i,v in next, FolderPage:GetChildren() do 
                if v.Name == "PageMain" then
                    currenttab = v.Name
                end
                UIPageLayout:JumpTo(PageMain)
            end
        end
        )

		if abc == false then
            for i,v in next, ScrollingTab:GetChildren() do
                if v:IsA("Frame") then
                    TweenService:Create(
                        v,
                        TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(20, 20, 20)}
                    ):Play()
                end
                TweenService:Create(
                    TabFrame,
                    TweenInfo.new(0.3,Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                    {BackgroundColor3 = Color3.fromRGB(35, 35, 35)}
                ):Play()
            end
            UIPageLayout:JumpToIndex(0)
			abc = true
		end



        local LibraryPage = {}

        function LibraryPage:Page(type)
            local function GetType(value)
                if value == 1 then
                    return Pageleft
                elseif value == 2 then
                    return Pageright
                else
                    return Pageleft
                end
            end  

            local Container_Page = Instance.new("Frame")
            local UICornerContainer_Page = Instance.new("UICorner")
            local UIPaddingContainer_Page = Instance.new("UIPadding")
            local UIListLayoutContainer_Page = Instance.new("UIListLayout")
     
            Container_Page.Name = "Container_Page"
            Container_Page.Parent = GetType(type)
            Container_Page.BackgroundColor3 = Color3.fromRGB(9, 9, 9)
            Container_Page.BackgroundTransparency = 0.200
            Container_Page.Position = UDim2.new(0.0127974451, 0, 0.0141784344, 0)
            Container_Page.Size = UDim2.new(0, 680, 0, 736)

            UICornerContainer_Page.CornerRadius = UDim.new(0, 10)
            UICornerContainer_Page.Name = "UICorner Container_Page"
            UICornerContainer_Page.Parent = Container_Page

            UIPaddingContainer_Page.Name = "UIPadding Container_Page"
            UIPaddingContainer_Page.Parent = Container_Page
            UIPaddingContainer_Page.PaddingLeft = UDim.new(0, 15)
            UIPaddingContainer_Page.PaddingTop = UDim.new(0, 20)

            UIListLayoutContainer_Page.Name = "UIListLayout Container_Page"
            UIListLayoutContainer_Page.Parent = Container_Page
            UIListLayoutContainer_Page.SortOrder = Enum.SortOrder.LayoutOrder
            UIListLayoutContainer_Page.Padding = UDim.new(0, 15)

            game:GetService("RunService").Stepped:Connect(function()
                Container_Page.Size =  UDim2.new(0, 680, 0,UIListLayoutContainer_Page.AbsoluteContentSize.Y + 35)
            end)
            local libitem = {}
            function libitem:Button(title,des,logo,callback)
                local ButtonFrame = Instance.new("Frame")
                local UICornerToggleFrame_2 = Instance.new("UICorner")
                local Hander_Button = Instance.new("TextLabel")
                local DesTitle_Button = Instance.new("TextLabel")
                local ButtonFrameMain = Instance.new("Frame")
                local UICornerButtonFrameMain = Instance.new("UICorner")
                local Imageclick = Instance.new("ImageLabel")
                local Presshere = Instance.new("TextLabel")
                local imgbutton = Instance.new("ImageLabel")
                local Button = Instance.new("TextButton")
                if logo == nil or logo == 0 then
                    logo = '6031229361'
                end
                ButtonFrame.Name = "ButtonFrame"
                ButtonFrame.Parent = Container_Page
                ButtonFrame.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
                ButtonFrame.BackgroundTransparency = 0.550
                ButtonFrame.Position = UDim2.new(0.106766917, 0, 0.00440528616, 0)
                ButtonFrame.Size = UDim2.new(0, 645, 0, 169)

                UICornerToggleFrame_2.Name = "UICorner ToggleFrame"
                UICornerToggleFrame_2.Parent = ButtonFrame

                Hander_Button.Name = "Hander_Button"
                Hander_Button.Parent = ButtonFrame
                Hander_Button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Hander_Button.BackgroundTransparency = 1.000
                Hander_Button.Position = UDim2.new(0.0294573642, 0, 0.00591715984, 0)
                Hander_Button.Size = UDim2.new(0, 409, 0, 43)
                Hander_Button.Font = Enum.Font.GothamBold
                Hander_Button.Text = title
                Hander_Button.TextColor3 = Color3.fromRGB(245, 245, 245)
                Hander_Button.TextSize = 24.000
                Hander_Button.TextXAlignment = Enum.TextXAlignment.Left

                DesTitle_Button.Name = "DesTitle_Button"
                DesTitle_Button.Parent = ButtonFrame
                DesTitle_Button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                DesTitle_Button.BackgroundTransparency = 1.000
                DesTitle_Button.Position = UDim2.new(0.0294573642, 0, 0.260355026, 0)
                DesTitle_Button.Size = UDim2.new(0, 409, 0, 65)
                DesTitle_Button.Font = Enum.Font.GothamMedium
                DesTitle_Button.Text = des
                DesTitle_Button.TextColor3 = Color3.fromRGB(175, 175, 175)
                DesTitle_Button.TextSize = 19.000
                DesTitle_Button.TextWrapped = true
                DesTitle_Button.TextXAlignment = Enum.TextXAlignment.Left
                DesTitle_Button.TextYAlignment = Enum.TextYAlignment.Top

                ButtonFrameMain.Name = "ButtonFrameMain"
                ButtonFrameMain.Parent = ButtonFrame
                ButtonFrameMain.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
                ButtonFrameMain.ClipsDescendants = true
                ButtonFrameMain.Position = UDim2.new(0.0217054263, 0, 0.686390519, 0)
                ButtonFrameMain.Size = UDim2.new(0, 419, 0, 40)

                UICornerButtonFrameMain.CornerRadius = UDim.new(0, 5)
                UICornerButtonFrameMain.Name = "UICornerButtonFrameMain"
                UICornerButtonFrameMain.Parent = ButtonFrameMain

                Imageclick.Name = "Imageclick"
                Imageclick.Parent = ButtonFrameMain
                Imageclick.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Imageclick.BackgroundTransparency = 1.000
                Imageclick.BorderColor3 = Color3.fromRGB(27, 42, 53)
                Imageclick.Position = UDim2.new(0.909307897, 0, 0.075000003, 0)
                Imageclick.Rotation = -12.000
                Imageclick.Size = UDim2.new(0, 33, 0, 33)
                Imageclick.Image = "http://www.roblox.com/asset/?id="..logo

                Presshere.Name = "Presshere"
                Presshere.Parent = ButtonFrameMain
                Presshere.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Presshere.BackgroundTransparency = 1.000
                Presshere.Position = UDim2.new(0.011933174, 0, 0.075000003, 0)
                Presshere.Size = UDim2.new(0, 376, 0, 37)
                Presshere.Font = Enum.Font.GothamBold
                Presshere.Text = "Press here to work!"
                Presshere.TextColor3 = Color3.fromRGB(255, 255, 255)
                Presshere.TextSize = 19.000
                Presshere.TextTransparency = 0.5

                imgbutton.Name = "imgbutton"
                imgbutton.Parent = ButtonFrame
                imgbutton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                imgbutton.BackgroundTransparency = 1.000
                imgbutton.ClipsDescendants = true
                imgbutton.Position = UDim2.new(0.722480655, 0, 0.00591715984, 0)
                imgbutton.Size = UDim2.new(0, 169, 0, 169)
                imgbutton.Image = "rbxassetid://11960621607"

                Button.Name = "Button"
                Button.Parent = ButtonFrame
                Button.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Button.BackgroundTransparency = 1.000
                Button.Position = UDim2.new(0.0217054263, 0, 0.65680474, 0)
                Button.Size = UDim2.new(0, 418, 0, 50)
                Button.Font = Enum.Font.SourceSans
                Button.Text = ""
                Button.TextColor3 = Color3.fromRGB(0, 0, 0)
                Button.TextSize = 14.000

                Button.MouseEnter:Connect(function()
                    TweenService:Create(
                        Presshere,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out,0.1),
                        {TextTransparency = 0}
                    ):Play()
                end)
        
                Presshere.MouseLeave:Connect(function()
                    TweenService:Create(
                        Presshere,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out,0.1),
                        {TextTransparency = 0.5}
                    ):Play()
                end)
        
                Button.MouseButton1Click:Connect(function()

                    CircleAnim(ButtonFrameMain, Color3.fromRGB(25,25,25), Color3.fromRGB(25,25,25))
                    callback()
                end
                )
            end
            function libitem:Dropdown(text,item,default,callback)
                local DropFrame = Instance.new("Frame")
                local UICornerDropFrame = Instance.new("UICorner")
                local Drop = Instance.new("Frame")
                local UICornerDrop = Instance.new("UICorner")
                local ImgDrop = Instance.new("ImageLabel")
                local LabelDrop = Instance.new("TextLabel")
                local Hander_Drop = Instance.new("TextLabel")
                local DropButton = Instance.new("TextButton")
                local Down = Instance.new("Frame")
                local UICornerDownFrame = Instance.new("UICorner")
                local DownFrame = Instance.new("Frame")
                local UICornerDown = Instance.new("UICorner")
                local ScrollingDown = Instance.new("ScrollingFrame")
                local UIListLayoutDown = Instance.new("UIListLayout")
                local UIPaddingDown = Instance.new("UIPadding")
                local DropToggle = false 
                local Dropfunc = {}

                if default == nil then default = "nil" end

                if default ~= "nil" or default ~= nil then
                    callback(default)
                end

                DropFrame.Name = "DropFrame"
                DropFrame.Parent = Container_Page
                DropFrame.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
                DropFrame.BackgroundTransparency = 0.550
                DropFrame.Position = UDim2.new(0, 0, 0.513966501, 0)
                DropFrame.Size = UDim2.new(0, 645, 0, 110)

                UICornerDropFrame.Name = "UICorner DropFrame"
                UICornerDropFrame.Parent = DropFrame

                Drop.Name = "Drop"
                Drop.Parent = DropFrame
                Drop.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
                Drop.Position = UDim2.new(0.0294573642, 0, 0.463636369, 0)
                Drop.Size = UDim2.new(0, 604, 0, 49)
                Drop.ClipsDescendants = true

                UICornerDrop.Name = "UICorner Drop"
                UICornerDrop.Parent = Drop

                ImgDrop.Name = "ImgDrop"
                ImgDrop.Parent = Drop
                ImgDrop.AnchorPoint = Vector2.new(0.5, 0.5)
                ImgDrop.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ImgDrop.BackgroundTransparency = 1.000
                ImgDrop.Position = UDim2.new(0.930452824, 0, 0.489795923, 0)
                ImgDrop.Rotation = 90.000
                ImgDrop.Size = UDim2.new(0, 45, 0, 45)
                ImgDrop.Image = "rbxassetid://6026663699"
                ImgDrop.ImageColor3 = Color3.fromRGB(190, 190, 190)

                LabelDrop.Name = "LabelDrop"
                LabelDrop.Parent = Drop
                LabelDrop.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                LabelDrop.BackgroundTransparency = 1.000
                LabelDrop.Position = UDim2.new(0.0546357632, 0, 0.0408163257, 0)
                LabelDrop.Size = UDim2.new(0, 453, 0, 45)
                LabelDrop.Font = Enum.Font.GothamBold
                LabelDrop.Text = text.." : "..default
                LabelDrop.TextColor3 = Color3.fromRGB(255, 255, 255)
                LabelDrop.TextSize = 19.000
                LabelDrop.TextXAlignment = Enum.TextXAlignment.Left

                Hander_Drop.Name = "Hander_Drop"
                Hander_Drop.Parent = DropFrame
                Hander_Drop.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Hander_Drop.BackgroundTransparency = 1.000
                Hander_Drop.Position = UDim2.new(0.0294573642, 0, 0.00591715984, 0)
                Hander_Drop.Size = UDim2.new(0, 409, 0, 43)
                Hander_Drop.Font = Enum.Font.GothamBold
                Hander_Drop.Text = text
                Hander_Drop.TextColor3 = Color3.fromRGB(245, 245, 245)
                Hander_Drop.TextSize = 24.000
                Hander_Drop.TextXAlignment = Enum.TextXAlignment.Left

                DropButton.Name = "Drop Button"
                DropButton.Parent = DropFrame
                DropButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                DropButton.BackgroundTransparency = 1.000
                DropButton.Position = UDim2.new(0.0356589146, 0, 0.463636369, 0)
                DropButton.Size = UDim2.new(0, 604, 0, 49)
                DropButton.Font = Enum.Font.SourceSans
                DropButton.Text = ""
                DropButton.TextColor3 = Color3.fromRGB(0, 0, 0)
                DropButton.TextSize = 14.000

                Down.Name = "Down"
                Down.Parent = Container_Page
                Down.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
                Down.BackgroundTransparency = 0.550
                Down.ClipsDescendants = true
                Down.Position = UDim2.new(0, 0, 0.530107498, 0)
                Down.Size = UDim2.new(0, 645, 0, 0)
                Down.ClipsDescendants = true

                UICornerDownFrame.Name = "UICorner DownFrame"
                UICornerDownFrame.Parent = Down

                DownFrame.Name = "DownFrame"
                DownFrame.Parent = Down
                DownFrame.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
                DownFrame.Position = UDim2.new(0.0356589146, 0, 0.0910610259, 0)
                DownFrame.Size = UDim2.new(0, 604, 0, 203)

                UICornerDown.Name = "UICorner Down"
                UICornerDown.Parent = DownFrame

                ScrollingDown.Name = "Scrolling Down"
                ScrollingDown.Parent = DownFrame
                ScrollingDown.Active = true
                ScrollingDown.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                ScrollingDown.BackgroundTransparency = 1.000
                ScrollingDown.Size = UDim2.new(0, 600, 0, 203)
                ScrollingDown.ScrollBarThickness = 0
                ScrollingDown.CanvasSize = UDim2.new(0, 0, 0, 0)

                UIListLayoutDown.Name = "UIListLayout Down"
                UIListLayoutDown.Parent = ScrollingDown
                UIListLayoutDown.SortOrder = Enum.SortOrder.LayoutOrder
                UIListLayoutDown.Padding = UDim.new(0, 10)

                UIPaddingDown.Name = "UIPadding Down"
                UIPaddingDown.Parent = ScrollingDown
                UIPaddingDown.PaddingLeft = UDim.new(0, 15)
                UIPaddingDown.PaddingTop = UDim.new(0, 15)


                DropButton.MouseButton1Click:Connect(function()
                    if DropToggle == false then
                        DropToggle = true
                        CircleAnim(Drop, Color3.fromRGB(25,25,25), Color3.fromRGB(25,25,25))
                        TweenService:Create(
                            ImgDrop,
                            TweenInfo.new(0.2, Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                            {Size = UDim2.new(0, 25, 0, 25)}
                        ):Play()
                        wait()
                        TweenService:Create(
                            ImgDrop,
                            TweenInfo.new(0.2, Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                            {Size = UDim2.new(0, 45, 0, 45)}
                        ):Play()
                        wait()
                        TweenService:Create(
                            Down,
                            TweenInfo.new(0.2, Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                            {Size = UDim2.new(0, 645, 0, 250)}
                        ):Play()

                    elseif DropToggle == true then
                        DropToggle = false
                        CircleAnim(Drop, Color3.fromRGB(25,25,25), Color3.fromRGB(25,25,25))
                        TweenService:Create(
                            ImgDrop,
                            TweenInfo.new(0.2, Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                            {Size = UDim2.new(0, 25, 0, 25)}
                        ):Play()
                        wait()
                        TweenService:Create(
                            ImgDrop,
                            TweenInfo.new(0.2, Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                            {Size = UDim2.new(0, 45, 0, 45)}
                        ):Play()
                        wait()
                        TweenService:Create(
                            Down,
                            TweenInfo.new(0.2, Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                            {Size = UDim2.new(0, 645, 0, 0)}
                        ):Play()

                    end
                end
                )

                for i,v in pairs(item) do
                    local ItemFrame = Instance.new("Frame")
                    local UICornerItem = Instance.new("UICorner")
                    local HanderItem = Instance.new("TextLabel")
                    local ItemButton = Instance.new("TextButton")
                    
                    ItemFrame.Name = "Item Frame"
                    ItemFrame.Parent = ScrollingDown
                    ItemFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
                    ItemFrame.Size = UDim2.new(0, 575, 0, 52)
                    ItemFrame.ClipsDescendants = true

                    UICornerItem.Name = "UICorner Item"
                    UICornerItem.Parent = ItemFrame

                    HanderItem.Name = "Hander Item"
                    HanderItem.Parent = ItemFrame
                    HanderItem.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    HanderItem.BackgroundTransparency = 1.000
                    HanderItem.Size = UDim2.new(0, 575, 0, 52)
                    HanderItem.Font = Enum.Font.GothamBold
                    HanderItem.Text = v
                    HanderItem.TextColor3 = Color3.fromRGB(255, 255, 255)
                    HanderItem.TextSize = 20.000

                    ItemButton.Name = "Item Button"
                    ItemButton.Parent = ItemFrame
                    ItemButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    ItemButton.BackgroundTransparency = 1.000
                    ItemButton.Size = UDim2.new(0, 575, 0, 52)
                    ItemButton.Font = Enum.Font.SourceSans
                    ItemButton.Text = ""
                    ItemButton.TextColor3 = Color3.fromRGB(0, 0, 0)
                    ItemButton.TextSize = 14.000

                    ItemButton.MouseButton1Click:Connect(function()
                        LabelDrop.Text = tostring(text.." : "..v)
                        CircleAnim(ItemFrame,Color3.fromRGB(150,150,150),Color3.fromRGB(150,150,150))
                        callback(v)
                    end)

                end
                ScrollingDown.CanvasSize = UDim2.new(0,0,0,UIListLayoutDown.AbsoluteContentSize.Y + 25)
                
                function Dropfunc:Clear()
                    DropToggle = false
                    LabelDrop.Text = tostring(text).." : "
                    TweenService:Create(
                        Down,
                        TweenInfo.new(0.2, Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                        {Size = UDim2.new(0, 645, 0, 0)}
                    ):Play()
                    for i, v in next, ScrollingDown:GetChildren() do
                        if v:IsA("Frame") then
                            v:Destroy()
                        end
                    end
                    ScrollingDown.CanvasSize = UDim2.new(0,0,0,UIListLayoutDown.AbsoluteContentSize.Y + 25)
                end

                function Dropfunc:Add(Nameitem)
                    local ItemFrame = Instance.new("Frame")
                    local UICornerItem = Instance.new("UICorner")
                    local HanderItem = Instance.new("TextLabel")
                    local ItemButton = Instance.new("TextButton")
                    
                    ItemFrame.Name = "Item Frame"
                    ItemFrame.Parent = ScrollingDown
                    ItemFrame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
                    ItemFrame.Size = UDim2.new(0, 575, 0, 52)
                    ItemFrame.ClipsDescendants = true

                    UICornerItem.Name = "UICorner Item"
                    UICornerItem.Parent = ItemFrame

                    HanderItem.Name = "Hander Item"
                    HanderItem.Parent = ItemFrame
                    HanderItem.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    HanderItem.BackgroundTransparency = 1.000
                    HanderItem.Size = UDim2.new(0, 575, 0, 52)
                    HanderItem.Font = Enum.Font.GothamBold
                    HanderItem.Text = Nameitem
                    HanderItem.TextColor3 = Color3.fromRGB(255, 255, 255)
                    HanderItem.TextSize = 20.000

                    ItemButton.Name = "Item Button"
                    ItemButton.Parent = ItemFrame
                    ItemButton.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                    ItemButton.BackgroundTransparency = 1.000
                    ItemButton.Size = UDim2.new(0, 575, 0, 52)
                    ItemButton.Font = Enum.Font.SourceSans
                    ItemButton.Text = ""
                    ItemButton.TextColor3 = Color3.fromRGB(0, 0, 0)
                    ItemButton.TextSize = 14.000

                    ItemButton.MouseButton1Click:Connect(function()
                        LabelDrop.Text = tostring(text.." : "..Nameitem)
                        CircleAnim(ItemFrame,Color3.fromRGB(150,150,150),Color3.fromRGB(150,150,150))
                        callback(Nameitem)
                    end)
                    ScrollingDown.CanvasSize = UDim2.new(0,0,0,UIListLayoutDown.AbsoluteContentSize.Y + 25)
                end
                return Dropfunc
            end
            function libitem:Slider(text,floor,min,max,de,callback)
                local SliderFrame = Instance.new("Frame")
                local UICornerSlider = Instance.new("UICorner")
                local Hander_Slider = Instance.new("TextLabel")
                local CustomValue = Instance.new("TextBox")
                local CustomValueUICorner = Instance.new("UICorner")
                local ValueFrame = Instance.new("Frame")
                local ValueFrameUICorner = Instance.new("UICorner")
                local PartValue = Instance.new("Frame")
                local PartValueUICorner = Instance.new("UICorner")
                local MainValue = Instance.new("Frame")
                local MainValueUICorner = Instance.new("UICorner")
             
                local sliderfunc = {}

                SliderFrame.Name = "SliderFrame"
                SliderFrame.Parent = Container_Page
                SliderFrame.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
                SliderFrame.BackgroundTransparency = 0.550
                SliderFrame.Position = UDim2.new(0, 0, 0.696691155, 0)
                SliderFrame.Size = UDim2.new(0, 645, 0, 139)

                UICornerSlider.Name = "UICorner Slider"
                UICornerSlider.Parent = SliderFrame

                Hander_Slider.Name = "Hander_Slider"
                Hander_Slider.Parent = SliderFrame
                Hander_Slider.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Hander_Slider.BackgroundTransparency = 1.000
                Hander_Slider.Position = UDim2.new(0.0589147285, 0, 0.106636584, 0)
                Hander_Slider.Size = UDim2.new(0, 409, 0, 43)
                Hander_Slider.Font = Enum.Font.GothamBold
                Hander_Slider.Text = tostring(text)
                Hander_Slider.TextColor3 = Color3.fromRGB(245, 245, 245)
                Hander_Slider.TextSize = 24.000
                Hander_Slider.TextXAlignment = Enum.TextXAlignment.Left

                CustomValue.Name = "CustomValue"
                CustomValue.Parent = SliderFrame
                CustomValue.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
                CustomValue.Position = UDim2.new(0.789147317, 0, 0.107913673, 0)
                CustomValue.Size = UDim2.new(0, 114, 0, 36)
                CustomValue.Font = Enum.Font.GothamBold
                CustomValue.Text = "50"
                CustomValue.TextColor3 = Color3.fromRGB(255, 255, 255)
                CustomValue.TextSize = 20.000

                CustomValueUICorner.Name = "CustomValueUICorner"
                CustomValueUICorner.Parent = CustomValue

                ValueFrame.Name = "ValueFrame"
                ValueFrame.Parent = SliderFrame
                ValueFrame.AnchorPoint = Vector2.new(0.5, 0.5)
                ValueFrame.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
                ValueFrame.Position = UDim2.new(0.499224812, 0, 0.726618767, 0)
                ValueFrame.Size = UDim2.new(0, 588, 0, 26)

                ValueFrameUICorner.CornerRadius = UDim.new(0, 10)
                ValueFrameUICorner.Name = "ValueFrameUICorner"
                ValueFrameUICorner.Parent = ValueFrame

                PartValue.Name = "PartValue"
                PartValue.Parent = ValueFrame
                PartValue.AnchorPoint = Vector2.new(0.5, 0.5)
                PartValue.BackgroundColor3 = Color3.fromRGB(15, 15, 15)
                PartValue.Position = UDim2.new(0.5, 0, 0.5, 0)
                PartValue.Size = UDim2.new(0, 588, 0, 26)

                PartValueUICorner.CornerRadius = UDim.new(0, 10)
                PartValueUICorner.Name = "PartValueUICorner"
                PartValueUICorner.Parent = PartValue

                
                MainValue.Name = "MainValue"
                MainValue.Parent = PartValue
                MainValue.BackgroundColor3 = Color3.fromRGB(0, 255, 128)
                MainValue.Size = UDim2.new((de or 0) / max, 0, 0, 26)
                
                MainValueUICorner.CornerRadius = UDim.new(0, 10)
                MainValueUICorner.Name = "MainValueUICorner"
                MainValueUICorner.Parent = MainValue


                if floor == true then
                    CustomValue.Text =  tostring(de and string.format((de / max) * (max - min) + min) or 0)
                else
                    CustomValue.Text =  tostring(de and math.floor((de / max) * (max - min) + min) or 0)
                end

                local function move(input)
                    local pos =
                        UDim2.new(
                            math.clamp((input.Position.X - ValueFrame.AbsolutePosition.X) / ValueFrame.AbsoluteSize.X, 0, 1),
                            0,
                            0.5,
                            0
                        )
                    local pos1 =
                        UDim2.new(
                            math.clamp((input.Position.X - ValueFrame.AbsolutePosition.X) / ValueFrame.AbsoluteSize.X, 0, 1),
                            0,
                            0,
                            26
                        )
                    MainValue:TweenSize(pos1, "Out", "Sine", 0.2, true)

                    if floor == true then
                        local value = string.format("%.0f",((pos.X.Scale * max) / max) * (max - min) + min)
                        CustomValue.Text = tostring(value)
                        callback(value)
                    else
                        local value = math.floor(((pos.X.Scale * max) / max) * (max - min) + min)
                        CustomValue.Text = tostring(value)
                        callback(value)
                    end
                end
                local dragging = false
                SliderFrame.InputBegan:Connect(
                    function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            dragging = true
                        end
                    end)
                SliderFrame.InputEnded:Connect(
                    function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            dragging = false
                        end
                    end)
                ValueFrame.InputBegan:Connect(
                    function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            dragging = true
                        end
                    end)
                ValueFrame.InputEnded:Connect(
                    function(input)
                        if input.UserInputType == Enum.UserInputType.MouseButton1 then
                            dragging = false
                        end
                    end)
                    game:GetService("UserInputService").InputChanged:Connect(function(input)
                        if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
                            move(input)
                        end
                    end)
                    CustomValue.FocusLost:Connect(function()
                        if CustomValue.Text == "" then
                            CustomValue.Text = de
                        end
                        if  tonumber(CustomValue.Text) > max then
                            CustomValue.Text  = max
                        end
                        if  tonumber(CustomValue.Text) < min then
                            CustomValue.Text  = min
                        end
                        MainValue:TweenSize(UDim2.new((CustomValue.Text or 0) / max, 0, 0, 26), "Out", "Sine", 0.2, true)
                        if floor == true then
                            CustomValue.Text = tostring(CustomValue.Text and string.format("%.0f",(CustomValue.Text / max) * (max - min) + min) )
                        else
                            CustomValue.Text = tostring(CustomValue.Text and math.floor( (CustomValue.Text / max) * (max - min) + min) )
                        end
                        pcall(callback, CustomValue.Text)
                    end)
                    
                    function sliderfunc:Update(value)
                        MainValue:TweenSize(UDim2.new((value or 0) / max, 0, 0, 26), "Out", "Sine", 0.2, true)
                        CustomValue.Text = value
                        pcall(function()
                            callback(value)
                        end)
                    end
                    return sliderfunc
            end
            function libitem:Toggle(titel,des,icon,default,callback)
                local ToggleFrame = Instance.new("Frame")
                local IconToggle = Instance.new("ImageLabel")
                local UICornerToggleFrame = Instance.new("UICorner")
                local Hander = Instance.new("TextLabel")
                local DesTitle = Instance.new("TextLabel")
                local Toggle = Instance.new("Frame")
                local UICornerToggle = Instance.new("UICorner")
                local ToggleIner = Instance.new("Frame")
                local UICornerToggleIner = Instance.new("UICorner")
                local TextButtonToggle = Instance.new("TextButton")
                local togglechecks = false
                local Togglefunc = {}
                if default == nil then default = false end
                lockers = true

                ToggleFrame.Name = "ToggleFrame"
                ToggleFrame.Parent = Container_Page
                ToggleFrame.BackgroundColor3 = Color3.fromRGB(24, 24, 24)
                ToggleFrame.BackgroundTransparency = 0.550
                ToggleFrame.Position = UDim2.new(0.106766917, 0, 0.00440528616, 0)
                ToggleFrame.Size = UDim2.new(0, 645, 0, 169)
                
                IconToggle.Name = "IconToggle"
                IconToggle.Parent = ToggleFrame
                IconToggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                IconToggle.BackgroundTransparency = 1.000
                IconToggle.Position = UDim2.new(0.742635667, 0, 0.0177514795, 0)
                IconToggle.Size = UDim2.new(0, 166, 0, 166)
                IconToggle.Image = "http://www.roblox.com/asset/?id="..icon
                
                UICornerToggleFrame.Name = "UICorner ToggleFrame"
                UICornerToggleFrame.Parent = ToggleFrame
                
                Hander.Name = "Hander"
                Hander.Parent = ToggleFrame
                Hander.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                Hander.BackgroundTransparency = 1.000
                Hander.Position = UDim2.new(0.0294573642, 0, 0.00591715984, 0)
                Hander.Size = UDim2.new(0, 409, 0, 43)
                Hander.Font = Enum.Font.GothamBold
                Hander.Text = titel
                Hander.TextColor3 = Color3.fromRGB(245, 245, 245)
                Hander.TextSize = 24.000
                Hander.TextXAlignment = Enum.TextXAlignment.Left
                
                DesTitle.Name = "DesTitle"
                DesTitle.Parent = ToggleFrame
                DesTitle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                DesTitle.BackgroundTransparency = 1.000
                DesTitle.Position = UDim2.new(0.0294573642, 0, 0.260355026, 0)
                DesTitle.Size = UDim2.new(0, 409, 0, 65)
                DesTitle.Font = Enum.Font.GothamMedium
                DesTitle.Text = des
                DesTitle.TextColor3 = Color3.fromRGB(175, 175, 175)
                DesTitle.TextSize = 19.000
                DesTitle.TextWrapped = true
                DesTitle.TextXAlignment = Enum.TextXAlignment.Left
                DesTitle.TextYAlignment = Enum.TextYAlignment.Top
                
                Toggle.Name = "Toggle"
                Toggle.Parent = ToggleFrame
                Toggle.BackgroundColor3 = Color3.fromRGB(33, 33, 33)
                Toggle.Position = UDim2.new(0.0294573642, 0, 0.716691971, 0)
                Toggle.Size = UDim2.new(0, 80, 0, 35)
                
                UICornerToggle.CornerRadius = UDim.new(0, 99)
                UICornerToggle.Name = "UICorner Toggle"
                UICornerToggle.Parent = Toggle
                
                ToggleIner.Name = "ToggleIner"
                ToggleIner.Parent = Toggle
                ToggleIner.AnchorPoint = Vector2.new(0.5, 0.5)
                ToggleIner.BackgroundColor3 = Color3.fromRGB(18, 18, 18)
                ToggleIner.Position = UDim2.new(0.253409117, 0, 0.485714287, 0)
                ToggleIner.Size = UDim2.new(0, 27, 0, 27)
                
                UICornerToggleIner.CornerRadius = UDim.new(0, 99)
                UICornerToggleIner.Name = "UICorner ToggleIner"
                UICornerToggleIner.Parent = ToggleIner
                
                TextButtonToggle.Parent = ToggleFrame
                TextButtonToggle.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                TextButtonToggle.BackgroundTransparency = 1.000
                TextButtonToggle.Position = UDim2.new(0, 0, 0, 0)
                TextButtonToggle.Size = UDim2.new(0, 645, 0, 169)
                TextButtonToggle.Font = Enum.Font.SourceSans
                TextButtonToggle.Text = ""
                TextButtonToggle.TextColor3 = Color3.fromRGB(0, 0, 0)
                TextButtonToggle.TextSize = 14.000

                
                if default == true then
                    togglechecks = true

                    TweenService:Create(
                        ToggleIner,
                        TweenInfo.new(0.15, Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                        {Position = UDim2.new(0.656536102, 0, 0.485714287, 0)}
                    ):Play()
                    TweenService:Create(
                        ToggleIner,
                        TweenInfo.new(0.15, Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                        {Size = UDim2.new(0, 45, 0, 27)}
                    ):Play()
                    wait()
                    TweenService:Create(
                        ToggleIner,
                        TweenInfo.new(0.15, Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                        {Position = UDim2.new(0.728409111, 0, 0.485714287, 0)}
                    ):Play()
                    wait()
                    TweenService:Create(
                        ToggleIner,
                        TweenInfo.new(0.15, Enum.EasingStyle.Back,Enum.EasingDirection.Out),
                        {Size = UDim2.new(0, 27, 0, 27)}
                    ):Play()
                    wait()
                    TweenService:Create(
                        Toggle,
                        TweenInfo.new(0.15, Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(0, 255, 128)}
                    ):Play()

                    callback(true)
                end

                if default == false then
                    togglechecks = false
                    TweenService:Create(
                        ToggleIner,
                        TweenInfo.new(0.15, Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                        {Position = UDim2.new(0.326704592, 0, 0.485714287, 0)}
                    ):Play()
                    TweenService:Create(
                        ToggleIner,
                        TweenInfo.new(0.15, Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                        {Size = UDim2.new(0, 45, 0, 27)}
                    ):Play()
                    wait()
                    TweenService:Create(
                        ToggleIner,
                        TweenInfo.new(0.15, Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                        {Position = UDim2.new(0.253409117, 0, 0.485714287, 0)}
                    ):Play()
                    wait()
                    TweenService:Create(
                        ToggleIner,
                        TweenInfo.new(0.15, Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                        {Size = UDim2.new(0, 27, 0, 27)}
                    ):Play()
                    wait()
                    TweenService:Create(
                        Toggle,
                        TweenInfo.new(0.2, Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                        {BackgroundColor3 = Color3.fromRGB(33, 33, 33)}
                    ):Play()

                    callback(false)
                end

                
                TextButtonToggle.MouseButton1Click:Connect(function()
                    if togglechecks == false and lockers == true then
                        togglechecks = true

                        TweenService:Create(
                            ToggleIner,
                            TweenInfo.new(0.15, Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                            {Position = UDim2.new(0.656536102, 0, 0.485714287, 0)}
                        ):Play()
                        TweenService:Create(
                            ToggleIner,
                            TweenInfo.new(0.15, Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                            {Size = UDim2.new(0, 45, 0, 27)}
                        ):Play()
                        wait()
                        TweenService:Create(
                            ToggleIner,
                            TweenInfo.new(0.15, Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                            {Position = UDim2.new(0.728409111, 0, 0.485714287, 0)}
                        ):Play()
                        wait()
                        TweenService:Create(
                            ToggleIner,
                            TweenInfo.new(0.15, Enum.EasingStyle.Back,Enum.EasingDirection.Out),
                            {Size = UDim2.new(0, 27, 0, 27)}
                        ):Play()
                        wait()
                        TweenService:Create(
                            Toggle,
                            TweenInfo.new(0.15, Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(0, 255, 128)}
                        ):Play()
                        callback(true)
                    elseif togglechecks == true and lockers == true then
                        togglechecks = false
                        TweenService:Create(
                            ToggleIner,
                            TweenInfo.new(0.15, Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                            {Position = UDim2.new(0.326704592, 0, 0.485714287, 0)}
                        ):Play()
                        TweenService:Create(
                            ToggleIner,
                            TweenInfo.new(0.15, Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                            {Size = UDim2.new(0, 45, 0, 27)}
                        ):Play()
                        wait()
                        TweenService:Create(
                            ToggleIner,
                            TweenInfo.new(0.15, Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                            {Position = UDim2.new(0.253409117, 0, 0.485714287, 0)}
                        ):Play()
                        wait()
                        TweenService:Create(
                            ToggleIner,
                            TweenInfo.new(0.15, Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                            {Size = UDim2.new(0, 27, 0, 27)}
                        ):Play()
                        wait()
                        TweenService:Create(
                            Toggle,
                            TweenInfo.new(0.2, Enum.EasingStyle.Quad,Enum.EasingDirection.Out),
                            {BackgroundColor3 = Color3.fromRGB(33, 33, 33)}
                        ):Play()
                        callback(false)
                    end
                end
                )

                local LockerFrame = Instance.new("Frame")
                local LockIcon = Instance.new("ImageLabel")


                LockerFrame.Name = "LockerFrame"
                LockerFrame.Parent = ToggleFrame
                LockerFrame.Active = true
                LockerFrame.BackgroundColor3 = Color3.fromRGB(10, 10, 10)
                LockerFrame.BackgroundTransparency = 0.200
                LockerFrame.BorderSizePixel = 0
                LockerFrame.ClipsDescendants = true
                LockerFrame.Position = UDim2.new(-0.0022222228, 0, 0, 0)
                LockerFrame.Size = UDim2.new(0, 645, 0, 169)
                LockerFrame.BackgroundTransparency = 1

                LockIcon.Name = "LockIcon"
                LockIcon.Parent = LockerFrame
                LockIcon.AnchorPoint = Vector2.new(0.5, 0.5)
                LockIcon.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
                LockIcon.BackgroundTransparency = 1.000
                LockIcon.Position = UDim2.new(0.5, 0, 0.5, 0)
                LockIcon.Size = UDim2.new(0, 0, 0, 0)
                LockIcon.Image = "http://www.roblox.com/asset/?id=3926305904"
                LockIcon.ImageRectOffset = Vector2.new(404, 364)
                LockIcon.ImageRectSize = Vector2.new(36, 36)
                LockIcon.ImageColor3 = Color3.fromRGB(255,25,25)
                function Togglefunc:Lock()
                    lockers = false
                    TweenService:Create(
                        LockerFrame,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out,0.1),
                        {BackgroundTransparency = 0.45}
                    ):Play()
                    wait()
                    TweenService:Create(
                        LockIcon,
                        TweenInfo.new(.2, Enum.EasingStyle.Back, Enum.EasingDirection.Out,0.1),
                        {Size = UDim2.new(0, 45, 0, 45)}
                    ):Play()
                end
                function Togglefunc:Unlock()
                    lockers = true
                    TweenService:Create(
                        LockerFrame,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out,0.1),
                        {BackgroundTransparency = 1}
                    ):Play()
                    wait()
                    TweenService:Create(
                        LockIcon,
                        TweenInfo.new(.2, Enum.EasingStyle.Quad, Enum.EasingDirection.Out,0.1),
                        {Size = UDim2.new(0, 0, 0, 0)}
                    ):Play()
                end
                return Togglefunc
            end
            return libitem
        end
        return LibraryPage
    end
    return tabs
end

local ui = lib:main()
local Tab1 = ui:Tab({titel = "Main" })
local Tab2 = ui:Tab({titel = "Main1" })
local Page1 = Tab1:Page(1)
local Page2 = Tab1:Page(2)

local versionx = "1.0.0"

---// Loading Section \\---
task.wait(2)
repeat  task.wait() until game:IsLoaded()
if game.PlaceId == 8304191830 then
    repeat task.wait() until game.Workspace:FindFirstChild(game.Players.LocalPlayer.Name)
    repeat task.wait() until game.Players.LocalPlayer.PlayerGui:FindFirstChild("collection"):FindFirstChild("grid"):FindFirstChild("List"):FindFirstChild("Outer"):FindFirstChild("UnitFrames")
else
    repeat task.wait() until game.Workspace:FindFirstChild(game.Players.LocalPlayer.Name)
    game:GetService("ReplicatedStorage").endpoints.client_to_server.vote_start:InvokeServer()
    repeat task.wait() until game:GetService("Workspace")["_waves_started"].Value == true
end
------------------------------
local HttpService = game:GetService("HttpService")
local Workspace = game:GetService("Workspace") 
local plr = game:GetService("Players").LocalPlayer
local RunService = game:GetService("RunService")
local mouse = game.Players.LocalPlayer:GetMouse()
local UserInputService = game:GetService("UserInputService")

getgenv().savefilename = "Anime-Adventures_UPD9t"..game.Players.LocalPlayer.Name..".json"
getgenv().door = "_lobbytemplategreen1"

--#region Webhook Sender
local function webhook()
	pcall(function()
		local url = tostring(getgenv().weburl) --webhook
		print("webhook?")
		if url == "" then
			return
		end 
			
    	XP = tostring(game:GetService("Players").LocalPlayer.PlayerGui.ResultsUI.Holder.LevelRewards.ScrollingFrame.XPReward.Main.Amount.Text)
		gems = tostring(game:GetService("Players").LocalPlayer.PlayerGui.ResultsUI.Holder.LevelRewards.ScrollingFrame.GemReward.Main.Amount.Text)
		gold = tostring(game:GetService("Players").LocalPlayer.PlayerGui.ResultsUI.Holder.LevelRewards.ScrollingFrame.GoldReward.Main.Amount.Text)
		item = tostring(game:GetService("Players").LocalPlayer.PlayerGui.Waves.HealthBar.IngameRewards.Configuration.ResourceRewardTotal.Holder.Main.Amount.Text)
		cwaves = game:GetService("Players").LocalPlayer.PlayerGui.ResultsUI.Holder.Middle.WavesCompleted.Text
		ctime = game:GetService("Players").LocalPlayer.PlayerGui.ResultsUI.Holder.Middle.Timer.Text
		waves = cwaves:split(": ")
		ttime = ctime:split(": ")

		local data = {
			["content"] = "",
			["username"] = "Anime Adventures",
			["avatar_url"] = "https://tr.rbxcdn.com/59739ce27080a9076dd408dfdeb1791d/150/150/Image/Png",
			["embeds"] = {
				{
					["author"] = {
						["name"] = "Anime Adventures | เนเธเนเธเน€เธ•เธทเธญเธ โ”",
						["icon_url"] = "https://cdn.discordapp.com/emojis/997123585476927558.webp?size=96&quality=lossless"
					},
					["description"] = "๐ฎ ||**"..game:GetService("Players").LocalPlayer.Name.."**|| ๐ฎ",
					["color"] = 110335,

					["thumbnail"] = {
						['url'] = "https://www.roblox.com/headshot-thumbnail/image?userId=" .. game.Players.LocalPlayer.userId .. "&width=420&height=420&format=png"
					},

					["fields"] = {
						{
							["name"] = "Total Waves:",
							["value"] = tostring(waves[2]) ..
								" <:wave:997136622363627530>",
							["inline"] = true
						}, {
                            ["name"] = "Total Time:",
                            ["value"] = tostring(ttime[2]) .. " โณ",
                            ["inline"] = true	
						}, {
							["name"] = "Recieved Gems:",
							["value"] = gems .. " <:gem:997123585476927558>",
							["inline"] = true
						}, {
							["name"] = "Recieved Gold:",
							["value"] = gold .. " ๐’ฐ",
							["inline"] = true	
						}, {
                            ["name"] = "Recieved XP:",
                            ["value"] = XP .. " ๐งช",
                            ["inline"] = true
                        }, {
                            ["name"] = "Current Gems:",
                            ["value"] = tostring(game.Players.LocalPlayer._stats.gem_amount.Value).." <:gem:997123585476927558>",
                            ["inline"] = true
						}, {
                            ["name"] = "Current Gold:",
                            ["value"] = tostring(game.Players.LocalPlayer._stats.gold_amount.Value).." ๐’ฐ",
                            ["inline"] = true	
                        }, {
                            ["name"] = "Current Level:",
                            ["value"] = tostring(game.Players.LocalPlayer.PlayerGui.spawn_units.Lives.Main.Desc.Level.Text).. " โจ",
                            ["inline"] = true	
						}, {
                            ["name"] = "item:",
                            ["value"] = item .. " ๐– ",
                            ["inline"] = true
                        }
					}
				}
			}
		}

		local porn = game:GetService("HttpService"):JSONEncode(data)

		local headers = {["content-type"] = "application/json"}
		request = http_request or request or HttpPost or syn.request or http.request
		local sex = {Url = url, Body = porn, Method = "POST", Headers = headers}
		warn("Sending webhook notification...")
		request(sex)
	end)
end
--#endregion

getgenv().UnitCache = {}

for _, Module in next, game:GetService("ReplicatedStorage"):WaitForChild("src"):WaitForChild("Data"):WaitForChild("Units"):GetDescendants() do
    if Module:IsA("ModuleScript") and Module.Name ~= "UnitPresets" then
        for UnitName, UnitStats in next, require(Module) do
            getgenv().UnitCache[UnitName] = UnitStats
        end
    end
end

--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\--
--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\--
--\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\--

function sex()
    -- reads jsonfile
    local jsonData = readfile(savefilename)
    local data = HttpService:JSONDecode(jsonData)

--#region global values

    --DEVIL CITY
    getgenv().portalnameX = data.portalnameX
    getgenv().farmprotal = data.farmportal
    getgenv().buyportal = data.buyportal
    getgenv().PortalID = data.PortalID


    getgenv().AutoLeave = data.AutoLeave
    getgenv().AutoReplay = data.AutoReplay
    getgenv().AutoChallenge = data.AutoChallenge  
    getgenv().selectedreward = data.selectedreward
    getgenv().AutoChallengeAll = data.AutoChallengeAll
    getgenv().disableatuofarm = false
    getgenv().sellatwave = data.sellatwave 
    getgenv().autosell = data.autosell
    getgenv().AutoFarm = data.autofarm
    getgenv().AutoFarmIC = data.autofarmic
    getgenv().AutoFarmTP = data.autofarmtp
    getgenv().AutoLoadTP = data.autoloadtp
    getgenv().weburl = data.webhook
    getgenv().autostart = data.autostart
    getgenv().autoupgrade = data.autoupgrade
    getgenv().difficulty = data.difficulty
    getgenv().world = data.world
    getgenv().level = data.level
    --getgenv().door = data.door

    getgenv().SpawnUnitPos = data.xspawnUnitPos
    getgenv().SelectedUnits = data.xselectedUnits
    getgenv().autoabilities = data.autoabilities
--#endregion

---// updates the json file
--#region update json
    function updatejson()

        local xdata = {
            --Devil City
            portalnameX = getgenv().portalnameX,
            farmportal = getgenv().farmprotal,
            buyportal = getgenv().buyportal,
            PortalID = getgenv().PortalID,

            -- unitname = getgenv().unitname,
            -- unitid = getgenv().unitid,
            autoloadtp = getgenv().AutoLoadTP,
            AutoLeave = getgenv().AutoLeave,
            AutoReplay = getgenv().AutoReplay,
            AutoChallenge  = getgenv().AutoChallenge, 
            selectedreward = getgenv().selectedreward,
            AutoChallengeAll = getgenv().AutoChallengeAll, 
            sellatwave = getgenv().sellatwave,
            autosell = getgenv().autosell,
            webhook = getgenv().weburl,
            autofarm = getgenv().AutoFarm,
            autofarmic = getgenv().AutoFarmIC,
            autofarmtp = getgenv().AutoFarmTP,
            autostart = getgenv().autostart,
            autoupgrade = getgenv().autoupgrade,
            difficulty = getgenv().difficulty,
            world = getgenv().world,
            level = getgenv().level,
            --door = getgenv().door,

            xspawnUnitPos = getgenv().SpawnUnitPos,
            xselectedUnits = getgenv().SelectedUnits,
            autoabilities = getgenv().autoabilities
        }

        local json = HttpService:JSONEncode(xdata)
        writefile(savefilename, json)
    end
--#endregion

    --\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\--
    --\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\--

    -- Uilib Shits

    local exec = tostring(identifyexecutor())

    local DiscordLib = loadstring(game:HttpGet "https://raw.githubusercontent.com/siradaniy/HSz/main/DiscordLid2.lua")()
    local win = DiscordLib:Window("HSz Member [๐‘นUPD 9] Anime Adventures "..versionx.." - "..exec)
       
    if exec == "Synapse X" or exec == "ScriptWare" or exec == "Trigon" then
        print("Good boi")
    else
        local gettrigonserver = win:Server("Support Member Ship!", "http://www.roblox.com/asset/?id=7628278821")
        local gettrigon = gettrigonserver:Channel(" HOLYSHz Member Only")
        gettrigon:Label("Thank for Support")
		gettrigon:Label("เธญเธขเนเธฒเธฅเธทเธกเธ•เนเธญ Member เธเธฑเธเธ”เนเธงเธขเธฅเธฐ")
        gettrigon:Button("๐‘ Copy HOLYSHz Member Link!", function()
            setclipboard("https://www.youtube.com/channel/UC8IbVYA7y2q67zcsgsWbycA/join")
            DiscordLib:Notification("Copied!!", "โ” เธฅเธดเนเธเธชเธกเธฑเธเธฃ Member เธเธญเธ HOLYSHz Copy เนเธงเนเนเธฅเนเธง เน€เธญเธฒเนเธเธงเธฒเธเนเธฅเนเธงเธเธ”เธชเธกเธฑเธเธฃเนเธ”เนเน€เธฅเธข!!", "Okay!")
        end)
    end

    local autofrmserver = win:Server("Auto Farm Section", "http://www.roblox.com/asset/?id=11579310982")
    local webhookserver = win:Server("Discord Wehhook  ", "http://www.roblox.com/asset/?id=11585480207")
	local diskordserver = win:Server("Discord Server   ", "http://www.roblox.com/asset/?id=11585480207")
    local creditsserver = win:Server("Youtube          ", "http://www.roblox.com/asset/?id=11585480207")


    if game.PlaceId == 8304191830 then

        local unitselecttab = autofrmserver:Channel("๐งโ€ Select Units")
        local slectworld = autofrmserver:Channel("๐ Select World")
        local devilcity = autofrmserver:Channel("๐ Devil City")
        local autofarmtab = autofrmserver:Channel("๐ค– Auto Farm")
        local autoclngtab = autofrmserver:Channel("โ Auto Challenge")
    

--------------------------------------------------
--------------- Select Units Tab -----------------
--------------------------------------------------
--#region Select Units Tab
        local Units = {}

        local function loadUnit()
            repeat task.wait() until game.Players.LocalPlayer.PlayerGui:FindFirstChild("collection"):FindFirstChild("grid"):FindFirstChild("List"):FindFirstChild("Outer"):FindFirstChild("UnitFrames")
            task.wait(2)
            table.clear(Units)
            for i, v in pairs(game:GetService("Players")[game.Players.LocalPlayer.Name].PlayerGui.collection.grid.List.Outer.UnitFrames:GetChildren()) do
                if v.Name == "CollectionUnitFrame" then
                    repeat task.wait() until v:FindFirstChild("_uuid")
                    table.insert(Units, v.name.Text .. " #" .. v._uuid.Value)
                end
            end
        end

        loadUnit()

        local function Check(x, y)
            for i, v in ipairs(game:GetService("Players").LocalPlayer.PlayerGui.collection.grid.List.Outer.UnitFrames:GetChildren()) do
                if v:IsA("ImageButton") then
                    if v.EquippedList.Equipped.Visible == true then
                        if v.Main.petimage:GetChildren()[2].Name == x then
                            --print(v.name.Text.." #"..v._uuid.Value)
                            getgenv().SelectedUnits["U"..tostring(y)] = tostring(v.name.Text.." #"..v._uuid.Value)
                            updatejson()
                            return true
                        end
                    end
                end
            end
        end

        local function Equip()
            game:GetService("ReplicatedStorage").endpoints.client_to_server.unequip_all:InvokeServer()
            
            for i = 1, 6 do
                local unitinfo = getgenv().SelectedUnits["U" .. i]
                warn(unitinfo)
                if unitinfo ~= nil then
                    local unitinfo_ = unitinfo:split(" #")
                    task.wait(0.5)
                    game:GetService("ReplicatedStorage").endpoints.client_to_server.equip_unit:InvokeServer(unitinfo_[2])
                end
            end
            updatejson()
        end

        unitselecttab:Button("Select Equipped Units", function()
            for i, v in ipairs(game:GetService("Players").LocalPlayer.PlayerGui["spawn_units"].Lives.Frame.Units:GetChildren()) do
                if v:IsA("ImageButton") then
                    local unitxx = v.Main.petimage.WorldModel:GetChildren()[1]
                    if unitxx ~= nil then
                        if Check(unitxx.Name,v) then
                            print(unitxx, v)
                        end
                    end
                end
            end
            DiscordLib:Notification("Equipped Units Are Selected!", "The dropdowns may not show the unit names now, but it will show next time you execute!", "Okay!")

        end)

        local drop = unitselecttab:Dropdown("Unit 1", Units, getgenv().SelectedUnits["U1"], function(bool)
            getgenv().SelectedUnits["U1"] = bool
            Equip()
        end)

        local drop2 = unitselecttab:Dropdown("Unit 2", Units, getgenv().SelectedUnits["U2"], function(bool)
            getgenv().SelectedUnits["U2"] = bool
            Equip()
        end)

        local drop3 = unitselecttab:Dropdown("Unit 3", Units, getgenv().SelectedUnits["U3"], function(bool)
            getgenv().SelectedUnits["U3"] = bool
            Equip()
        end)

        local drop4 = unitselecttab:Dropdown("Unit 4", Units, getgenv().SelectedUnits["U4"], function(bool)
            getgenv().SelectedUnits["U4"] = bool
            Equip()
        end)

        local axx =  game.Players.LocalPlayer.PlayerGui["spawn_units"].Lives.Main.Desc.Level.Text:split(" ")
        _G.drop5 = nil
        _G.drop6 = nil
        if tonumber(axx[2]) >= 20 then
            _G.drop5 = unitselecttab:Dropdown("Unit 5", Units, getgenv().SelectedUnits["U5"], function(bool)
                getgenv().SelectedUnits["U5"] = bool
                Equip()
            end)
        end

        if tonumber(axx[2]) >= 50 then
            _G.drop6 = unitselecttab:Dropdown("Unit 6", Units, getgenv().SelectedUnits["U6"], function(bool)
                getgenv().SelectedUnits["U6"] = bool
                Equip()
            end)
        end
--------------// Refresh Unit List \\------------- 
        unitselecttab:Button("Refresh Unit List", function()
            drop:Clear()
            drop2:Clear()
            drop3:Clear()
            drop4:Clear()
            if _G.drop5 ~= nil then
                _G.drop5:Clear()
            end
            if _G.drop6 ~= nil then
                _G.drop6:Clear()
            end 

            loadUnit()
            game:GetService("ReplicatedStorage").endpoints.client_to_server.unequip_all:InvokeServer()
            for i, v in ipairs(Units) do
                drop:Add(v)
                drop2:Add(v)
                drop3:Add(v)
                drop4:Add(v)
                if _G.drop5 ~= nil then
                    _G.drop5:Add(v)
                end
                if _G.drop6 ~= nil then
                    _G.drop6:Add(v)
                end 
            end
            getgenv().SelectedUnits = {
                U1 = nil,
                U2 = nil,
                U3 = nil,
                U4 = nil,
                U5 = nil,
                U6 = nil
            }
        end) 
        unitselecttab:Label(" ")
        unitselecttab:Label(" ")
--#endregion

--------------------------------------------------
--------------- Select World Tab -----------------
--------------------------------------------------
--#region Select world tab
        getgenv().levels = {"nill"}

        getgenv().diff = slectworld:Dropdown("Select Difficulty", {"Normal", "Hard"}, getgenv().difficulty, function(diff)
            getgenv().difficulty = diff
            updatejson()
        end)

        local worlddrop = slectworld:Dropdown("Select World", {"Plannet Namak", "Shiganshinu District", "Snowy Town","Hidden Sand Village", "Marine's Ford",
        "Ghoul City", "Hollow World", "Ant Kingdom", "Magic Town", "Cursed Academy","Clover Kingdom", "Clover Legend - HARD","Hollow Legend - HARD","Cape Canaveral","JoJo Legend - HARD"}, getgenv().world, function(world)
            getgenv().world = world
            updatejson()
            if world == "Plannet Namak" then
                getgenv().leveldrop:Clear()
                table.clear(levels)
                getgenv().levels = {"namek_infinite", "namek_level_1", "namek_level_2", "namek_level_3",
                                    "namek_level_4", "namek_level_5", "namek_level_6"}
                for i, v in ipairs(levels) do
                    getgenv().leveldrop:Add(v)
                end
            elseif world == "Shiganshinu District" then
                getgenv().leveldrop:Clear()
                table.clear(levels)
                getgenv().levels = {"aot_infinite", "aot_level_1", "aot_level_2", "aot_level_3", "aot_level_4",
                                    "aot_level_5", "aot_level_6"}
                for i, v in ipairs(levels) do
                    getgenv().leveldrop:Add(v)
                end
            elseif world == "Snowy Town" then
                getgenv().leveldrop:Clear()
                table.clear(levels)
                getgenv().levels = {"demonslayer_infinite", "demonslayer_level_1", "demonslayer_level_2",
                                    "demonslayer_level_3", "demonslayer_level_4", "demonslayer_level_5",
                                    "demonslayer_level_6"}
                for i, v in ipairs(levels) do
                    getgenv().leveldrop:Add(v)
                end
            elseif world == "Hidden Sand Village" then
                getgenv().leveldrop:Clear()
                table.clear(levels)
                getgenv().levels = {"naruto_infinite", "naruto_level_1", "naruto_level_2", "naruto_level_3",
                                    "naruto_level_4", "naruto_level_5", "naruto_level_6"}
                for i, v in ipairs(levels) do
                    getgenv().leveldrop:Add(v)
                end
            elseif world == "Marine's Ford" then
                getgenv().leveldrop:Clear()
                table.clear(levels)
                getgenv().levels = {"marineford_infinite","marineford_level_1","marineford_level_2","marineford_level_3",
                "marineford_level_4","marineford_level_5","marineford_level_6",}
                for i, v in ipairs(levels) do
                    getgenv().leveldrop:Add(v)
                end
            elseif world == "Ghoul City" then
                getgenv().leveldrop:Clear()
                table.clear(levels)
                getgenv().levels = {"tokyoghoul_infinite","tokyoghoul_level_1","tokyoghoul_level_2","tokyoghoul_level_3",
                                    "tokyoghoul_level_4","tokyoghoul_level_5","tokyoghoul_level_6",}
                for i, v in ipairs(levels) do
                    getgenv().leveldrop:Add(v)
                end
            elseif world == "Hollow World" then
                getgenv().leveldrop:Clear()
                table.clear(levels)
                getgenv().levels = {"hueco_infinite","hueco_level_1","hueco_level_2","hueco_level_3",
                                    "hueco_level_4","hueco_level_5","hueco_level_6",}
                for i, v in ipairs(levels) do
                    getgenv().leveldrop:Add(v)
                end
            elseif world == "Ant Kingdom" then
                getgenv().leveldrop:Clear()
                table.clear(levels)
                getgenv().levels = {"hxhant_infinite","hxhant_level_1","hxhant_level_2","hxhant_level_3",
                                    "hxhant_level_4","hxhant_level_5","hxhant_level_6",}
                for i, v in ipairs(levels) do
                    getgenv().leveldrop:Add(v)
                end
               
            elseif world == "Magic Town" then
                getgenv().leveldrop:Clear()
                table.clear(levels)
                getgenv().levels = {"magnolia_infinite","magnolia_level_1","magnolia_level_2","magnolia_level_3",
                                    "magnolia_level_4","magnolia_level_5","magnolia_level_6",}
                for i, v in ipairs(levels) do
                    getgenv().leveldrop:Add(v)
                end
            elseif world == "Cursed Academy" then
                getgenv().leveldrop:Clear()
                table.clear(levels)
                getgenv().levels = {"jjk_infinite","jjk_level_1","jjk_level_2","jjk_level_3",
                                    "jjk_level_4","jjk_level_5","jjk_level_6",}
                for i, v in ipairs(levels) do
                    getgenv().leveldrop:Add(v)
                end
            elseif world == "Clover Kingdom" then
                getgenv().leveldrop:Clear()
                table.clear(levels)
                getgenv().levels = {"clover_infinite","clover_level_1","clover_level_2","clover_level_3",
                                    "clover_level_4","clover_level_5","clover_level_6",}
                for i, v in ipairs(levels) do
                    getgenv().leveldrop:Add(v)
                end
            elseif world == "Clover Legend - HARD" then
                getgenv().leveldrop:Clear()
                table.clear(levels)
                getgenv().levels = {"clover_legend_1","clover_legend_2","clover_legend_3",}
                for i, v in ipairs(levels) do
                    getgenv().leveldrop:Add(v)
                end
            elseif world == "Hollow Legend - HARD" then
                getgenv().leveldrop:Clear()
                table.clear(levels)
                getgenv().levels = {"bleach_legend_1","bleach_legend_2","bleach_legend_3","bleach_legend_4","bleach_legend_5",}
                for i, v in ipairs(levels) do
                    getgenv().leveldrop:Add(v)
                end
            elseif world =="Cape Canaveral" then
                getgenv().leveldrop:Clear()
                table.clear(levels)
                getgenv().levels = {"jojo_infinite","jojo_level_1","jojo_level_2","jojo_level_3","jojo_level_4","jojo_level_5","jojo_level_6",}
                for i, v in ipairs(levels) do
                    getgenv().leveldrop:Add(v)
                end
			elseif world =="JoJo Legend - HARD" then
                getgenv().leveldrop:Clear()
                table.clear(levels)
                getgenv().levels = {"jojo_legend_1","jojo_legend_2","jojo_legend_3",}
                for i, v in ipairs(levels) do
                    getgenv().leveldrop:Add(v)
                end	
            end
        end)

      
            getgenv().leveldrop = slectworld:Dropdown("Select Level", getgenv().levels, getgenv().level, function(level)
            getgenv().level = level
            updatejson()
            
        end)
--#endregion



getgenv().portalname = devilcity:Dropdown("Select Portal", {"csm_contract_0", "csm_contract_1","csm_contract_2","csm_contract_3","csm_contract_4","csm_contract_5"}, getgenv().portalnameX, function(pornname)
    getgenv().portalnameX = pornname
    updatejson()
end)

devilcity:Button("Buy Portal", function()

    if getgenv().buyportal then
        local args = {
            [1] = tostring(getgenv().portalnameX)
        }
        game:GetService("ReplicatedStorage").endpoints.client_to_server.buy_csmportal_shop_item:InvokeServer(unpack(args))
    end

end)

devilcity:Toggle("Auto Farm Portal", getgenv().farmprotal, function(bool)
    getgenv().farmprotal = bool
    updatejson()
end)

devilcity:Label("เน€เธเธเธฒเธฐเธเธฃเธฐเธ•เธนเธ—เธตเนเธเธฅเธ”เธฅเนเธญเธ Rank เนเธฅเนเธงเน€เธ—เนเธฒเธเธฑเนเธ")
devilcity:Label("เธซเธฒเธเธกเธตเธเธฃเธฐเธ•เธนเน€เธเนเธฒ เธกเธฑเธเธญเธฒเธเธเธฐเน€เธฃเธดเนเธกเธ—เธณเธเธฒเธ เธ”เธฑเธเธเธฑเนเธเธญเธขเนเธฒเธเธทเนเธญเธเธฃเธฐเธ•เธนเธฃเธฐเธ”เธฑเธเธ•เนเธณเธ—เธตเนเธเธธเธ“เนเธกเนเธ•เนเธญเธเธเธฒเธฃเธ—เธณเธเธฒเธฃเนเธก.")

--------------------------------------------------
------------------ Auto Farm Tab -----------------
--------------------------------------------------
--#region Auto Farm Tab
        autofarmtab:Toggle("Auto Replay เน€เธฅเนเธเธเนเธณ", getgenv().AutoReplay, function(bool)
            getgenv().AutoReplay = bool
            updatejson()
        end)
        autofarmtab:Toggle("Auto Leave", getgenv().AutoLeave, function(bool)
            getgenv().AutoLeave = bool
            updatejson()
        end)
        autofarmtab:Toggle("Auto Farm เธเธฃเธฐเธ•เธนเธเนเธณเนเธเนเธ", getgenv().AutoFarmTP, function(bool)
            getgenv().AutoFarmTP = bool
            updatejson()
        end)

        autofarmtab:Toggle("Auto Start เธซเธญเธเธญเธข", getgenv().AutoFarmIC, function(bool)
            getgenv().AutoFarmIC = bool
            updatejson()
        end)

        autofarmtab:Toggle("Auto Farm เธงเธฒเธเธ•เธฑเธง", getgenv().AutoFarm, function(bool)
            getgenv().AutoFarm = bool
            updatejson()
        end)

        autofarmtab:Toggle("Auto Start", getgenv().autostart, function(bool)
            getgenv().autostart = bool
            updatejson()
        end)

        autofarmtab:Toggle("Auto Abilities", getgenv().autoabilities, function(bool)
            getgenv().autoabilities = bool
            updatejson()
        end)

        autofarmtab:Toggle("Auto Upgrade Units", getgenv().autoupgrade, function(bool)
            getgenv().autoupgrade = bool
            updatejson()
        end)

        autofarmtab:Toggle("Auto Sell เธเธฒเธขเน€เธกเธทเนเธญเธ–เธถเธ Wave", getgenv().autosell, function(x)
            getgenv().autosell = x
            updatejson()
            if getgenv().autosell == false then
                getgenv().disableatuofarm = false
            end
        end)

        ---- 
        autofarmtab:Textbox("เนเธชเนเธ•เธฑเธงเน€เธฅเธเน€เธเธทเนเธญ Auto Sell {เนเธชเนเน€เธฅเธเนเธฅเนเธงเธเธ” Enter}", tostring(getgenv().sellatwave), false, function(t)
            getgenv().sellatwave = tonumber(t)
            updatejson()
        end)
        
        local autoloadtab = autofrmserver:Channel("โ Auto Load Script")
		autoloadtab:Label("เธฃเธฑเธเธชเธเธฃเธดเธเธ•เนเนเธ”เธขเธญเธฑเธ•เนเธเธกเธฑเธ•เธดเน€เธกเธทเนเธญเธญเธญเธเธเธฒเธMap.")
        autoloadtab:Label("เนเธกเนเธเธณเน€เธเนเธเธ•เนเธญเธเนเธชเนเธชเธเธฃเธดเธเธ•เนเนเธเนเธเธฅเน€เธ”เธญเธฃเน AutoExec!")
        autoloadtab:Toggle("Auto Load Script", getgenv().AutoLoadTP, function(bool)
            --queue_on_teleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/siradaniy/HSz/main/AA_HSz.lua'))()")
            getgenv().AutoLoadTP = bool
            updatejson()
            if exec == "Synapse X" and getgenv().AutoLoadTP then
                syn.queue_on_teleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/siradaniy/HSz/main/AA_HSz.lua'))()")
            elseif exec ~= "Synapse X" and getgenv().AutoLoadTP then
                queue_on_teleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/siradaniy/HSz/main/AA_HSz.lua'))()")
            end

        end)
        autoloadtab:Label("โ ๏ธ เธซเธฒเธเธชเธเธฃเธดเธเธ•เนเธ—เธณเธเธฒเธเนเธกเนเธ–เธนเธเธ•เนเธญเธเนเธซเนเนเธชเนเธชเธเธฃเธดเธเธ•เนเน€เธเนเธฒเนเธ Autoexec\nfolder!!! โ ๏ธ")

        

		local webhooktab = webhookserver:Channel("๐ Webhook")
		webhooktab:Label("Webhook sends notification in discord everytime\nGame is Finished!")
		
		local webhoolPlaceholder
		if getgenv().weburl == "" then
			webhoolPlaceholder = "Insert url here!"
		else
			webhoolPlaceholder = getgenv().weburl
		end
		webhooktab:Textbox("Webhook URL {Press Enter}" , webhoolPlaceholder, false, function(web_url)
            getgenv().weburl = web_url
            updatejson()
        end)

        autofarmtab:Label(" ")
        autofarmtab:Label(" ")
        autofarmtab:Label(" ")
        autofarmtab:Label(" ")
--#endregion
--------------------------------------------------
-------------------- Auto Challenge --------------
--------------------------------------------------
--#region Auto Challenge
        autoclngtab:Toggle("Auto Challenge", getgenv().AutoChallenge, function(bool)
            getgenv().AutoChallenge = bool
            updatejson()
        end)
        local worlddrop = autoclngtab:Dropdown("Select Reward", {"star_fruit_random","star_remnant","gems", "gold"}, getgenv().selectedreward, function(reward)
            getgenv().selectedreward = reward
            updatejson()
        end)

        autoclngtab:Toggle("Farm All Rewards", getgenv().AutoChallengeAll, function(bool)
            getgenv().AutoChallengeAll = bool
            updatejson()
        end)
--#endregion
--------------------------------------------------
-------------------- Auto Buy/Sell ---------------
--------------------------------------------------
--#region Auto Buy/Sell
        getgenv().UnitSellTog = false
        getgenv().autosummontickets = false
        getgenv().autosummongem = false
        getgenv().autosummongem10 = false

        getgenv().autosummonticketse = false
        getgenv().autosummongeme = false
        getgenv().autosummongem10e = false

        local misc = autofrmserver:Channel("๐’ธ Auto Buy/Sell")


        local function autobuyfunc(xx, item)
            task.wait()

            local args = {
                [1] = xx,
                [2] = item
            }
            game:GetService("ReplicatedStorage").endpoints.client_to_server.buy_from_banner:InvokeServer(unpack(args))
            
        end

        misc:Label("Special - 2x Mythic")
        misc:Toggle("Auto Summon {Use Ticket 1}", getgenv().autosummonticketse, function(bool)
            getgenv().autosummonticketse = bool
            while getgenv().autosummonticketse do
                autobuyfunc("EventClover", "ticket")
            end
            updatejson()
        end)

        misc:Toggle("Auto Summon {Buy 1}", getgenv().autosummongeme, function(bool)
            getgenv().autosummongeme = bool
            while getgenv().autosummongeme do
                autobuyfunc("EventClover", "gems")
            end
            updatejson()
        end)

        misc:Toggle("Auto Summon {Buy 10}", getgenv().autosummongem10e, function(bool)
            getgenv().autosummongem10 = bool
            while getgenv().autosummongem10 do
                autobuyfunc("EventClover", "gems10")
            end
            updatejson()
        end)
        misc:Label("Standard")
        misc:Toggle("Auto Summon {Use Ticket 1}", getgenv().autosummontickets, function(bool)
            getgenv().autosummontickets = bool
            while getgenv().autosummontickets do
                autobuyfunc("Standard", "ticket")
            end
            updatejson()
        end)

        misc:Toggle("Auto Summon {Buy 1}", getgenv().autosummongem, function(bool)
            getgenv().autosummongem = bool
            while getgenv().autosummongem do
                autobuyfunc("Standard", "gems")
            end
            updatejson()
        end)

        misc:Toggle("Auto Summon {Buy 10}", getgenv().autosummongem10, function(bool)
            getgenv().autosummongem10 = bool
            while getgenv().autosummongem10 do
                autobuyfunc("Standard", "gems10")
            end
            updatejson()
        end)

        misc:Label("Sell Units")
        local utts = misc:Dropdown("Select Rarity", {"Rare", "Epic"}, getgenv().UnitToSell, function(u)
            getgenv().UnitToSell = u
        end)

        misc:Toggle("Auto Sell Units", getgenv().UnitSellTog, function(bool)
            getgenv().UnitSellTog = bool
        end) 
--#endregion
--------------------------------------------------
--------------------------------------------------
--------------------------------------------------
--#region --- Inside match ---
    else -- When in a match
        game.Players.LocalPlayer.PlayerGui.MessageGui.Enabled = false
        game:GetService("ReplicatedStorage").packages.assets["ui_sfx"].error.Volume = 0
        game:GetService("ReplicatedStorage").packages.assets["ui_sfx"].error_old.Volume = 0
        




    local autofarmtab = autofrmserver:Channel("๐ค– Auto Farm")
    local devilcity = autofrmserver:Channel("๐ Devil City")
    local autoclngtab = autofrmserver:Channel("๐ฏ Auto Challenge")
    local autoloadtab = autofrmserver:Channel("โ Auto Load Script_")
    local autoseltab = autofrmserver:Channel("๐’ธ Auto Sell")
    local webhooktab = webhookserver:Channel("๐ Webhook")
    
		autoloadtab:Label("เธฃเธฑเธเธชเธเธฃเธดเธเธ•เนเนเธ”เธขเธญเธฑเธ•เนเธเธกเธฑเธ•เธดเน€เธกเธทเนเธญเธญเธญเธเธเธฒเธMap.")
        autoloadtab:Label("เนเธกเนเธเธณเน€เธเนเธเธ•เนเธญเธเนเธชเนเธชเธเธฃเธดเธเธ•เนเนเธเนเธเธฅเน€เธ”เธญเธฃเน AutoExec!")
        autoloadtab:Toggle("Auto Load Script", getgenv().AutoLoadTP, function(bool)
            getgenv().AutoLoadTP = bool
            updatejson()
            if exec == "Synapse X" and getgenv().AutoLoadTP then
                syn.queue_on_teleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/siradaniy/HSz/main/AA_HSz.lua'))()")
            elseif exec ~= "Synapse X" and getgenv().AutoLoadTP then
                queue_on_teleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/siradaniy/HSz/main/AA_HSz.lua'))()")
            end

        end)
        autoloadtab:Label("โ ๏ธ เธซเธฒเธเธชเธเธฃเธดเธเธ•เนเธ—เธณเธเธฒเธเนเธกเนเธ–เธนเธเธ•เนเธญเธเนเธซเนเนเธชเนเธชเธเธฃเธดเธเธ•เนเน€เธเนเธฒเนเธ Autoexec\nfolder!!! โ ๏ธ")







    getgenv().portalname = devilcity:Dropdown("Select Portal", {"csm_contract_0", "csm_contract_1","csm_contract_2","csm_contract_3","csm_contract_4","csm_contract_5"}, getgenv().portalnameX, function(pornname)
        getgenv().portalnameX = pornname
        updatejson()
    end)
    
    devilcity:Button("Buy Portal", function()
        if getgenv().buyportal then
            local args = {
                [1] = tostring(getgenv().portalnameX)
            }
            
            game:GetService("ReplicatedStorage").endpoints.client_to_server.buy_csmportal_shop_item:InvokeServer(unpack(args))
        end
    end)
    
    devilcity:Toggle("Auto Farm เธเธฃเธฐเธ•เธน Devil", getgenv().farmprotal, function(bool)
        getgenv().farmprotal = bool
        updatejson()
    end)
    
    devilcity:Label("เน€เธเธเธฒเธฐเธเธฃเธฐเธ•เธนเธ—เธตเนเธเธฅเธ”เธฅเนเธญเธ Rank เนเธฅเนเธงเน€เธ—เนเธฒเธเธฑเนเธ")
    devilcity:Label("เธซเธฒเธเธกเธตเธเธฃเธฐเธ•เธนเน€เธเนเธฒ เธกเธฑเธเธญเธฒเธเธเธฐเน€เธฃเธดเนเธกเธ—เธณเธเธฒเธ เธ”เธฑเธเธเธฑเนเธเธญเธขเนเธฒเธเธทเนเธญเธเธฃเธฐเธ•เธนเธฃเธฐเธ”เธฑเธเธ•เนเธณเธ—เธตเนเธเธธเธ“เนเธกเนเธ•เนเธญเธเธเธฒเธฃเธ—เธณเธเธฒเธฃเนเธก.")

        
--#region Auto Farm Tab
        autofarmtab:Toggle("Auto Replay เน€เธฅเนเธเธเนเธณ", getgenv().AutoReplay, function(bool)
            getgenv().AutoReplay = bool
            updatejson()
        end)
        autofarmtab:Toggle("Auto Leave", getgenv().AutoLeave, function(bool)
            getgenv().AutoLeave = bool
            updatejson()
        end)
        autofarmtab:Toggle("Auto Farm เธเธฃเธฐเธ•เธนเธเนเธณเนเธเนเธ", getgenv().AutoFarmTP, function(bool)
            getgenv().AutoFarmTP = bool
            updatejson()
        end)

        autofarmtab:Toggle("Auto Start เธซเธญเธเธญเธข", getgenv().AutoFarmIC, function(bool)
            getgenv().AutoFarmIC = bool
            updatejson()
        end)

        autofarmtab:Toggle("Auto Farm เธงเธฒเธเธ•เธฑเธง", getgenv().AutoFarm, function(bool)
            getgenv().AutoFarm = bool
            updatejson()
        end)

        autofarmtab:Toggle("Auto Abilities เนเธเนเธชเธเธดเธฅ", getgenv().autoabilities, function(bool)
            getgenv().autoabilities = bool
            updatejson()
        end)

        autofarmtab:Toggle("Auto Start", getgenv().autostart, function(bool)
            getgenv().autostart = bool
            updatejson()
        end)

        autofarmtab:Toggle("Auto Upgrade Units", getgenv().autoupgrade, function(bool)
            getgenv().autoupgrade = bool
            updatejson()
        end)

        function MouseClick(UnitPos)
            local connection
            local _map = game:GetService("Workspace")["_BASES"].player.base["fake_unit"]:WaitForChild("HumanoidRootPart")
            connection = UserInputService.InputBegan:Connect(
                function(input, gameProcessed)
                    if input.UserInputType == Enum.UserInputType.MouseButton1 then
                        connection:Disconnect()
                        local a = Instance.new("Part", game.Workspace)
                        a.Size = Vector3.new(1, 1, 1)
                        a.Material = Enum.Material.Neon
                        a.Position = mouse.hit.p
                        task.wait()
                        a.Anchored = true
                        DiscordLib:Notification("Spawn Unit Posotion:", tostring(a.Position), "Okay!")
                        a.CanCollide = false
                        for i = 0, 1, 0.1 do
                            a.Transparency = i
                            task.wait()
                        end
                        a:Destroy()

                        if game.Workspace._map:FindFirstChild("namek mushroom model") then
                            print("Namak")
                            SpawnUnitPos["Namak"][UnitPos]["x"] = a.Position.X
                            SpawnUnitPos["Namak"][UnitPos]["y"] = a.Position.Y
                            SpawnUnitPos["Namak"][UnitPos]["z"] = a.Position.Z
                        elseif game.Workspace._map:FindFirstChild("houses_new") then
                            print("Aot")
                            SpawnUnitPos["Aot"][UnitPos]["x"] = a.Position.X
                            SpawnUnitPos["Aot"][UnitPos]["y"] = a.Position.Y
                            SpawnUnitPos["Aot"][UnitPos]["z"] = a.Position.Z
                        elseif game.Workspace._map:FindFirstChild("Snow Particles") then
                            print("Snowy")
                            SpawnUnitPos["Snowy"][UnitPos]["x"] = a.Position.X
                            SpawnUnitPos["Snowy"][UnitPos]["y"] = a.Position.Y
                            SpawnUnitPos["Snowy"][UnitPos]["z"] = a.Position.Z
                        elseif game.Workspace._map:FindFirstChild("sand_gate") then
                            warn("Sand")
                            SpawnUnitPos["Sand"][UnitPos]["x"] = a.Position.X
                            SpawnUnitPos["Sand"][UnitPos]["y"] = a.Position.Y
                            SpawnUnitPos["Sand"][UnitPos]["z"] = a.Position.Z
                        elseif game.Workspace._map:FindFirstChild("icebergs") then
                            print("Marine")
                            SpawnUnitPos["Marine"][UnitPos]["x"] = a.Position.X
                            SpawnUnitPos["Marine"][UnitPos]["y"] = a.Position.Y
                            SpawnUnitPos["Marine"][UnitPos]["z"] = a.Position.Z
                        elseif game.Workspace._map:FindFirstChild("Helicopter Pad") then
                            print("Ghoul")
                            SpawnUnitPos["Ghoul"][UnitPos]["x"] = a.Position.X
                            SpawnUnitPos["Ghoul"][UnitPos]["y"] = a.Position.Y
                            SpawnUnitPos["Ghoul"][UnitPos]["z"] = a.Position.Z
                        elseif game.Workspace._map:FindFirstChild("Bones/dust") then
                            print("Hollow")
                            SpawnUnitPos["Hollow"][UnitPos]["x"] = a.Position.X
                            SpawnUnitPos["Hollow"][UnitPos]["y"] = a.Position.Y
                            SpawnUnitPos["Hollow"][UnitPos]["z"] = a.Position.Z
                        elseif game.Workspace._map:FindFirstChild("Ant Nest") then
                            print("Ant")
                            SpawnUnitPos["Ant"][UnitPos]["x"] = a.Position.X
                            SpawnUnitPos["Ant"][UnitPos]["y"] = a.Position.Y
                            SpawnUnitPos["Ant"][UnitPos]["z"] = a.Position.Z
                        elseif game.Workspace._map:FindFirstChild("light poles") then
                            print("Magic")
                            SpawnUnitPos["Magic"][UnitPos]["x"] = a.Position.X
                            SpawnUnitPos["Magic"][UnitPos]["y"] = a.Position.Y
                            SpawnUnitPos["Magic"][UnitPos]["z"] = a.Position.Z
                        elseif game.Workspace._map:FindFirstChild("LanternsGround") then
                            print("Cursed")    
                            SpawnUnitPos["Cursed"][UnitPos]["x"] = a.Position.X
                            SpawnUnitPos["Cursed"][UnitPos]["y"] = a.Position.Y
                            SpawnUnitPos["Cursed"][UnitPos]["z"] = a.Position.Z
                        elseif game.Workspace._map:FindFirstChild("pumpkins") then
                            print("thriller_park")    
                            SpawnUnitPos["thriller_park"][UnitPos]["x"] = a.Position.X
                            SpawnUnitPos["thriller_park"][UnitPos]["y"] = a.Position.Y
                            SpawnUnitPos["thriller_park"][UnitPos]["z"] = a.Position.Z
                        elseif game.Workspace._map:FindFirstChild("skeleton") then
                            print("black_clover")    
                            SpawnUnitPos["black_clover"][UnitPos]["x"] = a.Position.X
                            SpawnUnitPos["black_clover"][UnitPos]["y"] = a.Position.Y
                            SpawnUnitPos["black_clover"][UnitPos]["z"] = a.Position.Z
                        elseif game.Workspace._map:FindFirstChild("graves") then
                            print("hollow_leg")    
                            SpawnUnitPos["hollow_leg"][UnitPos]["x"] = a.Position.X
                            SpawnUnitPos["hollow_leg"][UnitPos]["y"] = a.Position.Y
                            SpawnUnitPos["hollow_leg"][UnitPos]["z"] = a.Position.Z
                        elseif game.Workspace._map:FindFirstChild("SpaceCenter") then
                            print("Cape Canaveral")    
                            SpawnUnitPos["jojo"][UnitPos]["x"] = a.Position.X
                            SpawnUnitPos["jojo"][UnitPos]["y"] = a.Position.Y
                            SpawnUnitPos["jojo"][UnitPos]["z"] = a.Position.Z
                        elseif game.Workspace._map:FindFirstChild("vending machines") then
                            print("chainsaw")    
                            SpawnUnitPos["chainsaw"][UnitPos]["x"] = a.Position.X
                            SpawnUnitPos["chainsaw"][UnitPos]["y"] = a.Position.Y
                            SpawnUnitPos["chainsaw"][UnitPos]["z"] = a.Position.Z
                        end

                        updatejson()
                    end
                end)
        end

        --// Set Position \\--
        autofarmtab:Button("Set เธเธธเธ”เธงเธฒเธเธ•เธฑเธง Unit 1", function()
            DiscordLib:Notification("Set Unit 1 Spawn Position",
                "Click on the floor to set the spawn unit position!\n (don't press \"Done\" until you set position)",
                "Done")
                warn(1)
            MouseClick("UP1")
            warn(2)
        end)

        autofarmtab:Button("Set เธเธธเธ”เธงเธฒเธเธ•เธฑเธง Unit 2", function()
            DiscordLib:Notification("Set Unit 2 Spawn Position",
                "Click on the floor to set the spawn unit position!\n (don't press \"Done\" until you set position)",
                "Done")
            MouseClick("UP2")
        end)
        autofarmtab:Button("Set เธเธธเธ”เธงเธฒเธเธ•เธฑเธง Unit 3", function()
            DiscordLib:Notification("Set Unit 3 Spawn Position",
                "Click on the floor to set the spawn unit position!\n (don't press \"Done\" until you set position)",
                "Done")
            MouseClick("UP3")
        end)
        autofarmtab:Button("Set เธเธธเธ”เธงเธฒเธเธ•เธฑเธง Unit 4", function()
            DiscordLib:Notification("Set Unit 4 Spawn Position",
                "Click on the floor to set the spawn unit position!\n (don't press \"Done\" until you set position)",
                "Done")
            MouseClick("UP4")
        end)

        
        local axxc = game.Players.LocalPlayer.PlayerGui["spawn_units"].Lives.Main.Desc.Level.Text:split(" ")

        if tonumber(axxc[2]) >= 20 then
            autofarmtab:Button("Set เธเธธเธ”เธงเธฒเธเธ•เธฑเธง Unit 5", function()
                DiscordLib:Notification("Set Unit 5 Spawn Position",
                    "Click on the floor to set the spawn unit position!\n (don't press \"Done\" until you set position)",
                    "Done")
                MouseClick("UP5")
            end)
        end

        if tonumber(axxc[2]) >= 50 then
            autofarmtab:Button("Set เธเธธเธ”เธงเธฒเธเธ•เธฑเธง Unit 6", function()
                DiscordLib:Notification("Set Unit 6 Spawn Position",
                    "Click on the floor to set the spawn unit position!\n (don't press \"Done\" until you set position)",
                    "Done")
                MouseClick("UP6")
            end)
        end


        -- set unit position end--
        autofarmtab:Label("--- Saved Config (Doesn't Refresh) ---")
        autofarmtab:Label("Auto Sell at Wave: " .. tostring(getgenv().sellatwave))
        autofarmtab:Label("Webhook: " .. tostring(getgenv().weburl))
        autofarmtab:Label("Auto Farm: " .. tostring(getgenv().AutoFarm))
        autofarmtab:Label("Auto Start: " .. tostring(getgenv().autostart))
        autofarmtab:Label("Auto Sell: " .. tostring(getgenv().autosell))
        autofarmtab:Label("Auto Upgrade: " .. tostring(getgenv().autoupgrade))
        autofarmtab:Label("Difficulty: " .. tostring(getgenv().difficulty))
        autofarmtab:Label("Selected World: " .. tostring(getgenv().world))
        autofarmtab:Label("Selected Level: " .. tostring(getgenv().level))
        autofarmtab:Label(" ")
        autofarmtab:Label(" ")

--#endregion

--#region Auto Challenge 
autoclngtab:Toggle("Auto Challenge", getgenv().AutoChallenge, function(bool)
    getgenv().AutoChallenge = bool
    updatejson()
end)
local worlddrop = autoclngtab:Dropdown("Select Reward", {"star_fruit_random","star_remnant","gems", "gold"}, getgenv().selectedreward, function(reward)
    getgenv().selectedreward = reward
    updatejson()
end)

autoclngtab:Toggle("Farm All Rewards", getgenv().AutoChallengeAll, function(bool)
    getgenv().AutoChallengeAll = bool
    updatejson()
end)
--#endregion

--#region Auto Sell Tab
        autoseltab:Toggle("Auto Sell เธเธฒเธขเน€เธกเธทเนเธญเธ–เธถเธ Wave", getgenv().autosell, function(x)
            getgenv().autosell = x
            updatejson()
            if getgenv().autosell == false then
                getgenv().disableatuofarm = false
            end
        end)

        autoseltab:Textbox("เนเธชเนเธ•เธฑเธงเน€เธฅเธเน€เธเธทเนเธญ Auto Sell {เนเธชเนเน€เธฅเธเนเธฅเนเธงเธเธ” Enter}", getgenv().sellatwave, false, function(t)
            getgenv().sellatwave = tonumber(t)
            updatejson()
        end)
--#endregion



--#region Webhook
		--//Webhook Tab (in-game)\\--
		webhooktab:Label("Webhook เธเธฐเธชเนเธเนเธเนเธเน€เธ•เธทเธญเธ เธ—เธธเธเธเธฃเธฑเนเธ เธ—เธตเนเธเธเธฃเธญเธ.")
		local webhoolPlaceholder
		if getgenv().weburl == "" then
			webhoolPlaceholder = "Insert url here!"
		else
			webhoolPlaceholder = getgenv().weburl
		end
		webhooktab:Textbox("Webhook URL {Press Enter}" , webhoolPlaceholder, false, function(web_url)
            getgenv().weburl = web_url
            updatejson()
        end)
        webhooktab:Button("Test Webhook", function()
            webhook()
        end)
--#endregion


    end
--#endregion
local diskord = diskordserver:Channel("๐‘พ Discord")
diskord:Button("๐‘ HOLYSHz Discord Link!", function()
    setclipboard("https://discord.gg/6V8nzm5ZYB")
    DiscordLib:Notification("Copied!!", "โ” เธเธณเน€เธเธดเธ Discord เธ–เธนเธ Copy เนเธฅเนเธง!!", "Okay!")
end)
--#region Youtube
local credits = creditsserver:Channel("โจ Youtube")
credits:Label("HOLYSHz")
credits:Button("๐‘ HOLYSHz Youtube Link!", function()
    setclipboard("https://www.youtube.com/@HOLYSHz")
    DiscordLib:Notification("Copied!!", "โ” Link เธเนเธญเธ Youtube เธ–เธนเธ Copy เนเธฅเนเธง!!", "Okay!")	
end)
--#endregion


end


--------------------------------------------------
--------------------------------------------------

---// Checks if file exist or not\\---
if isfile(savefilename) then 

    local jsonData = readfile(savefilename)
    local data = HttpService:JSONDecode(jsonData)

    sex()

else
--#region CREATES JSON
    local xdata = {
        --Devil City
        portalnameX = "csm_contract_0",
        farmportal = false,
        buyportal = false,
        PortalID = "nil",
        
        -- unitname = "name",
        -- unitid = "id",
        AutoReplay = false,
        AutoLeave = true,
        AutoChallenge = false,
        selectedreward = "star_fruit_random",
        AutoChallengeAll = false,
        autoabilities = false,
        autofarmtp = false,
        webhook = "",
        sellatwave = 0,
        autosell = false,
        autofarm = false,
        autofarmic = false,
        autostart = false,
        autoloadtp = false,
        autoupgrade = false,
        difficulty = "nil",
        world = "nil",
        level = "nil",
        door = "nil",
    
        xspawnUnitPos  = {
            black_clover  = {
              UP1  = {
                y  = 1.4244641065597535,
                x  = -109.30056762695313,
                z  = -54.575347900390628
             },
              UP3  = {
                y  = 1.4322717189788819,
                x  = -114.2433853149414,
                z  = -55.260982513427737
             },
              UP2  = {
                y  = 1.7082736492156983,
                x  = -127.53932189941406,
                z  = -55.277626037597659
             },
              UP6  = {
                y  = 1.4487617015838624,
                x  = -107.07078552246094,
                z  = -51.333045959472659
             },
              UP5  = {
                y  = 1.8965977430343629,
                x  = -118.5692138671875,
                z  = -57.20484161376953
             },
              UP4  = {
                y  = 1.4205386638641358,
                x  = -105.46223449707031,
                z  = -51.20615005493164
             }
           },
           hollow_leg = {
            UP1 = {
                x = -168.71795654296875,
                y = 36.04443359375, 
                z = 564.4705810546875 
            },
            UP2 = {
                x = -161.105712890625, 
                y = 36.04443359375, 
                z = 558.4195556640625 
            },
            UP3 = {
                x = -161.05670166015625, 
                y = 36.04443359375, 
                z = 546.204833984375 
               
            },
            UP4 = {
                x = -163.51824951171875, 
                y = 36.04443359375, 
                z = 534.6953735351562 
            },
            UP5 = {
                x = -170.02479553222656, 
                y = 36.04443359375, 
                z = 528.9660034179688
            },
            UP6 = {
                x = -160.92405700683594, 
                y = 36.04443359375, 
                z = 565.2430419921875 
            }
           },
            Cursed  = {
              UP1  = {
                y  = 122.78201293945313,
                x  = 361.69732666015627,
                z  = -89.76468658447266
             },
              UP3  = {
                y  = 122.73872375488281,
                x  = 372.2068786621094,
                z  = -62.877601623535159
             },
              UP2  = {
                y  = 122.73872375488281,
                x  = 391.6465759277344,
                z  = -62.87253189086914
             },
              UP6  = {
                y  = 121.5274887084961,
                x  = 399.4963684082031,
                z  = -60.31044387817383
             },
              UP5  = {
                y  = 121.6282958984375,
                x  = 400.8389587402344,
                z  = -64.46269226074219
             },
              UP4  = {
                y  = 122.73872375488281,
                x  = 362.14788818359377,
                z  = -77.3993148803711
             }
           },
            Sand  = {
              UP1  = {
                y  = 25.514015197753908,
                x  = -919.7685546875,
                z  = 290.9293518066406
             },
              UP3  = {
                y  = 25.518001556396486,
                x  = -919.7103881835938,
                z  = 288.1217346191406
             },
              UP2  = {
                y  = 26.06340980529785,
                x  = -920.3797607421875,
                z  = 300.7817077636719
             },
              UP6  = {
                y  = 25.528093338012697,
                x  = -916.4822998046875,
                z  = 287.9609069824219
             },
              UP5  = {
                y  = 25.71731185913086,
                x  = -920.7069091796875,
                z  = 296.8504943847656
             },
              UP4  = {
                y  = 25.508501052856447,
                x  = -919.2952270507813,
                z  = 294.7797546386719
             }
           },
            Namak  = {
              UP1  = {
                y  = 92.14557647705078,
                x  = -2931.182861328125,
                z  = -698.5640869140625
             },
              UP3  = {
                y  = 92.5256118774414,
                x  = -2950.3916015625,
                z  = -697.1671142578125
             },
              UP2  = {
                y  = 93.32953643798828,
                x  = -2940.813720703125,
                z  = -697.09326171875
             },
              UP6  = {
                y  = 92.16944885253906,
                x  = -2946.967041015625,
                z  = -710.122802734375
             },
              UP5  = {
                y  = 92.15478515625,
                x  = -2947.684326171875,
                z  = -699.6248779296875
             },
              UP4  = {
                y  = 92.5256118774414,
                x  = -2950.408935546875,
                z  = -709.8072509765625
             }
           },
            Hollow  = {
              UP1  = {
                y  = 133.10752868652345,
                x  = -168.9812774658203,
                z  = -692.3645629882813
             },
              UP3  = {
                y  = 133.09632873535157,
                x  = -167.3197021484375,
                z  = -695.4755249023438
             },
              UP2  = {
                y  = 133.50978088378907,
                x  = -160.6356964111328,
                z  = -709.1862182617188
             },
              UP6  = {
                y  = 133.08169555664063,
                x  = -176.02857971191407,
                z  = -691.7825317382813
             },
              UP5  = {
                y  = 133.0151824951172,
                x  = -161.20188903808595,
                z  = -702.9484252929688
             },
              UP4  = {
                y  = 133.17193603515626,
                x  = -172.60714721679688,
                z  = -691.3147583007813
             }
           },
            Ant  = {
              UP1  = {
                y  = 23.502197265625,
                x  = -180.23072814941407,
                z  = 2961.130126953125
             },
              UP3  = {
                y  = 23.855152130126954,
                x  = -167.0123748779297,
                z  = 2954.2958984375
             },
              UP2  = {
                y  = 23.637359619140626,
                x  = -205.69203186035157,
                z  = 2964.095947265625
             },
              UP6  = {
                y  = 23.31997299194336,
                x  = -163.1376953125,
                z  = 2959.968017578125
             },
              UP5  = {
                y  = 23.598222732543947,
                x  = -170.1063232421875,
                z  = 2955.477294921875
             },
              UP4  = {
                y  = 23.855152130126954,
                x  = -156.4979705810547,
                z  = 2959.6123046875
             }
           },
            Aot  = {
              UP1  = {
                y  = 34.25483703613281,
                x  = -3016.723388671875,
                z  = -682.4714965820313
             },
              UP3  = {
                y  = 34.442054748535159,
                x  = -3024.1181640625,
                z  = -682.2401123046875
             },
              UP2  = {
                y  = 34.387603759765628,
                x  = -3035.071533203125,
                z  = -683.9107055664063
             },
              UP6  = {
                y  = 34.25492477416992,
                x  = -3019.5390625,
                z  = -681.8257446289063
             },
              UP5  = {
                y  = 34.25492477416992,
                x  = -3030.930419921875,
                z  = -683.3449096679688
             },
              UP4  = {
                y  = 34.442054748535159,
                x  = -3013.065185546875,
                z  = -681.4302368164063
             }
           },
            Snowy  = {
              UP1  = {
                y  = 34.8720588684082,
                x  = -2884.6103515625,
                z  = -139.17750549316407
             },
              UP3  = {
                y  = 35.055450439453128,
                x  = -2871.251708984375,
                z  = -131.86231994628907
             },
              UP2  = {
                y  = 34.86832046508789,
                x  = -2863.6240234375,
                z  = -120.90508270263672
             },
              UP6  = {
                y  = 34.79566192626953,
                x  = -2853.62548828125,
                z  = -123.30137634277344
             },
              UP5  = {
                y  = 34.79277038574219,
                x  = -2853.63232421875,
                z  = -119.10173034667969
             },
              UP4  = {
                y  = 34.86832046508789,
                x  = -2878.749755859375,
                z  = -138.48580932617188
             }
           },
            Ghoul  = {
              UP1  = {
                y  = 59.36590576171875,
                x  = -3008.964111328125,
                z  = -56.00475311279297
             },
              UP3  = {
                y  = 59.03008270263672,
                x  = -3008.75732421875,
                z  = -58.37107849121094
             },
              UP2  = {
                y  = 59.382938385009769,
                x  = -2998.44140625,
                z  = -42.68498992919922
             },
              UP6  = {
                y  = 59.03008270263672,
                x  = -3009.03125,
                z  = -67.12299346923828
             },
              UP5  = {
                y  = 59.03008270263672,
                x  = -3007.1025390625,
                z  = -52.12919998168945
             },
              UP4  = {
                y  = 59.03008270263672,
                x  = -3008.94580078125,
                z  = -63.67665100097656
             }
           },
            Magic  = {
              UP1  = {
                y  = 7.411101341247559,
                x  = -606.7291259765625,
                z  = -815.5218505859375
             },
              UP3  = {
                y  = 7.411093711853027,
                x  = -589.5305786132813,
                z  = -814.8512573242188
             },
              UP2  = {
                y  = 7.413991928100586,
                x  = -578.809814453125,
                z  = -814.5386962890625
             },
              UP6  = {
                y  = 7.372146129608154,
                x  = -605.3615112304688,
                z  = -820.8731079101563
             },
              UP5  = {
                y  = 7.413986682891846,
                x  = -597.8843383789063,
                z  = -814.5377807617188
             },
              UP4  = {
                y  = 7.4139862060546879,
                x  = -600.348388671875,
                z  = -814.8621215820313
             }
           },
            Marine  = {
              UP1  = {
                y  = 25.521255493164064,
                x  = -2566.733642578125,
                z  = -62.77167892456055
             },
              UP3  = {
                y  = 25.5211124420166,
                x  = -2565.930419921875,
                z  = -57.89338684082031
             },
              UP2  = {
                y  = 25.210872650146486,
                x  = -2560.966796875,
                z  = -44.40180969238281
             },
              UP6  = {
                y  = 25.676485061645509,
                x  = -2566.796142578125,
                z  = -67.01408386230469
             },
              UP5  = {
                y  = 25.5211238861084,
                x  = -2563.39990234375,
                z  = -63.74509811401367
             },
              UP4  = {
                y  = 24.990556716918947,
                x  = -2570.3349609375,
                z  = -69.34259033203125
             }
           },
            thriller_park  = {
              UP1  = {
                y  = 113.23728942871094,
                x  = -224.14295959472657,
                z  = -657.738037109375
             },
              UP3  = {
                y  = 109.37400817871094,
                x  = -224.78709411621095,
                z  = -640.7178955078125
             },
              UP2  = {
                y  = 109.37401580810547,
                x  = -229.42715454101563,
                z  = -649.636474609375
             },
              UP6  = {
                y  = 109.37400817871094,
                x  = -214.7626190185547,
                z  = -632.3900146484375
             },
              UP5  = {
                y  = 109.37401580810547,
                x  = -230.53053283691407,
                z  = -657.9769287109375
             },
              UP4  = {
                y  = 109.37400817871094,
                x  = -220.0915985107422,
                z  = -636.2127075195313
             }
           },
           chainsaw  = {
            UP1  = {
                x = -332.51287841796875, 
                y = 1.0000009536743164,
                z = -554.8867797851562
                
           },
            UP3  = {
                x = -326.1617126464844,
                y = 1.0000009536743164,
                z = -554.5086669921875
           },
            UP2  = {
                x = -317.24713134765625,
                y = 1.0000007152557373,
                z = -553.8807983398438
           },
            UP6  = {
                x = -327.2223815917969,
                y = 1.0000004768371582,
                z = -550.3519287109375
           },
            UP5  = {
                x = -342.5332946777344,
                y = 1.0000004768371582,
                z = -551.2924194335938
           },
            UP4  = {
                x = -320.3905944824219,
                y = 1.0000004768371582,
                z = -550.587890625
           }
         },
           jojo = {
            UP1  = {
                x = -111.61297607421875, 
                y = 15.255210876464844, 
                z = -513.5579833984375
             },
              UP3  = {
                x = -120.01858520507812, 
                y = 15.255210876464844, 
                z = -522.66650390625
             },
              UP2  = {
                x = -124.42668151855469, 
                y = 15.255210876464844, 
                z = -530.7169799804688
             },
              UP6  = {
                x = -120.38040161132812, 
                y = 15.255212783813477, 
                z = -536.6077270507812
             },
              UP5  = {
                x = -115.62987518310547, 
                y = 15.255210876464844, 
                z = -518.679931640625                
             },
              UP4  = {
                x = -118.3056411743164, 
                y = 15.255210876464844, 
                z = -529.9589233398438
             }	 
           }
           
         },

        xselectedUnits = {
            U1 = nil,
            U2 = nil,
            U3 = nil,
            U4 = nil,
            U5 = nil,
            U6 = nil
        }
    
    }

    local json = HttpService:JSONEncode(xdata)
    writefile(savefilename, json)

    sex()
--#endregion
end

--#region ----------------------
--#endregion
--------------------------------------------------



------// Auto Farm \\------
--#region Auto Farm Loop
coroutine.resume(coroutine.create(function()
    while task.wait(1.5) do
        local _wave = game:GetService("Workspace"):WaitForChild("_wave_num")
        repeat task.wait() until game:GetService("Workspace"):WaitForChild("_map")

        if getgenv().AutoFarm and not getgenv().disableatuofarm then
            print('farming')
            if game.PlaceId ~= 8304191830 then
                x = 1
                y = 0.7
                z = 1
                --print("AutoFarming")
                if game.Workspace._map:FindFirstChild("namek mushroom model") then
                    print("Namak")
                    for i = 1, 6 do
                        local unitinfo = getgenv().SelectedUnits["U" .. i]
                        if unitinfo ~= nil then
                            local unitinfo_ = unitinfo:split(" #")
                            local pos = getgenv().SpawnUnitPos["Namak"]["UP" .. i]
    
                            --place units 0
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"], pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
    
                            --place units 1
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] - x, pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
    
                            --place units 2 
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"], pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
    
                            --place units 3 
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] - x, pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
    
                            --place units 4
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"]+ x, pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
    
                            --place units 5
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] + x, pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
                        end
                    end
                elseif game.Workspace._map:FindFirstChild("houses_new") then
                    print("Aot")
                    for i = 1, 6 do
                        local unitinfo = getgenv().SelectedUnits["U" .. i]
                        if unitinfo ~= nil then
                            local unitinfo_ = unitinfo:split(" #")
                            local pos = getgenv().SpawnUnitPos["Aot"]["UP" .. i]

                            --place units 0
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"], pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 1
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] - x, pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 2 
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"], pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 3 
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] - x, pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 4
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"]+ x, pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 5
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] + x, pos["y"] - y , pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
                        end
                    end
                elseif game.Workspace._map:FindFirstChild("Snow Particles") then
                    print("Snowy")
                    for i = 1, 6 do
                        local unitinfo = getgenv().SelectedUnits["U" .. i]
                        if unitinfo ~= nil then
                            local unitinfo_ = unitinfo:split(" #")
                            local pos = getgenv().SpawnUnitPos["Snowy"]["UP" .. i]

                            --place units 0
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"], pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 1
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] - x, pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 2 
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"], pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 3 
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] - x, pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 4
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"]+ x, pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 5
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] + x, pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
                        end
                    end
                elseif game.Workspace._map:FindFirstChild("sand_gate") then
                    print("Sand")
                    for i = 1, 6 do
                        local unitinfo = getgenv().SelectedUnits["U" .. i]
                        if unitinfo ~= nil then
                            local unitinfo_ = unitinfo:split(" #")
                            local pos = getgenv().SpawnUnitPos["Sand"]["UP" .. i]

                            --place units 0
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"], pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 1
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] - x, pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 2 
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"], pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 3 
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] - x, pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 4
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"]+ x, pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 5
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] + x, pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
                        end
                    end
                elseif game.Workspace._map:FindFirstChild("icebergs") then
                    print("Marine")
                    for i = 1, 6 do
                        local unitinfo = getgenv().SelectedUnits["U" .. i]
                        if unitinfo ~= nil then
                            local unitinfo_ = unitinfo:split(" #")
                            local pos = getgenv().SpawnUnitPos["Marine"]["UP" .. i]

                            --place units 0
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"], pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 1
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] - x, pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 2 
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"], pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 3 
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] - x, pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 4
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"]+ x, pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 5
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] + x, pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
                        end
                    end
                elseif game.Workspace._map:FindFirstChild("Helicopter Pad") then
                    print("Ghoul")
                    for i = 1, 6 do
                        local unitinfo = getgenv().SelectedUnits["U" .. i]
                        if unitinfo ~= nil then
                            local unitinfo_ = unitinfo:split(" #")
                            local pos = getgenv().SpawnUnitPos["Ghoul"]["UP" .. i]

                            --place units 0
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"], pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 1
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] - x, pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 2 
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"], pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 3 
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] - x, pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 4
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"]+ x, pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 5
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] + x, pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
                        end
                    end
                elseif game.Workspace._map:FindFirstChild("Bones/dust") then
                    print("Hollow")
                    for i = 1, 6 do
                        local unitinfo = getgenv().SelectedUnits["U" .. i]
                        if unitinfo ~= nil then
                            local unitinfo_ = unitinfo:split(" #")
                            local pos = getgenv().SpawnUnitPos["Hollow"]["UP" .. i]

                            --place units 0
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"], pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 1
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] - x, pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 2 
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"], pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 3 
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] - x, pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 4
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"]+ x, pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 5
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] + x, pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
                        end
                    end
                elseif game.Workspace._map:FindFirstChild("Ant Nest") then
                    print("Ant")
                    for i = 1, 6 do
                        local unitinfo = getgenv().SelectedUnits["U" .. i]
                        if unitinfo ~= nil then
                            local unitinfo_ = unitinfo:split(" #")
                            local pos = getgenv().SpawnUnitPos["Ant"]["UP" .. i]

                            --place units 0
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"], pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 1
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] - x, pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 2 
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"], pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 3 
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] - x, pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 4
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"]+ x, pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 5
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] + x, pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
                        end
                    end
                elseif game.Workspace._map:FindFirstChild("light poles") then
                    print("Magic")
                    for i = 1, 6 do
                        local unitinfo = getgenv().SelectedUnits["U" .. i]
                        if unitinfo ~= nil then
                            local unitinfo_ = unitinfo:split(" #")
                            local pos = getgenv().SpawnUnitPos["Magic"]["UP" .. i]

                            --place units 0
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"], pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 1
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] - x, pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 2 
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"], pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 3 
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] - x, pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 4
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"]+ x, pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))

                            --place units 5
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] + x, pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
                        end
                    end
                elseif game.Workspace._map:FindFirstChild("LanternsGround") then
                    print("Cursed")    
                    for i = 1, 6 do
                        local unitinfo = getgenv().SelectedUnits["U" .. i]
                        if unitinfo ~= nil then
                            local unitinfo_ = unitinfo:split(" #")
                            local pos = getgenv().SpawnUnitPos["Cursed"]["UP" .. i]
    
                            --place units 0
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"], pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
    
                            --place units 1
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] - x, pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
    
                            --place units 2 
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"], pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
    
                            --place units 3 
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] - x, pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
    
                            --place units 4
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"]+ x, pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
    
                            --place units 5
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] + x, pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
                        end
                    end
                elseif game.Workspace._map:FindFirstChild("pumpkins") then
                        print("thriller_park")    
                        for i = 1, 6 do
                            local unitinfo = getgenv().SelectedUnits["U" .. i]
                            if unitinfo ~= nil then
                                local unitinfo_ = unitinfo:split(" #")
                                local pos = getgenv().SpawnUnitPos["thriller_park"]["UP" .. i]
        
                                --place units 0
                                local args = {
                                    [1] = unitinfo_[2],
                                    [2] = CFrame.new(Vector3.new(pos["x"], pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                                }
                                game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
        
                                --place units 1
                                local args = {
                                    [1] = unitinfo_[2],
                                    [2] = CFrame.new(Vector3.new(pos["x"] - x, pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                                }
                                game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
        
                                --place units 2 
                                local args = {
                                    [1] = unitinfo_[2],
                                    [2] = CFrame.new(Vector3.new(pos["x"], pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                                }
                                game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
        
                                --place units 3 
                                local args = {
                                    [1] = unitinfo_[2],
                                    [2] = CFrame.new(Vector3.new(pos["x"] - x, pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                                }
                                game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
        
                                --place units 4
                                local args = {
                                    [1] = unitinfo_[2],
                                    [2] = CFrame.new(Vector3.new(pos["x"]+ x, pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                                }
                                game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
        
                                --place units 5
                                local args = {
                                    [1] = unitinfo_[2],
                                    [2] = CFrame.new(Vector3.new(pos["x"] + x, pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                                }
                                game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
                            end
                        end
                elseif game.Workspace._map:FindFirstChild("skeleton") then
                    print("black_clover")    
                    for i = 1, 6 do
                        local unitinfo = getgenv().SelectedUnits["U" .. i]
                        if unitinfo ~= nil then
                            local unitinfo_ = unitinfo:split(" #")
                            local pos = getgenv().SpawnUnitPos["black_clover"]["UP" .. i]
    
                            --place units 0
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"], pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
    
                            --place units 1
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] - x, pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
    
                            --place units 2 
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"], pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
    
                            --place units 3 
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] - x, pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
    
                            --place units 4
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"]+ x, pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
    
                            --place units 5
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] + x, pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
                        end
                    end
                elseif game.Workspace._map:FindFirstChild("graves") then
                    print("Hollow Legend")
                    for i = 1, 6 do
                        local unitinfo = getgenv().SelectedUnits["U" .. i]
                        if unitinfo ~= nil then
                            local unitinfo_ = unitinfo:split(" #")
                            local pos = getgenv().SpawnUnitPos["hollow_leg"]["UP" .. i]
    
                            --place units 0
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"], pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
    
                            --place units 1
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] - x, pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
    
                            --place units 2 
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"], pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
    
                            --place units 3 
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] - x, pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
    
                            --place units 4
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"]+ x, pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
    
                            --place units 5
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] + x, pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
                        end
                    end
                elseif game.Workspace._map:FindFirstChild("vending machines") then
                    print("chainsaw")
                    for i = 1, 6 do
                        local unitinfo = getgenv().SelectedUnits["U" .. i]
                        if unitinfo ~= nil then
                            local unitinfo_ = unitinfo:split(" #")
                            local pos = getgenv().SpawnUnitPos["chainsaw"]["UP" .. i]
    
                            --place units 0
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"], pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
    
                            --place units 1
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] - x, pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
    
                            --place units 2 
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"], pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
    
                            --place units 3 
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] - x, pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
    
                            --place units 4
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"]+ x, pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
    
                            --place units 5
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] + x, pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
                        end
                    end
                elseif game.Workspace._map:FindFirstChild("SpaceCenter") then
                    print("Cape Canaveral")
                    for i = 1, 6 do
                        local unitinfo = getgenv().SelectedUnits["U" .. i]
                        if unitinfo ~= nil then
                            local unitinfo_ = unitinfo:split(" #")
                            local pos = getgenv().SpawnUnitPos["jojo"]["UP" .. i]
    
                            --place units 0
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"], pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
    
                            --place units 1
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] - x, pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
    
                            --place units 2 
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"], pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
    
                            --place units 3 
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] - x, pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
    
                            --place units 4
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"]+ x, pos["y"] - y, pos["z"] + z), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
    
                            --place units 5
                            local args = {
                                [1] = unitinfo_[2],
                                [2] = CFrame.new(Vector3.new(pos["x"] + x, pos["y"] - y, pos["z"]), Vector3.new(0, 0, -1))
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.spawn_unit:InvokeServer(unpack(args))
                        end
                    end
                end
            end
        end
    end
end))
--#endregion



------// Auto Leave \\------
--#region Auto Leave 



--- Made by "HOLYSHz"
local PlaceID = 8304191830
local AllIDs = {}
local foundAnything = ""
local actualHour = os.date("!*t").hour
local Deleted = false

local last

local File = pcall(function()
   AllIDs = game:GetService('HttpService'):JSONDecode(readfile("NotSameServers.json"))
end)
if not File then
   table.insert(AllIDs, actualHour)
   writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
end

function TPReturner()
   local Site;
   if foundAnything == "" then
       Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100'))
   else
       Site = game.HttpService:JSONDecode(game:HttpGet('https://games.roblox.com/v1/games/' .. PlaceID .. '/servers/Public?sortOrder=Asc&limit=100&cursor=' .. foundAnything))
   end
   local ID = ""
   if Site.nextPageCursor and Site.nextPageCursor ~= "null" and Site.nextPageCursor ~= nil then
       foundAnything = Site.nextPageCursor
   end
   local num = 0;
   local extranum = 0
   for i,v in pairs(Site.data) do
       extranum += 1
       local Possible = true
       ID = tostring(v.id)
       if tonumber(v.maxPlayers) > tonumber(v.playing) then
           if extranum ~= 1 and tonumber(v.playing) < last or extranum == 1 then
               last = tonumber(v.playing)
           elseif extranum ~= 1 then
               continue
           end
           for _,Existing in pairs(AllIDs) do
               if num ~= 0 then
                   if ID == tostring(Existing) then
                       Possible = false
                   end
               else
                   if tonumber(actualHour) ~= tonumber(Existing) then
                       local delFile = pcall(function()
                           delfile("NotSameServers.json")
                           AllIDs = {}
                           table.insert(AllIDs, actualHour)
                       end)
                   end
               end
               num = num + 1
           end
           if Possible == true then
               table.insert(AllIDs, ID)
               wait()
               pcall(function()
                   writefile("NotSameServers.json", game:GetService('HttpService'):JSONEncode(AllIDs))
                   wait()
                   game:GetService("TeleportService"):TeleportToPlaceInstance(PlaceID, ID, game.Players.LocalPlayer)
               end)
               wait(4)
           end
       end
   end
end

function Teleport()
   while wait() do
       pcall(function()
           TPReturner()
           if foundAnything ~= "" then
               TPReturner()
           end
       end)
   end
end
-------------------------------------------

coroutine.resume(coroutine.create(function()
	local GameFinished = game:GetService("Workspace"):WaitForChild("_DATA"):WaitForChild("GameFinished")
    GameFinished:GetPropertyChangedSignal("Value"):Connect(function()
        print("Changed", GameFinished.Value == true)
        if GameFinished.Value == true then
            repeat task.wait() until  game:GetService("Players").LocalPlayer.PlayerGui.ResultsUI.Enabled == true
            task.wait()
            pcall(function() webhook() end)
            print("next")
            task.wait(2.1)
            if getgenv().AutoReplay then
                local a={[1]="replay"} game:GetService("ReplicatedStorage").endpoints.client_to_server.set_game_finished_vote:InvokeServer(unpack(a))
                local a={[1]="replay"} game:GetService("ReplicatedStorage").endpoints.client_to_server.set_game_finished_vote:InvokeServer(unpack(a))
            elseif getgenv().AutoLeave then
                --
                Teleport()
                -- game:GetService("TeleportService"):Teleport(8304191830, game.Players.LocalPlayer)
            end
        end
	end)
end))
--#endregion

------// Auto Sell Units \\------
coroutine.resume(coroutine.create(function()
while task.wait() do
    if getgenv().UnitSellTog then

        for i, v in pairs(game:GetService("Players")[game.Players.LocalPlayer.Name].PlayerGui.collection.grid.List.Outer.UnitFrames:GetChildren()) do
            if v.Name == "CollectionUnitFrame" then
                repeat task.wait() until v:FindFirstChild("name")
                for _, Info in next, getgenv().UnitCache do
                    if Info.name == v.name.Text and Info.rarity == getgenv().UnitToSell then
                        local args = {
                            [1] = {
                                [1] = tostring(v._uuid.Value)
                            }
                        }
                        game:GetService("ReplicatedStorage").endpoints.client_to_server.sell_units:InvokeServer(unpack(args))
                     end
                end
            end
        end
        
    end
end
end))

------// Auto Upgrade \\------
--#region Auto Upgrade Loop
getgenv().autoupgradeerr = false

function autoupgradefunc()
    local success, err = pcall(function() --///

        repeat task.wait() until game:GetService("Workspace"):WaitForChild("_UNITS")
        for i, v in ipairs(game:GetService("Workspace")["_UNITS"]:GetChildren()) do
           if v:FindFirstChild("_stats") then
                if tostring(v["_stats"].player.Value) == game.Players.LocalPlayer.Name and v["_stats"].xp.Value >= 0 then
                    game:GetService("ReplicatedStorage").endpoints.client_to_server.upgrade_unit_ingame:InvokeServer(v)
                end
            end
        end

    end)

    if err then
        warn("//////////////////////////////////////////////////")
        warn("//////////////////////////////////////////////////")
        getgenv().autoupgradeerr = true
        error(err)
    end
end

coroutine.resume(coroutine.create(function()
    while task.wait(2) do
        if getgenv().autoupgrade then
            if game.PlaceId ~= 8304191830 then
                pcall(function()
                    autoupgradefunc()
                end)
            end
            if  getgenv().autoupgradeerr == true then
                task.wait()
                autoupgradefunc()
                getgenv().autoupgradeerr = false
            end
        end
    end
end))
--#endregion


------// Auto Sell \\------
--#region Auto Sell loop
coroutine.resume(coroutine.create(function()
    while task.wait() do
        local _wave = game:GetService("Workspace"):WaitForChild("_wave_num")
        if getgenv().autosell and tonumber(getgenv().sellatwave) <= _wave.Value then
            getgenv().disableatuofarm = true
            if game.PlaceId ~= 8304191830 then
                repeat task.wait() until game:GetService("Workspace"):WaitForChild("_UNITS")
                for i, v in ipairs(game:GetService("Workspace")["_UNITS"]:GetChildren()) do
                    repeat
                        task.wait()
                    until v:WaitForChild("_stats")
                    if tostring(v["_stats"].player.Value) == game.Players.LocalPlayer.Name then
                        repeat
                            task.wait()
                        until v:WaitForChild("_stats"):WaitForChild("upgrade")
            
                        game:GetService("ReplicatedStorage").endpoints.client_to_server.sell_unit_ingame:InvokeServer(v)
                    end
                end
            end
        end
    end
end))
--#endregion

--//Auto Abilities--
--#region Auto Abilities loop
getgenv().autoabilityerr = false

function autoabilityfunc()
    local success, err = pcall(function() --///
        repeat task.wait() until game:GetService("Workspace"):WaitForChild("_UNITS")
        for i, v in ipairs(game:GetService("Workspace")["_UNITS"]:GetChildren()) do
            if v:FindFirstChild("_stats") then
                if v._stats:FindFirstChild("player") and v._stats:FindFirstChild("xp") then
                    if tostring(v["_stats"].player.Value) == game.Players.LocalPlayer.Name and v["_stats"].xp.Value > 0 then
                        game:GetService("ReplicatedStorage").endpoints.client_to_server.use_active_attack:InvokeServer(v)
                    end
                end
            end
        end
    end)
     
     if err then
         warn("//////////////////////////////////////////////////")
         warn("//////////////////////////////////////////////////")
         getgenv().autoabilityerr = true
         error(err)
     end

end

coroutine.resume(coroutine.create(function()

    while task.wait(2) do
        if getgenv().autoabilities then
            if game.PlaceId ~= 8304191830 then
                pcall(function()
                    autoabilityfunc()
                end)
            end
            if  getgenv().autoabilityerr == true then
                task.wait()
                autoabilityfunc()
                getgenv().autoabilityerr = false
            end
        end
    end   

end))
--#endregion


getgenv().teleporting = true

------// Auto Start \\------
--#region Auto Start loop

local function checkChallenge()
    for i,v in pairs(game.Players.LocalPlayer.PlayerGui:GetChildren()) do
        if v:IsA("SurfaceGui") then
            if v:FindFirstChild("ChallengeCleared") then
                --print(v.ChallengeCleared.Visible)
                return v.ChallengeCleared.Visible
            end
        end
    end
end

local function checkReward()
    if checkChallenge() == false then
        if getgenv().selectedreward == game:GetService("Workspace")["_LOBBIES"]["_DATA"]["_CHALLENGE"]["current_reward"].Value then
            return true
        elseif getgenv().AutoChallengeAll then
            return true
        else
            return false
        end
    else
        return false
    end
end


local function startfarming()
    if getgenv().farmprotal == false and getgenv().autostart and getgenv().AutoFarm and getgenv().teleporting 
                           and getgenv().AutoFarmTP == false and getgenv().AutoFarmIC == false then

        if game.PlaceId == 8304191830 then
            local cpos = plr.Character.HumanoidRootPart.CFrame

            if tostring(Workspace._LOBBIES.Story[getgenv().door].Owner.Value) ~= plr.Name then
                for i, v in pairs(game:GetService("Workspace")["_LOBBIES"].Story:GetDescendants()) do
                    if v.Name == "Owner" and v.Value == nil then

                        local args = {
                            [1] = tostring(v.Parent.Name)
                        }
                        game:GetService("ReplicatedStorage").endpoints.client_to_server.request_join_lobby:InvokeServer(unpack(args))
                    
                        task.wait()
                    
                        if getgenv().level:match("infinite") then
                            local args = {
                                [1] = tostring(v.Parent.Name), -- Lobby 
                                [2] = getgenv().level, -- World
                                [3] = true, -- Friends Only or not
                                [4] = "Hard"
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.request_lock_level:InvokeServer(unpack(args))
                        else
                            local args = {
                                [1] = tostring(v.Parent.Name), -- Lobby 
                                [2] = getgenv().level, -- World
                                [3] = true, -- Friends Only or not
                                [4] = getgenv().difficulty
                            }
                            game:GetService("ReplicatedStorage").endpoints.client_to_server.request_lock_level:InvokeServer(unpack(args))
                        end

                        local args = { 
                            [1] =tostring(v.Parent.Name)
                        }
                        game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_game:InvokeServer(unpack(args))
                        getgenv().door = v.Parent.Name print(v.Parent.Name) --v.Parent:GetFullName()
                        plr.Character.HumanoidRootPart.CFrame = v.Parent.Door.CFrame
                        break
                    end
                end
            end

            task.wait()

            plr.Character.HumanoidRootPart.CFrame = cpos

            if Workspace._LOBBIES.Story[getgenv().door].Owner == plr.Name then
                if Workspace._LOBBIES.Story[getgenv().door].Teleporting.Value == true then
                    getgenv().teleporting = false
                else
                    getgenv().teleporting = true
                end
            end

            warn("farming")
            task.wait(3)
        end
    elseif getgenv().autostart and getgenv().AutoFarm and getgenv().teleporting 
                           and getgenv().AutoFarmTP == false and getgenv().AutoFarmIC == false and getgenv().farmprotal or getgenv().farmprotal then

        for i,v in pairs(game:GetService("Players").LocalPlayer.PlayerGui.items.grid.List.Outer.ItemFrames:GetChildren()) do
            if v.Name == "portal_csm" or v.Name == "portal_csm1" or v.Name == "portal_csm2" or v.Name == "portal_csm3" or v.Name == "portal_csm4" or v.Name == "portal_csm5"  then
                print(v._uuid_or_id.value)
                getgenv().PortalID = v._uuid_or_id.value
                break;
            end
        end
          task.wait(1.5)

          local args = {
            [1] = tostring(getgenv().PortalID),
            [2] = {
                ["friends_only"] = true
            }
        }
        
        game:GetService("ReplicatedStorage").endpoints.client_to_server.use_portal:InvokeServer(unpack(args))

        task.wait(1.5)

        for i,v in pairs(game:GetService("Workspace")["_PORTALS"].Lobbies:GetDescendants()) do
            if v.Name == "Owner" then
                if tostring(v.value) == game.Players.LocalPlayer.Name then
                    local args = {
                        [1] = tostring(v.Parent.Name)
                    }
                    
                    game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_game:InvokeServer(unpack(args))
                    break;
                end
            end 
        end
        

        task.wait(7)
    end
end

local function startChallenge()
    if game.PlaceId == 8304191830 then
        local cpos = plr.Character.HumanoidRootPart.CFrame

        if getgenv().AutoChallenge and getgenv().autostart and getgenv().AutoFarm  and checkReward() == true then

            for i, v in pairs(game:GetService("Workspace")["_CHALLENGES"].Challenges:GetDescendants()) do
                if v.Name == "Owner" and v.Value == nil then
                    --print(v.Parent.Name.." "..v.Parent:GetFullName())
                    local args = { 
                        [1] = tostring(v.Parent.Name)
                    }
                    game:GetService("ReplicatedStorage").endpoints.client_to_server.request_join_lobby:InvokeServer(unpack(args))

                    getgenv().chdoor = v.Parent.Name
                    break
                end
            end
            task.wait()
            plr.Character.HumanoidRootPart.CFrame = cpos
           
        end
    end
end

coroutine.resume(coroutine.create(function()
    while task.wait() do
        if getgenv().AutoFarmIC == false and getgenv().AutoFarmTP == false then
            if checkChallenge() == false  then --challenge is not cleared
                if  getgenv().AutoChallenge and checkReward() == true then
                    startChallenge() --start challenge
                else
                    startfarming()--regular farming
                end
            elseif checkChallenge() == true then
                startfarming()--regular farming
            end
        end
    end
end))
--#endregion


------// Auto Start Infiniy Castle && Thriller Park \\------

local function FarmCastlePark()
    if getgenv().AutoFarmIC and getgenv().AutoFarm then
        if game.PlaceId == 8304191830 then

            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(12423.1855, 155.24025, 3198.07593, -1.34111269e-06, -2.02512282e-08, 1, 3.91705386e-13, 1, 2.02512282e-08, -1, 4.18864542e-13, -1.34111269e-06)
            
            getgenv().infinityroom = 0

            for i, v in pairs(game:GetService("Players")[game.Players.LocalPlayer.Name].PlayerGui.InfiniteTowerUI.LevelSelect.InfoFrame.LevelButtons:GetChildren()) do
                if v.Name == "FloorButton" then
                    if v.clear.Visible == false and v.Locked.Visible == false then
                        local room = string.split(v.Main.text.Text, " ")

                        local args = {
                            [1] = tonumber(room[2])
                        }
                        
                        game:GetService("ReplicatedStorage").endpoints.client_to_server.request_start_infinite_tower:InvokeServer(unpack(args))
                        getgenv().infinityroom = tonumber(room[2])
                        break
                    end
                end
            end
            
            task.wait(6)
        end
    elseif getgenv().AutoFarmTP and getgenv().AutoFarm then
        if game.PlaceId == 8304191830 then

            local cpos = plr.Character.HumanoidRootPart.CFrame

            for i, v in pairs(game:GetService("Workspace")["_EVENT_CHALLENGES"].Lobbies:GetDescendants()) do
                    if v.Name == "Owner" and v.Value == nil then

                        local args = {
                            [1] = tostring(v.Parent.Name)
                        }
                        
                        game:GetService("ReplicatedStorage").endpoints.client_to_server.request_join_lobby:InvokeServer(unpack(args))

                        task.wait()

                        plr.Character.HumanoidRootPart.CFrame = v.Parent.Door.CFrame
                        break
                    end
                end

            task.wait()

            plr.Character.HumanoidRootPart.CFrame = cpos
            warn("farming")
            task.wait(5)

        end
    end
end

coroutine.resume(coroutine.create(function()
    while task.wait() do
        if checkChallenge() == false  then --challenge is not cleared
            if  getgenv().AutoChallenge and checkReward() == true then
                startChallenge() --start challenge
            else
                FarmCastlePark()--regular farming
            end
        elseif checkChallenge() == true then
            FarmCastlePark()--regular farming
        end
    end
end))

if getgenv().AutoLoadTP == true then
    local exec = tostring(identifyexecutor())

    if exec == "Synapse X" then
        syn.queue_on_teleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/siradaniy/HSz/main/AA_HSz.lua'))()")
    else
        queue_on_teleport("loadstring(game:HttpGet('https://raw.githubusercontent.com/siradaniy/HSz/main/AA_HSz.lua'))()")
    end

end


--hide name
task.spawn(function()  -- Hides name for yters (not sure if its Fe)
    while task.wait() do
        pcall(function()
            if game.Players.LocalPlayer.Character.Head:FindFirstChild("_overhead") then
               workspace[game.Players.LocalPlayer.Name].Head["_overhead"]:Destroy()
            end
        end)
    end
end)

--anti afk
pcall(function()
    local vu = game:GetService("VirtualUser")
    game:GetService("Players").LocalPlayer.Idled:connect(function()
    vu:Button2Down(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    wait(1)
    vu:Button2Up(Vector2.new(0,0),workspace.CurrentCamera.CFrame)
    end)

    game:GetService("ReplicatedStorage").endpoints.client_to_server.claim_daily_reward:InvokeServer()
end)

print("Successfully Loaded!!")
---------------------------------------------------------------------
