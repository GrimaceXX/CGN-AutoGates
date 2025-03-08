-- Convert gate model names to hashes for efficient lookup
local gateModelHashes = {}
for _, model in ipairs(Config.GateModels) do
    table.insert(gateModelHashes, GetHashKey(model))
end

-- Table to track managed gates
local managedGates = {}

-- Function to generate a unique door hash based on gate coordinates
local function generateDoorHash(coords)
    return math.floor(coords.x * 1000 + coords.y * 100 + coords.z * 10)
end

-- Main thread for gate detection and management
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1000) -- Check every second to reduce resource usage
        local playerPed = PlayerPedId()
        local vehicle = GetVehiclePedIsIn(playerPed, false)
        if DoesEntityExist(vehicle) and IsPedInAnyVehicle(playerPed, false) then
            local vehicleCoords = GetEntityCoords(vehicle)
            for _, modelHash in ipairs(gateModelHashes) do
                local gate = GetClosestObjectOfType(vehicleCoords.x, vehicleCoords.y, vehicleCoords.z, Config.DetectionDistance, modelHash, false, false, false)
                if DoesEntityExist(gate) then
                    local gateCoords = GetEntityCoords(gate)
                    local doorHash = generateDoorHash(gateCoords)
                    if not managedGates[doorHash] then
                        AddDoorToSystem(doorHash, modelHash, gateCoords.x, gateCoords.y, gateCoords.z, false, false, false)
                        DoorSystemSetDoorState(doorHash, 0) -- Ensure it's closed initially
                        DoorSystemSetAutomaticDistance(doorHash, Config.AutoDistance)
                        DoorSystemSetAutomaticRate(doorHash, Config.AutoRate)
                        if Config.PhysicsController then
                            DoorSystemSetHoldOpen(doorHash, true)
                        end
                        managedGates[doorHash] = { entity = gate, coords = gateCoords }
                    end
                end
            end
            -- Clean up gates that are too far away
            for doorHash, gateData in pairs(managedGates) do
                local distance = #(vehicleCoords - gateData.coords)
                if distance > Config.DetectionDistance then
                    RemoveDoorFromSystem(doorHash)
                    managedGates[doorHash] = nil
                end
            end
        else
            -- Clear all managed gates if not in a vehicle
            for doorHash, _ in pairs(managedGates) do
                RemoveDoorFromSystem(doorHash)
            end
            managedGates = {}
        end
    end
end)

-- Thread to refresh gate settings periodically
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(Config.RefreshInterval * 1000) -- Convert to milliseconds
        for doorHash, _ in pairs(managedGates) do
            DoorSystemSetAutomaticDistance(doorHash, Config.AutoDistance)
            DoorSystemSetAutomaticRate(doorHash, Config.AutoRate)
        end
    end
end)
