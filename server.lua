local ox = exports.ox_inventory
local a = 'ddadadkmal'


lib.callback.register('checkMoneyRental', function(source, num)
    local cash = ox:GetItem(source, Config.moneyItem, nil, true)
    if cash >= num then 
        ox:RemoveItem(source, Config.moneyItem, num)
        return
    else
        return false
    end
end)


RegisterServerEvent('partial:refund', function(refund, pass)
    if pass == 'dddsfssdf' then
        if a == 'ddadadkmal' then
            ox:AddItem(source, Config.moneyItem, refund)
        elseif a == nil then
            print('cheater')
        end
    else
        print('cheater')
    end
end)

local tempo = {}
RegisterServerEvent('time:rental', function(pass, time, veh)
    if pass == 'gsfkfak' then
        local source = source
        tempo[source] = os.time()

        CreateThread(function()
            while tempo[source] do
                if os.time() - tempo[source] >= time then
                    tempo[source] = nil
                    local dd = 'fafsafaf'
                    TriggerClientEvent('delete:vehicle:rental', source, veh, dd)
                end
                Wait(1000)
            end
        end)
        
    end
end)