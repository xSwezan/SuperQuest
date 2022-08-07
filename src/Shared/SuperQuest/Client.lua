local ReplicatedStorage = game:GetService("ReplicatedStorage")

export type ClientSuperQuestType = {
	QuestCreated: RBXScriptSignal;
	QuestRemoved: RBXScriptSignal;
}

local Client: ClientSuperQuestType = {}

function Client:FindEvent(Name: string): RemoteEvent
	return ReplicatedStorage:WaitForChild("SuperQuest-Extra"):FindFirstChild(Name)
end

Client.QuestCreated = Client:FindEvent("QuestCreated").OnClientEvent
Client.QuestRemoved = Client:FindEvent("QuestRemoved").OnClientEvent

return Client