# CGN Scripts - Automatic Gate Opener

## Description
The CGN Automatic Gate Opener enhances in-game gate mechanics by automatically detecting and opening gates when a vehicle approaches. This prevents unnecessary collisions and ensures smoother transitions through restricted areas. The script overrides default GTA behavior, allowing gates to open faster and at greater distances.

## Features
- Seamlessly detects and opens gates as vehicles approach.
- Customizable detection range and gate opening speed.
- Supports multiple gate models.
- Periodic refresh of gate settings to maintain functionality.
- Optional physics control for enhanced interaction with dynamic gates.

## Installation
1. Place the script files in your FiveM resource folder.
2. Add `ensure CGN_Scripts` to your `server.cfg` to enable the resource.

## Configuration
The script behavior can be fine-tuned using the `config.lua` file.

### Configurable Options:
- **GateModels** *(array)*: Specifies the gate models that will be managed by the script.
  - Example: `"prop_sec_barrier_ld_01a", "prop_sec_barrier_ld_02a", "prop_gate_airport_01"`
  - Additional gate models can be added as needed.

- **DetectionDistance** *(float)*: Defines the maximum range (in meters) at which the script detects gates around the player's vehicle.
  - Default: `50.0`
  
- **AutoDistance** *(float)*: The proximity at which gates will automatically open.
  - Default: `15.0`
  
- **AutoRate** *(float)*: The speed at which gates open upon detection.
  - Default: `2.5` (Recommended minimum: `1.5`)
  
- **RefreshInterval** *(float)*: Determines how often (in seconds) gate settings are refreshed.
  - Default: `5.0`
  
- **PhysicsController** *(boolean)*: Controls whether gates interact dynamically with physics.
  - Default: `true`
  - When enabled, this feature ensures that dynamic gates behave naturally in response to player interaction, maintaining smooth motion and preventing abrupt stops or glitches.

## How It Works
1. The script converts specified gate model names into hashes for efficient processing.
2. It continuously scans the area for gates near the player’s vehicle within the `DetectionDistance`.
3. When a gate is found within `AutoDistance`, it opens at the defined `AutoRate`.
4. The system efficiently manages detected gates, removing them from memory when they are no longer within range.
5. A separate thread runs at defined intervals to refresh gate settings and maintain consistent behavior.

## Additional Notes
- This script enhances realism by preventing gates from being forcefully broken off their poles by vehicles.
- The adjustable detection and automation settings ensure compatibility with various map designs and custom scenarios.
- The optional physics controller ensures smoother interactions with gates that are part of dynamic environments.

## Credits
Developed by **GrimaceXX** for **CGN Scripts**.

