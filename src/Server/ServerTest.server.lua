local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local SuperQuest = require(ReplicatedStorage.SuperQuest)
SuperQuest:Start()

Players.PlayerAdded:Connect(function(Player: Player)
	local Quest = SuperQuest:CreateQuest(Player, "Part Madness #1", {
		SuperQuest:CreateGoal("Walk On Parts", 0, 4),
		SuperQuest:CreateGoal("Click On Parts", 0, 3)
	})
	Quest.GoalsReached:Connect(function()
		print("GOALS REACHED")
		local Quest = SuperQuest:CreateQuest(Player, "Part Madness #2", {
			SuperQuest:CreateGoal("Walk On Parts", 0, 8),
			SuperQuest:CreateGoal("Click On Parts", 0, 6)
		})
	end)
end)