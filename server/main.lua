--- ESX RELATED ---
ESX = nil
local redeemedIdents = {}
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

if Config.UseCommand then
	RegisterCommand(Config.Command, function(source, args)
		ClaimReward(source)
	end, false)
end

RegisterCommand('viewRedeemed', function(source, args)
    for k,v in pairs(redeemedIdents) do
        print(v)
    end
end, false)

function ClaimReward(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local xPlayerName = xPlayer.getName()
    local xPlayerIdentifier = xPlayer.getIdentifier()

    -- Print that the player is trying to redeem their reward
    if Config.EnableDebug then
        print(xPlayerName .. ' (' .. xPlayerIdentifier .. ') is attempting to redeem their daily reward')
    end

    -- Check to see if the player's identifier exist in the table
    if #redeemedIdents == 0 then
        -- Debug Message
        if Config.EnableDebug then
            print('Redeemed indentifiers is empty')
        end

        -- Add the player to the reward list
        table.insert(redeemedIdents, xPlayerIdentifier)
        if Config.EnableDebug then
            print('Added ' .. xPlayerIdentifier .. ' to redeemed identifiers.')
        end

        --- MONEY REWARD ---
        if Config.MoneyReward then
            if Config.RandomAmount then
                local crateAmount = Config.MoneyRewards[math.random(#Config.MoneyRewards)]
                xPlayer.addAccountMoney('bank', crateAmount)
                xPlayer.showNotification('$' .. crateAmount .. ' has been added to your bank!')
                if Config.EnableDebug then
                    print('Gave ' .. xPlayerIdentifier .. ' their daily reward')
                end
            else
                local crateAmount = Config.PresetAmount
                xPlayer.addAccountMoney('bank', crateAmount)
                xPlayer.showNotification('$' .. crateAmount .. ' has been added to your bank!')
                if Config.EnableDebug then
                    print('Gave ' .. xPlayerIdentifier .. ' their daily reward')
                end
            end
        end

        -- WAIT
        Citizen.Wait(3 * 1000)

        --- ITEM REWARD ---
        if Config.ItemReward then
            if Config.RandomItems then
                local randomItem = Config.ItemRewards[math.random(#Config.ItemRewards)]
                local selectedItem = randomItem.item
                local selectedItemCount = randomItem.amount
                xPlayer.addInventoryItem(selectedItem, selectedItemCount)
                local itemLabel = ESX.GetItemLabel(selectedItem)
                xPlayer.showNotification('' .. selectedItemCount .. ' ' .. itemLabel .. ' has been added to your inventory!')
                if Config.EnableDebug then
                    print('Gave ' .. xPlayerIdentifier .. ' their daily reward')
                end
            else
                xPlayer.addInventoryItem(Config.PresetItem, Config.PresetAmount)
                local itemLabel = ESX.GetItemLabel(Config.PresetItem)
                xPlayer.showNotification('' .. Config.PresetAmount .. ' ' .. itemLabel .. ' has been added to your inventory!')
                if Config.EnableDebug then
                    print('Gave ' .. xPlayerIdentifier .. ' their daily reward')
                end
            end
        end
    else
        if has_redeemed(redeemedIdents, xPlayerIdentifier) then
            xPlayer.showNotification('[ERROR] You have already redeemed your daily reward!')
            if Config.EnableDebug then
                print('Player: ' .. xPlayerIdentifier .. ' tried to redeem their daily reward again')
            end
        else
            -- Add the player to the reward list
            table.insert(redeemedIdents, xPlayerIdentifier)
            if Config.EnableDebug then
                print('Added ' .. xPlayerIdentifier .. ' to redeemed identifiers.')
            end

            --- MONEY REWARD ---
            if Config.MoneyReward then
                if Config.RandomAmount then
                    local crateAmount = Config.MoneyRewards[math.random(#Config.MoneyRewards)]
                    xPlayer.addAccountMoney('bank', crateAmount)
                    xPlayer.showNotification('$' .. crateAmount .. ' has been added to your bank!')
                    if Config.EnableDebug then
                        print('Gave ' .. xPlayerIdentifier .. ' their daily reward')
                    end
                else
                    local crateAmount = Config.PresetAmount
                    xPlayer.addAccountMoney('bank', crateAmount)
                    xPlayer.showNotification('$' .. crateAmount .. ' has been added to your bank!')
                    if Config.EnableDebug then
                        print('Gave ' .. xPlayerIdentifier .. ' their daily reward')
                    end
                end
            end

            --- ITEM REWARD ---
            if Config.ItemReward then
                if Config.RandomItems then
                    local randomItem = Config.ItemRewards[math.random(#Config.ItemRewards)]
                    local selectedItem = randomItem.item
                    local selectedItemCount = randomItem.amount
                    xPlayer.addInventoryItem(selectedItem, selectedItemCount)
                    local itemLabel = ESX.GetItemLabel(selectedItem)
                    xPlayer.showNotification('' .. selectedItemCount .. ' ' .. itemLabel .. ' has been added to your inventory!')
                    if Config.EnableDebug then
                        print('Gave ' .. xPlayerIdentifier .. ' their daily reward')
                    end
                else
                    xPlayer.addInventoryItem(Config.PresetItem, Config.PresetAmount)
                    local itemLabel = ESX.GetItemLabel(Config.PresetItem)
                    xPlayer.showNotification('' .. Config.PresetAmount .. ' ' .. itemLabel .. ' has been added to your inventory!')
                    if Config.EnableDebug then
                        print('Gave ' .. xPlayerIdentifier .. ' their daily reward')
                    end
                end
            end
        end
    end
end

function has_redeemed(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end