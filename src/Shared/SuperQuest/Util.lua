local ReplicatedStorage = game:GetService("ReplicatedStorage")

local Util = {}

function Util:CreateNetworkEvent(Name: string)
	local NewEvent = Instance.new("RemoteEvent")

	NewEvent.Name = Name
	NewEvent.Parent = ReplicatedStorage:WaitForChild("SuperQuest-Extra")

	return NewEvent
end

function Util:FireNetworkEvent(EventName: string, Player: Player, ...: any)
	if not (Player) then return end

	local Event: RemoteEvent = ReplicatedStorage:WaitForChild("SuperQuest-Extra"):FindFirstChild(EventName)
	if not (typeof(Event) == "Instance") then return end
	if not (Event:IsA("RemoteEvent")) then return end

	Event:FireClient(Player, ...)
end

return Util