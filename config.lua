Config = {}

Config.ox_target = false

Config.gridsystem = false --set true if you have gridsystem / metti true se hai gridsystem
Config.hudFuel = false --set true if you have a fuel system / metti true se hai un sistema di benzina
Config.moneyItem = 'money'

Config.TimeRental = true --activate if you want the rental to be timed / attiva se vuoi che il noleggio sia a tempo
Config.PriceMinute = 2 -- price per minute of rental / prezzo per ogni minuto di noleggio
Config.MaxMinutes = 60 -- max rental time / tempo massimo noleggio

Config.Rental = {
    {
        marker = vec3(-239.7840, -992.0256, 29.2886),
        spawn = vec4(-235.7207, -993.6666, 29.2623, 161.3503)
    },
    -- add other marker if you want more blip / aggiungi altri se vuoi altri marker per spawnare veicoli
}

Config.Type = function(spawn)
    lib.registerContext({
        id = 'rental',
        title = 'Vehicle Rental',
        options = {
            {
                title = "Bicycle",
                description = "Rent a bmx for $250",
                metadata = {
                    {label = 'Model', value = 'Bicycle'},
                    {label = 'Price', value = '250$'},
                },
                args = {type = 'bmx', price = 250, refund = 50},
                onSelect = function(args)
                    NewVeh(spawn, args)
                end
            },
            {
                title = "Faggio",
                description = "Rent a faggio for $500",
                metadata = {
                    {label = 'Model', value = 'Motorcycle'},
                    {label = 'Displacement', value = '50cc'},
                    {label = 'Price', value = '500$'},
                },
                args = {type = 'faggio', price = 500, refund = 100},
                onSelect = function(args)
                    NewVeh(spawn, args)
                end
            }
            --add other vehicle as you want / aggiungi altri veicoli se vuoi
        }
    })
end

Config.Notify = function(msg)
    lib.notify({
        title = 'Server Name', --config your server name / configura il nome del tuo server
        description = msg,
        type = 'error',
        position = 'top-center'
    })
end

Marker = {
    depositIcon = 'fas fa-car',
    depositDistance = 2.5,

    interactDistance = 1.3,
    drawDistance = 10,
    interactKey = 38, --38 = E  
    refreshTime = 3000,

    TextUI = {
        position = "top-center",
        icon = 'hand',
        style = {
            borderRadius = 8,
            backgroundColor = '#ff8c00',
            color = 'white'
        }
    },
    
    control = 'E',
    type = 22,
    size = {x = 0.8, y = 0.8, z = 0.8},
    color = {r = 288, g = 76, b = 0},
}


Blip = {
    sprite = 376,
    colour = 2,
    scale = 0.5,
    name = 'Vehicle rental'
}

--english translate
Lang = {
    depositMsg = 'Deposit Rented Vehicle',
    msg = 'Press E for interact',
    noMoney = 'You don\'t have enough cash',
    time = 'Rental Time',
    minutes = 'Minutes',
    less = 'The value must be greater than 0',
    max = 'You can rent the vehicle for max '..Config.MaxMinutes..' minutes',
    already = 'You have already rented a vehicle',
    finished = 'The rental period is ended',
}


--[[
--italian translate
Lang = {
    depositMsg = 'Deposita veicolo a noleggio',
    msg = 'Premi E per interagire',
    noMoney = 'Non hai abbastanza contanti',
    time = 'Tempo noleggio',
    minutes = 'Minuti',
    less = 'Il tempo deve essere maggiore di 0',
    max = 'Puoi noleggiare il veicolo per massimo '..Config.MaxMinutes..' minuti',
    already = 'Hai già noleggiato un veicolo',
    finished = 'Il periodo di noleggio è terminato',
}
]]--
