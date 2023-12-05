ESX = exports["es_extended"]:getSharedObject()

local playerRanks = {}
local discordWebhook = 'https://discord.com/api/webhooks/1180466785452044329/dX28-G2jE8Eoih19ijGaK1VMkcbeL70I6bjwg6CXwXiQEyoZKrU4eaf8LHHEze6k4eKj' -- Reemplaza con tu URL del webhook de Discord

RegisterServerEvent('cambiarTrabajo')
AddEventHandler('cambiarTrabajo', function(trabajo)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)

    if xPlayer then
        local currentJob = xPlayer.getJob().name
        local playerName = GetPlayerName(_source) -- Obtener el nombre del juego del jugador
        if trabajo == 'policia' then
            if currentJob == 'police' then
                playerRanks[_source] = xPlayer.getJob().grade
            end

            if currentJob == 'police' then
                xPlayer.setJob('offpolice', 0)
                avisoNotificacion("salgo")
                SendDiscordMessage('👮‍♂'.. playerName .. ' ha salido de servicio')
            elseif currentJob == 'offpolice' then
                --xPlayer.setJob('police', 0)
                if playerRanks[_source] then
                    xPlayer.setJob('police', playerRanks[_source])
                    playerRanks[_source] = nil
                    avisoNotificacion("entro")
                end
                SendDiscordMessage('👮‍♂'.. playerName .. ' está de servicio')
            end
        elseif trabajo == 'ambulancia' then
            if currentJob == 'ambulance' then
                playerRanks[_source] = xPlayer.getJob().grade
            end

            if currentJob == 'ambulance' then
                xPlayer.setJob('offambulance', 0)
                avisoNotificacion("salgo")
                SendDiscordMessage('​🚑​ '.. playerName .. ' ha salido de servicio')
            elseif currentJob == 'offambulance' then
                --xPlayer.setJob('police', 0)
                if playerRanks[_source] then
                    xPlayer.setJob('ambulance', playerRanks[_source])
                    playerRanks[_source] = nil
                    avisoNotificacion("entro")
                end
                SendDiscordMessage('​🚑​ '.. playerName .. ' está de servicio')
            end
        elseif trabajo == 'mecanico' then
            if currentJob == 'mechanic' then
                playerRanks[_source] = xPlayer.getJob().grade
            end

            if currentJob == 'mechanic' then
                xPlayer.setJob('offmechanic', 0)
                avisoNotificacion("salgo")
                SendDiscordMessage('​​​🔧​ '.. playerName .. ' ha salido de servicio')
            elseif currentJob == 'offmechanic' then
                --xPlayer.setJob('police', 0)
                if playerRanks[_source] then
                    xPlayer.setJob('mechanic', playerRanks[_source])
                    playerRanks[_source] = nil
                    avisoNotificacion("entro")
                end
                SendDiscordMessage('​​​​🔧 '.. playerName .. ' está de servicio') 
            end
        elseif trabajo == 'taxi' then
            if currentJob == 'taxi' then
                playerRanks[_source] = xPlayer.getJob().grade
            end

            if currentJob == 'taxi' then
                xPlayer.setJob('offtaxi', 0)
                avisoNotificacion("salgo")
                SendDiscordMessage('​​​🚕​​ '.. playerName .. ' ha salido de servicio') 
            elseif currentJob == 'offtaxi' then
                --xPlayer.setJob('police', 0)
                if playerRanks[_source] then
                    xPlayer.setJob('taxi', playerRanks[_source])
                    playerRanks[_source] = nil
                    avisoNotificacion("entro")
                end
                SendDiscordMessage('​​​🚕​ '.. playerName .. ' está de servicio') 
            end
        elseif trabajo == 'gc' then
            if currentJob == 'gc' then
                playerRanks[_source] = xPlayer.getJob().grade
            end

            if currentJob == 'gc' then
                xPlayer.setJob('offgc', 0)
                avisoNotificacion("salgo")
                SendDiscordMessage('​​​🚓​​ '.. playerName .. ' ha salido de servicio') 
            elseif currentJob == 'offgc' then
                --xPlayer.setJob('police', 0)
                if playerRanks[_source] then
                    xPlayer.setJob('gc', playerRanks[_source])
                    playerRanks[_source] = nil
                    avisoNotificacion("entro")
                end
                SendDiscordMessage('​​​🚓​ '.. playerName .. ' está de servicio') 
            end
    end
end)

function SendDiscordMessage(message)
    local headers = {
        ['Content-Type'] = 'application/json'
    }
    local data = {
        ["username"] = "Ministerio de Trabajo",
        ["content"] = message
    }

    PerformHttpRequest(discordWebhook, function(err, text, headers) end, 'POST', json.encode(data), headers)
end

function avisoNotificacion(modo)
    if modo == 'entro' then
        TriggerClientEvent('okokNotify:Alert', source, 'Fichaje', 'Entraste de servicio', 2500, 'info', true)
    else
        TriggerClientEvent('okokNotify:Alert', source, 'Fichaje', 'Saliste de servicio', 2500, 'info', true)
    end
end