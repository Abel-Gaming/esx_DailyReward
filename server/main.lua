--- ESX RELATED ---
ESX = nil
local redeemedIdents = {}
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

if Config.UseCommand then
	RegisterCommand(Config.Command, function(source, args)
		ClaimReward(source)
	end, false)
end

function ClaimReward(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayerIdentifier = xPlayer.getIdentifier()
    

    -- Check to see if the player's identifier exist in the table
    if #redeemedIdents == 0 then
        -- Add the player to the reward list
        table.insert(redeemedIdents, xPlayerIdentifier)

        --- MONEY REWARD ---
        if Config.MoneyReward then
            local crateAmount = Config.MoneyRewards[math.random(#Config.MoneyRewards)]
            xPlayer.addAccountMoney('bank', crateAmount)
            xPlayer.showNotification('$' .. crateAmount .. ' has been added to your bank!')
        end

        --- ITEM REWARD ---
        if Config.ItemReward then
            xPlayer.addInventoryItem(Config.Item, Config.ItemAmount)
            local itemLabel = ESX.GetItemLabel(Config.Item)
            xPlayer.showNotification('' .. Config.ItemAmount .. ' ' .. itemLabel .. ' has been added to your inventory!')
        end
    else
        for k, v in ipairs(redeemedIdents) do
            if xPlayerIdentifier == v then
                xPlayer.showNotification('[ERROR] You have already redeemed your daily reward!')
            else
                -- Add the player to the reward list
                table.insert(redeemedIdents, xPlayerIdentifier)

                --- MONEY REWARD ---
                if Config.MoneyReward then
                    local crateAmount = Config.MoneyRewards[math.random(#Config.MoneyRewards)]
                    xPlayer.addAccountMoney('bank', crateAmount)
                    xPlayer.showNotification('$' .. crateAmount .. ' has been added to your bank!')
                end
    
                --- ITEM REWARD ---
                if Config.ItemReward then
                    xPlayer.addInventoryItem(Config.Item, Config.ItemAmount)
                    local itemLabel = ESX.GetItemLabel(Config.Item)
                    xPlayer.showNotification('' .. Config.ItemAmount .. ' ' .. itemLabel .. ' has been added to your inventory!')
                end
            end
        end
    end
end