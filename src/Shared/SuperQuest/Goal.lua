local Types = require(script.Parent.Types)

--[=[
	@class Goal

	A Goal can be added to a Quest, **Goals signifies if the Quest is finished**.
	When all Goals has reached their EndValue they will be detected as finished.

	Goals has a **StartValue and an EndValue** which can be set by the Developer.
	**The Developer can set the Value of a Goal whenever**, E.g if a Player mines a Rock in your game,
	you want that to register in your Quests and add 1 to the Rock Goal.


	```lua
	local SuperQuest = require(PARENT.SuperQuest)

	-- Create a Goal
	local SomeGoal = SuperQuest:CreateGoal("SomeGoal", 0, 10)
	```
]=]
local Goal: Types.GoalType = {} :: Types.GoalType
Goal.__index = Goal

--[=[
	@readonly
	
	@prop Name string
	@within Goal
]=]

--[=[
	@readonly

	@prop Value any
	@within Goal

	The Value is the current Value of the Goal.
]=]

--[=[
	@readonly

	@prop StartValue any
	@within Goal

	The StartValue is what the Value will start as.
]=]

--[=[
	@readonly

	@prop EndValue any
	@within Goal

	The EndValue is what the Goal signifies as the "Finish Line".
	When the Value has reached the EndValue, the Goal is Finished.
]=]

--[=[
	@readonly

	@prop Instance Configuration
	@within Goal
]=]

--[=[
	@readonly

	@prop Quest QuestType
	@within Goal
]=]

function Goal:Create(Name: string, Quest: Types.QuestType, StartValue: any, EndValue: any): Types.GoalType
	local self = setmetatable({}, Goal)

	self.Name = Name

	self.Quest = Quest

	self.Value = StartValue
	self.StartValue = StartValue
	self.EndValue = EndValue

	self.Instance = Instance.new("Configuration")
	self.Instance.Name = Name

	self.Instance:SetAttribute("Value", self.Value)
	self.Instance:SetAttribute("StartValue", self.StartValue)
	self.Instance:SetAttribute("EndValue", self.EndValue)

	self.Instance.AttributeChanged:Connect(function()
		self.Value = self.Instance:GetAttribute("Value")
	end)

	self.Instance.Parent = Quest.QuestFolder

	return self
end

function Goal:SetValue(Value: any)
	if (self.Quest:ReachedAllGoals()) then return end

	self.Instance:SetAttribute("Value", Value)

	if not (self.Quest:ReachedAllGoals()) then return end

	self.Quest:__FireEvent("GoalsReached")
	self.Quest:Destroy()
end

function Goal:Get(Name: string)
	return self.Instance:GetAttribute(Name)
end

function Goal:Destroy()
	self.Instance:Destroy()
end

return Goal
