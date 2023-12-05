
local isInsideMarker = false
ESX = exports["es_extended"]:getSharedObject()

-- Coordenadas del marcador
local coords = {
    policiaCoords = {coords = vector3(445.25, -999.23, 30.72)},   -- Policia La 69
    hospitalCoords =  {coords = vector3(306.69, -601.73, 43.28)},   -- Hospital
    taxiCoords = {coords = vector3(893.41, -168.10, 81.60)}, -- Mecanico
    mechanicCoords = {coords = vector3(-206.74, -1341.53, 34.89)}, -- Taxi
    gcCoords = {coords = vector3(1876.25, 3689.39, 33.55)}, -- GC
}

-- Función para dibujar los marcadores
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        local ped = PlayerPedId()
        local playerCoords = GetEntityCoords(ped)

        -- Iterar sobre cada coordenada en coords
        for key, marker in pairs(coords) do
            local distance = GetDistanceBetweenCoords(playerCoords, marker.coords, true)

            -- Verificar si el jugador está cerca del marcador
            if distance < 1.5 then
                ESX.ShowHelpNotification("Pulsa [E] para interactuar")
                DrawMarker(23, marker.coords.x, marker.coords.y, marker.coords.z - 1, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 1.0, 255, 0, 0, 200, false, true, 2, nil, nil, false)

                -- Verificar si se presiona la tecla E cerca del marcador
                if IsControlJustReleased(0, 38) then -- INPUT_CONTEXT: Tecla 'E'
                    -- Realizar alguna acción relacionada con el marcador aquí
                    if key == "policiaCoords" then
                        TriggerServerEvent('cambiarTrabajo', "policia")
                    elseif key == "hospitalCoords" then
                        TriggerServerEvent('cambiarTrabajo', "ambulancia")
                    elseif key == "taxiCoords" then
                        TriggerServerEvent('cambiarTrabajo', "taxi")
                    elseif key == "mechanicCoords" then
                        TriggerServerEvent('cambiarTrabajo', "mecanico")
                    elseif key == "gcCoords" then
                        TriggerServerEvent('cambiarTrabajo', "gc")
                        
                    end
                end
            end
        end
    end
end)
