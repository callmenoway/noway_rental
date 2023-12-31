local haToccato = false

CreateThread(function()
    for k,v in pairs(Config.Rental) do

        local blip = AddBlipForCoord(v.marker.x, v.marker.y, 130)
        SetBlipSprite(blip, Blip.sprite)
        SetBlipDisplay(blip, 4)
        SetBlipColour(blip, Blip.colour)
        SetBlipAsShortRange(blip, true)
        SetBlipScale(blip, Blip.scale)
        BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName(Blip.name)
		EndTextCommandSetBlipName(blip)

        if Config.gridsystem then
            TriggerEvent('gridsystem:registerMarker', {
                name = 'rental'..k,
                pos = v.marker,
                size = Marker.size,
                scale = Marker.size,
                color = Marker.color,
                type = Marker.type,
                control = Marker.control,
                msg = Lang.msg,
                action = function()
                    Config.Type(v.spawn)
                    lib.showContext('rental')
                end
            })
        else
            CreateThread(function()
                while true do  
                    local asp = Marker.refreshTime
                    local distanza = #(GetEntityCoords(cache.ped) - v.marker)
                    if distanza < Marker.drawDistance then
                        asp = 0
                        DrawMarker(Marker.type, v.marker.x, v.marker.y, v.marker.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Marker.size.x, Marker.size.y, Marker.size.z, Marker.color.r, Marker.color.g, Marker.color.b, 140, false, false, 2, nil, nil, false)
                    end
                    if distanza <= Marker.interactDistance then
                        lib.showTextUI(Lang.msg, Marker.TextUI)
                        haToccato = true
                        if IsControlJustPressed(0, Marker.interactKey) then
                            Config.Type(v.spawn)
                            lib.showContext('rental')
                        end
                    else
                        if haToccato then
                            lib.hideTextUI()
                            haToccato = false
                        end
                    end
                    Wait(asp)
                end
            end)
        end
    end
end)

local preso = false
NewVeh = function(spawn, args)
    if not Config.TimeRental then
        lib.callback('checkMoneyRental', false, function(a)
            if a ~= false then

                lib.requestModel(args.type)
                local veh = CreateVehicle(args.type, spawn.x, spawn.y, spawn.z, spawn.w, true, true)
                SetPedIntoVehicle(cache.ped, veh, -1)
                if Config.hudFuel then
                    SetVehicleFuelLevel(veh, 100.0)
                end
                if Config.ox_target then
                    local options = {
                        {
                            name = 'dep',
                            icon = Marker.depositIcon,
                            label = Lang.depositMsg,
                            distance = Marker.depositDistance,
                            onSelect = function(data)
                                DeleteEntity(data.entity)
                                local pos = 'dddsfssdf'
                                TriggerServerEvent('partial:refund', args.refund, pos)
                            end
                        }
                    }
                    exports.ox_target:addLocalEntity(veh, options)
                end

            else
                Config.Notify(Config.noMoney)
            end
        end, args.price)
    else
        if not preso then
            local input = lib.inputDialog(Lang.time, {
                {type = 'number', description = Lang.minutes, icon = 'money-bill', required = true},
            })

            if not input then return end
            if not input[1] then return end

            local time = tonumber(input[1])
            if time <= 0 then Config.Notify(Lang.less) return end
            if time > Config.MaxMinutes then Config.Notify(Lang.max) return end

            local price = time * Config.PriceMinute
            local total = price + args.price

            lib.callback('checkMoneyRental', false, function(a)
                if a ~= false then
                    lib.requestModel(args.type)
                    local veh = CreateVehicle(args.type, spawn.x, spawn.y, spawn.z, spawn.w, true, true)
                    SetPedIntoVehicle(cache.ped, veh, -1)
                    if Config.hudFuel then
                        SetVehicleFuelLevel(veh, 100.0)
                    end

                    local pp = 'gsfkfak'
                    local time2 = time * 60
                    TriggerServerEvent('time:rental', pp, time2, veh)
                    preso = true
                    
                end
            end, total)
        else
            Config.Notify(Lang.already)
        end
    end
end

RegisterNetEvent('delete:vehicle:rental', function(veh, pass)
    if pass == 'fafsafaf' then
        preso = false
        DeleteEntity(veh)
        Config.Notify(Lang.finished)
    end
end)

