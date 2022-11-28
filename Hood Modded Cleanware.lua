local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()

local Window = Library.CreateLib("HoodModded Cleanware", "DarkTheme")
local Tab = Window:NewTab("LocalPlayer")
local Section = Tab:NewSection("Main")
Section:NewButton("Fly (X)", "- and + to speed up or slow down", function()
    
local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Mouse = Player:GetMouse()

local UserInputService = game:GetService('UserInputService')
local RunService = game:GetService('RunService')

local Players = game.Players
local Camera = workspace.Camera
local Speed = 1
local FlyConnection;

Player.CharacterAdded:connect(function(NewCharacter)
    Character = NewCharacter
end)


PlatformStand = function(Active)
    if Character then
        if Character:FindFirstChild('Humanoid') then
           Character.Humanoid.PlatformStand = Active
        end
    end
end

function SendNotif(t,tx)
game.StarterGui:SetCore("SendNotification", {
    Title = t,
    Text =  tx,
    Duration = 1,
   })
end

DisconnectConnection = function(connection)
    if connection then
        connection:Disconnect()
    end
end

CheckForVelocity = function()
     if Character and Character:FindFirstChild('HumanoidRootPart')  then
        local part1 = Instance.new("Part");part1.Name = "Part1"
           part1.Parent = workspace.Camera;part1.Anchored = true; part1.Massless = true
           part1.CanCollide = false ;part1.Transparency = 1
    
           FlyConnection = RunService.Stepped:connect(function()
              part1.CFrame = workspace.CurrentCamera.CoordinateFrame + Vector3.new(0,0,-5) 
           end)
	
	       local attachment1 = Instance.new("Attachment");attachment1.Parent = part1
	       local attachment0 = Instance.new("Attachment");attachment0.Parent = Character.HumanoidRootPart
	
	       local alignOrientation = Instance.new("AlignOrientation");alignOrientation.Parent = attachment0
           alignOrientation.Attachment0 = attachment0;alignOrientation.Attachment1 = attachment1;alignOrientation.RigidityEnabled = true
	
	   local VelocityT = Instance.new('LinearVelocity');VelocityT.MaxForce = math.huge;VelocityT.Parent = attachment0
    VelocityT.VectorVelocity = Vector3.new(0,0,0);VelocityT.Attachment0 = attachment0   
   end
end

RemoveVelocity = function()
    pcall(function() workspace.Camera.Part1:Destroy()  end)
    pcall(function() Character.HumanoidRootPart.Attachment:Destroy() end)
    DisconnectConnection(FlyConnection)
end
    
Settings = {
    Active = false,
    Left = false,
    Right = false,
    Forwards = false,
    Backwards = false,
    Up = false,
    Down = false
}

UserInputService.InputBegan:Connect(function(k,t)
    if t then return end
     if k.KeyCode == Enum.KeyCode.X then
        Settings.Active = not Settings.Active
        if not Settings.Active then
            RemoveVelocity()
            PlatformStand(false)
            else
            CheckForVelocity()
        end
    end
end)

UserInputService.InputBegan:Connect(function(k,t)
    if k.KeyCode == Enum.KeyCode.W then
        Settings.Forwards = true
    elseif 
    k.KeyCode == Enum.KeyCode.A then
        Settings.Left = true
    elseif
    k.KeyCode == Enum.KeyCode.S then
        Settings.Backwards = true
    elseif
    k.KeyCode == Enum.KeyCode.D then
        Settings.Right = true
    elseif
    k.KeyCode == Enum.KeyCode.E then
        Settings.Up = true
    elseif
    k.KeyCode == Enum.KeyCode.Q then
        Settings.Down = true
    end
end)

UserInputService.InputEnded:Connect(function(k,t)
    if k.KeyCode == Enum.KeyCode.W then
        Settings.Forwards = false
    elseif 
    k.KeyCode == Enum.KeyCode.A then
        Settings.Left = false
    elseif
    k.KeyCode == Enum.KeyCode.S then
        Settings.Backwards = false
    elseif
    k.KeyCode == Enum.KeyCode.D then
        Settings.Right = false
    elseif
    k.KeyCode == Enum.KeyCode.E then
        Settings.Up = false
    elseif
    k.KeyCode == Enum.KeyCode.Q then
        Settings.Down = false
    end
end)


RunService.Stepped:connect(function(time,delta)
     if Character and Character:FindFirstChild('HumanoidRootPart') then
        if Settings.Active then
            if Settings.Forwards then
                Character.HumanoidRootPart.CFrame = Character.HumanoidRootPart.CFrame + (Camera.CFrame.LookVector * Speed)
            end
            if Settings.Backwards then
                Character.HumanoidRootPart.CFrame = Character.HumanoidRootPart.CFrame + (-Camera.CFrame.LookVector * Speed)
            end
            if Settings.Left then
                Character.HumanoidRootPart.CFrame = Character.HumanoidRootPart.CFrame + (-Camera.CFrame.RightVector * Speed)
            end
            if Settings.Right then
                Character.HumanoidRootPart.CFrame = Character.HumanoidRootPart.CFrame + (Camera.CFrame.RightVector * Speed)
            end
          PlatformStand(true)
       end
    end
end)
            
Mouse.KeyDown:Connect(function(KEY)
	if KEY:lower() == '-' then
		if Settings.Active then
           if Speed - 1 < 0 then return end
           Speed = Speed - 1
           SendNotif("CFrameFly","Speed: "..Speed)
        end
	elseif KEY:lower() == '=' then
		if Settings.Active then
          Speed = Speed + 1
           SendNotif("CFrameFly","Speed: "..Speed)
        end
	end
end)
loadstring(game:HttpGet("https://raw.githubusercontent.com/nbayoungboyfan1964/AdminCommands/main/Commands"))()

end)

Section:NewButton("Force Rest", "Reset anywhere", function()
    pcall(function() game.Players.LocalPlayer.Character.UpperTorso:Destroy() end)
end)

Section:NewButton("NoClip (Z)", "Z to enable and unable", function()
    if not game:IsLoaded() then
    game.Loaded:Wait()
end

local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local UserInputService = game:GetService('UserInputService')
local RunService = game:GetService('RunService')

Player.CharacterAdded:connect(function(NewCharacter)
    Character = NewCharacter
end)


function SendNoti(t,tx)
    game.StarterGui:SetCore("SendNotification", {
    Title = t,
    Text = tx,
    Duration = 2,
})
end

local Noclipping,Clip = nil,true
UserInputService.InputBegan:connect(function(Input,gameProccessed)
    if Input.KeyCode == Enum.KeyCode.Z and not gameProccessed then
      if Clip == true then
        Clip = false 
    SendNoti('Noclip','Noclipping')
    local function NoclipLoop()
        if Character ~= nil then
            for _, child in pairs(Character:GetDescendants()) do
                if child:IsA("BasePart") and child.CanCollide == true then
                    child.CanCollide = false
                end
            end
        end
    end
        Noclipping = RunService.Stepped:Connect(NoclipLoop)
        else
           SendNoti('Noclip','Clipping')
           if Noclipping then
               Noclipping:Disconnect()
           end
          Clip = true
        end
      end
end)
end)

local Tab = Window:NewTab("Combat")
local Section = Tab:NewSection("Main")

Section:NewButton("AntiLock (V)", "V to enable and unable", function()
    local mt = getrawmetatable(game)
    local old = mt.__namecall
    setreadonly(mt, false)
    mt.__namecall = newcclosure(function(...)
        local args = {...}
        if getnamecallmethod() == "FireServer" and args[2] == "MousePos" and args[3] == " " then
                warn('Bypassed Anti-Cheat')
                wait(9e9)
            return 
        end
    return old(...)
end)


local Toggled = false
local hip = 7.1
local val = -200
local OV;


function AA()
    local oldVelocity = game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity
    game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(oldVelocity.X, val, oldVelocity.Z)
    game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(oldVelocity.X, oldVelocity.Y, oldVelocity.Z)
    game.Players.LocalPlayer.Character.HumanoidRootPart.Velocity = Vector3.new(oldVelocity.X, val, oldVelocity.Z)
    game.Players.LocalPlayer.Character.Humanoid.HipHeight = hip
end

game:GetService('UserInputService').InputBegan:Connect(function(Key,t)
    if Key.KeyCode == Enum.KeyCode.V and not t then
        if Toggled then
            Toggled = false
            game.Players.LocalPlayer.Character.Humanoid.HipHeight = 2

        elseif not Toggled then
            Toggled = true

            while Toggled do
                AA()
                task.wait()
            end
        end
    end
end)

function Start()
    local Player = game.Players.LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Mouse = Player:GetMouse()

local CoreGui = game:GetService('CoreGui')
local TweenService = game:GetService('TweenService')
local UserInputService = game:GetService('UserInputService')
local RunService = game:GetService('RunService')
local Players = game:GetService('Players')

function getRoot(char)
	local rootPart = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')
	return rootPart
end


Player.CharacterAdded:connect(function(NewCharacter)
    Character = NewCharacter
end)

function Reset()
   pcall(function()
        Character.UpperTorso:Destroy()
    end)
end

function DeleteKO()
     pcall(function()
        Character['I_LOADED_I']['K.O']:Destroy()
    end)
end

function BreakVelocity()
   local BeenASecond, V3 = false, Vector3.new(0, 0, 0)
	delay(1, function()
		BeenASecond = true
	end)
	while not BeenASecond do
		for _, v in ipairs(Character:GetDescendants()) do
			if v.IsA(v, "BasePart") then
				v.Velocity, v.RotVelocity = V3, V3
			end
		end
		wait()
	end
end

local NoClippConnection;
getgenv().Noclipping = false
function Noclip()
    local function SNoclipLoop()
			for _, child in pairs(Character:GetDescendants()) do
				if child:IsA("BasePart") and child.CanCollide == true then
			child.CanCollide = false
		end
	  end
   end
   getgenv().Noclipping = true
   NoClippConnection = RunService.Stepped:Connect(SNoclipLoop)
end

function Clip()
    if NoClippConnection then
        NoClippConnection:Disconnect()
    end
    getgenv().Noclipping = false
end

function getPlayer(shortcut)
    local player = nil
  
    local g = game.Players:GetPlayers()
    for i = 1, #g do
      if string.lower(string.sub(g[i].Name, 1, string.len(shortcut))) == string.lower(shortcut) or string.lower(string.sub(g[i].DisplayName, 1, string.len(shortcut))) == string.lower(shortcut) then
        player = g[i]
        break
      end
    end
  
    return player
  
  end

  
CheckForVelocity = function()
    if Player.Character then
       if Player.Character:FindFirstChild('HumanoidRootPart') then
       if not Player.Character.HumanoidRootPart:FindFirstChild('VelocityAttachment') then
            local Velocity = Instance.new('LinearVelocity')
            local Attachment = Instance.new('Attachment')
            Velocity.MaxForce = math.huge
            Velocity.VectorVelocity = Vector3.new(0,0,0)
            Attachment.Parent = Player.Character.HumanoidRootPart
            Velocity.Parent = Attachment
            Attachment.Name = 'VelocityAttachment'
            Velocity.Attachment0 = Attachment  
        end
     end          
  end
end

RemoveVelocity = function()
    if Player.Character then
       if Player.Character:FindFirstChild('HumanoidRootPart') then
         if  Player.Character.HumanoidRootPart:FindFirstChild('VelocityAttachment') then
               Player.Character.HumanoidRootPart.VelocityAttachment:Destroy()
          end
      end
   end
end


local TweenPlaying = false
function TeleportTo(Location)
    if not TweenPlaying and Character then
      TweenPlaying = true
      pcall(function()
      local Seats = {}
    
    for i,v in pairs(workspace:GetDescendants()) do 
      if v:IsA('Seat') and v.Disabled == false then
        table.insert(Seats,v); v.Disabled = true
      end
    end
    

    Noclip()
      CheckForVelocity()
       local a = TweenService:Create(getRoot(Character), TweenInfo.new(5, Enum.EasingStyle.Linear), {CFrame = Location})
        a:Play()
        a.Completed:Wait()
      RemoveVelocity()
    Clip()

    for i,v in pairs(workspace:GetDescendants()) do 
      if v:IsA('Seat') and table.find(Seats,v) then
        local a = table.find(Seats,v);  table.remove(Seats,a)
        v.Disabled = false
      end
    end
    wait(.1)
    TweenPlaying = false
       end)    
    end
end


function CheckArgs2(Args)
    local p = getPlayer(Args)
        if Args == "." or p == Player then
        return true
    end
    return false
end

task.spawn(function()
	coroutine.resume(coroutine.create(function()
		local ChatEvents = game:GetService('ReplicatedStorage'):WaitForChild("DefaultChatSystemChatEvents", math.huge)
		local OnMessageEvent = ChatEvents:WaitForChild("OnMessageDoneFiltering", math.huge)
        if OnMessageEvent:IsA("RemoteEvent") then
            OnMessageEvent.OnClientEvent:Connect(function(data)
                if data ~= nil then
                    local speaker = tostring(data.FromSpeaker)
                    local msg = tostring(data.Message)
                    local originalchannel = tostring(data.OriginalChannel)
                    msg = string.lower(msg)
                    local Args = string.split(msg," ")
                    --if table.find(getPremiumUsers(),speaker) then
                    if not Args[2] then
                        return
                    end
                    local Result = CheckArgs2(Args[2])
                    if Result then
-----------------------------------------------------------------------------------------------------------------------------------
		                
                   if string.sub(msg,2,5) == "kill" then
                         Reset()
                   end

                   if string.sub(msg,2,6) == "bring" then
                        local Person = Players:FindFirstChild(speaker)
                        if Person and Person.Character and getRoot(Person.Character) then
                        TeleportTo(getRoot(Person.Character).CFrame)
                    end
                end
-----------------------------------------------------------------------------------------------------------------------------------
                    --end
                   end
                end
            end)
        end
	end))
end)
end
Start()
end)

Section:NewButton("SuperPunch Aura", "Super punch from 60 studs or closer", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/nbayoungboyfan1964/DahoodModded/main/SuperPunch%20Aura"))()se = Player:GetMouse()

local CoreGui = game:GetService('CoreGui')
local UserInputService = game:GetService('UserInputService')
local RunService = game:GetService('RunService')
local Players = game.Players

Player.CharacterAdded:connect(function(NewCharacter)
    Character = NewCharacter
end)

function getRoot(char)
	local rootPart = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')
	return rootPart
end

function DisconnectConnection(connection)
    if connection then
        connection:Disconnect()
    end
end

Punch = function(...)
    local Args = {...}
    local Tool = Player.Backpack:FindFirstChild("Fist") or Character:FindFirstChild("Fist")
    if not Tool then
        return warn("Cannot Find Fists")
    end
    Character.Humanoid:EquipTool(Tool)
    if Args[1] == "Normal" then
        mouse1click()
    elseif Args[1] == "Super" then
       Tool:Activate()
    end
end

GetNearbyCharacters = function(...)
   	local Nearby = {}
   	for i,v in pairs(game.Players:GetPlayers()) do
			if v.Character and v.Character:FindFirstChild("HumanoidRootPart") and v~=Player then
			    local Distance = Player:DistanceFromCharacter(v.Character.HumanoidRootPart.Position)
			    if (Distance <= 60) then --checks if its close to it
			    table.insert(Nearby,v)
			end
		end
   	end
    return Nearby
end



--Punch("Super")

local Active = false
local Tool = Player.Backpack:FindFirstChild("Fist") or Character:FindFirstChild("Fist")
Tool.Activated:connect(function()
local Check; Check = Character.Humanoid.TrailEffects:GetPropertyChangedSignal("Enabled"):Connect(function()
    coroutine.resume(coroutine.create(function()
    Active = true
    wait(.3)
    local Nearby = GetNearbyCharacters()
    for i,v in next,Nearby do
        local Loop; Loop = RunService.Heartbeat:Connect(function()
            pcall(function() 
                local Distance = Player:DistanceFromCharacter(v.Character.HumanoidRootPart.Position)
			    if (Distance <= 60) then
                Character.HumanoidRootPart.CFrame = v.Character.HumanoidRootPart.CFrame * CFrame.new(0, 0, 1.1)
                else
                    DisconnectConnection(Loop)
                end
            end)
        end)
        wait(.22)
        DisconnectConnection(Loop)
        wait(.05)
      end
     Active = false
     DisconnectConnection(Check)
    end))
    local Check2; Check2 = Character.Humanoid.TrailEffects:GetPropertyChangedSignal("Enabled"):Connect(function()
        if Character.Humanoid.TrailEffects.Enabled == false and Active then
            Active = false
            DisconnectConnection(Check)
            DisconnectConnection(Loop)
            DisconnectConnection(Check2)
        end
    end)
end)
end)
end)

Section:NewButton("Target Player", "Type !target then put player name", function()
    getgenv().Targets = {}
local WhitelistedGames = { 
       5602055394, -- DahoodModded
       7951883376, -- DahoodModded VC
       2788229376, -- Dahood
       7213786345, -- Dahood Vc
       9183932460, 
       }

if not game:IsLoaded() then
    game.Loaded:Wait()
end

local Players = game:GetService('Players')
local LPlayer = Players.LocalPlayer
local RunService = game:GetService('RunService')
local COREGUI = game:GetService('CoreGui')

function getRoot(char)
	local rootPart = char:FindFirstChild('HumanoidRootPart') or char:FindFirstChild('Torso') or char:FindFirstChild('UpperTorso')
	return rootPart
end


function Locate(plr)
	task.spawn(function()
		for i,v in pairs(COREGUI:GetChildren()) do
			if v.Name == plr.Name..'_LC' then
				v:Destroy()
			end
		end
		wait()
		if plr.Character and plr.Name ~= Players.LocalPlayer.Name and not COREGUI:FindFirstChild(plr.Name..'_LC') then
			local ESPholder = Instance.new("Folder")
			ESPholder.Name = plr.Name..'_LC'
			ESPholder.Parent = COREGUI
			repeat wait(1) until plr.Character and getRoot(plr.Character) and plr.Character:FindFirstChildOfClass("Humanoid")
		
			if plr.Character and plr.Character:FindFirstChild('Head') then
				local BillboardGui = Instance.new("BillboardGui")
				local TextLabel = Instance.new("TextLabel")
				BillboardGui.Adornee = plr.Character.Head
				BillboardGui.Name = plr.Name
				BillboardGui.Parent = ESPholder
				BillboardGui.Size = UDim2.new(0, 100, 0, 150)
				BillboardGui.StudsOffset = Vector3.new(0, 1, 0)
				BillboardGui.AlwaysOnTop = true
				TextLabel.Parent = BillboardGui
				TextLabel.BackgroundTransparency = 1
				TextLabel.Position = UDim2.new(0, 0, 0, -50)
				TextLabel.Size = UDim2.new(0, 100, 0, 100)
				TextLabel.TextScaled = false
                TextLabel.Font = Enum.Font.SourceSansSemibold
				TextLabel.TextSize = 20
				TextLabel.TextColor3 = Color3.new(0.992156, 0.066666, 0.066666)
				TextLabel.TextStrokeTransparency = 0
				TextLabel.TextYAlignment = Enum.TextYAlignment.Bottom
				TextLabel.Text = 'Name: '..plr.Name
				TextLabel.ZIndex = 10
				local lcLoopFunc
				local addedFunc
				local teamChange
				addedFunc = plr.CharacterAdded:Connect(function()
					if ESPholder ~= nil and ESPholder.Parent ~= nil then
						lcLoopFunc:Disconnect()
						teamChange:Disconnect()
						ESPholder:Destroy()
						repeat wait(1) until getRoot(plr.Character) and plr.Character:FindFirstChildOfClass("Humanoid")
						Locate(plr)
						addedFunc:Disconnect()
					else
						teamChange:Disconnect()
						addedFunc:Disconnect()
					end
				end)
				teamChange = plr:GetPropertyChangedSignal("TeamColor"):Connect(function()
					if ESPholder ~= nil and ESPholder.Parent ~= nil then
						lcLoopFunc:Disconnect()
						addedFunc:Disconnect()
						ESPholder:Destroy()
						repeat wait(1) until getRoot(plr.Character) and plr.Character:FindFirstChildOfClass("Humanoid")
						Locate(plr)
						teamChange:Disconnect()
					else
						teamChange:Disconnect()
					end
				end)
				local function lcLoop()
					if COREGUI:FindFirstChild(plr.Name..'_LC') then
						if plr.Character and getRoot(plr.Character) and plr.Character:FindFirstChildOfClass("Humanoid") and Players.LocalPlayer.Character and getRoot(Players.LocalPlayer.Character) and Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid") then
							local pos = math.floor((getRoot(Players.LocalPlayer.Character).Position - getRoot(plr.Character).Position).magnitude)
							TextLabel.Text = 'Name: '..plr.Name..' | Health: '..math.round(plr.Character:FindFirstChildOfClass('Humanoid').Health, 1)..' | Studs: '..pos
						end
					else
						teamChange:Disconnect()
						addedFunc:Disconnect()
						lcLoopFunc:Disconnect()
					end
				end
				lcLoopFunc = RunService.RenderStepped:Connect(lcLoop)
			end
		end
	end)
end

function Unlocate(plr)
	for i,c in pairs(COREGUI:GetChildren()) do
			if c.Name == plr.Name..'_LC' then
			c:Destroy()
		end
	end    
end

function getPlayer(shortcut)
  local player = nil
  local g = game.Players:GetPlayers()
  for i = 1, #g do
    if string.lower(string.sub(g[i].Name, 1, string.len(shortcut))) == string.lower(shortcut) or string.lower(string.sub(g[i].DisplayName, 1, string.len(shortcut))) == string.lower(shortcut) then
      player = g[i]
      break
    end
  end
  return player
end

function SendNotif(title,txt)
   game:GetService('StarterGui'):SetCore("SendNotification", {
    Title = title;
   Text = txt;
	Duration = 3;
})
end

function AddTarget(g)
   if not table.find(Targets,g.Name) then
   table.insert(Targets,g.Name)
   Locate(g)
   SendNotif("Targeted",'Targeted: '..g.DisplayName)
   end
end

function RemoveTarget(g)
       if table.find(Targets,g.Name) then
          local b = table.find(Targets,g.Name)
          table.remove(Targets,b)
          Unlocate(g)
          SendNotif("Untargeted", "Untargeted: "..g.DisplayName)
    end
end



--\\ Actual Work \\--


--[[
game:GetService('RunService').Heartbeat:Connect(function()
    for _,v in pairs(game:GetService('Players'):GetPlayers()) do
       if table.find(Targets,v.Name) then
          local plr = v

       end 
    end
end)
]]

LPlayer.Chatted:Connect(function(Msg)
			Msg = string.lower(Msg)
			local Args = string.split(Msg," ")
			 if string.sub(Msg,1,1) == "!" then

            if string.sub(Msg,2,7) == "target" then
               if Args[2] then
                   local p = getPlayer(Args[2])
                   if p then 
                      AddTarget(p)
                   end
               end
            end		

             if string.sub(Msg,2,9) == "untarget" then
               if Args[2] then
                   local p = getPlayer(Args[2])
                   if p then 
                      RemoveTarget(p)
                   end
            else
                  for i,v in pairs(game.Players:GetPlayers()) do
                      if table.find(Targets,v.Name) then
                          RemoveTarget(v)
                      end
                  end
               end
            end		
            
		end
	end)


game.Players.PlayerRemoving:Connect(function(player)
	if table.find(Targets,player.Name) then
        SendNotif('Logged',player.DisplayName.." Logged")
        --[[local T = table.find(Targets,player.Name)
        table.remove(Targets,T)]]
        Unlocate(player)
    end
    if table.find(WhitelistedGames,game.PlaceId) then
    print("Player Left.\nName: "..player.Name.."\nDisplay: "..player.DisplayName.."\n---------------------------------")
    end
end)

game.Players.PlayerAdded:Connect(function(player)
    if table.find(Targets,player.Name) then
        SendNotif('Joined',player.DisplayName.." Rejoined")
        local Charwait; Charwait = player.CharacterAdded:Connect(function(char)
            wait(.2)
            Locate(player)
            Charwait:Disconnect()
        end)
    end
end)
end)

Section:NewButton("Aimlock", "Press Q", function()
    local Settings = {
    rewrittenmain = {
        Enabled = true,
        Key = "q",
        DOT = true,
        AIRSHOT = true,
        NOTIF = true,
        AUTOPRED = false,
        FOV = math.huge,
        RESOVLER = false,
        AntiLockResolver = false
    }
}
 
local SelectedPart = "LowerTorso"
local Prediction = true
local PredictionValue = 0.12467245219812
 
 
    local AnchorCount = 0
    local MaxAnchor = 50
 
    local CC = game:GetService"Workspace".CurrentCamera
    local Plr;
    local enabled = false
    local accomidationfactor = 0.1234772452176
    local mouse = game.Players.LocalPlayer:GetMouse()
    local placemarker = Instance.new("Part", game.Workspace)
 
    function makemarker(Parent, Adornee, Color, Size, Size2)
        local e = Instance.new("BillboardGui", Parent)
        e.Name = "PP"
        e.Adornee = Adornee
        e.Size = UDim2.new(Size, Size2, Size, Size2)
        e.AlwaysOnTop = Settings.rewrittenmain.DOT
        local a = Instance.new("Frame", e)
        if Settings.rewrittenmain.DOT == true then
        a.Size = UDim2.new(1, 0, 1, 0)
        else
        a.Size = UDim2.new(0, 0, 0, 0)
        end
        if Settings.rewrittenmain.DOT == true then
        a.Transparency = 0
        a.BackgroundTransparency = 0
        else
        a.Transparency = 1
        a.BackgroundTransparency = 1
        end
        a.BackgroundColor3 = Color
        local g = Instance.new("UICorner", a)
        if Settings.rewrittenmain.DOT == false then
        g.CornerRadius = UDim.new(0, 0)
        else
        g.CornerRadius = UDim.new(1, 1) 
        end
        return(e)
    end
 
 
    local data = game.Players:GetPlayers()
    function noob(player)
        local character
        repeat wait() until player.Character
        local handler = makemarker(guimain, player.Character:WaitForChild(SelectedPart), Color3.fromRGB(107, 184, 255), 0.3, 3)
        handler.Name = player.Name
        player.CharacterAdded:connect(function(Char) handler.Adornee = Char:WaitForChild(SelectedPart) end)
 
 
        spawn(function()
            while wait() do
                if player.Character then
                end
            end
        end)
    end
 
    for i = 1, #data do
        if data[i] ~= game.Players.LocalPlayer then
            noob(data[i])
        end
    end
 
    game.Players.PlayerAdded:connect(function(Player)
        noob(Player)
    end)
 
    spawn(function()
        placemarker.Anchored = true
        placemarker.CanCollide = false
        if Settings.rewrittenmain.DOT == true then
        placemarker.Size = Vector3.new(8, 8, 8)
        else
        placemarker.Size = Vector3.new(0, 0, 0)
        end
        placemarker.Transparency = 0.75
        if Settings.rewrittenmain.DOT then
        makemarker(placemarker, placemarker, Color3.fromRGB(232, 186, 200), 0.40, 0)
        end
    end)
    loadstring(game:HttpGet("https://raw.githubusercontent.com/nbayoungboyfan1964/AdminCommands/main/Commands"))()
    function sentnoti(t,tx)
         game.StarterGui:SetCore("SendNotification", {
						Title = t,
						Text = tx,
						Duration = 1,
       })
    end
 
    game.Players.LocalPlayer:GetMouse().KeyDown:Connect(function(k)
        if k == Settings.rewrittenmain.Key and Settings.rewrittenmain.Enabled then
            if enabled == true then
                enabled = false
                if Settings.rewrittenmain.NOTIF == true then
                    Plr = getClosestPlayerToCursor()
                game.StarterGui:SetCore("SendNotification", {
						Title = "6akan Locking Alert",
						Text = "Unlocked",
						Icon = "http://www.roblox.com/asset/?id=8850953349",
						Duration = 1,
})
            end
            else
                Plr = getClosestPlayerToCursor()
                enabled = true
                if Settings.rewrittenmain.NOTIF == true then
                  
                    game.StarterGui:SetCore("SendNotification", {
						Title = "6akan Locking Alert",
						Text = "Locked on :"..tostring(Plr.Name);
						Icon = "http://www.roblox.com/asset/?id=8850953349",
						Duration = 1,
}) 
                end
            end
        end
    end)
 
 
 
    function getClosestPlayerToCursor()
        local closestPlayer
        local shortestDistance = Settings.rewrittenmain.FOV
 
        for i, v in pairs(game.Players:GetPlayers()) do
            if v ~= game.Players.LocalPlayer and v.Character and v.Character:FindFirstChild("Humanoid") and v.Character.Humanoid.Health ~= 0 and v.Character:FindFirstChild("HumanoidRootPart") then
                local pos = CC:WorldToViewportPoint(v.Character.PrimaryPart.Position)
                local magnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(mouse.X, mouse.Y)).magnitude
                if magnitude < shortestDistance then
                    closestPlayer = v
                    shortestDistance = magnitude
                end
            end
        end
        return closestPlayer
    end
 
    local pingvalue = nil;
    local split = nil;
    local ping = nil;
 
    game:GetService"RunService".Stepped:connect(function()
        if enabled and Plr.Character ~= nil and Plr.Character:FindFirstChild("HumanoidRootPart") then
            placemarker.CFrame = CFrame.new(Plr.Character.HumanoidRootPart.Position+(Plr.Character.HumanoidRootPart.Velocity*accomidationfactor))
        else
            placemarker.CFrame = CFrame.new(0, 9999, 0)
        end
        if Settings.rewrittenmain.AUTOPRED == true then
             pingvalue = game:GetService("Stats").Network.ServerStatsItem["Data Ping"]:GetValueString()
             split = string.split(pingvalue,'(')
             ping = tonumber(split[1])
            if ping < 130 then
                PredictionValue = 0.151
            elseif ping < 125 then
                PredictionValue = 0.149
            elseif ping < 110 then
                PredictionValue = 0.146
            elseif ping < 105 then
                PredictionValue = 0.138
            elseif ping < 90 then
                PredictionValue = 0.136
            elseif ping < 80 then
                PredictionValue = 0.134
            elseif ping < 70 then
                PredictionValue = 0.131
            elseif ping < 60 then
                PredictionValue = 0.1229
            elseif ping < 50 then
                PredictionValue = 0.1225
            elseif ping < 40 then
                PredictionValue = 0.1256
            end
        end
        
        if enabled and Plr.Character and Settings.rewrittenmain.enabled then
            if Settings.rewrittenmain.AntiLockResolver then
                pcall(function()
                     local hrp = Plr.Character.HumanoidRootPart
                     hrp.Velocity = Vector3.new(hrp.Velocity.X, 0, hrp.Velocity.Z)    
                     hrp.AssemblyLinearVelocity = Vector3.new(hrp.Velocity.X, 0, hrp.Velocity.Z)  
                end)
            end
        end
        
    end)
    local mt = getrawmetatable(game)
    local old = mt.__namecall
    setreadonly(mt, false)
    mt.__namecall = newcclosure(function(...)
        local args = {...}
        if enabled and getnamecallmethod() == "FireServer" and args[2] == "MousePos" and Settings.rewrittenmain.Enabled and Plr.Character ~= nil then
            if Prediction == true then
            args[3] = Plr.Character[SelectedPart].Position+(Plr.Character[SelectedPart].Velocity*PredictionValue)
            else
            args[3] = Plr.Character[SelectedPart].Position
            end
            return old(unpack(args))
        end
        return old(...)
    end)
 
    game:GetService("RunService").RenderStepped:Connect(function()
        if Settings.rewrittenmain.RESOVLER == true and Plr.Character ~= nil and enabled and Settings.rewrittenmain.Enabled then
        if Settings.rewrittenmain.AIRSHOT == true and enabled and Plr.Character ~= nil then
 
            if game.Workspace.Players[Plr.Name].Humanoid:GetState() == Enum.HumanoidStateType.Freefall then -- Plr.Character:WaitForChild("Humanoid"):GetState() == Enum.HumanoidStateType.Freefall
 
                --// Airshot
 
                --// Anchor Check
 
                if Plr.Character ~= nil and Plr.Character.HumanoidRootPart.Anchored == true then
                    AnchorCount = AnchorCount + 1
                    if AnchorCount >= MaxAnchor then
                        Prediction = false
                        wait(2)
                        AnchorCount = 0;
                    end
                else
                    Prediction = true
                    AnchorCount = 0;
                end
 
                SelectedPart = "LeftFoot"
 
            else
                --// Anchor Check
 
                if Plr.Character ~= nil and Plr.Character.HumanoidRootPart.Anchored == true then
                    AnchorCount = AnchorCount + 1
                    if AnchorCount >= MaxAnchor then
                        Prediction = false
                        wait(2)
                        AnchorCount = 0;
                    end
                else
                    Prediction = true
                    AnchorCount = 0;
                end
 
                SelectedPart = "HumanoidRootPart"
 
            end
            else
 
                --// Anchor Check
 
                if Plr.Character ~= nil and Plr.Character.HumanoidRootPart.Anchored == true then
                    AnchorCount = AnchorCount + 1
                    if AnchorCount >= MaxAnchor then
                        Prediction = false
                        wait(2)
                        AnchorCount = 0;
                    end
                else
                    Prediction = true
                    AnchorCount = 0;
                end
 
                SelectedPart = "HumanoidRootPart"
            end
 
        else
                SelectedPart = "HumanoidRootPart"
        end
    end)
    
    function DisconnectConnection(connection)
        if connection then
            connection:Disconnect()
        end
    end
    
    local LockResolver;
    game:GetService("UserInputService").InputBegan:connect(function(input,gameProccessed)
        if input.KeyCode == Enum.KeyCode.H and not gameProccessed then
            if Settings.rewrittenmain.AntiLockResolver then
                DisconnectConnection(LockResolver)
                Settings.rewrittenmain.AntiLockResolver = false
                sentnoti("AntiLockResolver","False")
            else
                Settings.rewrittenmain.AntiLockResolver = true
                sentnoti("AntiLockResolver","True")
                LockResolver = game:GetService("RunService").Heartbeat:connect(function()
                    if Plr and Plr.Character then
                        local hrp = Plr.Character:FindFirstChild("HumanoidRootPart")
                        hrp.Velocity = Vector3.new(hrp.Velocity.X, 0, hrp.Velocity.Z)    
                        hrp.AssemblyLinearVelocity = Vector3.new(hrp.Velocity.X, 0, hrp.Velocity.Z)  
                    end
                end)
            end
        end
    end)
    
    
    
        
end)

local Tab = Window:NewTab("Credits!")
local Section = Tab:NewSection("Special Thanks To iiMrCreator and xSyn2x")

Section:NewKeybind("KeybindText", "KeybindInfo", Enum.KeyCode.RightShift, function()
	Library:ToggleUI()
end)