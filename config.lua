Config = {}

-- COMMANDS SETTINGS --
Config.Command = 'daily-reward'
Config.UseCommand = true

-- REWARD TYPES --
Config.MoneyReward = true
Config.ItemReward = true

-- MONEY REWARD SETTINGS --
Config.RandomAmount = true -- TRUE will select a random amount from the rewards table | FALSE will use the preset amount
Config.PresetAmount = 1000
Config.MoneyRewards = {
    5000,
    10000,
    15000,
    20000,
    25000,
    30000,
    35000,
    40000,
    45000,
    50000
}

-- ITEM REWARD SETTINGS --
Config.RandomItems = true -- TRUE will select a random item from the items table | FALSE will use the preset item with the preset amount
Config.PresetAmount = 1 
Config.PresetItem = 'fixkit'
Config.ItemRewards = {
    {
        item = 'casino_token',
        amount = 1000
    },
    {
        item = 'marijuana',
        amount = 10
    }
}

-- DEBUG SETTINGS --
Config.EnableDebug = false