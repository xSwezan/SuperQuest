---
sidebar_position: 2
---

# Getting Started

### Starting SuperQuest

To start using SuperQuest you have to start it using the `:Start()` method.

:::danger
If you don't start SuperQuest **none of the functions will work**!
:::
```lua
local SuperQuest = require(PARENT.SuperQuest)

-- Start SuperQuest
SuperQuest:Start()
```

### Creating Quests

To create Quests with SuperQuest you have to use the `:CreateQuest()` method.

:::tip Quest API
More info about Quests are in the [Quest documentation](http://xSwezan.github.io/SuperQuest/api/Quest)!
:::

The Goals is a table with Goals inside it.
Goals are created with the `:CreateGoal()` method.

:::tip Goals API
More info about Goals are in the [Goal documentation](http://xSwezan.github.io/SuperQuest/api/Goal)!
:::

This is an example of a Lumberman Quest:
```lua
local SuperQuest = require(PARENT.SuperQuest)

-- Create Quest
local Quest = SuperQuest:CreateQuest(PLAYER, "Lumberman", {
	SuperQuest:CreateGoal("Pick up Sticks", 0, 10),
	SuperQuest:CreateGoal("Cut down Trees", 0, 3)
})
```