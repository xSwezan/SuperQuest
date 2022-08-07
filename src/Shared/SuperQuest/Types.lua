export type QuestInfo = {
	Name: string;

	Goals: {[string]: {Value: string, EndValue: string}};
}

--[=[
	@interface QuestType
	.GoalsReached: RBXScriptSignal

	.QuestFolder: Configuration
	.Goals: {GoalType}

	.Create: (Player: Player, Name: string) -> QuestType

	.ReachedAllGoals: () -> boolean

	.GetInfo: () -> QuestInfo
	.Destroy: () -> nil
	
	@within Quest
]=]
export type QuestType = {
	GoalsReached: RBXScriptSignal;

	QuestFolder: Configuration;
	Goals: {GoalType};

	Create: (QuestType, Player: Player, Name: string) -> QuestType;

	ReachedAllGoals: () -> boolean;

	GetInfo: () -> QuestInfo;
	Destroy: () -> nil;
}

export type GoalInfo = {
	Name: string;
	Value: any;
	EndValue: any;
}

--[=[
	@interface GoalType
	.Create: (Name: string, Quest: QuestType, StartValue: any, EndValue: any) -> GoalType

	.SetValue: (Value: any) -> nil
	.Destroy: () -> nil

	@within Goal
]=]
export type GoalType = {
	Create: (Name: string, Quest: QuestType, StartValue: any, EndValue: any) -> GoalType;

	Name: string;

	Value: any;
	StartValue: any;
	EndValue: any;

	Instance: Configuration;
	Quest: QuestType;

	SetValue: (Value: any) -> nil;
	Destroy: () -> nil;
}

return {}