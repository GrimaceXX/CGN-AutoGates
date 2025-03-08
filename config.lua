Config = {
    GateModels = {
        "prop_sec_barrier_ld_01a",
        "prop_sec_barrier_ld_02a",
        "prop_gate_airport_01"
        -- Add more gate models as needed
    },
    DetectionDistance = 50.0, -- Distance (in meters) to search for gates around the vehicle
    AutoDistance = 15.0,       -- Distance at which the gate automatically opens
    AutoRate = 2.5,           -- Speed of gate opening (minimum 1.5 recommended)
    RefreshInterval = 5.0,    -- Time (in seconds) to refresh gate settings
    PhysicsController = true  -- Enable physics controller for dynamic gates (optional)
}
