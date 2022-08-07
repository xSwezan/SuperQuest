local HttpService = game:GetService("HttpService")

local Types = require(script.Parent.Types)
local Util = require(script.Parent.Util)

--[=[
	@class Quest

	A Quest is a Folder stored in the Player that contains all the Goals that it has been assigned.
	When all of the Goals are reached the Quest will be Removed and described as Finised.

	When a Quest is Finished it will trigger the **Quest.GoalsReached** event which can be useful for when E.g rewarding the Player.

	```lua
	local SuperQuest = require(PARENT.SuperQuest)

	-- Create a Quest for a Player
	local NewQuest = SuperQuest:CreateQuest(PLAYER, "NAME OF QUEST", {
		SuperQuest:CreateGoal("NAME OF GOAL", 0, 10),
		SuperQuest:CreateGoal("NAME OF GOAL 2", 0, 5)
	})

	-- Create Event when Goals are Reached
	NewQuest.GoalsReached:Connect(function()
		print("GOALS REACHED!") -- Goals are Reached
	end)
	```
]=]
local Quest: Types.QuestType = {} :: Types.QuestType
Quest.__index = Quest

--[=[
	@readonly

	@prop Goals {Goal}
	@within Quest
]=]

--[=[
	@private
	Creates the Quest

	@param Player Player -- Player that the Quest is binded to
	@param QuestName string -- Name of the Quest
	@param Goals {GoalType} -- The Goals of the Quest
	@return QuestType
]=]
function Quest:Create(Player: Player, QuestName: string, Goals: Types.GoalType): Types.QuestType
	local self = setmetatable({}, Quest)

	self.ID = HttpService:GenerateGUID()
	self.Name = QuestName
	self.Player = Player
	self.Goals = Goals or {}

	self.PlayerQuestFolder = self.Player:FindFirstChild("Quests") or Instance.new("Configuration")
	self.PlayerQuestFolder.Name = "Quests"
	self.PlayerQuestFolder.Parent = self.Player

	self.QuestFolder = Instance.new("Configuration")
	self.QuestFolder.Name = QuestName
	self.QuestFolder:SetAttribute("ID", self.ID)
	self.QuestFolder.Parent = self.PlayerQuestFolder

	self:__NewEvent("GoalsReached")

	return self
end

--[=[
	Returns a boolean if the Quest has reached all the goals that it was given

	@return boolean
]=]
function Quest:ReachedAllGoals(): boolean
	for _, Goal: Types.GoalType in pairs(self.Goals) do
		if (Goal:Get("Value") ~= Goal:Get("EndValue")) then
			return false
		end
	end
	return true
end

--[=[
	Returns useful information about the Quest

	@return QuestInfo
]=]
function Quest:GetInfo(): Types.QuestInfo
	local Info: Types.QuestInfo = {}

	Info.Name = self.Name
	Info.Goals = {}

	for _, Goal in pairs(self.Goals) do
		Info.Goals[Goal.Name] = Goal.Instance:GetAttributes()
	end

	return Info
end

function Quest:Destroy()
	Util:FireNetworkEvent("QuestRemoved", self.Player, self.Name, self:GetInfo())
	self.QuestFolder:Destroy()
end

function Quest:__FireEvent(Name: string, ...: any)
	if not (Name) then return end

	local Event = self["__"..Name]
	if not (Event) then return end

	Event:Fire(...)
end

function Quest:__NewEvent(Name: string): BindableEvent
	local NewEvent = Instance.new("BindableEvent")

	self[Name] = NewEvent.Event
	self["__"..Name] = NewEvent

	return NewEvent
end

return Quest