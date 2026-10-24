--[[
    Project Vector - Hamster Hub (Dust Place 79862723087324)
    Features:
      - Safe startup: All features OFF by default on load
      - Configuration System:
          * Save & Load full script configuration to hamster_hub_config.txt
          * Preserves toggles, sliders, combo boxes, colors, and keybinds
          * Auto-loads saved configuration on execution
      - Aimbot Pipeline:
          * Mappable activation key (Click keybind in menu to set RMB, LMB, Side Mouse, etc.)
          * Auto Gun & Bow Detection (Automatically selects muzzle velocity and drop ratio for any gun/bow)
          * Auto Velocity Lead Prediction (Targets moving enemies accurately)
          * Long-Range Bullet & Arrow Drop Compensation
          * Customizable FOV Circle overlay + Real-time Gun Target Lead Info
          * Configurable Smoothing & Target Bone Selection (Head / UpperTorso / Root)
      - Camera & Zoom System:
          * Zoom / Scope Toggle or Hold (Mappable keybind, custom zoom FOV, smooth zoom lerp)
      - Visuals & Fullbright:
          * Instant Fullbright (Noon ClockTime, boosted Brightness, full ambient lighting, disabled shadows)
          * Remove Fog Toggle (Maximized FogEnd for crystal-clear vision across the map)
          * Clean state restoration when toggled off
      - Full Interactive Inventory Viewer with Armor Type Identification:
          * Complete Target Inventory Breakdown (Equipped weapon, holstered weapons, worn armor, backpack)
          * Complete Local Inventory Breakdown (Hotbar slots 1-6, full 30-slot Grid slots 7-36, wear slots)
          * Detailed Armor Classification: Shows exact armor category, tier, and material:
              - Tier 3 (Heavy Metal): Metal Facemask, Metal Chestplate, Heavy Plate Pants
              - Tier 2 (Roadsign / Medium): Coffee Can Helmet, Roadsign Jacket, Roadsign Kilt
              - Tier 1 (Wood / Light): Wood Chestplate, Wood Armor Pants
              - Tier 0 (Cloth / Casual): Burlap Headwrap, Burlap Shirt, Burlap Trousers, Burlap Shoes
              - Military / Special: Tactical Kevlar Vest, Soldier Helmet, Death Tax Mask
          * Draggable UI panel with health bar, distance indicator, and color-coded items
          * Multiple viewing modes (Target Near Crosshair, Local Player Full, or Both)
      - Animals ESP:
          * Detects Boars, Deer, Bears, Wolves, and Werewolves in workspace.Animals
          * Toggleable Animal Names, Distance, Dynamic Health Bar, and Tracers / Snaplines
          * Individual color pickers for aggressive vs passive wildlife
      - NPCs ESP:
          * Detects Soldiers, Scientists, and Patrol Helicopter in workspace.Npcs & workspace.FustPatrolHeli
          * Toggleable NPC Names, Equipped Guns, Distance, Health Bar, and Tracers
      - Player ESP:
          * Skeleton ESP (R15 & R6 bone joints)
          * Player Name & Distance Toggles
          * Smooth Health Bar + HP value (Safe clamp)
          * Held Item / Weapon & Holstered Weapon Detection
          * Bounding Box
      - Ore Nodes ESP:
          * Stone, Sulfur, and Iron/Metal Nodes + Distance + Tracers
      - Pickups ESP:
          * Ground Pickups (Hemp, Corn, Pumpkin, Berries, Wood, Loose Ores)
      - Dropped Items ESP:
          * Dropped player loot, weapons, tools, ammo in WorldItems/DroppedItems
--]]

local TAB_NAME = "Hamster Hub"

-- =========================================================================
-- MENU CONFIGURATION (ALL TURNED OFF BY DEFAULT)
-- =========================================================================
menu.add_tab(TAB_NAME, "H")

-- Forward declarations for Configuration actions
local on_save_config_clicked = function() end
local on_load_config_clicked = function() end

-- --- Configuration System Group ---
menu.add_group(TAB_NAME, "Configuration")
menu.add_button(TAB_NAME, "Configuration", "hh_save_cfg", "Save Configuration", function()
    on_save_config_clicked()
end)
menu.add_button(TAB_NAME, "Configuration", "hh_load_cfg", "Load Configuration", function()
    on_load_config_clicked(true)
end)
menu.add_checkbox(TAB_NAME, "Configuration", "hh_autoload_cfg", "Auto-Load Config On Launch", true)

-- --- Aimbot & Lead Prediction Group ---
menu.add_group(TAB_NAME, "Aimbot & Prediction")
menu.add_checkbox(TAB_NAME, "Aimbot & Prediction", "aim_enabled", "Enable Aimbot", false, { key = 2, show_mode = false })
menu.add_checkbox(TAB_NAME, "Aimbot & Prediction", "aim_draw_fov", "Draw FOV Circle", false, { parent = "aim_enabled", colorpicker = { 1.0, 1.0, 1.0, 0.35 } })
menu.add_checkbox(TAB_NAME, "Aimbot & Prediction", "aim_auto_gun", "Auto Gun/Bow Detection", true, { parent = "aim_enabled" })
menu.add_checkbox(TAB_NAME, "Aimbot & Prediction", "aim_prediction", "Lead Prediction (Velocity)", false, { parent = "aim_enabled" })
menu.add_checkbox(TAB_NAME, "Aimbot & Prediction", "aim_drop_comp", "Bullet/Arrow Drop Comp", false, { parent = "aim_enabled" })
menu.add_slider_int(TAB_NAME, "Aimbot & Prediction", "aim_proj_speed", "Manual Velocity (m/s)", 50, 1200, 350, { parent = "aim_enabled" })
menu.add_combo(TAB_NAME, "Aimbot & Prediction", "aim_bone", "Target Bone", { "Head", "UpperTorso", "HumanoidRootPart" }, 0, { parent = "aim_enabled" })
menu.add_slider_int(TAB_NAME, "Aimbot & Prediction", "aim_fov", "FOV Radius (px)", 20, 600, 140, { parent = "aim_enabled" })
menu.add_slider_int(TAB_NAME, "Aimbot & Prediction", "aim_smooth", "Smoothing (1 = Instant)", 1, 20, 4, { parent = "aim_enabled" })

-- --- Camera & Zoom Group ---
menu.add_group(TAB_NAME, "Camera & Zoom")
menu.add_checkbox(TAB_NAME, "Camera & Zoom", "zoom_enabled", "Enable Zoom / Scope", false, { key = 0, show_mode = false })
menu.add_slider_int(TAB_NAME, "Camera & Zoom", "zoom_fov", "Zoom Field of View", 10, 60, 30, { parent = "zoom_enabled" })
menu.add_slider_int(TAB_NAME, "Camera & Zoom", "zoom_smooth", "Zoom Smooth Speed", 1, 15, 6, { parent = "zoom_enabled" })

-- --- Visuals & World Lighting Group ---
menu.add_group(TAB_NAME, "Visuals & World")
menu.add_checkbox(TAB_NAME, "Visuals & World", "fullbright_enabled", "Enable Fullbright", false)
menu.add_slider_int(TAB_NAME, "Visuals & World", "fullbright_clock", "Time of Day (ClockTime)", 0, 24, 14, { parent = "fullbright_enabled" })
menu.add_slider_int(TAB_NAME, "Visuals & World", "fullbright_bright", "Light Brightness", 1, 10, 2, { parent = "fullbright_enabled" })
menu.add_checkbox(TAB_NAME, "Visuals & World", "no_fog", "Remove All Fog", false, { parent = "fullbright_enabled" })

-- --- Full Inventory Viewer Group ---
menu.add_group(TAB_NAME, "Inventory Viewer")
menu.add_checkbox(TAB_NAME, "Inventory Viewer", "inv_enabled", "Enable Inventory Viewer", false)
menu.add_combo(TAB_NAME, "Inventory Viewer", "inv_mode", "View Mode", { "Target Player (Near Crosshair)", "Local Player (Full)", "Both" }, 0, { parent = "inv_enabled" })
menu.add_checkbox(TAB_NAME, "Inventory Viewer", "inv_show_weapons", "Weapons & Holsters", true, { parent = "inv_enabled" })
menu.add_checkbox(TAB_NAME, "Inventory Viewer", "inv_show_wear", "Worn Armor & Clothing", true, { parent = "inv_enabled" })
menu.add_checkbox(TAB_NAME, "Inventory Viewer", "inv_show_pack", "Backpack Container", true, { parent = "inv_enabled" })
menu.add_checkbox(TAB_NAME, "Inventory Viewer", "inv_show_grid", "Full Inventory Grid (Slots 7-36)", true, { parent = "inv_enabled" })
menu.add_slider_int(TAB_NAME, "Inventory Viewer", "inv_panel_x", "Panel Pos X", 10, 1920, 35, { parent = "inv_enabled" })
menu.add_slider_int(TAB_NAME, "Inventory Viewer", "inv_panel_y", "Panel Pos Y", 10, 1080, 180, { parent = "inv_enabled" })
menu.add_slider_int(TAB_NAME, "Inventory Viewer", "inv_panel_w", "Panel Width", 220, 520, 320, { parent = "inv_enabled" })

-- --- Animals ESP Group ---
menu.add_group(TAB_NAME, "Animals ESP")
menu.add_checkbox(TAB_NAME, "Animals ESP", "animals_esp_enabled", "Enable Animals ESP", false)
menu.add_checkbox(TAB_NAME, "Animals ESP", "animal_bear", "Bears", false, { parent = "animals_esp_enabled", colorpicker = { 0.95, 0.25, 0.25, 1.0 } })
menu.add_checkbox(TAB_NAME, "Animals ESP", "animal_wolf", "Wolves & Werewolves", false, { parent = "animals_esp_enabled", colorpicker = { 1.00, 0.55, 0.20, 1.0 } })
menu.add_checkbox(TAB_NAME, "Animals ESP", "animal_boar", "Boars", false, { parent = "animals_esp_enabled", colorpicker = { 0.85, 0.70, 0.40, 1.0 } })
menu.add_checkbox(TAB_NAME, "Animals ESP", "animal_deer", "Deer", false, { parent = "animals_esp_enabled", colorpicker = { 0.40, 0.90, 0.50, 1.0 } })
menu.add_checkbox(TAB_NAME, "Animals ESP", "animals_show_name", "Show Animal Name", false, { parent = "animals_esp_enabled" })
menu.add_checkbox(TAB_NAME, "Animals ESP", "animals_show_dist", "Show Distance", false, { parent = "animals_esp_enabled" })
menu.add_checkbox(TAB_NAME, "Animals ESP", "animals_show_health", "Show Health Bar", false, { parent = "animals_esp_enabled" })
menu.add_checkbox(TAB_NAME, "Animals ESP", "animals_tracers", "Tracers / Snaplines", false, { parent = "animals_esp_enabled" })
menu.add_slider_int(TAB_NAME, "Animals ESP", "animals_max_dist", "Max Range (m)", 20, 1200, 450, { parent = "animals_esp_enabled" })
menu.add_slider_int(TAB_NAME, "Animals ESP", "animals_font_size", "Text Size", 10, 20, 12, { parent = "animals_esp_enabled" })

-- --- NPCs ESP Group ---
menu.add_group(TAB_NAME, "NPCs ESP")
menu.add_checkbox(TAB_NAME, "NPCs ESP", "npcs_esp_enabled", "Enable NPCs ESP", false)
menu.add_checkbox(TAB_NAME, "NPCs ESP", "npc_soldier", "Soldiers & Scientists", false, { parent = "npcs_esp_enabled", colorpicker = { 0.25, 0.85, 1.00, 1.0 } })
menu.add_checkbox(TAB_NAME, "NPCs ESP", "npc_patrol_heli", "Patrol Helicopter", false, { parent = "npcs_esp_enabled", colorpicker = { 1.00, 0.20, 0.20, 1.0 } })
menu.add_checkbox(TAB_NAME, "NPCs ESP", "npcs_show_name", "Show NPC Name", false, { parent = "npcs_esp_enabled" })
menu.add_checkbox(TAB_NAME, "NPCs ESP", "npcs_show_dist", "Show Distance", false, { parent = "npcs_esp_enabled" })
menu.add_checkbox(TAB_NAME, "NPCs ESP", "npcs_show_health", "Show Health Bar", false, { parent = "npcs_esp_enabled" })
menu.add_checkbox(TAB_NAME, "NPCs ESP", "npcs_tracers", "Tracers / Snaplines", false, { parent = "npcs_esp_enabled" })
menu.add_slider_int(TAB_NAME, "NPCs ESP", "npcs_max_dist", "Max Range (m)", 50, 1500, 600, { parent = "npcs_esp_enabled" })
menu.add_slider_int(TAB_NAME, "NPCs ESP", "npcs_font_size", "Text Size", 10, 20, 13, { parent = "npcs_esp_enabled" })

-- --- Player ESP Group ---
menu.add_group(TAB_NAME, "Player ESP")
menu.add_checkbox(TAB_NAME, "Player ESP", "player_esp_enabled", "Enable Player ESP", false)
menu.add_checkbox(TAB_NAME, "Player ESP", "player_box", "Bounding Box", false, { parent = "player_esp_enabled", colorpicker = { 1.0, 1.0, 1.0, 0.85 } })
menu.add_checkbox(TAB_NAME, "Player ESP", "player_skeleton", "Skeleton ESP", false, { parent = "player_esp_enabled", colorpicker = { 1.0, 0.35, 0.35, 1.0 } })
menu.add_checkbox(TAB_NAME, "Player ESP", "player_chams", "Box Chams (Filled)", false, { parent = "player_esp_enabled", colorpicker = { 0.95, 0.25, 0.25, 0.25 } })
menu.add_checkbox(TAB_NAME, "Player ESP", "player_health", "Health Bar & HP Text", false, { parent = "player_esp_enabled" })
menu.add_checkbox(TAB_NAME, "Player ESP", "player_held", "Held Item", false, { parent = "player_esp_enabled", colorpicker = { 1.0, 0.85, 0.30, 1.0 } })
menu.add_checkbox(TAB_NAME, "Player ESP", "player_name", "Player Name", false, { parent = "player_esp_enabled" })
menu.add_checkbox(TAB_NAME, "Player ESP", "player_dist", "Distance", false, { parent = "player_esp_enabled" })
menu.add_checkbox(TAB_NAME, "Player ESP", "player_sleepers", "Sleeping Players (Sleepers)", false, { parent = "player_esp_enabled", colorpicker = { 0.65, 0.70, 0.85, 0.85 } })
menu.add_slider_int(TAB_NAME, "Player ESP", "player_max_dist", "Max Range (m)", 20, 1500, 500, { parent = "player_esp_enabled" })
menu.add_slider_int(TAB_NAME, "Player ESP", "player_font_size", "Text Size", 10, 20, 13, { parent = "player_esp_enabled" })

-- --- Ore Nodes ESP Group ---
menu.add_group(TAB_NAME, "Ore Nodes ESP")
menu.add_checkbox(TAB_NAME, "Ore Nodes ESP", "nodes_esp_enabled", "Enable Ore Nodes ESP", false)
menu.add_checkbox(TAB_NAME, "Ore Nodes ESP", "stone_node", "Stone Nodes", false, { parent = "nodes_esp_enabled", colorpicker = { 0.85, 0.85, 0.90, 1.0 } })
menu.add_checkbox(TAB_NAME, "Ore Nodes ESP", "sulfur_node", "Sulfur Nodes", false, { parent = "nodes_esp_enabled", colorpicker = { 0.95, 0.85, 0.20, 1.0 } })
menu.add_checkbox(TAB_NAME, "Ore Nodes ESP", "iron_node", "Iron Nodes", false, { parent = "nodes_esp_enabled", colorpicker = { 0.45, 0.75, 1.00, 1.0 } })
menu.add_checkbox(TAB_NAME, "Ore Nodes ESP", "nodes_show_dist", "Show Distance", false, { parent = "nodes_esp_enabled" })
menu.add_checkbox(TAB_NAME, "Ore Nodes ESP", "nodes_tracers", "Tracers / Snaplines", false, { parent = "nodes_esp_enabled" })
menu.add_slider_int(TAB_NAME, "Ore Nodes ESP", "nodes_max_dist", "Max Range (m)", 20, 1500, 450, { parent = "nodes_esp_enabled" })
menu.add_slider_int(TAB_NAME, "Ore Nodes ESP", "nodes_font_size", "Text Size", 10, 20, 13, { parent = "nodes_esp_enabled" })

-- --- Pickups ESP Group ---
menu.add_group(TAB_NAME, "Pickups ESP")
menu.add_checkbox(TAB_NAME, "Pickups ESP", "pickups_esp_enabled", "Enable Pickups ESP", false)
menu.add_checkbox(TAB_NAME, "Pickups ESP", "pickups_ores", "Ore Pickups (Stone/Sulfur/Iron)", false, { parent = "pickups_esp_enabled", colorpicker = { 1.0, 0.80, 0.35, 1.0 } })
menu.add_checkbox(TAB_NAME, "Pickups ESP", "pickups_plants", "Plants & Food (Hemp/Corn/etc)", false, { parent = "pickups_esp_enabled", colorpicker = { 0.35, 0.95, 0.45, 1.0 } })
menu.add_checkbox(TAB_NAME, "Pickups ESP", "pickups_wood", "Wood Piles", false, { parent = "pickups_esp_enabled", colorpicker = { 0.75, 0.55, 0.35, 1.0 } })
menu.add_checkbox(TAB_NAME, "Pickups ESP", "pickups_show_dist", "Show Distance", false, { parent = "pickups_esp_enabled" })
menu.add_slider_int(TAB_NAME, "Pickups ESP", "pickups_max_dist", "Max Range (m)", 10, 1000, 200, { parent = "pickups_esp_enabled" })
menu.add_slider_int(TAB_NAME, "Pickups ESP", "pickups_font_size", "Text Size", 10, 20, 12, { parent = "pickups_esp_enabled" })

-- --- Dropped Items ESP Group ---
menu.add_group(TAB_NAME, "Loot & Dropped ESP")
menu.add_checkbox(TAB_NAME, "Loot & Dropped ESP", "dropped_esp_enabled", "Enable Loot & Dropped ESP", false)
menu.add_checkbox(TAB_NAME, "Loot & Dropped ESP", "dropped_color", "Item Color", false, { parent = "dropped_esp_enabled", colorpicker = { 1.0, 0.40, 0.90, 1.0 } })
menu.add_checkbox(TAB_NAME, "Loot & Dropped ESP", "dropped_show_dist", "Show Distance", false, { parent = "dropped_esp_enabled" })
menu.add_slider_int(TAB_NAME, "Loot & Dropped ESP", "dropped_max_dist", "Max Range (m)", 10, 600, 150, { parent = "dropped_esp_enabled" })
menu.add_slider_int(TAB_NAME, "Loot & Dropped ESP", "dropped_font_size", "Text Size", 10, 20, 12, { parent = "dropped_esp_enabled" })

-- =========================================================================
-- CONFIGURATION SYSTEM SAVE & LOAD LOGIC
-- =========================================================================
local CONFIG_FILE_NAME = "hamster_hub_config.txt"

local function get_config_file_path()
    local appdata = os.getenv("LOCALAPPDATA")
    if appdata then
        return appdata .. "\\Project Vector\\Scripts\\" .. CONFIG_FILE_NAME
    end
    return CONFIG_FILE_NAME
end

local function safe_menu_get(id)
    local ok, val = pcall(function() return menu.get(id) end)
    return ok and val
end

local function safe_menu_get_color(id)
    local ok, col = pcall(function() return menu.get_color(id) end)
    return ok and col or { 1, 1, 1, 1 }
end

local function safe_menu_get_key(id)
    local ok, key = pcall(function() return menu.get_key(id) end)
    return ok and key or 0
end

local SAVE_ITEMS = {
    -- Config Autoload
    { id = "hh_autoload_cfg", type = "bool" },

    -- Aimbot & Prediction
    { id = "aim_enabled", type = "bool", key = true },
    { id = "aim_draw_fov", type = "bool", color = true },
    { id = "aim_auto_gun", type = "bool" },
    { id = "aim_prediction", type = "bool" },
    { id = "aim_drop_comp", type = "bool" },
    { id = "aim_proj_speed", type = "int" },
    { id = "aim_bone", type = "int" },
    { id = "aim_fov", type = "int" },
    { id = "aim_smooth", type = "int" },

    -- Camera & Zoom
    { id = "zoom_enabled", type = "bool", key = true },
    { id = "zoom_fov", type = "int" },
    { id = "zoom_smooth", type = "int" },

    -- Visuals & World Lighting
    { id = "fullbright_enabled", type = "bool" },
    { id = "fullbright_clock", type = "int" },
    { id = "fullbright_bright", type = "int" },
    { id = "no_fog", type = "bool" },

    -- Inventory Viewer
    { id = "inv_enabled", type = "bool" },
    { id = "inv_mode", type = "int" },
    { id = "inv_show_weapons", type = "bool" },
    { id = "inv_show_wear", type = "bool" },
    { id = "inv_show_pack", type = "bool" },
    { id = "inv_show_grid", type = "bool" },
    { id = "inv_panel_x", type = "int" },
    { id = "inv_panel_y", type = "int" },
    { id = "inv_panel_w", type = "int" },

    -- Animals ESP
    { id = "animals_esp_enabled", type = "bool" },
    { id = "animal_bear", type = "bool", color = true },
    { id = "animal_wolf", type = "bool", color = true },
    { id = "animal_boar", type = "bool", color = true },
    { id = "animal_deer", type = "bool", color = true },
    { id = "animals_show_name", type = "bool" },
    { id = "animals_show_dist", type = "bool" },
    { id = "animals_show_health", type = "bool" },
    { id = "animals_tracers", type = "bool" },
    { id = "animals_max_dist", type = "int" },
    { id = "animals_font_size", type = "int" },

    -- NPCs ESP
    { id = "npcs_esp_enabled", type = "bool" },
    { id = "npc_soldier", type = "bool", color = true },
    { id = "npc_patrol_heli", type = "bool", color = true },
    { id = "npcs_show_name", type = "bool" },
    { id = "npcs_show_dist", type = "bool" },
    { id = "npcs_show_health", type = "bool" },
    { id = "npcs_tracers", type = "bool" },
    { id = "npcs_max_dist", type = "int" },
    { id = "npcs_font_size", type = "int" },

    -- Player ESP
    { id = "player_esp_enabled", type = "bool" },
    { id = "player_box", type = "bool", color = true },
    { id = "player_skeleton", type = "bool", color = true },
    { id = "player_chams", type = "bool", color = true },
    { id = "player_health", type = "bool" },
    { id = "player_held", type = "bool", color = true },
    { id = "player_name", type = "bool" },
    { id = "player_dist", type = "bool" },
    { id = "player_sleepers", type = "bool", color = true },
    { id = "player_max_dist", type = "int" },
    { id = "player_font_size", type = "int" },

    -- Ore Nodes ESP
    { id = "nodes_esp_enabled", type = "bool" },
    { id = "stone_node", type = "bool", color = true },
    { id = "sulfur_node", type = "bool", color = true },
    { id = "iron_node", type = "bool", color = true },
    { id = "nodes_show_dist", type = "bool" },
    { id = "nodes_tracers", type = "bool" },
    { id = "nodes_max_dist", type = "int" },
    { id = "nodes_font_size", type = "int" },

    -- Pickups ESP
    { id = "pickups_esp_enabled", type = "bool" },
    { id = "pickups_ores", type = "bool", color = true },
    { id = "pickups_plants", type = "bool", color = true },
    { id = "pickups_wood", type = "bool", color = true },
    { id = "pickups_show_dist", type = "bool" },
    { id = "pickups_max_dist", type = "int" },
    { id = "pickups_font_size", type = "int" },

    -- Dropped Items ESP
    { id = "dropped_esp_enabled", type = "bool" },
    { id = "dropped_color", type = "bool", color = true },
    { id = "dropped_show_dist", type = "bool" },
    { id = "dropped_max_dist", type = "int" },
    { id = "dropped_font_size", type = "int" }
}

local function save_config()
    local ok, result = pcall(function()
        local path = get_config_file_path()
        local dir = path:match("^(.+)\\[^\\]+$")
        if dir then
            pcall(function() os.execute('mkdir "' .. dir .. '" 2>nul') end)
        end

        local file = io.open(path, "w")
        if not file then
            print("[Hamster Hub] Failed to open config file for writing: " .. path)
            return false
        end

        for _, item in ipairs(SAVE_ITEMS) do
            local id = item.id
            local val = safe_menu_get(id)
            if item.type == "bool" then
                file:write(id .. "=" .. (val and "1" or "0") .. "\n")
            elseif item.type == "int" then
                file:write(id .. "=" .. tostring(tonumber(val) or 0) .. "\n")
            end

            if item.color then
                local col = safe_menu_get_color(id)
                if col then
                    file:write(string.format("%s_color=%.4f,%.4f,%.4f,%.4f\n", id, col[1] or 1, col[2] or 1, col[3] or 1, col[4] or 1))
                end
            end

            if item.key then
                file:write(id .. "_key=" .. tostring(safe_menu_get_key(id)) .. "\n")
            end
        end

        file:close()
        print("[Hamster Hub] Configuration successfully saved to: " .. path)
        return true
    end)

    if not ok then
        print("[Hamster Hub] Error saving config: " .. tostring(result))
        return false
    end
    return result
end

local function load_config(is_manual)
    local ok, result = pcall(function()
        local path = get_config_file_path()
        local file = io.open(path, "r")
        if not file then
            if is_manual then
                print("[Hamster Hub] No config file found at: " .. path .. " (Click 'Save Configuration' first)")
            end
            return false
        end

        local data = {}
        for line in file:lines() do
            local key, value = line:match("^([^=]+)=(.*)$")
            if key and value then
                data[key] = value
            end
        end
        file:close()

        for _, item in ipairs(SAVE_ITEMS) do
            local id = item.id
            if data[id] then
                if item.type == "bool" then
                    pcall(function() menu.set(id, data[id] == "1") end)
                elseif item.type == "int" then
                    pcall(function() menu.set(id, tonumber(data[id]) or 0) end)
                end
            end

            if item.color and data[id .. "_color"] then
                local r, g, b, a = data[id .. "_color"]:match("([%d%.%-]+),([%d%.%-]+),([%d%.%-]+),([%d%.%-]+)")
                if r then
                    pcall(function()
                        menu.set_color(id, { tonumber(r), tonumber(g), tonumber(b), tonumber(a) })
                    end)
                end
            end

            if item.key and data[id .. "_key"] then
                pcall(function()
                    menu.set_key(id, tonumber(data[id .. "_key"]) or 0)
                end)
            end
        end

        print("[Hamster Hub] Configuration loaded successfully.")
        return true
    end)

    if not ok then
        print("[Hamster Hub] Error loading config: " .. tostring(result))
        return false
    end
    return result
end

-- Link Configuration Action Callbacks
on_save_config_clicked = save_config
on_load_config_clicked = load_config

-- Auto-load config on startup if enabled
local autoload = safe_menu_get("hh_autoload_cfg")
if autoload == nil or autoload == true then
    load_config()
end

-- =========================================================================
-- ARMOR TYPE & TIER CLASSIFICATION ENGINE
-- =========================================================================
-- Accurately identifies armor piece, gear slot, material, and protection tier
local function get_armor_info(name)
    if not name or type(name) ~= "string" then return nil end
    local lower = name:lower():gsub("[_%s%-]", "")

    -- 1. Helmets & Facemasks (Headwear)
    if lower:find("metalfacemask") or (lower:find("metal") and lower:find("mask")) then
        return { slot = "Head", tier = "Tier 3 (Heavy Metal)", display = "Metal Facemask", category = "Headwear", color = { 0.95, 0.35, 0.35, 1.0 } }
    elseif lower:find("coffeecan") or lower:find("coffee") then
        return { slot = "Head", tier = "Tier 2 (Roadsign/Med)", display = "Coffee Can Helmet", category = "Headwear", color = { 1.00, 0.65, 0.20, 1.0 } }
    elseif lower:find("deathtaxmask") or lower:find("deathtax") then
        return { slot = "Head", tier = "Special (Armored)", display = "Death Tax Mask", category = "Headwear", color = { 0.85, 0.30, 0.95, 1.0 } }
    elseif lower:find("burlapheadwrap") or lower:find("headwrap") then
        return { slot = "Head", tier = "Tier 1 (Cloth)", display = "Burlap Headwrap", category = "Headwear", color = { 0.75, 0.75, 0.80, 1.0 } }
    elseif lower:find("partyhat") then
        return { slot = "Head", tier = "Cosmetic", display = "Party Hat", category = "Headwear", color = { 0.40, 0.85, 1.00, 1.0 } }
    elseif lower:find("hwfrankhead") or lower:find("frankhead") then
        return { slot = "Head", tier = "Event (Armored)", display = "Frankenstein Head", category = "Headwear", color = { 0.40, 0.95, 0.40, 1.0 } }
    elseif lower:find("soldierhelmet") then
        return { slot = "Head", tier = "Military (Armored)", display = "Soldier Helmet", category = "Headwear", color = { 0.30, 0.85, 1.00, 1.0 } }
    elseif lower:find("helmet") or lower:find("mask") or lower:find("hood") then
        return { slot = "Head", tier = "Armored Headwear", display = name, category = "Headwear", color = { 0.85, 0.75, 0.45, 1.0 } }

    -- 2. Torso Armor & Shirts
    elseif lower:find("metalchestplate") or (lower:find("metal") and lower:find("chest")) then
        return { slot = "Chest Armor", tier = "Tier 3 (Heavy Metal)", display = "Metal Chestplate", category = "Chest Armor", color = { 0.95, 0.35, 0.35, 1.0 } }
    elseif lower:find("roadsignjacket") or lower:find("roadsign") then
        return { slot = "Chest Armor", tier = "Tier 2 (Roadsign/Med)", display = "Roadsign Jacket", category = "Chest Armor", color = { 1.00, 0.65, 0.20, 1.0 } }
    elseif lower:find("woodchestplate") or (lower:find("wood") and lower:find("chest")) then
        return { slot = "Chest Armor", tier = "Tier 1 (Wood/Light)", display = "Wood Chestplate", category = "Chest Armor", color = { 0.85, 0.65, 0.35, 1.0 } }
    elseif lower:find("burlapshirt") then
        return { slot = "Shirt", tier = "Tier 0 (Cloth/Shirt)", display = "Burlap Shirt", category = "Shirt", color = { 0.70, 0.70, 0.75, 1.0 } }
    elseif lower:find("hwfranktorso") or lower:find("franktorso") then
        return { slot = "Chest Armor", tier = "Event (Armored)", display = "Frankenstein Torso", category = "Chest Armor", color = { 0.40, 0.95, 0.40, 1.0 } }
    elseif lower:find("soldiervest") or lower:find("vest") then
        return { slot = "Chest Armor", tier = "Military (Tactical)", display = "Kevlar Tactical Vest", category = "Chest Armor", color = { 0.30, 0.85, 1.00, 1.0 } }
    elseif lower:find("torso_armor") or lower:find("chestplate") then
        return { slot = "Chest Armor", tier = "Chest Armor", display = name, category = "Chest Armor", color = { 0.85, 0.65, 0.35, 1.0 } }

    -- 3. Leg Armor & Pants
    elseif lower:find("heavyplatepants") or (lower:find("heavy") and lower:find("pants")) then
        return { slot = "Leg Armor", tier = "Tier 3 (Heavy Metal)", display = "Heavy Plate Pants", category = "Leg Armor", color = { 0.95, 0.35, 0.35, 1.0 } }
    elseif lower:find("roadsignkilt") or lower:find("kilt") then
        return { slot = "Leg Armor", tier = "Tier 2 (Roadsign/Med)", display = "Roadsign Kilt", category = "Leg Armor", color = { 1.00, 0.65, 0.20, 1.0 } }
    elseif lower:find("woodarmorpants") or (lower:find("wood") and lower:find("pants")) then
        return { slot = "Leg Armor", tier = "Tier 1 (Wood/Light)", display = "Wood Armor Pants", category = "Leg Armor", color = { 0.85, 0.65, 0.35, 1.0 } }
    elseif lower:find("burlaptrousers") or lower:find("pants") then
        return { slot = "Pants", tier = "Tier 0 (Cloth/Pants)", display = "Burlap Trousers", category = "Pants", color = { 0.70, 0.70, 0.75, 1.0 } }
    elseif lower:find("hwfranklegs") or lower:find("franklegs") then
        return { slot = "Leg Armor", tier = "Event (Armored)", display = "Frankenstein Legs", category = "Leg Armor", color = { 0.40, 0.95, 0.40, 1.0 } }
    elseif lower:find("legs_armor") then
        return { slot = "Leg Armor", tier = "Leg Armor", display = name, category = "Leg Armor", color = { 0.85, 0.65, 0.35, 1.0 } }

    -- 4. Footwear
    elseif lower:find("burlapshoes") or lower:find("shoes") or lower:find("boot") then
        return { slot = "Boots", tier = "Tier 0 (Footwear)", display = "Burlap Shoes", category = "Boots", color = { 0.70, 0.70, 0.75, 1.0 } }

    -- 5. Backpacks
    elseif lower:find("backpacklarge") then
        return { slot = "Pack", tier = "Large Storage", display = "Large Backpack", category = "Pack", color = { 0.35, 0.85, 1.00, 1.0 } }
    elseif lower:find("backpacksmall") or lower:find("backpack") then
        return { slot = "Pack", tier = "Small Storage", display = "Small Backpack", category = "Pack", color = { 0.35, 0.85, 1.00, 1.0 } }
    end

    -- Generic fallback
    if lower:find("wear_torso_armor") then
        return { slot = "Chest Armor", tier = "Chest Armor", display = "Chest Armor", category = "Chest Armor", color = { 0.85, 0.65, 0.35, 1.0 } }
    elseif lower:find("wear_legs_armor") then
        return { slot = "Leg Armor", tier = "Leg Armor", display = "Leg Armor", category = "Leg Armor", color = { 0.85, 0.65, 0.35, 1.0 } }
    elseif lower:find("wear_head") then
        return { slot = "Head", tier = "Headwear", display = "Headgear", category = "Headwear", color = { 0.75, 0.75, 0.80, 1.0 } }
    end

    return nil
end

-- =========================================================================
-- WEAPON BALLISTICS TABLE & PROFILES
-- =========================================================================
local GUN_PROFILES = {
    { pattern = "lrsniper",      name = "LR Sniper",        speed = 850, drop = 0.55 },
    { pattern = "boltaction",    name = "Bolt Action",      speed = 700, drop = 0.65 },
    { pattern = "assaultrifle",  name = "Assault Rifle",    speed = 520, drop = 0.90 },
    { pattern = "scarrifle",     name = "Scar Rifle",       speed = 540, drop = 0.88 },
    { pattern = "m249",          name = "M249 SAW",         speed = 490, drop = 0.95 },
    { pattern = "levercarbine",  name = "Lever Carbine",    speed = 460, drop = 1.05 },
    { pattern = "semiautorifle", name = "Semi Rifle (SAR)", speed = 440, drop = 1.10 },
    { pattern = "customsmg",     name = "Custom SMG",       speed = 330, drop = 1.45 },
    { pattern = "drumsmg",       name = "Drum SMG",         speed = 320, drop = 1.50 },
    { pattern = "tacticalsmg",   name = "Tactical SMG",     speed = 340, drop = 1.40 },
    { pattern = "servicepistol", name = "Service Pistol",   speed = 300, drop = 1.60 },
    { pattern = "semiautopistol",name = "Semi Pistol (SAP)",speed = 300, drop = 1.60 },
    { pattern = "revolver",      name = "Revolver",         speed = 280, drop = 1.75 },
    { pattern = "compoundbow",   name = "Compound Bow",     speed = 135, drop = 3.60 },
    { pattern = "crossbow",      name = "Crossbow",         speed = 105, drop = 4.40 },
    { pattern = "huntingbow",    name = "Hunting Bow",      speed = 85,  drop = 5.60 },
    { pattern = "pumpshotgun",   name = "Pump Shotgun",     speed = 260, drop = 1.90 },
    { pattern = "doublebarrel",  name = "Double Barrel",    speed = 250, drop = 2.00 },
    { pattern = "pipeshotgun",   name = "Waterpipe Shotgun",speed = 220, drop = 2.30 },
}

local function match_gun_profile(tool_name)
    if not tool_name or tool_name == "" then return nil end
    local clean = tool_name:lower():gsub("[_%s%-]", "")
    for i = 1, #GUN_PROFILES do
        local p = GUN_PROFILES[i]
        if clean:find(p.pattern) then
            return p
        end
    end
    return nil
end

-- =========================================================================
-- CACHED STATE & THEME COLORS
-- =========================================================================
local cam_x, cam_y, cam_z = 0, 0, 0
local cam_dx, cam_dy, cam_dz = 0, 0, -1

local cached_players = {}
local cached_nodes   = {}
local cached_pickups = {}
local cached_dropped = {}
local cached_animals = {}
local cached_npcs    = {}

local cached_local_tool    = nil
local cached_local_profile = nil

local cached_local_inventory = { hotbar = {}, grid = {}, wear = {} }
local cached_target_inventory = nil

local col_panel_bg     = { 0.05, 0.05, 0.08, 0.94 }
local col_panel_border = { 0.22, 0.24, 0.32, 1.00 }
local col_panel_header = { 0.10, 0.12, 0.18, 1.00 }
local col_accent       = { 0.40, 0.75, 1.00, 1.00 }
local col_text_main    = { 0.92, 0.94, 0.96, 1.00 }
local col_text_dim     = { 0.55, 0.58, 0.65, 1.00 }
local col_weapon       = { 1.00, 0.40, 0.40, 1.00 }
local col_armor        = { 0.35, 0.85, 1.00, 1.00 }
local col_resource     = { 0.95, 0.80, 0.25, 1.00 }
local col_pack         = { 0.50, 0.90, 0.50, 1.00 }

local inv_panel = {
    x = 35,
    y = 180,
    w = 320,
    dragging = false,
    drag_ox = 0,
    drag_oy = 0
}

local orig_lighting = {
    ClockTime = 14,
    Brightness = 2,
    GlobalShadows = true,
    FogEnd = 100000,
    Ambient = nil,
    OutdoorAmbient = nil
}
local orig_lighting_saved = false

local aim_target_player = nil
local aim_lead_offset = { x = 0, y = 0, z = 0 }
local aim_lead_screen = nil

local cfg = {
    aim_enabled = false,
    aim_key = 2,
    aim_fov_dr = false,
    aim_fov_col = { 1, 1, 1, 0.35 },
    aim_pred = false,
    aim_drop = false,
    aim_auto_gun = true,
    aim_speed = 350,
    aim_drop_ratio = 1.0,
    aim_bone_idx = 0,
    aim_fov = 140,
    aim_smooth = 4,

    zoom_enabled = false,
    zoom_key = 0,
    zoom_fov = 30,
    zoom_smooth = 6,

    fullbright_enabled = false,
    fullbright_clock = 14,
    fullbright_bright = 2,
    no_fog = false,

    inv_enabled = false,
    inv_mode = 0,
    inv_show_weapons = true,
    inv_show_wear = true,
    inv_show_pack = true,
    inv_show_grid = true,

    a_enabled = false,
    a_bear = false,
    a_bear_col = { 0.95, 0.25, 0.25, 1.0 },
    a_wolf = false,
    a_wolf_col = { 1.00, 0.55, 0.20, 1.0 },
    a_boar = false,
    a_boar_col = { 0.85, 0.70, 0.40, 1.0 },
    a_deer = false,
    a_deer_col = { 0.40, 0.90, 0.50, 1.0 },
    a_name = false,
    a_dist = false,
    a_hp = false,
    a_tracers = false,
    a_max_sq = 202500,
    a_font = 12,

    npc_enabled = false,
    npc_soldier = false,
    npc_sol_col = { 0.25, 0.85, 1.0, 1.0 },
    npc_heli = false,
    npc_heli_col = { 1.0, 0.20, 0.20, 1.0 },
    npc_name = false,
    npc_dist = false,
    npc_hp = false,
    npc_tracers = false,
    npc_max_sq = 360000,
    npc_font = 13,

    p_enabled = false,
    p_box = false,
    p_box_col = { 1, 1, 1, 0.85 },
    p_skel = false,
    p_skel_col = { 1, 0.35, 0.35, 1 },
    p_chams = false,
    p_chams_col = { 0.95, 0.25, 0.25, 0.25 },
    p_hp = false,
    p_held = false,
    p_held_col = { 1, 0.85, 0.3, 1 },
    p_name = false,
    p_dist = false,
    p_max_sq = 250000,
    p_font = 13,

    n_enabled = false,
    n_stone = false,
    n_stone_col = { 0.85, 0.85, 0.9, 1 },
    n_sulfur = false,
    n_sulf_col = { 0.95, 0.85, 0.2, 1 },
    n_iron = false,
    n_iron_col = { 0.45, 0.75, 1, 1 },
    n_dist = false,
    n_tracers = false,
    n_max_sq = 202500,
    n_font = 13,

    pk_enabled = false,
    pk_ores = false,
    pk_ores_col = { 1, 0.8, 0.35, 1 },
    pk_plants = false,
    pk_pl_col = { 0.35, 0.95, 0.45, 1 },
    pk_wood = false,
    pk_wood_col = { 0.75, 0.55, 0.35, 1 },
    pk_dist = false,
    pk_max_sq = 40000,
    pk_font = 12,

    d_enabled = false,
    d_col = { 1, 0.4, 0.9, 1 },
    d_dist = false,
    d_max_sq = 22500,
    d_font = 12
}

local function clamp(v, min_v, max_v)
    if v < min_v then return min_v end
    if v > max_v then return max_v end
    return v
end

local function get_model_position_part(inst)
    if not inst then return nil end
    if inst.ClassName == "MeshPart" or inst.ClassName == "Part" or inst.ClassName == "UnionOperation" then
        return inst
    end
    if inst.PrimaryPart then
        return inst.PrimaryPart
    end

    local candidate_names = {
        "HumanoidRootPart", "UpperTorso", "Torso", "Head", "Body",
        "Rock", "Ore", "Wood", "Leaves", "Stem", "Handle", "Metal", "Lid", "Cob", "Stalk"
    }
    for i = 1, #candidate_names do
        local p = inst:find_first_child(candidate_names[i])
        if p and (p.ClassName == "MeshPart" or p.ClassName == "Part" or p.ClassName == "UnionOperation") then
            return p
        end
    end

    local ch = inst:get_children()
    if ch and #ch > 0 then
        for k = 1, #ch do
            local c = ch[k]
            if c.ClassName == "MeshPart" or c.ClassName == "Part" or c.ClassName == "UnionOperation" then
                return c
            end
        end
    end
    return nil
end

local function safe_pos(part)
    if not part then return nil end
    local pos = part.Position
    if not pos then return nil end
    local x = pos.x or pos.X
    local y = pos.y or pos.Y
    local z = pos.z or pos.Z
    if not x or not y or not z then return nil end
    return x, y, z
end

local function get_item_color(name)
    local armor_info = get_armor_info(name)
    if armor_info then return armor_info.color end

    local n = (name or ""):lower()
    if match_gun_profile(name) or n:find("gun") or n:find("rifle") or n:find("bow") or n:find("smg") or n:find("pistol") or n:find("shotgun") then
        return col_weapon
    elseif n:find("bullet") or n:find("ammo") or n:find("arrow") or n:find("shell") or n:find("c4") or n:find("rocket") or n:find("grenade") then
        return { 1.0, 0.55, 0.20, 1.0 }
    elseif n:find("ore") or n:find("sulfur") or n:find("stone") or n:find("iron") or n:find("metal") or n:find("wood") or n:find("scrap") then
        return col_resource
    elseif n:find("pack") or n:find("bag") or n:find("box") then
        return col_pack
    elseif n:find("bandage") or n:find("med") or n:find("potion") or n:find("apple") or n:find("meat") or n:find("corn") or n:find("carrot") then
        return { 0.40, 0.95, 0.40, 1.0 }
    end
    return col_text_main
end

-- =========================================================================
-- BACKGROUND SCANNER: LOCAL PLAYER FULL INVENTORY (HOTBAR + GRID + WEAR)
-- =========================================================================
local function scan_local_inventory_task()
    if not cfg.inv_enabled then
        cached_local_inventory = { hotbar = {}, grid = {}, wear = {} }
        return
    end

    local rep_players = game.Players or (game.get_service and game.get_service("Players"))
    if not rep_players then return end

    local lp_obj = nil
    local lp = entity.get_local_player()
    if lp and lp.name then
        lp_obj = rep_players:find_first_child(lp.name)
    end
    if not lp_obj and rep_players.LocalPlayer then
        lp_obj = rep_players.LocalPlayer
    end

    if not lp_obj then return end

    local pg = lp_obj:find_first_child("PlayerGui")
    if not pg then return end

    local fust_inv = pg:find_first_child("FustInventory")
    if not fust_inv then return end

    local root = fust_inv:find_first_child("Root")
    if not root then return end

    local hotbar_items = {}
    local grid_items = {}
    local wear_items = {}

    local function parse_slot_btn(btn)
        if not btn then return nil end
        local item_name = nil
        local amount_str = ""

        local view = btn:find_first_child("View")
        if view then
            local ok, view_children = pcall(function() return view:get_children() end)
            if ok and view_children then
                for _, c in ipairs(view_children) do
                    if c.Name ~= "Camera" then
                        item_name = c.Name
                        break
                    end
                end
            end
        end

        local res = btn:find_first_child("Res")
        if res then
            local tl = res:find_first_child("TextLabel")
            if tl and tl.Text and tl.Text ~= "" and not item_name then
                item_name = tl.Text
            end
        end

        local amt_lbl = btn:find_first_child("Amount")
        if amt_lbl and amt_lbl.Text and amt_lbl.Text ~= "" then
            amount_str = amt_lbl.Text
        end

        if item_name and item_name ~= "" then
            return { name = item_name, amount = amount_str }
        end
        return nil
    end

    -- 1. Scan Hotbar (Slots 1 to 6)
    local hotbar = root:find_first_child("Hotbar")
    if hotbar then
        for slot_num = 1, 6 do
            local slot_btn = hotbar:find_first_child("Slot" .. tostring(slot_num))
            local it = parse_slot_btn(slot_btn)
            if it then
                it.slot = slot_num
                hotbar_items[#hotbar_items + 1] = it
            end
        end
    end

    -- 2. Scan Main Inventory Grid (Slots 7 to 36)
    local inv_frame = root:find_first_child("Inventory")
    local grid = inv_frame and inv_frame:find_first_child("Grid")
    if grid then
        for slot_num = 7, 36 do
            local slot_btn = grid:find_first_child("Slot" .. tostring(slot_num))
            local it = parse_slot_btn(slot_btn)
            if it then
                it.slot = slot_num
                grid_items[#grid_items + 1] = it
            end
        end
    end

    -- 3. Scan Wear Slots (Equipped Armor & Pack)
    local wear_slots = root:find_first_child("WearSlots")
    if wear_slots then
        local wear_names = {
            { id = "Wear_head", label = "Headwear" },
            { id = "Wear_torso_armor", label = "Chest Armor" },
            { id = "Wear_torso", label = "Shirt" },
            { id = "Wear_legs_armor", label = "Leg Armor" },
            { id = "Wear_legs", label = "Pants" },
            { id = "Wear_feet", label = "Boots" },
            { id = "Wear_backpack", label = "Backpack" }
        }
        for _, w in ipairs(wear_names) do
            local w_btn = wear_slots:find_first_child(w.id)
            local it = parse_slot_btn(w_btn)
            if it then
                it.slot_name = w.label
                wear_items[#wear_items + 1] = it
            end
        end
    end

    cached_local_inventory = {
        hotbar = hotbar_items,
        grid = grid_items,
        wear = wear_items
    }
end

-- =========================================================================
-- TARGET PLAYER FULL INVENTORY SCANNER
-- =========================================================================
local function scan_target_full_inventory(target_player)
    if not target_player or not target_player.char then return nil end

    local char = target_player.char
    local data = {
        name = target_player.name or "Unknown",
        hp = target_player.hp or 100,
        max_hp = target_player.max_hp or 100,
        distance_m = 0,
        equipped = nil,
        holsters = {},
        wear = {},
        backpack = nil,
        tools = {}
    }

    if target_player.root and target_player.root.Position then
        local dx = target_player.root.Position.x - cam_x
        local dy = target_player.root.Position.y - cam_y
        local dz = target_player.root.Position.z - cam_z
        data.distance_m = math.floor(math.sqrt(dx * dx + dy * dy + dz * dz) * 0.28)
    end

    -- 1. Equipped Item in hands
    local ch = char:get_children()
    if ch then
        for i = 1, #ch do
            local c = ch[i]
            if c.ClassName == "Tool" then
                data.equipped = c.Name
                break
            end
        end
    end

    -- 2. All Holstered Weapons (FustHolster)
    local holster = char:find_first_child("FustHolster")
    if holster then
        local h_items = holster:get_children()
        if h_items then
            for i = 1, #h_items do
                local h = h_items[i]
                local sub = h:get_children()
                if sub and #sub > 0 then
                    for s = 1, #sub do
                        local sn = sub[s].Name
                        if sn and sn ~= "Handle" and sn ~= "" and not sn:find("Weld") then
                            data.holsters[#data.holsters + 1] = sn
                            break
                        end
                    end
                end
            end
        end
    end

    -- 3. Backpack (FustPack)
    local pack = char:find_first_child("FustPack")
    if pack then
        local p_items = pack:get_children()
        if p_items and #p_items > 0 then
            local pname = p_items[1].Name
            local pack_info = get_armor_info(pname)
            if pack_info then
                data.backpack = pack_info.display
            else
                data.backpack = pname:lower():find("large") and "Large Backpack" or "Small Backpack"
            end
        end
    end

    -- 4. Complete Worn Gear & Armor with Type Identification (FustWear)
    local wear = char:find_first_child("FustWear")
    if wear then
        local w_items = wear:get_children()
        if w_items then
            local seen = {}
            for i = 1, #w_items do
                local item = w_items[i]
                local info = get_armor_info(item.Name)
                if not info then
                    local sub = item:get_children()
                    if sub and #sub > 0 then
                        for s = 1, #sub do
                            info = get_armor_info(sub[s].Name)
                            if info then break end
                        end
                    end
                end

                if not info then
                    local iname = item.Name:lower()
                    if iname:find("torso_armor") then
                        info = { slot = "Chest Armor", tier = "Chest Armor", display = "Chest Armor", category = "Chest Armor", color = col_armor }
                    elseif iname:find("legs_armor") then
                        info = { slot = "Leg Armor", tier = "Leg Armor", display = "Leg Armor", category = "Leg Armor", color = col_armor }
                    elseif iname:find("head") then
                        info = { slot = "Headwear", tier = "Headgear", display = "Headgear", category = "Headwear", color = col_armor }
                    end
                end

                if info and not seen[info.display] then
                    seen[info.display] = true
                    data.wear[#data.wear + 1] = info
                end
            end
        end
    end

    -- 5. Additional Tools stored in target's Player.Backpack (if available)
    if target_player.player and target_player.player.Backpack then
        local ok, bp_children = pcall(function() return target_player.player.Backpack:get_children() end)
        if ok and bp_children then
            for i = 1, #bp_children do
                data.tools[#data.tools + 1] = bp_children[i].Name
            end
        end
    end

    return data
end

-- =========================================================================
-- BACKGROUND SCANNER: PLAYERS
-- =========================================================================
local function scan_players_task()
    local ws = game.workspace or game.Workspace

    -- 1. Scan Local Player's Held Item & Auto Gun Detection
    local lp = entity.get_local_player()
    if lp then
        local lp_char = lp.character
        if not lp_char and ws and lp.name then
            lp_char = ws:find_first_child(lp.name)
        end
        if lp_char then
            local lp_tool = nil
            local ch = lp_char:get_children()
            if ch then
                for k = 1, #ch do
                    if ch[k].ClassName == "Tool" then
                        lp_tool = ch[k].Name
                        break
                    end
                end
            end
            cached_local_tool = lp_tool
            cached_local_profile = match_gun_profile(lp_tool)
        end
    end

    if not cfg.p_enabled and not cfg.aim_enabled and not cfg.inv_enabled then
        cached_players = {}
        return
    end

    local players = entity.get_players()
    if not players or #players == 0 then
        cached_players = {}
        return
    end

    local out = {}
    for i = 1, #players do
        local p = players[i]
        if not p.is_local_player then
            local char = p.character
            if char then
                local hum = char:find_first_child("Humanoid")
                local root = char:find_first_child("HumanoidRootPart")
                local head = char:find_first_child("Head")

                local hp = 100
                local max_hp = 100
                if hum then
                    hp = tonumber(hum.Health) or 100
                    max_hp = tonumber(hum.MaxHealth) or 100
                    if max_hp < 1 then max_hp = 100 end
                    hp = clamp(hp, 0, max_hp)
                end

                if hp > 0 and root and head then
                    local entry = {
                        name = p.name or "Player",
                        player = p,
                        char = char,
                        hum = hum,
                        root = root,
                        head = head,
                        hp = hp,
                        max_hp = max_hp,
                        held = nil,
                        parts = {}
                    }

                    if cfg.p_held then
                        local ch = char:get_children()
                        if ch then
                            for k = 1, #ch do
                                if ch[k].ClassName == "Tool" then
                                    entry.held = ch[k].Name
                                    break
                                end
                            end
                        end
                    end

                    if cfg.p_skel then
                        local part_names = {
                            "UpperTorso", "LowerTorso",
                            "LeftUpperArm", "LeftLowerArm", "LeftHand",
                            "RightUpperArm", "RightLowerArm", "RightHand",
                            "LeftUpperLeg", "LeftLowerLeg", "LeftFoot",
                            "RightUpperLeg", "RightLowerLeg", "RightFoot",
                            "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg"
                        }
                        for j = 1, #part_names do
                            local pname = part_names[j]
                            local pt = char:find_first_child(pname)
                            if pt then
                                entry.parts[pname] = pt
                            end
                        end
                    end

                    out[#out + 1] = entry
                end
            end
        end
    end

    -- Scan Sleeping Players in workspace.Sleepers
    if cfg.p_sleepers then
        local sleepers_folder = ws:find_first_child("Sleepers")
        if sleepers_folder then
            local s_ch = sleepers_folder:get_children()
            if s_ch then
                for s = 1, #s_ch do
                    local s_inst = s_ch[s]
                    local root = get_model_position_part(s_inst)
                    if root then
                        local s_name = s_inst.Name:gsub("Sleeper_", "Sleep: ")
                        local head = s_inst:find_first_child("Head") or root
                        out[#out + 1] = {
                            name = s_name,
                            char = s_inst,
                            root = root,
                            head = head,
                            hp = 100,
                            max_hp = 100,
                            is_sleeper = true,
                            parts = {}
                        }
                    end
                end
            end
        end
    end

    cached_players = out
end

-- =========================================================================
-- BACKGROUND SCANNER: ORE NODES (CORRECT DUST FOLDER: workspace.Nodes)
-- =========================================================================
local function scan_nodes_task()
    if not cfg.n_enabled then
        cached_nodes = {}
        return
    end

    local ws = game.workspace or game.Workspace
    if not ws then return end
    local folder = ws:find_first_child("Nodes") or ws:find_first_child("OreNodes")
    if not folder then
        cached_nodes = {}
        return
    end

    local children = folder:get_children()
    if not children then return end

    local out = {}
    for i = 1, #children do
        local inst = children[i]
        local name = inst.Name
        local ntype = nil
        local col = nil
        local lower = name:lower()

        if cfg.n_stone and (name == "StoneNode" or lower:find("stone")) then
            ntype = "Stone"
            col = cfg.n_stone_col
        elseif cfg.n_sulfur and (name == "SulfurNode" or lower:find("sulfur")) then
            ntype = "Sulfur"
            col = cfg.n_sulf_col
        elseif cfg.n_iron and (name == "MetalNode" or lower:find("metal") or lower:find("iron")) then
            ntype = "Iron/Metal"
            col = cfg.n_iron_col
        end

        if ntype then
            local p = get_model_position_part(inst)
            if p then
                local px, py, pz = safe_pos(p)
                if px then
                    out[#out + 1] = { x = px, y = py, z = pz, name = ntype, color = col }
                end
            end
        end
    end
    cached_nodes = out
end

-- =========================================================================
-- BACKGROUND SCANNER: GROUND PICKUPS (CORRECT DUST MODELS: StonePile, Hemp, Corn, etc)
-- =========================================================================
local function scan_pickups_task()
    if not cfg.pk_enabled then
        cached_pickups = {}
        return
    end

    local ws = game.workspace or game.Workspace
    if not ws then return end
    local folder = ws:find_first_child("Pickups") or ws:find_first_child("SpawnedPickups") or ws:find_first_child("GroundItems")
    if not folder then
        cached_pickups = {}
        return
    end

    local children = folder:get_children()
    if not children then return end

    local out = {}
    for i = 1, #children do
        local inst = children[i]
        local name = inst.Name
        local n_lower = name:lower()
        local label = nil
        local col = nil

        -- Ores: StonePile, SulfurOrePile, MetalOrePile
        if cfg.pk_ores and (n_lower:find("stone") or n_lower:find("sulfur") or n_lower:find("metal") or n_lower:find("ore")) then
            if n_lower:find("sulfur") then
                label = "Sulfur Pickup"
            elseif n_lower:find("metal") then
                label = "Metal Pickup"
            else
                label = "Stone Pickup"
            end
            col = cfg.pk_ores_col
        -- Plants & Food: Hemp, Corn, Pumpkin, ApplePile, BerryBush, CarrotPlant, PotatoPlant, Mushroom
        elseif cfg.pk_plants and (n_lower:find("hemp") or n_lower:find("corn") or n_lower:find("pumpkin") or n_lower:find("berry") or n_lower:find("mushroom") or n_lower:find("carrot") or n_lower:find("potato") or n_lower:find("apple")) then
            if n_lower:find("hemp") then
                label = "Hemp (Cloth)"
            else
                label = name:gsub("Plant", ""):gsub("Pile", ""):gsub("Bush", "")
            end
            col = cfg.pk_pl_col
        -- Wood: WoodPile
        elseif cfg.pk_wood and (n_lower:find("wood") or n_lower:find("log")) then
            label = "Wood Pile"
            col = cfg.pk_wood_col
        end

        if label then
            local p = get_model_position_part(inst)
            if p then
                local px, py, pz = safe_pos(p)
                if px then
                    out[#out + 1] = { x = px, y = py, z = pz, name = label, color = col }
                end
            end
        end
    end
    cached_pickups = out
end

-- =========================================================================
-- BACKGROUND SCANNER: LOOT CRATES, BARRELS & DROPPED ITEMS
-- =========================================================================
local function scan_dropped_task()
    if not cfg.d_enabled then
        cached_dropped = {}
        return
    end

    local ws = game.workspace or game.Workspace
    if not ws then return end

    local out = {}

    -- 1. Scan Loot Crates & Barrels in workspace.Loot
    local loot_folder = ws:find_first_child("Loot")
    if loot_folder then
        local children = loot_folder:get_children()
        if children then
            for i = 1, #children do
                local inst = children[i]
                local name = inst.Name
                local p = get_model_position_part(inst)
                if p then
                    local px, py, pz = safe_pos(p)
                    if px then
                        local col = cfg.d_col
                        local display_name = name
                        if name == "EliteCrate" then
                            display_name = "Elite Crate"
                            col = { 1.0, 0.85, 0.20, 1.0 }
                        elseif name == "MilitaryCrate" then
                            display_name = "Military Crate"
                            col = { 0.25, 0.90, 1.00, 1.0 }
                        elseif name == "LootCrate" then
                            display_name = "Loot Crate"
                            col = { 0.85, 0.65, 0.35, 1.0 }
                        elseif name == "LootBarrel" then
                            display_name = "Loot Barrel"
                            col = { 0.95, 0.70, 0.30, 1.0 }
                        end
                        out[#out + 1] = { x = px, y = py, z = pz, name = display_name, color = col }
                    end
                end
            end
        end
    end

    -- 2. Scan Dropped Items in workspace.WorldItems
    local dropped_folder = ws:find_first_child("WorldItems") or ws:find_first_child("DroppedItems") or ws:find_first_child("Dropped")
    if dropped_folder then
        local children = dropped_folder:get_children()
        if children then
            for i = 1, #children do
                local inst = children[i]
                local name = inst.Name
                local p = get_model_position_part(inst)
                if p then
                    local px, py, pz = safe_pos(p)
                    if px then
                        out[#out + 1] = { x = px, y = py, z = pz, name = name, color = cfg.d_col }
                    end
                end
            end
        end
    end

    cached_dropped = out
end

-- =========================================================================
-- BACKGROUND SCANNER: ANIMALS (BOARS, DEER, BEARS, WOLVES, WEREWOLVES)
-- =========================================================================
local function scan_animals_task()
    if not cfg.a_enabled then
        cached_animals = {}
        return
    end

    local ws = game.workspace or game.Workspace
    if not ws then return end

    local folder = ws:find_first_child("Animals")
    if not folder then
        cached_animals = {}
        return
    end

    local children = folder:get_children()
    if not children then return end

    local out = {}
    for i = 1, #children do
        local inst = children[i]
        local name = inst.Name
        local n_lower = name:lower()

        local is_bear = n_lower:find("bear")
        local is_wolf = n_lower:find("wolf") or n_lower:find("werewolf")
        local is_boar = n_lower:find("boar")
        local is_deer = n_lower:find("deer")

        local col = nil
        local show = false

        if is_bear and cfg.a_bear then
            col = cfg.a_bear_col
            show = true
        elseif is_wolf and cfg.a_wolf then
            col = cfg.a_wolf_col
            show = true
        elseif is_boar and cfg.a_boar then
            col = cfg.a_boar_col
            show = true
        elseif is_deer and cfg.a_deer then
            col = cfg.a_deer_col
            show = true
        end

        if show then
            local part = get_model_position_part(inst)

            if part then
                local px, py, pz = safe_pos(part)
                if px then
                    local hp = 100
                    local max_hp = 100
                    local hum = inst:find_first_child("Humanoid")
                    if hum then
                        hp = tonumber(hum.Health) or 100
                        max_hp = tonumber(hum.MaxHealth) or 100
                        if max_hp < 1 then max_hp = 100 end
                        hp = clamp(hp, 0, max_hp)
                    end

                    out[#out + 1] = {
                        x = px, y = py, z = pz,
                        name = name,
                        hp = hp,
                        max_hp = max_hp,
                        color = col
                    }
                end
            end
        end
    end
    cached_animals = out
end

-- =========================================================================
-- BACKGROUND SCANNER: NPCS (SOLDIERS, SCIENTISTS, PATROL HELICOPTER)
-- =========================================================================
local function scan_npcs_task()
    if not cfg.npc_enabled then
        cached_npcs = {}
        return
    end

    local ws = game.workspace or game.Workspace
    if not ws then return end

    local out = {}

    -- 1. Scan Ground NPCs (Soldiers / Scientists) in workspace.Npcs
    if cfg.npc_soldier then
        local npcs_folder = ws:find_first_child("Npcs")
        if npcs_folder then
            local children = npcs_folder:get_children()
            if children then
                for i = 1, #children do
                    local inst = children[i]
                    local name = inst.Name
                    local root = get_model_position_part(inst)
                    if root then
                        local px, py, pz = safe_pos(root)
                        if px then
                            local hum = inst:find_first_child("Humanoid")
                            local hp = 100
                            local max_hp = 100
                            if hum then
                                hp = tonumber(hum.Health) or 100
                                max_hp = tonumber(hum.MaxHealth) or 100
                                if max_hp < 1 then max_hp = 100 end
                                hp = clamp(hp, 0, max_hp)
                            end

                            local held_gun = "Military AR"
                            local gun_model = inst:find_first_child("Gun")
                            if gun_model then
                                held_gun = "Military Rifle"
                            end

                            out[#out + 1] = {
                                x = px, y = py, z = pz,
                                name = name,
                                held = held_gun,
                                hp = hp,
                                max_hp = max_hp,
                                is_heli = false,
                                color = cfg.npc_sol_col
                            }
                        end
                    end
                end
            end
        end
    end

    -- 2. Scan Patrol Helicopter in workspace.FustPatrolHeli
    if cfg.npc_heli then
        local heli_folder = ws:find_first_child("FustPatrolHeli")
        if heli_folder then
            local heli_model = heli_folder:find_first_child("PatrolHeliModel") or heli_folder:find_first_child("PatrolHeli")
            if heli_model then
                local main_part = heli_model:find_first_child("Engine") or heli_model:find_first_child("Body") or heli_model:find_first_child("Fuselage") or heli_model:find_first_child("MainRotor")
                if not main_part then
                    local ch = heli_model:get_children()
                    if ch and #ch > 0 then
                        for k = 1, #ch do
                            if ch[k].ClassName == "Part" or ch[k].ClassName == "MeshPart" then
                                main_part = ch[k]
                                break
                            end
                        end
                    end
                end

                if main_part then
                    local px, py, pz = safe_pos(main_part)
                    if px then
                        local hum = heli_model:find_first_child("Humanoid")
                        local hp = 5000
                        local max_hp = 5000
                        if hum then
                            hp = tonumber(hum.Health) or 5000
                            max_hp = tonumber(hum.MaxHealth) or 5000
                            if max_hp < 1 then max_hp = 5000 end
                            hp = clamp(hp, 0, max_hp)
                        end

                        out[#out + 1] = {
                            x = px, y = py, z = pz,
                            name = "Patrol Helicopter",
                            held = "Twin Heavy MG + Rockets",
                            hp = hp,
                            max_hp = max_hp,
                            is_heli = true,
                            color = cfg.npc_heli_col
                        }
                    end
                end
            end
        end
    end

    cached_npcs = out
end

-- =========================================================================
-- VISUALS: FULLBRIGHT & REMOVE FOG ENGINE
-- =========================================================================
local function update_visuals_task()
    local lighting = game.Lighting or (game.get_service and game.get_service("Lighting"))
    if not lighting then return end

    if not orig_lighting_saved then
        orig_lighting.ClockTime = lighting.ClockTime or 14
        orig_lighting.Brightness = lighting.Brightness or 2
        orig_lighting.GlobalShadows = lighting.GlobalShadows
        orig_lighting.FogEnd = lighting.FogEnd or 100000
        orig_lighting.Ambient = lighting.Ambient
        orig_lighting.OutdoorAmbient = lighting.OutdoorAmbient
        orig_lighting_saved = true
    end

    if cfg.fullbright_enabled then
        pcall(function()
            lighting.ClockTime = cfg.fullbright_clock
            lighting.Brightness = cfg.fullbright_bright
            lighting.GlobalShadows = false
            lighting.FogEnd = cfg.no_fog and 9999999 or orig_lighting.FogEnd
            if lighting.FogStart then lighting.FogStart = 0 end
            lighting.Ambient = Color3 and Color3.fromRGB and Color3.fromRGB(255, 255, 255) or lighting.Ambient
            lighting.OutdoorAmbient = Color3 and Color3.fromRGB and Color3.fromRGB(255, 255, 255) or lighting.OutdoorAmbient
        end)
    else
        if orig_lighting_saved then
            pcall(function()
                lighting.ClockTime = orig_lighting.ClockTime
                lighting.Brightness = orig_lighting.Brightness
                lighting.GlobalShadows = orig_lighting.GlobalShadows
                lighting.FogEnd = orig_lighting.FogEnd
                if orig_lighting.Ambient then lighting.Ambient = orig_lighting.Ambient end
                if orig_lighting.OutdoorAmbient then lighting.OutdoorAmbient = orig_lighting.OutdoorAmbient end
            end)
        end
    end
end

-- =========================================================================
-- HIGH-FPS RENDER PIPELINE: INVENTORY VIEWER WITH DETAILED ARMOR TIERS
-- =========================================================================
local function draw_section(px, ly, pw, title, color)
    draw.rect_filled(px + 8, ly, pw - 16, 16, { 0.12, 0.14, 0.20, 0.90 }, 2)
    draw.text(px + 12, ly + 2, title, color, 10)
    return ly + 19
end

local function render_inventory_panel()
    if not cfg.inv_enabled then return end

    local mode = cfg.inv_mode
    local px = inv_panel.x
    local py = inv_panel.y
    local pw = inv_panel.w
    local ly = py + 32

    local target_inv = cached_target_inventory

    -- Calculate dynamically required height
    local entries = 0
    if (mode == 0 or mode == 2) and target_inv then
        entries = entries + 1
        if cfg.inv_show_weapons then
            entries = entries + 2
            if #target_inv.holsters > 0 then
                entries = entries + 1 + #target_inv.holsters
            end
        end
        if cfg.inv_show_wear and #target_inv.wear > 0 then
            entries = entries + 1 + #target_inv.wear
        end
        if cfg.inv_show_pack and target_inv.backpack then
            entries = entries + 2
        end
        if #target_inv.tools > 0 then
            entries = entries + 1 + #target_inv.tools
        end
    elseif mode == 0 then
        entries = entries + 2
    end

    if (mode == 1 or mode == 2) then
        entries = entries + 1 + math.max(1, #cached_local_inventory.hotbar)
        if cfg.inv_show_grid and #cached_local_inventory.grid > 0 then
            entries = entries + 1 + #cached_local_inventory.grid
        end
        if cfg.inv_show_wear and #cached_local_inventory.wear > 0 then
            entries = entries + 1 + #cached_local_inventory.wear
        end
    end

    local panel_h = math.max(80, 36 + entries * 16 + 12)

    -- Draw Main Window Base
    draw.rect_filled(px, py, pw, panel_h, col_panel_bg, 4)
    draw.rect(px, py, pw, panel_h, col_panel_border, 4, 1)

    -- Draw Title Bar
    draw.rect_filled(px, py, pw, 26, col_panel_header, 4)
    draw.line(px, py + 26, px + pw, py + 26, col_panel_border, 1)

    local title_str = "Inventory Viewer"
    if target_inv then
        title_str = target_inv.name .. " [" .. tostring(target_inv.distance_m) .. "m]"
    elseif mode == 1 then
        title_str = "Local Player (Full Inventory)"
    end

    draw.text(px + 10, py + 6, title_str, col_accent, 12)
    local drag_hint = ":: drag"
    local dhw = draw.get_text_size(drag_hint, 10)
    draw.text(px + pw - dhw - 8, py + 8, drag_hint, col_text_dim, 10)

    -- 1. TARGET PLAYER COMPLETE INVENTORY
    if (mode == 0 or mode == 2) then
        if target_inv then
            -- Health Bar
            local hp_pct = clamp(target_inv.hp / math.max(1, target_inv.max_hp), 0, 1)
            draw.rect_filled(px + 8, ly, pw - 16, 4, { 0.15, 0.15, 0.15, 1 }, 1)
            draw.rect_filled(px + 8, ly, (pw - 16) * hp_pct, 4, { (1 - hp_pct), hp_pct, 0.2, 1 }, 1)
            ly = ly + 9

            -- A. Equipped Tool
            if cfg.inv_show_weapons then
                ly = draw_section(px, ly, pw, "EQUIPPED ITEM", col_weapon)
                local eq_text = target_inv.equipped or "None / Empty Hands"
                local eq_col = target_inv.equipped and get_item_color(target_inv.equipped) or col_text_dim
                draw.text(px + 14, ly, eq_text, eq_col, 11)
                ly = ly + 15

                -- B. Holstered Weapons
                if #target_inv.holsters > 0 then
                    ly = draw_section(px, ly, pw, "HOLSTERED WEAPONS", col_weapon)
                    for h = 1, #target_inv.holsters do
                        draw.text(px + 14, ly, "- " .. target_inv.holsters[h], col_weapon, 11)
                        ly = ly + 15
                    end
                end
            end

            -- C. Worn Armor & Clothing with Detailed Tier Identification
            if cfg.inv_show_wear and #target_inv.wear > 0 then
                ly = draw_section(px, ly, pw, "WORN GEAR & ARMOR TIERS", col_armor)
                for w = 1, #target_inv.wear do
                    local item = target_inv.wear[w]
                    local lbl = "[" .. item.slot .. ": " .. item.tier .. "] " .. item.display
                    local col = item.color or col_armor
                    draw.text(px + 14, ly, lbl, col, 11)
                    ly = ly + 15
                end
            end

            -- D. Backpack Container
            if cfg.inv_show_pack and target_inv.backpack then
                ly = draw_section(px, ly, pw, "CONTAINER", col_pack)
                draw.text(px + 14, ly, "[Pack] " .. target_inv.backpack, col_pack, 11)
                ly = ly + 15
            end

            -- E. Stored Tools in Backpack
            if #target_inv.tools > 0 then
                ly = draw_section(px, ly, pw, "STORED TOOLS", col_weapon)
                for t = 1, #target_inv.tools do
                    draw.text(px + 14, ly, "- " .. target_inv.tools[t], col_weapon, 11)
                    ly = ly + 15
                end
            end
        elseif mode == 0 then
            draw.text(px + 14, ly + 8, "No player near crosshair", col_text_dim, 11)
            ly = ly + 26
        end
    end

    -- 2. LOCAL PLAYER FULL INVENTORY
    if (mode == 1 or mode == 2) then
        -- A. Hotbar Slots 1 to 6
        ly = draw_section(px, ly, pw, "HOTBAR (SLOTS 1-6)", col_weapon)
        if #cached_local_inventory.hotbar > 0 then
            for i = 1, #cached_local_inventory.hotbar do
                local it = cached_local_inventory.hotbar[i]
                local amt_str = it.amount ~= "" and (" (x" .. it.amount .. ")") or ""
                local armor_info = get_armor_info(it.name)
                local label = ""
                local item_col = get_item_color(it.name)

                if armor_info then
                    label = tostring(it.slot) .. ": " .. armor_info.display .. " [" .. armor_info.tier .. "]" .. amt_str
                    item_col = armor_info.color
                else
                    label = tostring(it.slot) .. ": " .. it.name .. amt_str
                end

                draw.text(px + 14, ly, label, item_col, 11)
                ly = ly + 15
            end
        else
            draw.text(px + 14, ly, "No items in hotbar", col_text_dim, 11)
            ly = ly + 15
        end

        -- B. Main Inventory Grid Slots 7 to 36
        if cfg.inv_show_grid then
            ly = draw_section(px, ly, pw, "MAIN INVENTORY (SLOTS 7-36)", col_resource)
            if #cached_local_inventory.grid > 0 then
                for i = 1, #cached_local_inventory.grid do
                    local it = cached_local_inventory.grid[i]
                    local amt_str = it.amount ~= "" and (" (x" .. it.amount .. ")") or ""
                    local armor_info = get_armor_info(it.name)
                    local label = ""
                    local item_col = get_item_color(it.name)

                    if armor_info then
                        label = tostring(it.slot) .. ": " .. armor_info.display .. " [" .. armor_info.tier .. "]" .. amt_str
                        item_col = armor_info.color
                    else
                        label = tostring(it.slot) .. ": " .. it.name .. amt_str
                    end

                    draw.text(px + 14, ly, label, item_col, 11)
                    ly = ly + 15
                end
            else
                draw.text(px + 14, ly, "Main inventory is empty", col_text_dim, 11)
                ly = ly + 15
            end
        end

        -- C. Worn Equipment & Armor Slots with Detailed Tiers
        if cfg.inv_show_wear and #cached_local_inventory.wear > 0 then
            ly = draw_section(px, ly, pw, "MY WORN GEAR & ARMOR TIERS", col_armor)
            for i = 1, #cached_local_inventory.wear do
                local it = cached_local_inventory.wear[i]
                local armor_info = get_armor_info(it.name)
                local label = ""
                local col = col_armor

                if armor_info then
                    label = "[" .. it.slot_name .. ": " .. armor_info.tier .. "] " .. armor_info.display
                    col = armor_info.color
                else
                    label = "[" .. it.slot_name .. "] " .. it.name
                end

                draw.text(px + 14, ly, label, col, 11)
                ly = ly + 15
            end
        end
    end
end

-- =========================================================================
-- HIGH FPS RENDER PIPELINE: ANIMALS & NPCS ESP
-- =========================================================================
local function render_animals()
    if not cfg.a_enabled then return end
    local sw, sh = utility.get_screen_size()
    local tox, toy = sw * 0.5, sh

    for j = 1, #cached_animals do
        local an = cached_animals[j]
        local dx = an.x - cam_x
        local dy = an.y - cam_y
        local dz = an.z - cam_z
        local d_sq = dx * dx + dy * dy + dz * dz

        if d_sq <= cfg.a_max_sq then
            local sx, sy, vis = utility.world_to_screen(an.x, an.y, an.z)
            if vis then
                local col = an.color
                draw.circle_filled(sx, sy, 3, col)

                local parts = {}
                if cfg.a_name then
                    parts[#parts + 1] = an.name
                end
                if cfg.a_dist then
                    local dm = math.floor(math.sqrt(d_sq) * 0.28)
                    parts[#parts + 1] = "[" .. tostring(dm) .. "m]"
                end

                if #parts > 0 then
                    local txt = table.concat(parts, " ")
                    local tw = draw.get_text_size(txt, cfg.a_font)
                    draw.text(sx - tw * 0.5, sy - cfg.a_font - 3, txt, col, cfg.a_font)
                end

                if cfg.a_hp then
                    local hp_pct = clamp(an.hp / math.max(1, an.max_hp), 0, 1)
                    local bar_w = 26
                    local bar_h = 3
                    local bx = sx - bar_w * 0.5
                    local by = sy + 5
                    draw.rect_filled(bx, by, bar_w, bar_h, { 0.1, 0.1, 0.1, 0.8 })
                    draw.rect_filled(bx, by, bar_w * hp_pct, bar_h, { 1 - hp_pct, hp_pct, 0.2, 1 })
                end

                if cfg.a_tracers then
                    draw.line(tox, toy, sx, sy, { col[1], col[2], col[3], 0.30 }, 1)
                end
            end
        end
    end
end

local function render_npcs()
    if not cfg.npc_enabled then return end
    local sw, sh = utility.get_screen_size()
    local tox, toy = sw * 0.5, sh

    for j = 1, #cached_npcs do
        local n = cached_npcs[j]
        local dx = n.x - cam_x
        local dy = n.y - cam_y
        local dz = n.z - cam_z
        local d_sq = dx * dx + dy * dy + dz * dz

        if d_sq <= cfg.npc_max_sq then
            local sx, sy, vis = utility.world_to_screen(n.x, n.y, n.z)
            if vis then
                local col = n.color
                draw.circle_filled(sx, sy, 3.5, col)

                local parts = {}
                if cfg.npc_name then
                    parts[#parts + 1] = n.name
                end
                if cfg.npc_dist then
                    local dm = math.floor(math.sqrt(d_sq) * 0.28)
                    parts[#parts + 1] = "[" .. tostring(dm) .. "m]"
                end

                if #parts > 0 then
                    local txt = table.concat(parts, " ")
                    local tw = draw.get_text_size(txt, cfg.npc_font)
                    draw.text(sx - tw * 0.5, sy - cfg.npc_font - 4, txt, col, cfg.npc_font)
                end

                if n.held then
                    local hw = draw.get_text_size(n.held, cfg.npc_font - 2)
                    draw.text(sx - hw * 0.5, sy + 6, n.held, { 1, 0.85, 0.3, 1 }, cfg.npc_font - 2)
                end

                if cfg.npc_hp then
                    local hp_pct = clamp(n.hp / math.max(1, n.max_hp), 0, 1)
                    local bar_w = n.is_heli and 50 or 30
                    local bar_h = 3
                    local bx = sx - bar_w * 0.5
                    local by = sy + (n.held and 18 or 6)
                    draw.rect_filled(bx, by, bar_w, bar_h, { 0.1, 0.1, 0.1, 0.8 })
                    draw.rect_filled(bx, by, bar_w * hp_pct, bar_h, { 1 - hp_pct, hp_pct, 0.2, 1 })
                end

                if cfg.npc_tracers then
                    draw.line(tox, toy, sx, sy, { col[1], col[2], col[3], 0.35 }, 1)
                end
            end
        end
    end
end

-- =========================================================================
-- HIGH FPS RENDER PIPELINE: PLAYERS, NODES, PICKUPS, DROPPED
-- =========================================================================
local SKELETON_BONES = {
    { "Head", "UpperTorso" },
    { "UpperTorso", "LowerTorso" },
    { "UpperTorso", "LeftUpperArm" },
    { "LeftUpperArm", "LeftLowerArm" },
    { "LeftLowerArm", "LeftHand" },
    { "UpperTorso", "RightUpperArm" },
    { "RightUpperArm", "RightLowerArm" },
    { "RightLowerArm", "RightHand" },
    { "LowerTorso", "LeftUpperLeg" },
    { "LeftUpperLeg", "LeftLowerLeg" },
    { "LeftLowerLeg", "LeftFoot" },
    { "LowerTorso", "RightUpperLeg" },
    { "RightUpperLeg", "RightLowerLeg" },
    { "RightLowerLeg", "RightFoot" }
}

local R6_BONES = {
    { "Head", "Torso" },
    { "Torso", "Left Arm" },
    { "Torso", "Right Arm" },
    { "Torso", "Left Leg" },
    { "Torso", "Right Leg" }
}

local function render_player_esp(p)
    local rx, ry, rz = safe_pos(p.root)
    if not rx then return end

    local dx = rx - cam_x
    local dy = ry - cam_y
    local dz = rz - cam_z
    local d_sq = dx * dx + dy * dy + dz * dz

    if d_sq > cfg.p_max_sq then return end

    local hx, hy, hz = safe_pos(p.head)
    if not hx then return end

    local fsx, fsy, f_vis = utility.world_to_screen(rx, ry - 3.2, rz)
    local tsx, tsy, t_vis = utility.world_to_screen(hx, hy + 1.2, hz)

    if not f_vis and not t_vis then return end

    local box_h = math.abs(fsy - tsy)
    if box_h < 4 then return end
    local box_w = box_h * 0.58
    local box_x = fsx - box_w * 0.5
    local box_y = tsy

    if cfg.p_chams then
        draw.rect_filled(box_x, box_y, box_w, box_h, cfg.p_chams_col)
    end

    local bcol = p.is_sleeper and cfg.p_sleep_col or cfg.p_box_col
    if cfg.p_box then
        draw.rect(box_x, box_y, box_w, box_h, bcol, 1)
    end

    if cfg.p_hp then
        local hp_pct = clamp(p.hp / math.max(1, p.max_hp), 0, 1)
        local bar_x = box_x - 5
        local bar_h = box_h * hp_pct
        draw.rect_filled(bar_x, box_y, 3, box_h, { 0.1, 0.1, 0.1, 0.8 })
        draw.rect_filled(bar_x, box_y + (box_h - bar_h), 3, bar_h, { (1 - hp_pct), hp_pct, 0.2, 1 })
    end

    if cfg.p_skel and p.parts then
        local is_r15 = p.parts["UpperTorso"] ~= nil
        local bones = is_r15 and SKELETON_BONES or R6_BONES
        local scol = cfg.p_skel_col

        for b = 1, #bones do
            local pair = bones[b]
            local p1 = p.parts[pair[1]]
            local p2 = p.parts[pair[2]]
            if p1 and p2 then
                local x1, y1, z1 = safe_pos(p1)
                local x2, y2, z2 = safe_pos(p2)
                if x1 and x2 then
                    local s1x, s1y, v1 = utility.world_to_screen(x1, y1, z1)
                    local s2x, s2y, v2 = utility.world_to_screen(x2, y2, z2)
                    if v1 and v2 then
                        draw.line(s1x, s1y, s2x, s2y, scol, 1)
                    end
                end
            end
        end
    end

    local text_y = box_y
    if cfg.p_name then
        draw.text(box_x + box_w + 4, text_y, p.name, col_text_main, cfg.p_font)
        text_y = text_y + cfg.p_font + 1
    end

    if cfg.p_dist then
        local dist_m = math.floor(math.sqrt(d_sq) * 0.28)
        draw.text(box_x + box_w + 4, text_y, tostring(dist_m) .. "m", col_text_dim, cfg.p_font - 1)
        text_y = text_y + cfg.p_font
    end

    if cfg.p_held and p.held then
        draw.text(box_x + box_w + 4, text_y, p.held, cfg.p_held_col, cfg.p_font - 1)
    end
end

local function render_nodes()
    if not cfg.n_enabled then return end
    local sw, sh = utility.get_screen_size()
    local tox, toy = sw * 0.5, sh

    for j = 1, #cached_nodes do
        local n = cached_nodes[j]
        local dx = n.x - cam_x
        local dy = n.y - cam_y
        local dz = n.z - cam_z
        local d_sq = dx * dx + dy * dy + dz * dz

        if d_sq <= cfg.n_max_sq then
            local sx, sy, vis = utility.world_to_screen(n.x, n.y, n.z)
            if vis then
                local col = n.color
                draw.circle_filled(sx, sy, 3, col)

                local dist_str = ""
                if cfg.n_dist then
                    local dm = math.floor(math.sqrt(d_sq) * 0.28)
                    dist_str = " [" .. tostring(dm) .. "m]"
                end

                local txt = n.name .. " Node" .. dist_str
                local tw = draw.get_text_size(txt, cfg.n_font)
                draw.text(sx - tw * 0.5, sy - cfg.n_font - 3, txt, col, cfg.n_font)

                if cfg.n_tracers then
                    draw.line(tox, toy, sx, sy, { col[1], col[2], col[3], 0.25 }, 1)
                end
            end
        end
    end
end

local function render_pickups()
    if not cfg.pk_enabled then return end
    for j = 1, #cached_pickups do
        local pk = cached_pickups[j]
        local dx = pk.x - cam_x
        local dy = pk.y - cam_y
        local dz = pk.z - cam_z
        local d_sq = dx * dx + dy * dy + dz * dz

        if d_sq <= cfg.pk_max_sq then
            local sx, sy, vis = utility.world_to_screen(pk.x, pk.y, pk.z)
            if vis then
                local col = pk.color
                local txt = pk.name
                if cfg.pk_dist then
                    local dm = math.floor(math.sqrt(d_sq) * 0.28)
                    txt = txt .. " [" .. tostring(dm) .. "m]"
                end
                local tw = draw.get_text_size(txt, cfg.pk_font)
                draw.text(sx - tw * 0.5, sy - 6, txt, col, cfg.pk_font)
            end
        end
    end
end

local function render_dropped()
    if not cfg.d_enabled then return end
    local col = cfg.d_col
    for j = 1, #cached_dropped do
        local d = cached_dropped[j]
        local dx = d.x - cam_x
        local dy = d.y - cam_y
        local dz = d.z - cam_z
        local d_sq = dx * dx + dy * dy + dz * dz

        if d_sq <= cfg.d_max_sq then
            local sx, sy, vis = utility.world_to_screen(d.x, d.y, d.z)
            if vis then
                local txt = d.name
                if cfg.d_dist then
                    local dm = math.floor(math.sqrt(d_sq) * 0.28)
                    txt = txt .. " [" .. tostring(dm) .. "m]"
                end
                local tw = draw.get_text_size(txt, cfg.d_font)
                draw.text(sx - tw * 0.5, sy - 6, txt, col, cfg.d_font)
            end
        end
    end
end

-- =========================================================================
-- AIMBOT & CAMERA ZOOM CONTROL
-- =========================================================================
local function update_aimbot_and_zoom()
    local cx, cy = nil, nil
    if input and input.get_screen_center then
        local ok, sx, sy = pcall(function() return input.get_screen_center() end)
        if ok and sx and sy and sx > 0 then
            cx, cy = sx, sy
        end
    end
    if not cx then
        local sw, sh = utility.get_screen_size()
        cx, cy = sw * 0.5, sh * 0.5
    end

    -- 1. FOV Circle & Status Overlay (64 segments for smooth round circle)
    if cfg.aim_enabled and cfg.aim_fov_dr then
        draw.circle(cx, cy, cfg.aim_fov, cfg.aim_fov_col, 64)

        local p_info = cached_local_profile
        local name_str = p_info and p_info.name or (cached_local_tool or "Manual")
        local speed_val = p_info and p_info.speed or cfg.aim_speed
        local info_str = string.format("[%s | %dm/s]", name_str, speed_val)
        if cfg.aim_pred then info_str = info_str .. " +Lead" end
        if cfg.aim_drop then info_str = info_str .. " +Drop" end

        local tw = draw.get_text_size(info_str, 11)
        draw.text(cx - tw * 0.5, cy + cfg.aim_fov + 6, info_str, { 0.4, 0.75, 1, 0.8 }, 11)
    end

    -- 2. Zoom / Scope Handling
    if cfg.zoom_enabled then
        local zoom_active = false
        if cfg.zoom_key and cfg.zoom_key > 0 then
            zoom_active = input.is_key_down(cfg.zoom_key)
        else
            zoom_active = true
        end

        if zoom_active then
            local cam = game.workspace and game.workspace.CurrentCamera
            if cam then
                local cur_fov = cam.FieldOfView or 70
                local target_fov = cfg.zoom_fov
                local step = (target_fov - cur_fov) / math.max(1, cfg.zoom_smooth)
                cam.FieldOfView = cur_fov + step
            end
        end
    end

    -- 3. Aimbot Target Evaluation
    if not cfg.aim_enabled then
        aim_target_player = nil
        cached_target_inventory = nil
        return
    end

    local aim_down = input.is_key_down(cfg.aim_key)
    local best_target = nil
    local best_dist = cfg.aim_fov
    local best_target_pos = nil

    local bone_name = "Head"
    if cfg.aim_bone_idx == 1 then bone_name = "UpperTorso"
    elseif cfg.aim_bone_idx == 2 then bone_name = "HumanoidRootPart" end

    for i = 1, #cached_players do
        local p = cached_players[i]
        local bone_part = p.char:find_first_child(bone_name) or p.head or p.root
        if bone_part then
            local bx, by, bz = safe_pos(bone_part)
            if bx then
                local sx, sy, vis = utility.world_to_screen(bx, by, bz)
                if vis then
                    local d_cross = math.sqrt((sx - cx) * (sx - cx) + (sy - cy) * (sy - cy))
                    if d_cross < best_dist then
                        best_dist = d_cross
                        best_target = p
                        best_target_pos = { x = bx, y = by, z = bz }
                    end
                end
            end
        end
    end

    aim_target_player = best_target

    -- Scan target inventory for crosshair player
    if best_target and cfg.inv_enabled and (cfg.inv_mode == 0 or cfg.inv_mode == 2) then
        cached_target_inventory = scan_target_full_inventory(best_target)
    else
        if cfg.inv_mode == 0 then
            cached_target_inventory = nil
        end
    end

    -- 4. Lead Prediction & Drop Compensation
    if best_target and best_target_pos and aim_down then
        local tx = best_target_pos.x
        local ty = best_target_pos.y
        local tz = best_target_pos.z

        local dx = tx - cam_x
        local dy = ty - cam_y
        local dz = tz - cam_z
        local dist_studs = math.sqrt(dx * dx + dy * dy + dz * dz)

        local proj_speed = cfg.aim_speed
        local drop_mult = cfg.aim_drop_ratio
        if cfg.aim_auto_gun and cached_local_profile then
            proj_speed = cached_local_profile.speed
            drop_mult = cached_local_profile.drop
        end

        local proj_speed_studs = proj_speed * 3.571
        local time_to_hit = dist_studs / math.max(1, proj_speed_studs)

        if cfg.aim_pred and best_target.root and best_target.root.AssemblyLinearVelocity then
            local vel = best_target.root.AssemblyLinearVelocity
            local vx = vel.x or vel.X or 0
            local vy = vel.y or vel.Y or 0
            local vz = vel.z or vel.Z or 0
            tx = tx + vx * time_to_hit
            ty = ty + vy * time_to_hit
            tz = tz + vz * time_to_hit
        end

        if cfg.aim_drop then
            local gravity = 196.2
            local drop_offset = 0.5 * gravity * (time_to_hit * time_to_hit) * drop_mult
            ty = ty + drop_offset
        end

        if camera and camera.look_at then
            pcall(function() camera.look_at(tx, ty, tz, cfg.aim_smooth) end)
        else
            local tsx, tsy, tvis = utility.world_to_screen(tx, ty, tz)
            if tvis and input and input.mouse_move then
                local move_x = (tsx - cx) / cfg.aim_smooth
                local move_y = (tsy - cy) / cfg.aim_smooth
                pcall(function() input.mouse_move(move_x, move_y) end)
            end
        end
    end
end

-- =========================================================================
-- DRAGGABLE INVENTORY PANEL INPUT HANDLER
-- =========================================================================
local function get_safe_mouse_pos()
    if utility and utility.get_mouse_pos then
        local ok, mx, my = pcall(function() return utility.get_mouse_pos() end)
        if ok and mx then return mx, my end
    end
    if input and input.get_mouse_pos then
        local ok, mx, my = pcall(function() return input.get_mouse_pos() end)
        if ok and mx then return mx, my end
    end
    return 0, 0
end

local function handle_inventory_drag()
    if not cfg.inv_enabled then return end

    local mx, my = get_safe_mouse_pos()
    local lmb = false
    if input and input.is_key_down then
        lmb = input.is_key_down(1) or input.is_key_down(0x01)
    end

    local px = inv_panel.x
    local py = inv_panel.y
    local pw = inv_panel.w
    local header_h = 26

    if lmb then
        if not inv_panel.dragging then
            if mx >= px and mx <= (px + pw) and my >= py and my <= (py + header_h) then
                inv_panel.dragging = true
                inv_panel.drag_ox = mx - px
                inv_panel.drag_oy = my - py
            end
        else
            inv_panel.x = clamp(mx - inv_panel.drag_ox, 0, 1920 - pw)
            inv_panel.y = clamp(my - inv_panel.drag_oy, 0, 1080 - 40)
        end
    else
        inv_panel.dragging = false
    end
end

-- =========================================================================
-- CONFIGURATION REFRESH FROM MENU ON FRAME
-- =========================================================================
local function refresh_menu_config()
    cfg.aim_enabled = menu.get("aim_enabled") or false
    local k = menu.get_key and menu.get_key("aim_enabled") or 0
    if k and k > 0 then cfg.aim_key = k else cfg.aim_key = 2 end
    cfg.aim_fov_dr  = menu.get("aim_draw_fov") or false
    cfg.aim_fov_col = menu.get_color("aim_draw_fov") or { 1, 1, 1, 0.35 }
    cfg.aim_pred    = menu.get("aim_prediction") or false
    cfg.aim_drop    = menu.get("aim_drop_comp") or false
    cfg.aim_auto_gun= menu.get("aim_auto_gun")
    if cfg.aim_auto_gun == nil then cfg.aim_auto_gun = true end
    cfg.aim_speed   = menu.get("aim_proj_speed") or 350
    cfg.aim_bone_idx= menu.get("aim_bone") or 0
    cfg.aim_fov     = menu.get("aim_fov") or 140
    cfg.aim_smooth  = math.max(1, menu.get("aim_smooth") or 4)

    cfg.zoom_enabled= menu.get("zoom_enabled") or false
    local zk = menu.get_key and menu.get_key("zoom_enabled") or 0
    if zk and zk > 0 then cfg.zoom_key = zk else cfg.zoom_key = 0 end
    cfg.zoom_fov    = menu.get("zoom_fov") or 30
    cfg.zoom_smooth = math.max(1, menu.get("zoom_smooth") or 4)

    cfg.fullbright_enabled = menu.get("fullbright_enabled") or false
    cfg.fullbright_clock   = menu.get("fullbright_clock") or 14
    cfg.fullbright_bright  = menu.get("fullbright_bright") or 2
    cfg.no_fog             = menu.get("no_fog") or false

    cfg.inv_enabled        = menu.get("inv_enabled") or false
    cfg.inv_mode           = menu.get("inv_mode") or 0
    cfg.inv_show_weapons   = menu.get("inv_show_weapons")
    if cfg.inv_show_weapons == nil then cfg.inv_show_weapons = true end
    cfg.inv_show_wear      = menu.get("inv_show_wear")
    if cfg.inv_show_wear == nil then cfg.inv_show_wear = true end
    cfg.inv_show_pack      = menu.get("inv_show_pack")
    if cfg.inv_show_pack == nil then cfg.inv_show_pack = true end
    cfg.inv_show_grid      = menu.get("inv_show_grid")
    if cfg.inv_show_grid == nil then cfg.inv_show_grid = true end

    local px = menu.get("inv_panel_x")
    local py = menu.get("inv_panel_y")
    local pw = menu.get("inv_panel_w")
    if not inv_panel.dragging then
        if px then inv_panel.x = px end
        if py then inv_panel.y = py end
        if pw then inv_panel.w = pw end
    end

    cfg.a_enabled   = menu.get("animals_esp_enabled") or false
    cfg.a_bear      = menu.get("animal_bear") or false
    cfg.a_bear_col  = menu.get_color("animal_bear") or { 0.95, 0.25, 0.25, 1.0 }
    cfg.a_wolf      = menu.get("animal_wolf") or false
    cfg.a_wolf_col  = menu.get_color("animal_wolf") or { 1.00, 0.55, 0.20, 1.0 }
    cfg.a_boar      = menu.get("animal_boar") or false
    cfg.a_boar_col  = menu.get_color("animal_boar") or { 0.85, 0.70, 0.40, 1.0 }
    cfg.a_deer      = menu.get("animal_deer") or false
    cfg.a_deer_col  = menu.get_color("animal_deer") or { 0.40, 0.90, 0.50, 1.0 }
    cfg.a_name      = menu.get("animals_show_name") or false
    cfg.a_dist      = menu.get("animals_show_dist") or false
    cfg.a_hp        = menu.get("animals_show_health") or false
    cfg.a_tracers   = menu.get("animals_tracers") or false
    local a_range   = menu.get("animals_max_dist") or 450
    cfg.a_max_sq    = (a_range / 0.28) * (a_range / 0.28)
    cfg.a_font      = menu.get("animals_font_size") or 12

    cfg.npc_enabled = menu.get("npcs_esp_enabled") or false
    cfg.npc_soldier = menu.get("npc_soldier") or false
    cfg.npc_sol_col = menu.get_color("npc_soldier") or { 0.25, 0.85, 1.0, 1.0 }
    cfg.npc_heli    = menu.get("npc_patrol_heli") or false
    cfg.npc_heli_col= menu.get_color("npc_patrol_heli") or { 1.0, 0.20, 0.20, 1.0 }
    cfg.npc_name    = menu.get("npcs_show_name") or false
    cfg.npc_dist    = menu.get("npcs_show_dist") or false
    cfg.npc_hp      = menu.get("npcs_show_health") or false
    cfg.npc_tracers = menu.get("npcs_tracers") or false
    local npc_range = menu.get("npcs_max_dist") or 600
    cfg.npc_max_sq  = (npc_range / 0.28) * (npc_range / 0.28)
    cfg.npc_font    = menu.get("npcs_font_size") or 13

    cfg.p_enabled   = menu.get("player_esp_enabled") or false
    cfg.p_box       = menu.get("player_box") or false
    cfg.p_box_col   = menu.get_color("player_box") or { 1, 1, 1, 0.85 }
    cfg.p_skel      = menu.get("player_skeleton") or false
    cfg.p_skel_col  = menu.get_color("player_skeleton") or { 1, 0.35, 0.35, 1 }
    cfg.p_chams     = menu.get("player_chams") or false
    cfg.p_chams_col = menu.get_color("player_chams") or { 0.95, 0.25, 0.25, 0.25 }
    cfg.p_name      = menu.get("player_name") or false
    cfg.p_dist      = menu.get("player_dist") or false
    cfg.p_sleepers  = menu.get("player_sleepers") or false
    cfg.p_sleep_col = menu.get_color("player_sleepers") or { 0.65, 0.70, 0.85, 0.85 }
    cfg.p_hp        = menu.get("player_health") or false
    cfg.p_held      = menu.get("player_held") or false
    cfg.p_held_col  = menu.get_color("player_held") or { 1, 0.85, 0.3, 1 }
    local p_range   = menu.get("player_max_dist") or 500
    cfg.p_max_sq    = (p_range / 0.28) * (p_range / 0.28)
    cfg.p_font      = menu.get("player_font_size") or 13

    cfg.n_enabled   = menu.get("nodes_esp_enabled") or false
    cfg.n_stone     = menu.get("stone_node") or false
    cfg.n_stone_col = menu.get_color("stone_node") or { 0.85, 0.85, 0.9, 1 }
    cfg.n_sulfur    = menu.get("sulfur_node") or false
    cfg.n_sulf_col  = menu.get_color("sulfur_node") or { 0.95, 0.85, 0.2, 1 }
    cfg.n_iron      = menu.get("iron_node") or false
    cfg.n_iron_col  = menu.get_color("iron_node") or { 0.45, 0.75, 1, 1 }
    cfg.n_dist      = menu.get("nodes_show_dist") or false
    cfg.n_tracers   = menu.get("nodes_tracers") or false
    local n_range   = menu.get("nodes_max_dist") or 450
    cfg.n_max_sq    = (n_range / 0.28) * (n_range / 0.28)
    cfg.n_font      = menu.get("nodes_font_size") or 13

    cfg.pk_enabled  = menu.get("pickups_esp_enabled") or false
    cfg.pk_ores     = menu.get("pickups_ores") or false
    cfg.pk_ores_col = menu.get_color("pickups_ores") or { 1, 0.8, 0.35, 1 }
    cfg.pk_plants   = menu.get("pickups_plants") or false
    cfg.pk_pl_col   = menu.get_color("pickups_plants") or { 0.35, 0.95, 0.45, 1 }
    cfg.pk_wood     = menu.get("pickups_wood") or false
    cfg.pk_wood_col = menu.get_color("pickups_wood") or { 0.75, 0.55, 0.35, 1 }
    cfg.pk_dist     = menu.get("pickups_show_dist") or false
    local pk_range  = menu.get("pickups_max_dist") or 200
    cfg.pk_max_sq   = (pk_range / 0.28) * (pk_range / 0.28)
    cfg.pk_font     = menu.get("pickups_font_size") or 12

    cfg.d_enabled   = menu.get("dropped_esp_enabled") or false
    cfg.d_col       = menu.get_color("dropped_color") or { 1, 0.4, 0.9, 1 }
    cfg.d_dist      = menu.get("dropped_show_dist") or false
    local d_range   = menu.get("dropped_max_dist") or 150
    cfg.d_max_sq    = (d_range / 0.28) * (d_range / 0.28)
    cfg.d_font      = menu.get("dropped_font_size") or 12
end

-- Safe Camera Updater for Project Vector
local function update_camera()
    local pos = nil
    if camera and camera.get_position then
        local ok, p = pcall(function() return camera.get_position() end)
        if ok and p then pos = p end
    end
    if not pos and utility and utility.get_camera_position then
        local ok, p = pcall(function() return utility.get_camera_position() end)
        if ok and p then pos = p end
    end
    if not pos then
        local ws = game.workspace or game.Workspace
        local cam = ws and ws.CurrentCamera
        if cam and cam.CFrame then
            pos = cam.CFrame.Position
        end
    end
    if pos then
        cam_x = pos.x or pos.X or cam_x
        cam_y = pos.y or pos.Y or cam_y
        cam_z = pos.z or pos.Z or cam_z
    end
end

-- =========================================================================
-- MAIN RENDER HOOK (PROJECT VECTOR NATIVE GLOBAL on_frame)
-- =========================================================================
function on_frame()
    refresh_menu_config()
    update_camera()
    handle_inventory_drag()

    if cfg.p_enabled then
        for i = 1, #cached_players do
            render_player_esp(cached_players[i])
        end
    end

    render_animals()
    render_npcs()
    render_nodes()
    render_pickups()
    render_dropped()
    render_inventory_panel()
    update_aimbot_and_zoom()
end

-- Fallback for environments with client table
if client and client.register_callback then
    pcall(function() client.register_callback("on_frame", on_frame) end)
end

-- =========================================================================
-- LOW-TICK BACKGROUND WORKER THREADS
-- =========================================================================
thread.create(scan_players_task, 350)
thread.create(scan_animals_task, 800)
thread.create(scan_npcs_task, 800)
thread.create(scan_nodes_task, 1500)
thread.create(scan_pickups_task, 1500)
thread.create(scan_dropped_task, 1200)
thread.create(scan_local_inventory_task, 400)
thread.create(update_visuals_task, 1000)

print("[Hamster Hub] Full script with Config System and Detailed Armor Types loaded successfully.")
