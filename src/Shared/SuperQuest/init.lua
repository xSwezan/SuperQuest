local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")

local QuestClass = require(script.Quest)
local GoalClass = require(script.Goal)
local Types = require(script.Types)
local Util = require(script.Util)

local Global = _G
Global["SuperQuest-Quests"] = Global["SuperQuest-Quests"] or {}

type SuperQuestType = {
	Start: () -> nil;

	QuestCreated: RBXScriptSignal;
	QuestRemoved: RBXScriptSignal;

	CreateQuest: (SuperQuestType, Player: Player, Name: string, Goals: {Types.GoalType}) -> Types.QuestType;
	GetQuest: (SuperQuestType, Player: Player, Name: string) -> Types.QuestType | nil;

	FindGoalAndExecute: (SuperQuestType, Player: Player, GoalName: string, Callback: (Goal: Types.GoalType) -> nil) -> nil;

	CreateGoal: (SuperQuestType, Name: string, Value: any, EndValue: any) -> Types.GoalType;
}

local Server: SuperQuestType = {} :: SuperQuestType

function Server:Start()
	local SuperQuestExtra = Instance.new("Folder")
	SuperQuestExtra.Name = "SuperQuest-Extra"
	SuperQuestExtra.Parent = ReplicatedStorage

	Util:CreateNetworkEvent("QuestCreated")
	Util:CreateNetworkEvent("QuestRemoved")

	local function CreateQuestFolder(Player: Player)
		local Quests = Player:FindFirstChild("Quests") or Instance.new("Configuration")
		Quests.Name = "Quests"
		Quests.Parent = Player
	end

	Players.PlayerAdded:Connect(CreateQuestFolder)
	for _, Player: Player in pairs(Players:GetPlayers()) do
		CreateQuestFolder(Player)
	end

	script:SetAttribute("Started", true)
end

function Server:CreateQuest(Player: Player, Name: string, Goals: {Types.GoalInfo}?): Types.QuestType
	assert(script:GetAttribute("Started"), "SuperQuest needs to be started before using :CreateQuest!")

	local NewQuest = QuestClass:Create(Player, Name)

	for _, Info: Types.GoalType in pairs(Goals or {}) do
		table.insert(NewQuest.Goals, GoalClass:Create(Info.Name, NewQuest, Info.StartValue, Info.EndValue))
	end

	Global["SuperQuest-Quests"][NewQuest.ID] = NewQuest

	Util:FireNetworkEvent("QuestCreated", Player, Name, NewQuest:GetInfo())
	
	return NewQuest
end

function Server:GetQuest(Player: Player, Name: string): Types.QuestType | nil
	assert(script:GetAttribute("Started"), "SuperQuest needs to be started before using :GetQuest!")

	local QuestsFolder = Player:FindFirstChild("Quests")
	if not (QuestsFolder) then return end

	local FoundQuest = QuestsFolder:FindFirstChild(Name)
	if not (FoundQuest) then return end

	local QuestId = FoundQuest:GetAttribute("ID")
	if not (QuestId) then return end

	return Global["SuperQuest-Quests"][QuestId]
end

function Server:CreateGoal(Name: string, StartValue: any, EndValue: any): Types.GoalInfo
	return {
		Name = Name;
		StartValue = StartValue;
		EndValue = EndValue;
	}
end

function Server:FindGoalAndExecute(Player: Player, GoalName: string, Callback: (Goal: Types.GoalType) -> nil)
	assert(script:GetAttribute("Started"), "SuperQuest needs to be started before using :FindGoalAndExecute!")

	if not (Player) then return end
	if not (GoalName) then return end
	if not (typeof(Callback) == "function") then return end
	
	for _, Quest: Types.QuestType in pairs(Global["SuperQuest-Quests"]) do
		for _, Goal: Types.GoalType in pairs(Quest.Goals) do
			if (Goal.Name == GoalName) then
				Callback(Goal)
			end
		end
	end
end

if (RunService:IsServer()) then
	return Server :: SuperQuestType
else
	local Client = require(script.Client)
	return Client :: Client.ClientSuperQuestType
end