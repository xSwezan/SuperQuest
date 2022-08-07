"use strict";(self.webpackChunkdocs=self.webpackChunkdocs||[]).push([[814],{26008:e=>{e.exports=JSON.parse('{"functions":[{"name":"Create","desc":"Creates the Quest","params":[{"name":"Player","desc":"Player that the Quest is binded to","lua_type":"Player"},{"name":"QuestName","desc":"Name of the Quest","lua_type":"string"},{"name":"Goals","desc":"The Goals of the Quest","lua_type":"{GoalType}"}],"returns":[{"desc":"","lua_type":"QuestType"}],"function_type":"method","private":true,"source":{"line":48,"path":"src/Shared/SuperQuest/Quest.lua"}},{"name":"ReachedAllGoals","desc":"Returns a boolean if the Quest has reached all the goals that it was given","params":[],"returns":[{"desc":"","lua_type":"boolean"}],"function_type":"method","source":{"line":75,"path":"src/Shared/SuperQuest/Quest.lua"}},{"name":"GetInfo","desc":"Returns useful information about the Quest","params":[],"returns":[{"desc":"","lua_type":"QuestInfo"}],"function_type":"method","source":{"line":89,"path":"src/Shared/SuperQuest/Quest.lua"}}],"properties":[{"name":"Goals","desc":"","lua_type":"{Goal}","readonly":true,"source":{"line":38,"path":"src/Shared/SuperQuest/Quest.lua"}}],"types":[{"name":"QuestType","desc":"","fields":[{"name":"GoalsReached:","lua_type":"RBXScriptSignal","desc":""},{"name":"QuestFolder:","lua_type":"Configuration","desc":""},{"name":"Goals:","lua_type":"{GoalType}","desc":""},{"name":"Create:","lua_type":"(Player: Player, Name: string) -> QuestType","desc":""},{"name":"ReachedAllGoals:","lua_type":"() -> boolean","desc":""},{"name":"GetInfo:","lua_type":"() -> QuestInfo","desc":""},{"name":"Destroy:","lua_type":"() -> nil","desc":""}],"source":{"line":23,"path":"src/Shared/SuperQuest/Types.lua"}}],"name":"Quest","desc":"A Quest is a Folder stored in the Player that contains all the Goals that it has been assigned.\\nWhen all of the Goals are reached the Quest will be Removed and described as Finised.\\n\\nWhen a Quest is Finished it will trigger the **Quest.GoalsReached** event which can be useful for when E.g rewarding the Player.\\n\\n```lua\\nlocal SuperQuest = require(PARENT.SuperQuest)\\n\\n-- Create a Quest for a Player\\nlocal NewQuest = SuperQuest:CreateQuest(PLAYER, \\"NAME OF QUEST\\", {\\n\\tSuperQuest:CreateGoal(\\"NAME OF GOAL\\", 0, 10),\\n\\tSuperQuest:CreateGoal(\\"NAME OF GOAL 2\\", 0, 5)\\n})\\n\\n-- Create Event when Goals are Reached\\nNewQuest.GoalsReached:Connect(function()\\n\\tprint(\\"GOALS REACHED!\\") -- Goals are Reached\\nend)\\n```","source":{"line":29,"path":"src/Shared/SuperQuest/Quest.lua"}}')}}]);