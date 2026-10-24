--[[
Project Vector - Hamster Hub (Dust Place 79862723087324)
Features:
- Organized Sidebar Tabs:
  * Aimbot (Aimbot & Prediction, Gun Mods, Camera & Zoom)
  * Visuals (Player ESP, NPCs ESP, Animals ESP, Environment)
  * World (Loot Containers ESP with Collapsible Dropdowns, Body Bags, Ores & Pickups)
  * Inventory (Interactive Player Inventory & Container Viewer)
  * Settings (Configuration Save/Load, HUD & Anti-AFK)
- Advanced Aimbot & Gun Mods:
  * Recoil Control System (RCS with adjustable % reduction)
  * Full Auto / Rapid Fire (Continuous fire for semi-auto weapons)
  * Triggerbot (Auto Shoot on Crosshair with delay & NPC toggle)
  * Multi-bone humanoid resolution & lead prediction for Players, Soldiers, Patrol Heli
  * Visible Check (LOS raycast) & Team check
  * Pulsing 32-segment target lock ring
- Visuals & ESP:
  * 14-Bone Skeleton ESP, Dynamic Boxes, Health bars, Weapon held detection, Sleepers, Tracers & Off-Screen radar arrows
  * Completely separated & individual Base Container toggles (Large Box, Small Box, TC, Locker, Furnace, Workbench, Shelves, Sleeping Bag)
- Automation & Utility:
  * Anti-AFK (Roblox Idled interception + heartbeat keepalive)
  * Watermark & live FPS counter (Enabled by default)
  * Full configuration auto-save & auto-load persistence (hamster_hub_config.txt)
--]]

local TAB_AIM   = "Aimbot"
local TAB_VIS   = "Visuals"
local TAB_WORLD = "World"
local TAB_INV   = "Inventory"
local TAB_CFG   = "Settings"

-- =========================================================================
-- ORGANIZED MENU TABS & COLLAPSIBLE DROPDOWN WINDOWS
-- =========================================================================
menu.add_tab(TAB_AIM,   "A")
menu.add_tab(TAB_VIS,   "V")
menu.add_tab(TAB_WORLD, "W")
menu.add_tab(TAB_INV,   "I")
menu.add_tab(TAB_CFG,   "S")

-- =========================================================================
-- TAB 1: AIMBOT & WEAPONS
-- =========================================================================
menu.add_group(TAB_AIM, "Aimbot & Prediction")
menu.add_checkbox(TAB_AIM, "Aimbot & Prediction", "aim_enabled", "Enable Aimbot", false, { key = 2, show_mode = false })
menu.add_checkbox(TAB_AIM, "Aimbot & Prediction", "aim_draw_fov", "Draw FOV Circle", false, { parent = "aim_enabled", colorpicker = { 1.0, 1.0, 1.0, 0.35 } })
menu.add_checkbox(TAB_AIM, "Aimbot & Prediction", "aim_auto_bow", "Auto Gun/Bow Velocity", true, { parent = "aim_enabled" })
menu.add_checkbox(TAB_AIM, "Aimbot & Prediction", "aim_target_npcs", "Target NPCs / Scientists", false, { parent = "aim_enabled" })
menu.add_checkbox(TAB_AIM, "Aimbot & Prediction", "aim_vis_check", "Visible Check (LOS Raycast)", false, { parent = "aim_enabled" })
menu.add_checkbox(TAB_AIM, "Aimbot & Prediction", "aim_team_check", "Skip Friendly Teammates", false, { parent = "aim_enabled" })
menu.add_checkbox(TAB_AIM, "Aimbot & Prediction", "aim_target_highlight", "Pulsing Target Lock Ring", false, { parent = "aim_enabled", colorpicker = { 1.0, 0.30, 0.30, 1.0 } })
menu.add_checkbox(TAB_AIM, "Aimbot & Prediction", "aim_prediction", "Auto Lead Prediction", false, { parent = "aim_enabled" })
menu.add_checkbox(TAB_AIM, "Aimbot & Prediction", "aim_drop_comp", "Bullet/Arrow Drop Comp", false, { parent = "aim_enabled" })
menu.add_slider_int(TAB_AIM, "Aimbot & Prediction", "aim_proj_speed", "Manual Velocity (studs/s)", 50, 1200, 350, { parent = "aim_enabled" })
menu.add_combo(TAB_AIM, "Aimbot & Prediction", "aim_bone", "Target Bone", { "Head", "UpperTorso", "HumanoidRootPart" }, 0, { parent = "aim_enabled" })
menu.add_slider_int(TAB_AIM, "Aimbot & Prediction", "aim_fov", "FOV Radius (px)", 20, 600, 140, { parent = "aim_enabled" })
menu.add_slider_int(TAB_AIM, "Aimbot & Prediction", "aim_smooth", "Smoothing (1 = Instant)", 1, 20, 4, { parent = "aim_enabled" })

-- Gun Mods Group
menu.add_group(TAB_AIM, "Gun Mods")
menu.add_checkbox(TAB_AIM, "Gun Mods", "gun_recoil_enabled", "Recoil Control System (RCS)", false)
menu.add_slider_int(TAB_AIM, "Gun Mods", "gun_recoil_pct", "Recoil Reduction (%)", 10, 100, 80, { parent = "gun_recoil_enabled" })
menu.add_checkbox(TAB_AIM, "Gun Mods", "gun_rapid_fire", "Full Auto / Rapid Fire", false)
menu.add_slider_int(TAB_AIM, "Gun Mods", "gun_rapid_delay", "Rapid Fire Delay (ms)", 50, 400, 120, { parent = "gun_rapid_fire" })
menu.add_checkbox(TAB_AIM, "Gun Mods", "gun_triggerbot", "Triggerbot (Auto Shoot on Crosshair)", false)
menu.add_slider_int(TAB_AIM, "Gun Mods", "gun_trigger_delay", "Trigger Reaction Delay (ms)", 0, 200, 25, { parent = "gun_triggerbot" })
menu.add_checkbox(TAB_AIM, "Gun Mods", "gun_trigger_npcs", "Triggerbot Targets NPCs", true, { parent = "gun_triggerbot" })

-- Camera & Zoom Group
menu.add_group(TAB_AIM, "Camera & Zoom")
menu.add_checkbox(TAB_AIM, "Camera & Zoom", "zoom_enabled", "Enable Zoom / Scope", false, { key = 0, show_mode = false })
menu.add_slider_int(TAB_AIM, "Camera & Zoom", "zoom_fov", "Zoom Field of View", 10, 60, 30, { parent = "zoom_enabled" })
menu.add_slider_int(TAB_AIM, "Camera & Zoom", "zoom_smooth", "Zoom Smooth Speed", 1, 15, 6, { parent = "zoom_enabled" })

-- =========================================================================
-- TAB 2: VISUALS & ESP
-- =========================================================================
menu.add_group(TAB_VIS, "Player ESP")
menu.add_checkbox(TAB_VIS, "Player ESP", "player_esp_enabled", "Enable Player ESP", false)
menu.add_checkbox(TAB_VIS, "Player ESP", "player_box", "Bounding Box", false, { parent = "player_esp_enabled", colorpicker = { 1.0, 1.0, 1.0, 0.85 } })
menu.add_checkbox(TAB_VIS, "Player ESP", "player_skeleton", "14-Bone Skeleton ESP", false, { parent = "player_esp_enabled", colorpicker = { 1.0, 0.35, 0.35, 1.0 } })
menu.add_checkbox(TAB_VIS, "Player ESP", "player_chams", "Box Chams (Filled)", false, { parent = "player_esp_enabled", colorpicker = { 0.95, 0.25, 0.25, 0.25 } })
menu.add_checkbox(TAB_VIS, "Player ESP", "player_health", "Health Bar & HP Text", false, { parent = "player_esp_enabled" })
menu.add_checkbox(TAB_VIS, "Player ESP", "player_held", "Equipped Weapon / Tool", false, { parent = "player_esp_enabled", colorpicker = { 1.0, 0.85, 0.30, 1.0 } })
menu.add_checkbox(TAB_VIS, "Player ESP", "player_name", "Player Name", false, { parent = "player_esp_enabled" })
menu.add_checkbox(TAB_VIS, "Player ESP", "player_dist", "Distance Readout", false, { parent = "player_esp_enabled" })
menu.add_checkbox(TAB_VIS, "Player ESP", "player_sleepers", "Sleeping Players (Sleepers)", false, { parent = "player_esp_enabled", colorpicker = { 0.65, 0.70, 0.85, 0.85 } })
menu.add_checkbox(TAB_VIS, "Player ESP", "player_tracers", "Player Snaplines / Tracers", false, { parent = "player_esp_enabled", colorpicker = { 1.0, 1.0, 1.0, 0.35 } })
menu.add_checkbox(TAB_VIS, "Player ESP", "offscreen_players", "Off-Screen Player Radar Arrows", false, { parent = "player_esp_enabled" })
menu.add_slider_int(TAB_VIS, "Player ESP", "player_max_dist", "Max Range (m)", 20, 1500, 500, { parent = "player_esp_enabled" })
menu.add_slider_int(TAB_VIS, "Player ESP", "player_font_size", "Text Size", 10, 20, 13, { parent = "player_esp_enabled" })

menu.add_group(TAB_VIS, "NPCs ESP")
menu.add_checkbox(TAB_VIS, "NPCs ESP", "npcs_esp_enabled", "Enable NPCs ESP", false)
menu.add_checkbox(TAB_VIS, "NPCs ESP", "npc_soldier", "Soldiers & Scientists", false, { parent = "npcs_esp_enabled", colorpicker = { 0.25, 0.85, 1.00, 1.0 } })
menu.add_checkbox(TAB_VIS, "NPCs ESP", "npc_patrol_heli", "Patrol Helicopter", false, { parent = "npcs_esp_enabled", colorpicker = { 1.00, 0.20, 0.20, 1.0 } })
menu.add_checkbox(TAB_VIS, "NPCs ESP", "npc_skeleton", "NPC Skeleton ESP", false, { parent = "npcs_esp_enabled", colorpicker = { 1.00, 0.35, 0.35, 1.0 } })
menu.add_checkbox(TAB_VIS, "NPCs ESP", "npc_aimbot", "NPC Aimbot Tracking", false, { parent = "npcs_esp_enabled" })
menu.add_checkbox(TAB_VIS, "NPCs ESP", "npcs_show_name", "Show NPC Name", false, { parent = "npcs_esp_enabled" })
menu.add_checkbox(TAB_VIS, "NPCs ESP", "npcs_show_dist", "Distance Readout", false, { parent = "npcs_esp_enabled" })
menu.add_checkbox(TAB_VIS, "NPCs ESP", "npcs_show_health", "Health Bar & HP Text", false, { parent = "npcs_esp_enabled" })
menu.add_checkbox(TAB_VIS, "NPCs ESP", "npcs_tracers", "NPC Snaplines / Tracers", false, { parent = "npcs_esp_enabled" })
menu.add_checkbox(TAB_VIS, "NPCs ESP", "offscreen_npcs", "Off-Screen NPC Radar Arrows", false, { parent = "npcs_esp_enabled" })
menu.add_slider_int(TAB_VIS, "NPCs ESP", "npcs_max_dist", "Max Range (m)", 20, 1200, 450, { parent = "npcs_esp_enabled" })
menu.add_slider_int(TAB_VIS, "NPCs ESP", "npcs_font_size", "Text Size", 10, 20, 13, { parent = "npcs_esp_enabled" })

menu.add_group(TAB_VIS, "Animals ESP")
menu.add_checkbox(TAB_VIS, "Animals ESP", "animals_esp_enabled", "Enable Animals ESP", false)
menu.add_checkbox(TAB_VIS, "Animals ESP", "animal_bear", "Bears", false, { parent = "animals_esp_enabled", colorpicker = { 0.95, 0.25, 0.25, 1.0 } })
menu.add_checkbox(TAB_VIS, "Animals ESP", "animal_wolf", "Wolves & Werewolves", false, { parent = "animals_esp_enabled", colorpicker = { 1.00, 0.55, 0.20, 1.0 } })
menu.add_checkbox(TAB_VIS, "Animals ESP", "animal_boar", "Boars", false, { parent = "animals_esp_enabled", colorpicker = { 0.85, 0.70, 0.40, 1.0 } })
menu.add_checkbox(TAB_VIS, "Animals ESP", "animal_deer", "Deer", false, { parent = "animals_esp_enabled", colorpicker = { 0.40, 0.90, 0.50, 1.0 } })
menu.add_checkbox(TAB_VIS, "Animals ESP", "animals_show_name", "Animal Name", false, { parent = "animals_esp_enabled" })
menu.add_checkbox(TAB_VIS, "Animals ESP", "animals_show_dist", "Distance Readout", false, { parent = "animals_esp_enabled" })
menu.add_checkbox(TAB_VIS, "Animals ESP", "animals_show_health", "Health Bar & HP Text", false, { parent = "animals_esp_enabled" })
menu.add_checkbox(TAB_VIS, "Animals ESP", "animals_tracers", "Tracers / Snaplines", false, { parent = "animals_esp_enabled" })
menu.add_slider_int(TAB_VIS, "Animals ESP", "animals_max_dist", "Max Range (m)", 20, 1200, 450, { parent = "animals_esp_enabled" })
menu.add_slider_int(TAB_VIS, "Animals ESP", "animals_font_size", "Text Size", 10, 20, 12, { parent = "animals_esp_enabled" })

menu.add_group(TAB_VIS, "Environment")
menu.add_checkbox(TAB_VIS, "Environment", "no_fog", "Remove All Fog (Clear View)", false)

-- =========================================================================
-- TAB 3: WORLD & LOOT
-- =========================================================================
menu.add_group(TAB_WORLD, "Loot Containers ESP")
menu.add_checkbox(TAB_WORLD, "Loot Containers ESP", "loot_esp_enabled", "Enable Loot Containers ESP", false)

-- Collapsible Section 1: World Loot
menu.add_checkbox(TAB_WORLD, "Loot Containers ESP", "loot_show_world_cat", "[+] World Loot Crates & Barrels", true, { parent = "loot_esp_enabled" })
menu.add_checkbox(TAB_WORLD, "Loot Containers ESP", "loot_show_barrels", "Loot Barrels", true, { parent = "loot_show_world_cat", colorpicker = { 0.25, 0.75, 1.00, 1.0 } })
menu.add_checkbox(TAB_WORLD, "Loot Containers ESP", "loot_show_crates", "Standard Crates", true, { parent = "loot_show_world_cat", colorpicker = { 0.95, 0.70, 0.25, 1.0 } })
menu.add_checkbox(TAB_WORLD, "Loot Containers ESP", "loot_show_military", "Military Crates", true, { parent = "loot_show_world_cat", colorpicker = { 0.20, 1.00, 0.40, 1.0 } })
menu.add_checkbox(TAB_WORLD, "Loot Containers ESP", "loot_show_elite", "Elite Crates", true, { parent = "loot_show_world_cat", colorpicker = { 0.95, 0.25, 0.45, 1.0 } })

-- Collapsible Section 2: Base Containers
menu.add_checkbox(TAB_WORLD, "Loot Containers ESP", "loot_show_base_cat", "[+] Base Storage & Deployables", true, { parent = "loot_esp_enabled" })
menu.add_checkbox(TAB_WORLD, "Loot Containers ESP", "loot_show_large_box", "Large Wooden Box", true, { parent = "loot_show_base_cat", colorpicker = { 0.95, 0.65, 0.20, 1.0 } })
menu.add_checkbox(TAB_WORLD, "Loot Containers ESP", "loot_show_small_box", "Small Wooden Box", true, { parent = "loot_show_base_cat", colorpicker = { 0.85, 0.50, 0.15, 1.0 } })
menu.add_checkbox(TAB_WORLD, "Loot Containers ESP", "loot_show_tc", "Tool Cupboard (TC)", true, { parent = "loot_show_base_cat", colorpicker = { 0.20, 0.85, 1.00, 1.0 } })
menu.add_checkbox(TAB_WORLD, "Loot Containers ESP", "loot_show_locker", "Locker", true, { parent = "loot_show_base_cat", colorpicker = { 0.70, 0.75, 0.90, 1.0 } })
menu.add_checkbox(TAB_WORLD, "Loot Containers ESP", "loot_show_furnace", "Furnace", true, { parent = "loot_show_base_cat", colorpicker = { 1.00, 0.42, 0.15, 1.0 } })
menu.add_checkbox(TAB_WORLD, "Loot Containers ESP", "loot_show_workbench", "Workbench", true, { parent = "loot_show_base_cat", colorpicker = { 0.60, 0.85, 0.40, 1.0 } })
menu.add_checkbox(TAB_WORLD, "Loot Containers ESP", "loot_show_shelves", "Shelves", true, { parent = "loot_show_base_cat", colorpicker = { 0.80, 0.60, 0.35, 1.0 } })
menu.add_checkbox(TAB_WORLD, "Loot Containers ESP", "loot_show_sleeping_bag", "Sleeping Bag", true, { parent = "loot_show_base_cat", colorpicker = { 0.45, 0.90, 0.65, 1.0 } })

-- Loot Settings
menu.add_checkbox(TAB_WORLD, "Loot Containers ESP", "loot_show_dist", "Show Distance", true, { parent = "loot_esp_enabled" })
menu.add_checkbox(TAB_WORLD, "Loot Containers ESP", "loot_tracers", "Tracers / Snaplines", false, { parent = "loot_esp_enabled" })
menu.add_slider_int(TAB_WORLD, "Loot Containers ESP", "loot_max_dist", "Max Range (m)", 20, 1000, 350, { parent = "loot_esp_enabled" })
menu.add_slider_int(TAB_WORLD, "Loot Containers ESP", "loot_font_size", "Text Size", 10, 20, 12, { parent = "loot_esp_enabled" })

-- Body Bags & Dropped Items Group
menu.add_group(TAB_WORLD, "Body Bags & Dropped")
menu.add_checkbox(TAB_WORLD, "Body Bags & Dropped", "bodybag_enabled", "Enable Body Bags ESP", false, { colorpicker = { 0.90, 0.25, 0.35, 1.0 } })
menu.add_checkbox(TAB_WORLD, "Body Bags & Dropped", "bodybag_show_dist", "Body Bag Distance", false, { parent = "bodybag_enabled" })
menu.add_checkbox(TAB_WORLD, "Body Bags & Dropped", "bodybag_tracers", "Body Bag Snaplines", false, { parent = "bodybag_enabled" })
menu.add_slider_int(TAB_WORLD, "Body Bags & Dropped", "bodybag_max_dist", "Body Bag Range (m)", 20, 1000, 500, { parent = "bodybag_enabled" })
menu.add_slider_int(TAB_WORLD, "Body Bags & Dropped", "bodybag_font_size", "Body Bag Text Size", 10, 20, 13, { parent = "bodybag_enabled" })

menu.add_checkbox(TAB_WORLD, "Body Bags & Dropped", "dropped_esp_enabled", "Enable Dropped Items ESP", false)
menu.add_checkbox(TAB_WORLD, "Body Bags & Dropped", "dropped_color", "Dropped Color Picker", false, { parent = "dropped_esp_enabled", colorpicker = { 1.0, 0.4, 0.9, 1.0 } })
menu.add_checkbox(TAB_WORLD, "Body Bags & Dropped", "dropped_tracers", "Dropped Item Snaplines", false, { parent = "dropped_esp_enabled" })
menu.add_checkbox(TAB_WORLD, "Body Bags & Dropped", "dropped_show_dist", "Show Distance", false, { parent = "dropped_esp_enabled" })
menu.add_slider_int(TAB_WORLD, "Body Bags & Dropped", "dropped_max_dist", "Max Range (m)", 10, 500, 150, { parent = "dropped_esp_enabled" })
menu.add_slider_int(TAB_WORLD, "Body Bags & Dropped", "dropped_font_size", "Text Size", 10, 20, 12, { parent = "dropped_esp_enabled" })

-- Ore Nodes & Pickups Group
menu.add_group(TAB_WORLD, "Ore Nodes & Pickups")
menu.add_checkbox(TAB_WORLD, "Ore Nodes & Pickups", "nodes_esp_enabled", "Enable Ore Nodes ESP", false)
menu.add_checkbox(TAB_WORLD, "Ore Nodes & Pickups", "stone_node", "Stone Nodes", false, { parent = "nodes_esp_enabled", colorpicker = { 0.85, 0.85, 0.90, 1.0 } })
menu.add_checkbox(TAB_WORLD, "Ore Nodes & Pickups", "sulfur_node", "Sulfur Nodes", false, { parent = "nodes_esp_enabled", colorpicker = { 0.95, 0.85, 0.20, 1.0 } })
menu.add_checkbox(TAB_WORLD, "Ore Nodes & Pickups", "iron_node", "Metal / Iron Nodes", false, { parent = "nodes_esp_enabled", colorpicker = { 0.45, 0.75, 1.00, 1.0 } })
menu.add_checkbox(TAB_WORLD, "Ore Nodes & Pickups", "nodes_show_dist", "Show Distance", false, { parent = "nodes_esp_enabled" })
menu.add_checkbox(TAB_WORLD, "Ore Nodes & Pickups", "nodes_tracers", "Tracers / Snaplines", false, { parent = "nodes_esp_enabled" })
menu.add_slider_int(TAB_WORLD, "Ore Nodes & Pickups", "nodes_max_dist", "Max Range (m)", 20, 1200, 450, { parent = "nodes_esp_enabled" })
menu.add_slider_int(TAB_WORLD, "Ore Nodes & Pickups", "nodes_font_size", "Text Size", 10, 20, 13, { parent = "nodes_esp_enabled" })

menu.add_checkbox(TAB_WORLD, "Ore Nodes & Pickups", "pickups_esp_enabled", "Enable Ground Pickups ESP", false)
menu.add_checkbox(TAB_WORLD, "Ore Nodes & Pickups", "pickups_ores", "Loose Ores (Stone/Sulfur/Metal)", false, { parent = "pickups_esp_enabled", colorpicker = { 1.0, 0.80, 0.35, 1.0 } })
menu.add_checkbox(TAB_WORLD, "Ore Nodes & Pickups", "pickups_plants", "Plants (Hemp / Corn / Pumpkin)", false, { parent = "pickups_esp_enabled", colorpicker = { 0.35, 0.95, 0.45, 1.0 } })
menu.add_checkbox(TAB_WORLD, "Ore Nodes & Pickups", "pickups_wood", "Loose Wood Logs", false, { parent = "pickups_esp_enabled", colorpicker = { 0.75, 0.55, 0.35, 1.0 } })
menu.add_checkbox(TAB_WORLD, "Ore Nodes & Pickups", "pickups_show_dist", "Show Distance", false, { parent = "pickups_esp_enabled" })
menu.add_slider_int(TAB_WORLD, "Ore Nodes & Pickups", "pickups_max_dist", "Max Range (m)", 10, 600, 200, { parent = "pickups_esp_enabled" })
menu.add_slider_int(TAB_WORLD, "Ore Nodes & Pickups", "pickups_font_size", "Text Size", 10, 20, 12, { parent = "pickups_esp_enabled" })

-- =========================================================================
-- TAB 4: INVENTORY INSPECTION
-- =========================================================================
menu.add_group(TAB_INV, "Player Inventory Viewer")
menu.add_checkbox(TAB_INV, "Player Inventory Viewer", "inv_enabled", "Enable Player Inventory Viewer", false)
menu.add_combo(TAB_INV, "Player Inventory Viewer", "inv_mode", "View Mode", { "Target Player (Near Crosshair)", "Local Player (Full)", "Both" }, 0, { parent = "inv_enabled" })
menu.add_checkbox(TAB_INV, "Player Inventory Viewer", "inv_show_weapons", "Equipped & Holstered Weapons", true, { parent = "inv_enabled" })
menu.add_checkbox(TAB_INV, "Player Inventory Viewer", "inv_show_wear", "Worn Armor & Classification", true, { parent = "inv_enabled" })
menu.add_checkbox(TAB_INV, "Player Inventory Viewer", "inv_show_pack", "Backpack Container Contents", true, { parent = "inv_enabled" })
menu.add_checkbox(TAB_INV, "Player Inventory Viewer", "inv_show_grid", "Full Inventory Grid (Slots 7-36)", true, { parent = "inv_enabled" })
menu.add_slider_int(TAB_INV, "Player Inventory Viewer", "inv_panel_x", "Panel Pos X", 10, 1920, 35, { parent = "inv_enabled" })
menu.add_slider_int(TAB_INV, "Player Inventory Viewer", "inv_panel_y", "Panel Pos Y", 10, 1080, 180, { parent = "inv_enabled" })
menu.add_slider_int(TAB_INV, "Player Inventory Viewer", "inv_panel_w", "Panel Width", 220, 520, 320, { parent = "inv_enabled" })

menu.add_group(TAB_INV, "Body Bag & Container Viewer")
menu.add_checkbox(TAB_INV, "Body Bag & Container Viewer", "bodybag_viewer_enabled", "Enable Container & Body Bag Viewer", false)
menu.add_combo(TAB_INV, "Body Bag & Container Viewer", "bodybag_viewer_mode", "Viewer Trigger", { "Near Crosshair", "Always Closest" }, 0, { parent = "bodybag_viewer_enabled" })
menu.add_slider_int(TAB_INV, "Body Bag & Container Viewer", "bodybag_panel_x", "Viewer Pos X", 10, 1920, 380, { parent = "bodybag_viewer_enabled" })
menu.add_slider_int(TAB_INV, "Body Bag & Container Viewer", "bodybag_panel_y", "Viewer Pos Y", 10, 1080, 180, { parent = "bodybag_viewer_enabled" })
menu.add_slider_int(TAB_INV, "Body Bag & Container Viewer", "bodybag_panel_w", "Viewer Width", 220, 520, 300, { parent = "bodybag_viewer_enabled" })

-- =========================================================================
-- TAB 5: SETTINGS & MISC
-- =========================================================================
menu.add_group(TAB_CFG, "Configuration")
menu.add_button(TAB_CFG, "Configuration", "hh_save_cfg", "Save Configuration", function()
    on_save_config_clicked()
end)
menu.add_button(TAB_CFG, "Configuration", "hh_load_cfg", "Load Configuration", function()
    on_load_config_clicked(true)
end)
menu.add_checkbox(TAB_CFG, "Configuration", "hh_autoload_cfg", "Auto-Load Config On Launch", true)

menu.add_group(TAB_CFG, "HUD & Automation")
menu.add_checkbox(TAB_CFG, "HUD & Automation", "watermark_enabled", "Show Watermark and FPS", true)
menu.add_checkbox(TAB_CFG, "HUD & Automation", "anti_afk", "Anti-AFK (Prevent Inactivity Kick)", true)
menu.add_checkbox(TAB_CFG, "HUD & Automation", "notifications_enabled", "Feature Toggle On-Screen Toasts", true)
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
    { id = "aim_auto_bow", type = "bool" },
    { id = "aim_target_npcs", type = "bool" },
    { id = "aim_vis_check", type = "bool" },
    { id = "aim_team_check", type = "bool" },
    { id = "aim_target_highlight", type = "bool", color = true },
    { id = "aim_prediction", type = "bool" },
    { id = "aim_drop_comp", type = "bool" },
    { id = "aim_proj_speed", type = "int" },
    { id = "aim_bone", type = "int" },
    { id = "aim_fov", type = "int" },
    { id = "aim_smooth", type = "int" },

    -- Gun Mods
    { id = "gun_recoil_enabled", type = "bool" },
    { id = "gun_recoil_pct",     type = "int" },
    { id = "gun_rapid_fire",     type = "bool" },
    { id = "gun_rapid_delay",    type = "int" },
    { id = "gun_triggerbot",     type = "bool" },
    { id = "gun_trigger_delay",  type = "int" },
    { id = "gun_trigger_npcs",   type = "bool" },

    -- Camera & Zoom
    { id = "zoom_enabled", type = "bool", key = true },
    { id = "zoom_fov", type = "int" },
    { id = "zoom_smooth", type = "int" },

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
    { id = "npc_skeleton", type = "bool", color = true },
    { id = "npc_aimbot", type = "bool" },
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
    { id = "player_tracers", type = "bool", color = true },
    { id = "offscreen_players", type = "bool" },
    { id = "player_max_dist", type = "int" },
    { id = "player_font_size", type = "int" },

    -- Environment
    { id = "no_fog", type = "bool" },

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
    { id = "dropped_tracers", type = "bool" },
    { id = "dropped_show_dist", type = "bool" },
    { id = "dropped_max_dist", type = "int" },
    { id = "dropped_font_size", type = "int" },

    -- Body Bags ESP
    { id = "bodybag_enabled", type = "bool", color = true },
    { id = "bodybag_show_dist", type = "bool" },
    { id = "bodybag_tracers", type = "bool" },
    { id = "bodybag_max_dist", type = "int" },
    { id = "bodybag_font_size", type = "int" },

    -- Body Bag Viewer
    { id = "bodybag_viewer_enabled", type = "bool" },
    { id = "bodybag_viewer_mode",    type = "int" },
    { id = "bodybag_panel_x",        type = "int" },
    { id = "bodybag_panel_y",        type = "int" },
    { id = "bodybag_panel_w",        type = "int" },

    -- Loot Containers ESP
    { id = "loot_esp_enabled",       type = "bool" },
    { id = "loot_show_world_cat",    type = "bool" },
    { id = "loot_show_barrels",      type = "bool", color = true },
    { id = "loot_show_crates",       type = "bool", color = true },
    { id = "loot_show_military",     type = "bool", color = true },
    { id = "loot_show_elite",        type = "bool", color = true },
    { id = "loot_show_base_cat",     type = "bool" },
    { id = "loot_show_large_box",    type = "bool", color = true },
    { id = "loot_show_small_box",    type = "bool", color = true },
    { id = "loot_show_tc",           type = "bool", color = true },
    { id = "loot_show_locker",       type = "bool", color = true },
    { id = "loot_show_furnace",      type = "bool", color = true },
    { id = "loot_show_workbench",    type = "bool", color = true },
    { id = "loot_show_shelves",      type = "bool", color = true },
    { id = "loot_show_sleeping_bag", type = "bool", color = true },
    { id = "loot_show_dist",         type = "bool" },
    { id = "loot_tracers",           type = "bool" },
    { id = "loot_max_dist",          type = "int" },
    { id = "loot_font_size",         type = "int" },

    -- Settings & Misc
    { id = "watermark_enabled",      type = "bool" },
    { id = "anti_afk",               type = "bool" },
    { id = "notifications_enabled",  type = "bool" },
    { id = "offscreen_npcs",         type = "bool" }
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
    { pattern = "lrsniper",      aliases = { "lr300", "lr" },             name = "LR Sniper",        speed = 950, drop = 0.60 },
    { pattern = "boltaction",    aliases = { "boltrifle", "l96" },        name = "Bolt Action",      speed = 750, drop = 0.70 },
    { pattern = "assaultrifle",  aliases = { "ak47", "ak" },              name = "Assault Rifle",    speed = 480, drop = 0.85 },
    { pattern = "scarrifle",     aliases = { "scar" },                    name = "Scar Rifle",       speed = 500, drop = 0.85 },
    { pattern = "m249",          aliases = { "saw" },                     name = "M249 SAW",         speed = 520, drop = 0.80 },
    { pattern = "levercarbine",  aliases = { "carbine", "lever" },        name = "Lever Carbine",    speed = 460, drop = 0.90 },
    { pattern = "semiautorifle", aliases = { "sar" },                     name = "Semi Rifle (SAR)", speed = 440, drop = 0.90 },
    { pattern = "tacticalsmg",   aliases = { "tacsmg" },                  name = "Tactical SMG",     speed = 350, drop = 1.05 },
    { pattern = "drumsmg",       aliases = { "tommy", "thompson" },       name = "Drum SMG",         speed = 330, drop = 1.10 },
    { pattern = "customsmg",     aliases = { "smg", "mp5" },              name = "Custom SMG",       speed = 340, drop = 1.05 },
    { pattern = "servicepistol", aliases = { "glock", "m9" },             name = "Service Pistol",   speed = 320, drop = 1.10 },
    { pattern = "semiautopistol",aliases = { "sap" },                     name = "Semi Pistol (SAP)",speed = 320, drop = 1.10 },
    { pattern = "revolver",      aliases = { "python", "magnum" },        name = "Revolver",         speed = 300, drop = 1.15 },
    { pattern = "compoundbow",   aliases = { "compound" },                name = "Compound Bow",     speed = 260, drop = 1.15 },
    { pattern = "crossbow",      aliases = { "xbow" },                    name = "Crossbow",         speed = 210, drop = 1.25 },
    { pattern = "huntingbow",    aliases = { "bow", "arrow" },            name = "Hunting Bow",      speed = 175, drop = 1.35 },
    { pattern = "pumpshotgun",   aliases = { "pump", "spas" },            name = "Pump Shotgun",     speed = 280, drop = 1.20 },
    { pattern = "doublebarrel",  aliases = { "db" },                      name = "Double Barrel",    speed = 270, drop = 1.25 },
    { pattern = "pipeshotgun",   aliases = { "waterpipe", "pipe" },       name = "Waterpipe Shotgun",speed = 240, drop = 1.30 },
}

local function match_gun_profile(tool_name)
    if not tool_name or tool_name == "" then return nil end
    local clean = tool_name:lower():gsub("[_%s%-]", "")
    for i = 1, #GUN_PROFILES do
        local p = GUN_PROFILES[i]
        if clean:find(p.pattern) then
            return p
        end
        if p.aliases then
            for a = 1, #p.aliases do
                if clean:find(p.aliases[a]) then
                    return p
                end
            end
        end
    end
    return nil
end

local function get_roblox_service(name)
    local s = nil
    pcall(function()
        if game.GetService then
            s = game:GetService(name)
        elseif game.get_service then
            s = game.get_service(name)
        elseif game.FindService then
            s = game:FindService(name)
        end
    end)
    if not s then
        pcall(function()
            s = game[name]
        end)
    end
    return s
end

local function detect_local_held_weapon()
    local ws = game.workspace or game.Workspace

    -- 1. Check Active Hotbar Slot in PlayerGui.FustInventory.Root.Hotbar
    local rep_players = get_roblox_service("Players")
    local lp_obj = nil
    local lp = entity.get_local_player()
    if rep_players then
        if lp and lp.name then lp_obj = rep_players:find_first_child(lp.name) end
        if not lp_obj and rep_players.LocalPlayer then lp_obj = rep_players.LocalPlayer end
    end

    if lp_obj then
        local pg = lp_obj:find_first_child("PlayerGui")
        if pg then
            local fust_inv = pg:find_first_child("FustInventory")
            local root = fust_inv and fust_inv:find_first_child("Root")
            local hotbar = root and root:find_first_child("Hotbar")
            if hotbar then
                for slot_num = 1, 6 do
                    local slot_btn = hotbar:find_first_child("Slot" .. tostring(slot_num))
                    if slot_btn then
                        local sel = slot_btn:find_first_child("Sel")
                        local is_sel = false
                        if sel then
                            if sel.Visible == true then is_sel = true
                            elseif sel.BackgroundTransparency and sel.BackgroundTransparency < 0.5 then is_sel = true end
                        end

                        if is_sel then
                            local view = slot_btn:find_first_child("View")
                            if view then
                                local ok, ch = pcall(function() return view:get_children() end)
                                if ok and ch then
                                    for _, c in ipairs(ch) do
                                        if c.Name ~= "Camera" and c.Name ~= "" then
                                            return c.Name
                                        end
                                    end
                                end
                            end

                            local res = slot_btn:find_first_child("Res")
                            local tl = res and res:find_first_child("TextLabel")
                            if tl and tl.Text and tl.Text ~= "" then
                                return tl.Text
                            end
                        end
                    end
                end
            end
        end
    end

    -- 2. Check Local Character for equipped Tool or Model
    local lp_char = lp and lp.character
    if not lp_char and ws and lp and lp.name then
        lp_char = ws:find_first_child(lp.name)
    end

    if lp_char then
        local ch = lp_char:get_children()
        if ch then
            for k = 1, #ch do
                local c = ch[k]
                if c.ClassName == "Tool" and c.Name ~= "" then
                    return c.Name
                end
            end

            for k = 1, #ch do
                local c = ch[k]
                if c.ClassName == "Model" and c.Name ~= "" then
                    if match_gun_profile(c.Name) then
                        return c.Name
                    end
                end
            end
        end

        local rh = lp_char:find_first_child("RightHand") or lp_char:find_first_child("Right Arm")
        if rh then
            local rch = rh:get_children()
            if rch then
                for k = 1, #rch do
                    if match_gun_profile(rch[k].Name) then
                        return rch[k].Name
                    end
                end
            end
        end
    end

    -- 3. Check CurrentCamera Viewmodel
    local cam = ws and ws.CurrentCamera
    if cam then
        local cam_ch = cam:get_children()
        if cam_ch then
            for k = 1, #cam_ch do
                if match_gun_profile(cam_ch[k].Name) then
                    return cam_ch[k].Name
                end
            end
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
local cached_bodybags = {}
local cached_animals = {}
local cached_npcs    = {}
local cached_loot    = {}
local cached_bodybag_inventory = nil
local inv_bb_panel = {
    x = 380,
    y = 180,
    w = 300,
    dragging = false,
    drag_ox = 0,
    drag_oy = 0
}
local cached_sw, cached_sh = 1920, 1080
local frame_dt     = 0
local frame_last_t = os.clock()
local notifications = {}
local local_team_cache = nil
local local_team_timer = 0
local _prev_toggles = {}

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
    aim_auto_bow = true,
    aim_target_npcs = false,
    aim_speed = 350,
    aim_bone_idx = 0,
    aim_fov = 140,
    aim_smooth = 4,
    aim_vis_check = false,
    aim_team_check = false,
    aim_highlight = false,
    aim_hl_col = { 1.0, 0.30, 0.30, 1.0 },

    gun_recoil = false,
    gun_recoil_pct = 80,
    gun_rapid = false,
    gun_rapid_delay = 120,
    gun_trigger = false,
    gun_trigger_delay = 25,
    gun_trigger_npcs = true,

    zoom_enabled = false,
    zoom_key = 0,
    zoom_fov = 30,
    zoom_smooth = 6,

    no_fog = false,

    inv_enabled = false,
    inv_mode = 0,
    inv_show_weapons = true,
    inv_show_wear = true,
    inv_show_pack = true,
    inv_show_grid = true,
    inv_panel_x = 35,
    inv_panel_y = 180,
    inv_panel_w = 320,

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
    npc_skel = false,
    npc_skel_col = { 1.00, 0.35, 0.35, 1.0 },
    npc_aimbot = false,
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
    p_tracers = false,
    p_tracers_col = { 1.0, 1.0, 1.0, 0.35 },
    p_sleepers = false,
    p_sleep_col = { 0.65, 0.70, 0.85, 0.85 },
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
    d_tracers = false,
    d_dist = false,
    d_max_sq = 22500,
    d_font = 12,

    bb_enabled = false,
    bb_col = { 0.90, 0.25, 0.35, 1.0 },
    bb_dist = false,
    bb_tracers = false,
    bb_max_sq = 3188775,
    bb_font = 13,

    bb_viewer_enabled = false,
    bb_viewer_mode    = 0,

    loot_enabled           = false,
    loot_show_world_cat    = true,
    loot_show_barrels      = true,
    loot_col_barrels       = { 0.25, 0.75, 1.0, 1.0 },
    loot_show_crates       = true,
    loot_col_crates        = { 0.95, 0.70, 0.25, 1.0 },
    loot_show_military     = true,
    loot_col_military      = { 0.20, 1.00, 0.40, 1.0 },
    loot_show_elite        = true,
    loot_col_elite         = { 0.95, 0.25, 0.45, 1.0 },
    loot_show_base_cat     = true,
    loot_show_large_box    = true,
    loot_col_large_box     = { 0.95, 0.65, 0.20, 1.0 },
    loot_show_small_box    = true,
    loot_col_small_box     = { 0.85, 0.50, 0.15, 1.0 },
    loot_show_tc           = true,
    loot_col_tc            = { 0.20, 0.85, 1.00, 1.0 },
    loot_show_locker       = true,
    loot_col_locker        = { 0.70, 0.75, 0.90, 1.0 },
    loot_show_furnace      = true,
    loot_col_furnace       = { 1.00, 0.42, 0.15, 1.0 },
    loot_show_workbench    = true,
    loot_col_workbench     = { 0.60, 0.85, 0.40, 1.0 },
    loot_show_shelves      = true,
    loot_col_shelves       = { 0.80, 0.60, 0.35, 1.0 },
    loot_show_sleeping_bag = true,
    loot_col_sleeping_bag  = { 0.45, 0.90, 0.65, 1.0 },
    loot_dist              = true,
    loot_tracers           = false,
    loot_max_sq            = 1562500,
    loot_font              = 12,

    watermark              = true,
    anti_afk               = true,
    notifs                 = true,
    os_players             = false,
    os_npcs                = false
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
        "HumanoidRootPart", "UpperTorso", "Torso", "Head", "Body", "Canvas", "Strap", "WoodDark", "Rim",
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
-- =========================================================================
-- TOAST NOTIFICATIONS, TEAM CACHE, VISIBILITY & HUD HELPERS
-- =========================================================================
local TRACK_TOGGLES = {
    { key = "aim_enabled",         label = "Aimbot",          on = {0.40,1.00,0.40,1}, off = {1,0.40,0.40,1} },
    { key = "gun_recoil",          label = "Recoil Control",  on = {0.40,1.00,0.40,1}, off = {1,0.40,0.40,1} },
    { key = "gun_rapid",           label = "Rapid Fire",      on = {0.40,1.00,0.40,1}, off = {1,0.40,0.40,1} },
    { key = "gun_trigger",         label = "Triggerbot",      on = {0.40,1.00,0.40,1}, off = {1,0.40,0.40,1} },
    { key = "zoom_enabled",        label = "Zoom/Scope",      on = {0.40,0.80,1.00,1}, off = {0.7,0.7,0.7,1} },
    { key = "player_esp_enabled",  label = "Player ESP",      on = {0.40,1.00,0.40,1}, off = {1,0.40,0.40,1} },
    { key = "animals_esp_enabled", label = "Animals ESP",     on = {0.40,1.00,0.40,1}, off = {1,0.40,0.40,1} },
    { key = "npcs_esp_enabled",    label = "NPCs ESP",        on = {0.40,1.00,0.40,1}, off = {1,0.40,0.40,1} },
    { key = "nodes_esp_enabled",   label = "Ore Nodes ESP",   on = {0.40,1.00,0.40,1}, off = {1,0.40,0.40,1} },
    { key = "loot_esp_enabled",    label = "Loot ESP",        on = {0.40,0.80,1.00,1}, off = {0.7,0.7,0.7,1} },
    { key = "inv_enabled",         label = "Inv Viewer",      on = {0.40,0.80,1.00,1}, off = {0.7,0.7,0.7,1} },
    { key = "no_fog",              label = "Remove Fog",      on = {0.40,1.00,0.40,1}, off = {0.7,0.7,0.7,1} },
}

local function push_notification(text, col, duration)
    notifications[#notifications + 1] = {
        text   = text,
        col    = col or { 1, 1, 1, 1 },
        expire = os.clock() + (duration or 2.5),
        born   = os.clock()
    }
    if #notifications > 8 then table.remove(notifications, 1) end
end

local function render_notifications()
    if not cfg.notifs then return end
    local now  = os.clock()
    local ox   = cached_sw - 16
    local oy   = 52
    local i    = 1

    while i <= #notifications do
        local n = notifications[i]
        if now > n.expire then
            table.remove(notifications, i)
        else
            local remaining = n.expire - now
            local alpha = math.min(1, remaining / 0.4)
            alpha = math.min(alpha, math.min(1, (now - n.born) / 0.15))
            local tw = draw.get_text_size(n.text, 13)
            local bx = ox - tw - 10
            draw.rect_filled(bx - 4, oy - 2, tw + 14, 18, { 0.06, 0.06, 0.10, alpha * 0.88 }, 3)
            draw.text(bx, oy, n.text, { n.col[1], n.col[2], n.col[3], alpha }, 13)
            oy = oy + 22
            i  = i + 1
        end
    end
end

local function refresh_local_team()
    local now = os.clock()
    if now - local_team_timer < 1.0 then return end
    local_team_timer = now

    pcall(function()
        local ws  = game.workspace or game.Workspace
        local cam = ws and ws.CurrentCamera
        local tags = cam and cam:find_first_child("FustTeamTags")
        if tags then
            local children = tags:get_children()
            if children and #children > 0 then
                local_team_cache = {}
                for i = 1, #children do
                    local_team_cache[children[i].Name:lower()] = true
                end
                return
            end
        end

        local lp = nil
        if game.Players and game.Players.LocalPlayer then
            lp = game.Players.LocalPlayer
        end
        if lp and lp.Team then
            local_team_cache = { [tostring(lp.Team):lower()] = true }
        else
            local_team_cache = nil
        end
    end)
end

local function is_same_team(target_player)
    if not cfg.aim_team_check or not local_team_cache then return false end
    if not target_player then return false end
    local name = (target_player.name or ""):lower()
    if local_team_cache[name] then return true end
    if target_player.char then
        local t = target_player.char:find_first_child("Team")
        if t and local_team_cache[tostring(t.Value):lower()] then return true end
    end
    return false
end

local function is_target_visible(tx, ty, tz)
    if not cfg.aim_vis_check then return true end
    local visible = true
    pcall(function()
        local ws = game.workspace or game.Workspace
        if not ws then return end

        local dx = tx - cam_x
        local dy = ty - cam_y
        local dz = tz - cam_z
        local dist = math.sqrt(dx*dx + dy*dy + dz*dz)
        if dist < 1 then return end

        if ws.Raycast then
            local origin = Vector3.new(cam_x, cam_y, cam_z)
            local dir    = Vector3.new(dx, dy, dz)
            local params = RaycastParams.new()
            params.FilterType = Enum.RaycastFilterType.Exclude

            local ignore = {}
            local lp_char = nil
            if game.Players and game.Players.LocalPlayer then
                lp_char = game.Players.LocalPlayer.Character
            end
            if lp_char then ignore[#ignore + 1] = lp_char end
            local cam = ws.CurrentCamera
            if cam then ignore[#ignore + 1] = cam end
            params.FilterDescendantsInstances = ignore

            local hit = ws:Raycast(origin, dir, params)
            if hit and hit.Instance then
                local hpos = hit.Position
                local hdx = hpos.X - cam_x
                local hdy = hpos.Y - cam_y
                local hdz = hpos.Z - cam_z
                local hit_dist = math.sqrt(hdx*hdx + hdy*hdy + hdz*hdz)
                if hit_dist < dist - 2.5 then
                    visible = false
                end
            end
        end
    end)
    return visible
end

local function render_aim_target_highlight()
    if not (cfg.aim_enabled or cfg.npc_aimbot) or not cfg.aim_highlight or not aim_target_player then return end
    pcall(function()
        local pos = nil
        if aim_target_player.head and aim_target_player.head.Position then
            pos = aim_target_player.head.Position
        elseif aim_target_player.root and aim_target_player.root.Position then
            pos = aim_target_player.root.Position
        elseif aim_target_player.x and aim_target_player.y and aim_target_player.z then
            pos = { x = aim_target_player.x, y = aim_target_player.y, z = aim_target_player.z }
        end
        if not pos then return end

        local px = pos.x or pos.X
        local py = pos.y or pos.Y
        local pz = pos.z or pos.Z
        local sx, sy, vis = utility.world_to_screen(px, py, pz)
        if not vis then return end

        local t = os.clock() * 5.0
        local pulse_r = 14 + math.sin(t) * 4
        local alpha = 0.70 + math.sin(t) * 0.25
        local col = { cfg.aim_hl_col[1], cfg.aim_hl_col[2], cfg.aim_hl_col[3], alpha }

        draw.circle(sx, sy, pulse_r, col, 32)
        draw.line(sx - pulse_r - 4, sy, sx - pulse_r + 2, sy, col, 1.5)
        draw.line(sx + pulse_r - 2, sy, sx + pulse_r + 4, sy, col, 1.5)
        draw.line(sx, sy - pulse_r - 4, sx, sy - pulse_r + 2, col, 1.5)
        draw.line(sx, sy + pulse_r - 2, sx, sy + pulse_r + 4, col, 1.5)
    end)
end

local function render_watermark()
    if not cfg.watermark then return end
    local fps = frame_dt > 0 and math.floor(1.0 / frame_dt + 0.5) or 60
    local text = string.format("HAMSTER HUB | DUST | FPS: %d", fps)
    local tw = draw.get_text_size(text, 12)
    local bx = 16
    local by = 16
    draw.rect_filled(bx - 6, by - 4, tw + 20, 22, { 0.05, 0.06, 0.09, 0.88 }, 4)
    draw.rect(bx - 6, by - 4, tw + 20, 22, { 0.40, 0.75, 1.00, 0.60 }, 1, 4)
    draw.text(bx + 4, by, text, { 0.90, 0.94, 0.98, 1.0 }, 12)
end

local function render_offscreen_arrow(wx, wy, wz, col)
    local sx, sy, vis = utility.world_to_screen(wx, wy, wz)
    if vis then return end

    local cx = cached_sw * 0.5
    local cy = cached_sh * 0.5
    local dx = (sx or cx) - cx
    local dy = (sy or cy) - cy
    local len = math.sqrt(dx*dx + dy*dy)
    if len < 0.001 then return end

    local adx = dx / len
    local ady = dy / len

    local mg = 36
    local sx_e = (adx > 0) and ((cached_sw - mg - cx) / adx) or ((mg - cx) / adx)
    local sy_e = (ady > 0) and ((cached_sh - mg - cy) / ady) or ((mg - cy) / ady)
    local scale = math.min(sx_e, sy_e)
    local ax = clamp(cx + adx * scale, mg, cached_sw - mg)
    local ay = clamp(cy + ady * scale, mg, cached_sh - mg)

    local sz    = 8
    local tip_x = ax + adx * sz
    local tip_y = ay + ady * sz
    local px    = -ady
    local py    =  adx
    local lx    = ax - adx*sz + px*sz*0.55
    local ly    = ay - ady*sz + py*sz*0.55
    local rx2   = ax - adx*sz - px*sz*0.55
    local ry2   = ay - ady*sz - py*sz*0.55

    local ac = { col[1], col[2], col[3], 0.80 }
    draw.line(tip_x, tip_y, lx,   ly,   ac, 2)
    draw.line(tip_x, tip_y, rx2,  ry2,  ac, 2)
    draw.line(lx,    ly,    rx2,  ry2,  ac, 1)
end

local function render_all_offscreen_arrows()
    if cfg.p_enabled and cfg.os_players then
        for i = 1, #cached_players do
            local p = cached_players[i]
            if p.root then
                local rx, ry, rz = safe_pos(p.root)
                if rx then
                    local dx = rx-cam_x; local dy = ry-cam_y; local dz = rz-cam_z
                    if dx*dx+dy*dy+dz*dz <= cfg.p_max_sq then
                        render_offscreen_arrow(rx, ry, rz, cfg.p_box_col)
                    end
                end
            end
        end
    end
    if cfg.npc_enabled and cfg.os_npcs then
        for i = 1, #cached_npcs do
            local n = cached_npcs[i]
            local dx = n.x-cam_x; local dy = n.y-cam_y; local dz = n.z-cam_z
            if dx*dx+dy*dy+dz*dz <= cfg.npc_max_sq then
                render_offscreen_arrow(n.x, n.y, n.z, n.color)
            end
        end
    end
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

    if not cfg.p_enabled and not cfg.aim_enabled and not cfg.inv_enabled and not cfg.gun_trigger then
        cached_players = {}
        return
    end

    local players = entity.get_players()
    if not players or #players == 0 then
        cached_players = {}
        return
    end

    local lp_name = lp and lp.name or nil

    local out = {}
    for i = 1, #players do
        local p = players[i]
        local is_me = false
        if p.is_local == true then is_me = true end
        if lp_name and p.name == lp_name then is_me = true end

        if not is_me and (p.is_valid == nil or p.is_valid) and (p.is_alive == nil or p.is_alive) then
            local pname = p.name or "Player"
            local char = p.character
            if not char and ws then
                char = ws:find_first_child(pname)
            end

            if char then
                local hum = char:find_first_child_of_class("Humanoid") or char:find_first_child("Humanoid")
                local root = char:find_first_child("HumanoidRootPart") or char:find_first_child("UpperTorso") or char:find_first_child("Torso") or get_model_position_part(char)
                local head = char:find_first_child("Head") or root

                local hp = tonumber(p.health) or 100
                local max_hp = tonumber(p.max_health) or 100
                if hum and hum.Health then
                    hp = tonumber(hum.Health) or hp
                    if hum.MaxHealth and hum.MaxHealth > 0 then
                        max_hp = tonumber(hum.MaxHealth) or max_hp
                    end
                end
                hp = clamp(hp, 0, max_hp)

                if hp > 0 and root then
                    local entry = {
                        name = pname,
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
                        if not entry.held then
                            local holster = char:find_first_child("FustHolster")
                            if holster then
                                local h_items = holster:get_children()
                                if h_items then
                                    for k = 1, #h_items do
                                        local sub = h_items[k]:get_children()
                                        if sub then
                                            for s = 1, #sub do
                                                if sub[s].Name and sub[s].Name ~= "Handle" and sub[s].Name ~= "" then
                                                    entry.held = sub[s].Name
                                                    break
                                                end
                                            end
                                        end
                                        if entry.held then break end
                                    end
                                end
                            end
                        end
                    end

                    local part_names = {
                        "Head", "UpperTorso", "LowerTorso",
                        "LeftUpperArm", "LeftLowerArm", "LeftHand",
                        "RightUpperArm", "RightLowerArm", "RightHand",
                        "LeftUpperLeg", "LeftLowerLeg", "LeftFoot",
                        "RightUpperLeg", "RightLowerLeg", "RightFoot",
                        "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg"
                    }
                    for j = 1, #part_names do
                        local pname_part = part_names[j]
                        local pt = char:find_first_child(pname_part)
                        if pt then
                            entry.parts[pname_part] = pt
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
-- BACKGROUND SCANNER: DROPPED PLAYER ITEMS
-- =========================================================================
-- =========================================================================
-- BACKGROUND SCANNER: DEAD BODIES, CORPSES & BODY BAGS
-- =========================================================================
local function scan_bodybags_task()
    if not cfg.bb_enabled then
        cached_bodybags = {}
        return
    end

    local ws = game.workspace or game.Workspace
    if not ws then return end

    local out = {}

    local function check_candidate(inst, custom_label)
        if not inst then return end
        local iname = inst.Name
        local ilower = iname:lower()
        local label = custom_label

        if not label then
            if ilower:find("bodybag") or ilower:find("body_bag") or ilower:find("deathbag") or ilower:find("lootbag") then
                label = "Body Bag"
            elseif ilower:find("corpse") or ilower:find("deadbody") or ilower:find("dead_body") or ilower:find("ragdoll") then
                label = "Dead Body"
            elseif ilower:find("backpack") or ilower:find("pack") then
                label = "Death Bag"
            elseif ilower:find("sleepingbag") or ilower:find("sleeping_bag") then
                label = "Sleeping Bag"
            end
        end

        if label then
            local p = get_model_position_part(inst)
            if p then
                local px, py, pz = safe_pos(p)
                if px then
                    out[#out + 1] = {
                        x = px, y = py, z = pz,
                        name = label,
                        color = cfg.bb_col,
                        model = inst
                    }
                end
            end
        end
    end

    -- 1. Check WorldItems / DroppedItems for Body Bags and Death Backpacks
    local item_folders = { "WorldItems", "DroppedItems", "Dropped", "Debris", "Corpses", "DeadBodies", "Bags", "Dead" }
    for f_idx = 1, #item_folders do
        local folder = ws:find_first_child(item_folders[f_idx])
        if folder then
            local children = folder:get_children()
            if children then
                for i = 1, #children do
                    check_candidate(children[i])
                end
            end
        end
    end

    -- 2. Check top-level workspace models
    local ws_children = ws:get_children()
    if ws_children then
        for i = 1, #ws_children do
            local inst = ws_children[i]
            local iname = inst.Name:lower()
            if iname:find("corpse") or iname:find("bodybag") or iname:find("deadbody") or iname:find("ragdoll") or iname:find("sleepingbag") then
                check_candidate(inst)
            end
        end
    end

    cached_bodybags = out
end

local function scan_dropped_task()
    if not cfg.d_enabled then
        cached_dropped = {}
        return
    end

    local ws = game.workspace or game.Workspace
    if not ws then return end

    local out = {}

    -- Scan Dropped Items in workspace.WorldItems
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
-- =========================================================================
-- BACKGROUND SCANNER: LOOT CONTAINERS (BARRELS, CRATES, STORAGE BOXES)
-- =========================================================================
local function scan_loot_task()
    if not cfg.loot_enabled then
        cached_loot = {}
        return
    end

    local ws = game.workspace or game.Workspace
    if not ws then return end

    local out = {}

    local function check_container(inst)
        if not inst then return end
        local name = inst.Name
        local lower = name:lower()
        local display = nil
        local col = nil
        local cat = nil

        -- World loot
        if lower:find("barrel") then
            if cfg.loot_show_barrels then
                display = "Loot Barrel"
                col = cfg.loot_col_barrels
                cat = "barrel"
            end
        elseif lower:find("elite") then
            if cfg.loot_show_elite then
                display = "Elite Crate"
                col = cfg.loot_col_elite
                cat = "elite_crate"
            end
        elseif lower:find("military") then
            if cfg.loot_show_military then
                display = "Military Crate"
                col = cfg.loot_col_military
                cat = "military_crate"
            end
        elseif lower:find("crate") then
            if cfg.loot_show_crates then
                display = "Loot Crate"
                col = cfg.loot_col_crates
                cat = "crate"
            end
        -- Base deployable containers
        elseif lower:find("largebox") then
            if cfg.loot_show_large_box then
                display = "Large Wooden Box"
                col = cfg.loot_col_large_box
                cat = "large_box"
            end
        elseif lower:find("woodenbox") then
            if cfg.loot_show_small_box then
                display = "Small Wooden Box"
                col = cfg.loot_col_small_box
                cat = "small_box"
            end
        elseif lower:find("toolcupboard") or lower:find("cupboard") then
            if cfg.loot_show_tc then
                display = "Tool Cupboard"
                col = cfg.loot_col_tc
                cat = "tc"
            end
        elseif lower:find("locker") then
            if cfg.loot_show_locker then
                display = "Locker"
                col = cfg.loot_col_locker
                cat = "locker"
            end
        elseif lower:find("furnace") then
            if cfg.loot_show_furnace then
                display = "Furnace"
                col = cfg.loot_col_furnace
                cat = "furnace"
            end
        elseif lower:find("workbench") then
            if cfg.loot_show_workbench then
                display = name
                col = cfg.loot_col_workbench
                cat = "workbench"
            end
        elseif lower:find("shelves") then
            if cfg.loot_show_shelves then
                display = "Shelves"
                col = cfg.loot_col_shelves
                cat = "shelves"
            end
        elseif lower:find("sleepingbag") or lower:find("sleeping_bag") then
            if cfg.loot_show_sleeping_bag then
                display = "Sleeping Bag"
                col = cfg.loot_col_sleeping_bag
                cat = "sleeping_bag"
            end
        end

        if display and col then
            local p = get_model_position_part(inst)
            if p then
                local px, py, pz = safe_pos(p)
                if px then
                    out[#out + 1] = {
                        x = px, y = py, z = pz,
                        name = display,
                        category = cat or "container",
                        color = col,
                        model = inst
                    }
                end
            end
        end
    end

    -- 1. Scan workspace.Loot
    local loot_folder = ws:find_first_child("Loot")
    if loot_folder then
        local children = loot_folder:get_children()
        if children then
            for i = 1, #children do
                check_container(children[i])
            end
        end
    end

    -- 2. Scan workspace.Deployables
    local dep_folder = ws:find_first_child("Deployables")
    if dep_folder then
        local children = dep_folder:get_children()
        if children then
            for i = 1, #children do
                check_container(children[i])
            end
        end
    end

    cached_loot = out
end

-- =========================================================================
-- SCANNER: BODY BAG & CONTAINER INVENTORY INSPECTOR
-- =========================================================================
local function scan_bodybag_inventory(bb_entry)
    if not bb_entry or not bb_entry.model then return nil end
    local model = bb_entry.model
    local dx = bb_entry.x - cam_x
    local dy = bb_entry.y - cam_y
    local dz = bb_entry.z - cam_z
    local dist_m = math.floor(math.sqrt(dx * dx + dy * dy + dz * dz) * 0.28)

    local data = {
        name = bb_entry.name or "Body Bag",
        distance_m = dist_m,
        is_sleeper = bb_entry.is_sleeper or false,
        hp = nil,
        max_hp = nil,
        equipped = nil,
        holsters = {},
        wear = {},
        backpack = nil,
        items = {}
    }

    pcall(function()
        local hum = model:find_first_child_which_is_a("Humanoid")
        if hum then
            data.hp = math.floor(hum.Health or 100)
            data.max_hp = math.floor(hum.MaxHealth or 100)
        end

        -- Check tools in model
        local children = model:get_children()
        if children then
            for i = 1, #children do
                local c = children[i]
                if c.ClassName == "Tool" then
                    data.equipped = c.Name
                end
            end
        end

        -- Check FustHolster
        local holster = model:find_first_child("FustHolster")
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

        -- Check FustWear
        local wear = model:find_first_child("FustWear")
        if wear then
            local w_items = wear:get_children()
            if w_items then
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
                    if info then
                        data.wear[#data.wear + 1] = info
                    else
                        data.wear[#data.wear + 1] = {
                            display = item.Name,
                            slot = "Gear",
                            tier = "T0",
                            color = { 0.7, 0.7, 0.7, 1 }
                        }
                    end
                end
            end
        end

        -- Check FustPack
        local pack = model:find_first_child("FustPack")
        if pack then
            local p_items = pack:get_children()
            if p_items and #p_items > 0 then
                data.backpack = p_items[1].Name
            end
        end

        local mname_lower = model.Name:lower()
        if mname_lower:find("backpack") and not data.backpack then
            data.backpack = "Death Backpack"
        end

        -- Scan loose items / tools / containers
        for i = 1, #children do
            local c = children[i]
            local cname = c.Name
            local clower = cname:lower()
            if not clower:find("joint") and not clower:find("attachment") and not clower:find("root") and not clower:find("fust") and not clower:find("torso") and not clower:find("arm") and not clower:find("leg") and not clower:find("head") and c.ClassName ~= "Humanoid" and c.ClassName ~= "BodyColors" then
                if cname ~= "Strap" and cname ~= "Canvas" and cname ~= "PromptAnchor" and cname ~= "Rim" and cname ~= "Metal" and cname ~= "Wood" and cname ~= "WoodDark" and cname ~= "Lid" then
                    data.items[#data.items + 1] = cname
                end
            end
        end
    end)

    return data
end

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
    local need_npcs = cfg.npc_enabled or cfg.aim_target_npcs or cfg.npc_aimbot or (cfg.gun_trigger and cfg.gun_trigger_npcs)
    if not need_npcs then
        cached_npcs = {}
        return
    end

    local ws = game.workspace or game.Workspace
    if not ws then return end

    local out = {}

    -- 1. Scan Ground NPCs (Soldiers / Scientists) in workspace.Npcs
    local want_soldiers = cfg.npc_soldier or cfg.aim_target_npcs or cfg.npc_aimbot or (cfg.gun_trigger and cfg.gun_trigger_npcs)
    if want_soldiers then
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

                            local head_p = inst:find_first_child("Head")
                            local torso_p = inst:find_first_child("UpperTorso") or inst:find_first_child("Torso")

                            local npc_parts = {}
                            local part_names = {
                                "Head", "UpperTorso", "LowerTorso",
                                "LeftUpperArm", "LeftLowerArm", "LeftHand",
                                "RightUpperArm", "RightLowerArm", "RightHand",
                                "LeftUpperLeg", "LeftLowerLeg", "LeftFoot",
                                "RightUpperLeg", "RightLowerLeg", "RightFoot"
                            }
                            for pidx = 1, #part_names do
                                local pt = inst:find_first_child(part_names[pidx])
                                if pt then npc_parts[part_names[pidx]] = pt end
                            end

                            out[#out + 1] = {
                                x = px, y = py, z = pz,
                                name = name,
                                inst = inst,
                                root = root,
                                head = head_p or root,
                                torso = torso_p or root,
                                parts = npc_parts,
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
    local want_heli = cfg.npc_heli or cfg.aim_target_npcs or cfg.npc_aimbot
    if want_heli then
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
                            inst = heli_model,
                            root = main_part,
                            head = main_part,
                            torso = main_part,
                            parts = {},
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
-- VISUALS: REMOVE FOG ENGINE
-- =========================================================================
local function update_visuals_task()
    local lighting = game.Lighting or (game.get_service and game.get_service("Lighting"))
    if not lighting then return end

    if not orig_lighting_saved then
        orig_lighting.FogEnd = lighting.FogEnd or 100000
        orig_lighting_saved = true
    end

    if cfg.no_fog then
        pcall(function()
            lighting.FogEnd = 9999999
            if lighting.FogStart then lighting.FogStart = 0 end
        end)
    elseif orig_lighting_saved then
        pcall(function()
            lighting.FogEnd = orig_lighting.FogEnd
        end)
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

                -- Skeleton ESP for Humanoid NPCs
                if cfg.npc_skel and n.parts and not n.is_heli then
                    local scol = cfg.npc_skel_col
                    for b = 1, #SKELETON_BONES do
                        local pair = SKELETON_BONES[b]
                        local p1 = n.parts[pair[1]]
                        local p2 = n.parts[pair[2]]
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

                if cfg.npc_hp then
                    local hp_pct = clamp(n.hp / math.max(1, n.max_hp), 0, 1)
                    local bar_w = n.is_heli and 50 or 30
                    local bar_h = 3
                    local bx = sx - bar_w * 0.5
                    local by = sy + 6
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

local function render_player_esp(p)
    if not p or not p.root then return end
    local rx, ry, rz = safe_pos(p.root)
    if not rx then return end

    local dx = rx - cam_x
    local dy = ry - cam_y
    local dz = rz - cam_z
    local d_sq = dx * dx + dy * dy + dz * dz

    if d_sq > cfg.p_max_sq then return end

    local dist_m = math.floor(math.sqrt(d_sq) * 0.28)
    local min_x, min_y, max_x, max_y = 999999, 999999, -999999, -999999
    local has_point = false

    -- 1. Fast Skeleton Drawing & Dynamic Joint Bounding
    if p.parts and not p.is_sleeper then
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
                        if cfg.p_skel then
                            draw.line(s1x, s1y, s2x, s2y, scol, 1)
                        end
                        if s1x < min_x then min_x = s1x end
                        if s1x > max_x then max_x = s1x end
                        if s1y < min_y then min_y = s1y end
                        if s1y > max_y then max_y = s1y end
                        if s2x < min_x then min_x = s2x end
                        if s2x > max_x then max_x = s2x end
                        if s2y < min_y then min_y = s2y end
                        if s2y > max_y then max_y = s2y end
                        has_point = true
                    end
                end
            end
        end
    end

    -- 2. Fallback Centered Box (When skeleton is disabled, obscured, or sleeping)
    local rsx, rsy, rvis = utility.world_to_screen(rx, ry, rz)
    if not has_point then
        if not rvis then return end
        local sc = clamp(900 / math.max(1, dist_m), 14, 110)
        min_x = rsx - sc * 0.45
        max_x = rsx + sc * 0.45
        min_y = rsy - sc * 0.85
        max_y = rsy + sc * 0.85
        has_point = true
    end

    if not has_point then return end

    local bx = min_x - 3
    local by = min_y - 5
    local bw = (max_x - min_x) + 6
    local bh = (max_y - min_y) + 10

    if bw < 4 or bh < 4 then return end

    -- Chams (Filled Box)
    if cfg.p_chams then
        draw.rect_filled(bx, by, bw, bh, cfg.p_chams_col)
    end

    -- Bounding Box
    local bcol = p.is_sleeper and cfg.p_sleep_col or cfg.p_box_col
    if cfg.p_box then
        draw.rect(bx, by, bw, bh, bcol, 0, 1)
    end

    -- Dynamic Vertical Health Bar
    if cfg.p_hp then
        local bar_w = 3
        local bar_x = bx - bar_w - 3
        draw.rect_filled(bar_x - 1, by - 1, bar_w + 2, bh + 2, { 0.05, 0.05, 0.05, 0.8 }, 0)
        local hp_pct = clamp(p.hp / math.max(1, p.max_hp), 0, 1)
        local r_hp = clamp(2.0 * (1.0 - hp_pct), 0, 1)
        local g_hp = clamp(2.0 * hp_pct, 0, 1)
        local f_h = math.floor(bh * hp_pct)
        draw.rect_filled(bar_x, by + (bh - f_h), bar_w, f_h, { r_hp, g_hp, 0.1, 1.0 }, 0)

        if hp_pct < 1.0 then
            local hp_txt = tostring(math.floor(p.hp))
            draw.text(bar_x - draw.get_text_size(hp_txt, 10) - 2, by + (bh - f_h) - 4, hp_txt, { 1, 1, 1, 0.9 }, 10)
        end
    end

    -- Top: Centered Name & Distance
    local top_parts = {}
    if cfg.p_name then
        top_parts[#top_parts + 1] = p.name
    end
    if cfg.p_dist then
        top_parts[#top_parts + 1] = "[" .. tostring(dist_m) .. "m]"
    end

    if #top_parts > 0 then
        local top_txt = table.concat(top_parts, " ")
        local tw = draw.get_text_size(top_txt, cfg.p_font)
        draw.text(bx + (bw - tw) * 0.5, by - cfg.p_font - 4, top_txt, { 1, 1, 1, 1 }, cfg.p_font)
    end

    -- Bottom: Centered Held Item
    if cfg.p_held and p.held then
        local h_lbl = "[Held: " .. p.held .. "]"
        local htw = draw.get_text_size(h_lbl, cfg.p_font - 1)
        draw.text(bx + (bw - htw) * 0.5, by + bh + 3, h_lbl, cfg.p_held_col, cfg.p_font - 1)
    end

    -- Player Tracer / Snapline
    if cfg.p_tracers then
        local rsx, rsy, rvis = utility.world_to_screen(rx, ry, rz)
        if rvis then
            draw.line(
                cached_sw * 0.5, cached_sh,
                rsx, rsy,
                { cfg.p_tracers_col[1], cfg.p_tracers_col[2],
                  cfg.p_tracers_col[3], cfg.p_tracers_col[4] }, 1)
        end
    end
end

local function render_bodybags()
    if not cfg.bb_enabled then return end
    local sw, sh = utility.get_screen_size()
    local tox, toy = sw * 0.5, sh
    local drawn_bb = 0

    for j = 1, #cached_bodybags do
        if drawn_bb >= 100 then break end
        local bb = cached_bodybags[j]
        local dx = bb.x - cam_x
        local dy = bb.y - cam_y
        local dz = bb.z - cam_z
        local d_sq = dx * dx + dy * dy + dz * dz

        if d_sq <= cfg.bb_max_sq then
            local sx, sy, vis = utility.world_to_screen(bb.x, bb.y, bb.z)
            if vis then
                drawn_bb = drawn_bb + 1
                local col = bb.color or cfg.bb_col
                draw.circle_filled(sx, sy, 3.5, col)

                local dist_str = ""
                if cfg.bb_dist then
                    local dm = math.floor(math.sqrt(d_sq) * 0.28)
                    dist_str = " [" .. tostring(dm) .. "m]"
                end

                local txt = bb.name .. dist_str
                local tw = draw.get_text_size(txt, cfg.bb_font)
                draw.text(sx - tw * 0.5, sy - cfg.bb_font - 3, txt, col, cfg.bb_font)

                if cfg.bb_tracers then
                    draw.line(tox, toy, sx, sy, { col[1], col[2], col[3], 0.35 }, 1)
                end
            end
        end
    end
end

local function render_nodes()
    if not cfg.n_enabled then return end
    local sw, sh = utility.get_screen_size()
    local tox, toy = sw * 0.5, sh
    local drawn_nodes = 0

    for j = 1, #cached_nodes do
        if drawn_nodes >= 120 then break end
        local n = cached_nodes[j]
        local dx = n.x - cam_x
        local dy = n.y - cam_y
        local dz = n.z - cam_z
        local d_sq = dx * dx + dy * dy + dz * dz

        if d_sq <= cfg.n_max_sq then
            local sx, sy, vis = utility.world_to_screen(n.x, n.y, n.z)
            if vis then
                drawn_nodes = drawn_nodes + 1
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
    local drawn_pk = 0
    for j = 1, #cached_pickups do
        if drawn_pk >= 100 then break end
        local pk = cached_pickups[j]
        local dx = pk.x - cam_x
        local dy = pk.y - cam_y
        local dz = pk.z - cam_z
        local d_sq = dx * dx + dy * dy + dz * dz

        if d_sq <= cfg.pk_max_sq then
            local sx, sy, vis = utility.world_to_screen(pk.x, pk.y, pk.z)
            if vis then
                drawn_pk = drawn_pk + 1
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
    local drawn_d = 0
    for j = 1, #cached_dropped do
        if drawn_d >= 100 then break end
        local d = cached_dropped[j]
        local dx = d.x - cam_x
        local dy = d.y - cam_y
        local dz = d.z - cam_z
        local d_sq = dx * dx + dy * dy + dz * dz

        if d_sq <= cfg.d_max_sq then
            local sx, sy, vis = utility.world_to_screen(d.x, d.y, d.z)
            if vis then
                drawn_d = drawn_d + 1
                local txt = d.name
                if cfg.d_dist then
                    local dm = math.floor(math.sqrt(d_sq) * 0.28)
                    txt = txt .. " [" .. tostring(dm) .. "m]"
                end
                local tw = draw.get_text_size(txt, cfg.d_font)
                draw.text(sx - tw * 0.5, sy - 6, txt, col, cfg.d_font)

                if cfg.d_tracers then
                    draw.line(cached_sw * 0.5, cached_sh, sx, sy, { col[1], col[2], col[3], 0.35 }, 1)
                end
            end
        end
    end
end

-- =========================================================================
-- =========================================================================
-- HIGH FPS RENDER PIPELINE: LOOT CONTAINERS (BARRELS, CRATES, STORAGE BOXES)
-- =========================================================================
local function render_loot()
    if not cfg.loot_enabled then return end
    local sw, sh = cached_sw, cached_sh
    local tox, toy = sw * 0.5, sh
    local drawn = 0

    for j = 1, #cached_loot do
        if drawn >= 120 then break end
        local item = cached_loot[j]
        local show = false
        if item.category == "barrel" and cfg.loot_show_barrels then show = true
        elseif item.category == "crate" and cfg.loot_show_crates then show = true
        elseif item.category == "military" and cfg.loot_show_military then show = true
        elseif item.category == "box" and cfg.loot_show_boxes then show = true
        end

        if show then
            local dx = item.x - cam_x
            local dy = item.y - cam_y
            local dz = item.z - cam_z
            local d_sq = dx * dx + dy * dy + dz * dz

            if d_sq <= cfg.loot_max_sq then
                local sx, sy, vis = utility.world_to_screen(item.x, item.y, item.z)
                if vis then
                    drawn = drawn + 1
                    local col = item.color or { 0.9, 0.7, 0.2, 1 }
                    draw.circle_filled(sx, sy, 3.0, col)

                    local txt = item.name
                    if cfg.loot_dist then
                        local dm = math.floor(math.sqrt(d_sq) * 0.28)
                        txt = txt .. " [" .. tostring(dm) .. "m]"
                    end
                    local tw = draw.get_text_size(txt, cfg.loot_font)
                    draw.text(sx - tw * 0.5, sy - cfg.loot_font - 3, txt, col, cfg.loot_font)

                    if cfg.loot_tracers then
                        draw.line(tox, toy, sx, sy, { col[1], col[2], col[3], 0.35 }, 1)
                    end
                end
            end
        end
    end
end

-- =========================================================================
-- HIGH FPS RENDER PIPELINE: BODY BAG & CONTAINER VIEWER HUD PANEL
-- =========================================================================
local function render_bodybag_viewer_panel()
    if not cfg.bb_viewer_enabled then return end
    if not cached_bodybag_inventory then return end

    local inv = cached_bodybag_inventory
    local px = inv_bb_panel.x
    local py = inv_bb_panel.y
    local pw = inv_bb_panel.w
    local ly = py + 34

    -- Outer Panel Frame
    local total_h = 42
    if inv.hp then total_h = total_h + 16 end
    if inv.equipped then total_h = total_h + 30 end
    if #inv.holsters > 0 then total_h = total_h + 20 + #inv.holsters * 15 end
    if #inv.wear > 0 then total_h = total_h + 20 + #inv.wear * 15 end
    if inv.backpack then total_h = total_h + 30 end
    if #inv.items > 0 then total_h = total_h + 20 + #inv.items * 15 end
    if not inv.equipped and #inv.holsters == 0 and #inv.wear == 0 and not inv.backpack and #inv.items == 0 then
        total_h = total_h + 26
    end

    draw.rect_filled(px, py, pw, total_h, col_panel_bg, 6)
    draw.rect(px, py, pw, total_h, col_panel_border, 1, 6)
    draw.rect_filled(px, py, pw, 26, col_panel_header, 6)
    draw.line(px, py + 26, px + pw, py + 26, col_panel_border, 1)

    -- Header Title
    local title_str = inv.name .. " [" .. tostring(inv.distance_m) .. "m]"
    draw.text(px + 10, py + 6, title_str, col_accent, 12)

    -- Health bar if sleeper
    if inv.hp and inv.max_hp then
        local hp_pct = clamp(inv.hp / math.max(1, inv.max_hp), 0, 1)
        draw.rect_filled(px + 8, ly, pw - 16, 4, { 0.15, 0.15, 0.15, 1 }, 1)
        draw.rect_filled(px + 8, ly, (pw - 16) * hp_pct, 4, { (1 - hp_pct), hp_pct, 0.2, 1 }, 1)
        ly = ly + 9
    end

    -- Equipped tool
    if inv.equipped then
        ly = draw_section(px, ly, pw, "EQUIPPED TOOL", col_weapon)
        draw.text(px + 14, ly, inv.equipped, col_weapon, 11)
        ly = ly + 15
    end

    -- Holstered weapons
    if #inv.holsters > 0 then
        ly = draw_section(px, ly, pw, "HOLSTERED WEAPONS", col_weapon)
        for h = 1, #inv.holsters do
            draw.text(px + 14, ly, "- " .. inv.holsters[h], col_weapon, 11)
            ly = ly + 15
        end
    end

    -- Worn armor & clothing
    if #inv.wear > 0 then
        ly = draw_section(px, ly, pw, "WORN GEAR & ARMOR", col_armor)
        for w = 1, #inv.wear do
            local item = inv.wear[w]
            local lbl = "[" .. item.slot .. ": " .. item.tier .. "] " .. item.display
            local col = item.color or col_armor
            draw.text(px + 14, ly, lbl, col, 11)
            ly = ly + 15
        end
    end

    -- Backpack
    if inv.backpack then
        ly = draw_section(px, ly, pw, "CONTAINER", col_pack)
        draw.text(px + 14, ly, "[Pack] " .. inv.backpack, col_pack, 11)
        ly = ly + 15
    end

    -- Loose tools / sub-items
    if #inv.items > 0 then
        ly = draw_section(px, ly, pw, "LOOT CONTENTS", col_resource)
        for t = 1, #inv.items do
            draw.text(px + 14, ly, "- " .. inv.items[t], col_resource, 11)
            ly = ly + 15
        end
    end

    if not inv.equipped and #inv.holsters == 0 and #inv.wear == 0 and not inv.backpack and #inv.items == 0 then
        draw.text(px + 14, ly, "Container Sealed / Interact To Open", col_text_dim, 11)
    end
end

-- AIMBOT & CAMERA ZOOM CONTROL
-- =========================================================================
local function update_aimbot_and_zoom()
    local sw, sh = utility.get_screen_size()
    local scx, scy = sw * 0.5, sh * 0.5

    -- Detect local held tool in real time
    local detected_tool = detect_local_held_weapon()
    if detected_tool and detected_tool ~= "" then
        cached_local_tool = detected_tool
    end

    -- Determine projectile speed (Auto Bow Detect or Slider)
    local proj_speed = cfg.aim_speed
    if cfg.aim_auto_bow and cached_local_tool then
        local profile = match_gun_profile(cached_local_tool)
        if profile then
            proj_speed = profile.speed
        else
            local lh = cached_local_tool:lower()
            if lh:find("bow") or lh:find("arrow") or lh:find("crossbow") then
                proj_speed = 260
            end
        end
    end

    -- 1. Draw FOV Circle & Status
    if cfg.aim_enabled and cfg.aim_fov_dr then
        draw.circle(scx, scy, cfg.aim_fov, cfg.aim_fov_col, 64)

        local name_str = cached_local_tool or "Manual"
        local info_str = string.format("[%s | %d]", name_str, proj_speed)
        if cfg.aim_pred then info_str = info_str .. " +Lead" end
        if cfg.aim_drop then info_str = info_str .. " +Drop" end

        local tw = draw.get_text_size(info_str, 11)
        draw.text(scx - tw * 0.5, scy + cfg.aim_fov + 6, info_str, { 0.4, 0.75, 1, 0.8 }, 11)
    end

    if cfg.zoom_enabled then
        local zoom_active = false
        if cfg.zoom_key and cfg.zoom_key > 0 then
            zoom_active = input.is_key_down(cfg.zoom_key)
        else
            zoom_active = true
        end
        local cam_obj = game.workspace and game.workspace.CurrentCamera
        if cam_obj then
            local cur_fov    = cam_obj.FieldOfView or 70
            local target_fov = zoom_active and cfg.zoom_fov or 70
            local step = (target_fov - cur_fov) / math.max(1, cfg.zoom_smooth)
            if math.abs(target_fov - cur_fov) > 0.05 then
                cam_obj.FieldOfView = cur_fov + step
            end
        end
    end

    local aim_active = cfg.aim_enabled or cfg.npc_aimbot
    if not aim_active then
        aim_target_player = nil
        cached_target_inventory = nil
        return
    end

    local is_aiming = false
    if input and input.is_key_down then
        is_aiming = input.is_key_down(cfg.aim_key)
        if not is_aiming and cfg.aim_key == 2 then
            is_aiming = input.is_key_down(0x02)
        end
    end

    local best_fov = cfg.aim_fov
    local best_aim_pos = nil
    local best_target = nil

    local bone_name = "Head"
    if cfg.aim_bone_idx == 1 then bone_name = "UpperTorso"
    elseif cfg.aim_bone_idx == 2 then bone_name = "HumanoidRootPart" end

    -- Gravity constant (Roblox default ~196.2 studs/s^2)
    local grav = 196.2
    local ws = game.workspace or game.Workspace
    local ws_grav = ws and ws.Gravity
    if ws_grav and ws_grav > 0 then
        grav = ws_grav
    end

    -- 3. Evaluate Players
    if cfg.aim_enabled then
        for j = 1, #cached_players do
            local p = cached_players[j]
            if p.hp > 0 and p.root then
                local target_part = (p.parts and p.parts[bone_name]) or p.head or p.root
                if target_part then
                    local ax, ay, az = safe_pos(target_part)
                    if ax then
                        local dx = ax - cam_x
                        local dy = ay - cam_y
                        local dz = az - cam_z
                        local dist = math.sqrt(dx * dx + dy * dy + dz * dz)

                        -- Flight time calculation
                        local flight_time = dist / math.max(1, proj_speed)

                        -- Auto Velocity Lead Prediction
                        if cfg.aim_pred then
                            local vel = target_part.velocity or target_part.AssemblyLinearVelocity
                            if not vel and p.root then
                                vel = p.root.velocity or p.root.AssemblyLinearVelocity
                            end
                            if vel then
                                local vx = vel.x or vel.X or 0
                                local vy = vel.y or vel.Y or 0
                                local vz = vel.z or vel.Z or 0
                                ax = ax + (vx * flight_time)
                                ay = ay + (vy * flight_time)
                                az = az + (vz * flight_time)
                            end
                        end

                        -- Bullet & Arrow Drop Compensation
                        if cfg.aim_drop then
                            local drop_comp = 0.5 * grav * (flight_time * flight_time)
                            ay = ay + drop_comp
                        end

                        -- Visible + team filter
                        local aim_skip = false
                        if cfg.aim_team_check then
                            aim_skip = is_same_team(p)
                        end
                        if not aim_skip and cfg.aim_vis_check then
                            aim_skip = not is_target_visible(ax, ay, az)
                        end

                        if not aim_skip then
                            local sx, sy, vis = utility.world_to_screen(ax, ay, az)
                            if vis then
                                local fdx = sx - scx
                                local fdy = sy - scy
                                local fov_dist = math.sqrt(fdx * fdx + fdy * fdy)
                                if fov_dist < best_fov then
                                    best_fov = fov_dist
                                    best_aim_pos = { x = ax, y = ay, z = az, sx = sx, sy = sy }
                                    best_target = p
                                end
                            end
                        end
                    end
                end
            end
        end
    end

    -- 4. Evaluate NPCs (Soldiers, Scientists, Patrol Heli)
    if cfg.aim_target_npcs or cfg.npc_aimbot then
        for j = 1, #cached_npcs do
            local n = cached_npcs[j]
            if n.inst and n.hp > 0 then
                local target_part = nil
                if not n.is_heli then
                    if bone_name == "Head" then
                        target_part = (n.parts and n.parts.Head) or n.head or n.inst:find_first_child("Head") or n.root
                    elseif bone_name == "UpperTorso" then
                        target_part = (n.parts and n.parts.UpperTorso) or n.torso or n.inst:find_first_child("UpperTorso") or n.root
                    else -- HumanoidRootPart or Torso
                        target_part = (n.parts and n.parts.HumanoidRootPart) or n.root or (n.parts and n.parts.UpperTorso) or n.torso or n.head
                    end
                else
                    target_part = n.root or (n.inst and n.inst.PrimaryPart)
                end

                if target_part then
                    local ax, ay, az = safe_pos(target_part)
                    if ax then
                        local dx = ax - cam_x
                        local dy = ay - cam_y
                        local dz = az - cam_z
                        local dist = math.sqrt(dx * dx + dy * dy + dz * dz)

                        local flight_time = dist / math.max(1, proj_speed)

                        if cfg.aim_pred then
                            local vel = target_part.velocity or target_part.AssemblyLinearVelocity
                            if not vel and n.root then
                                vel = n.root.velocity or n.root.AssemblyLinearVelocity
                            end
                            if vel then
                                local vx = vel.x or vel.X or 0
                                local vy = vel.y or vel.Y or 0
                                local vz = vel.z or vel.Z or 0
                                ax = ax + (vx * flight_time)
                                ay = ay + (vy * flight_time)
                                az = az + (vz * flight_time)
                            end
                        end

                        if cfg.aim_drop then
                            local drop_comp = 0.5 * grav * (flight_time * flight_time)
                            ay = ay + drop_comp
                        end

                        local aim_skip = false
                        if cfg.aim_vis_check then
                            aim_skip = not is_target_visible(ax, ay, az)
                        end

                        if not aim_skip then
                            local sx, sy, vis = utility.world_to_screen(ax, ay, az)
                            if vis then
                                local fdx = sx - scx
                                local fdy = sy - scy
                                local fov_dist = math.sqrt(fdx * fdx + fdy * fdy)

                                if fov_dist < best_fov then
                                    best_fov = fov_dist
                                    best_aim_pos = { x = ax, y = ay, z = az, sx = sx, sy = sy }
                                    best_target = n
                                end
                            end
                        end
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

    -- Scan body bag / container viewer candidate
    if cfg.bb_viewer_enabled then
        local best_bb = nil
        local best_dist = 999999
        if cfg.bb_viewer_mode == 0 then -- Near crosshair
            local best_f = 220
            for b = 1, #cached_bodybags do
                local bb = cached_bodybags[b]
                local sx, sy, vis = utility.world_to_screen(bb.x, bb.y, bb.z)
                if vis then
                    local bx = sx - scx
                    local by = sy - scy
                    local fd = math.sqrt(bx*bx + by*by)
                    if fd < best_f then
                        best_f = fd
                        best_bb = bb
                    end
                end
            end
        else -- Always closest within range
            for b = 1, #cached_bodybags do
                local bb = cached_bodybags[b]
                local dx = bb.x - cam_x
                local dy = bb.y - cam_y
                local dz = bb.z - cam_z
                local d = math.sqrt(dx*dx + dy*dy + dz*dz) * 0.28
                if d <= 50 and d < best_dist then
                    best_dist = d
                    best_bb = bb
                end
            end
        end

        -- Also allow container inspection from cached_loot
        if not best_bb then
            if cfg.bb_viewer_mode == 0 then
                local best_f = 220
                for b = 1, #cached_loot do
                    local loot_item = cached_loot[b]
                    local sx, sy, vis = utility.world_to_screen(loot_item.x, loot_item.y, loot_item.z)
                    if vis then
                        local bx = sx - scx
                        local by = sy - scy
                        local fd = math.sqrt(bx*bx + by*by)
                        if fd < best_f then
                            best_f = fd
                            best_bb = loot_item
                        end
                    end
                end
            else
                for b = 1, #cached_loot do
                    local loot_item = cached_loot[b]
                    local dx = loot_item.x - cam_x
                    local dy = loot_item.y - cam_y
                    local dz = loot_item.z - cam_z
                    local d = math.sqrt(dx*dx + dy*dy + dz*dz) * 0.28
                    if d <= 50 and d < best_dist then
                        best_dist = d
                        best_bb = loot_item
                    end
                end
            end
        end

        if best_bb then
            cached_bodybag_inventory = scan_bodybag_inventory(best_bb)
        else
            cached_bodybag_inventory = nil
        end
    else
        cached_bodybag_inventory = nil
    end

    -- 5. Apply Aim Movement
    if best_aim_pos and is_aiming then
        local delta_x = best_aim_pos.sx - scx
        local delta_y = best_aim_pos.sy - scy
        local smooth = math.max(1, cfg.aim_smooth)

        if camera and camera.look_at then
            pcall(function() camera.look_at(best_aim_pos.x, best_aim_pos.y, best_aim_pos.z, smooth) end)
        elseif utility and utility.mouse_move then
            pcall(function() utility.mouse_move(delta_x / smooth, delta_y / smooth) end)
        elseif input and input.mouse_move then
            pcall(function() input.mouse_move(delta_x / smooth, delta_y / smooth) end)
        end
    end
end

-- =========================================================================
-- MOUSE INPUT & CLICK SIMULATION HELPERS
-- =========================================================================
local function is_mouse1_pressed()
    local pressed = false
    pcall(function()
        local uis = get_roblox_service("UserInputService")
        if uis and uis.IsMouseButtonPressed then
            pressed = uis:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)
        end
    end)
    if pressed then return true end
    if input and input.is_key_down then
        local ok, down = pcall(function()
            return input.is_key_down(1) or input.is_key_down(0x01)
        end)
        if ok and down then return true end
    end
    return false
end

local function do_click_mouse1()
    local clicked = false
    if mouse1click then
        local ok = pcall(mouse1click)
        if ok then clicked = true end
    end
    if not clicked and mouse1press and mouse1release then
        pcall(function()
            mouse1press()
            mouse1release()
            clicked = true
        end)
    end

    local vim = get_roblox_service("VirtualInputManager")
    if vim and vim.SendMouseButtonEvent then
        local sw = cached_sw or 1920
        local sh = cached_sh or 1080
        local cx = sw * 0.5
        local cy = sh * 0.5
        pcall(function()
            vim:SendMouseButtonEvent(cx, cy, 0, true, game, 0)
            vim:SendMouseButtonEvent(cx, cy, 0, false, game, 0)
            clicked = true
        end)
    end

    local vu = get_roblox_service("VirtualUser")
    if vu then
        pcall(function()
            if vu.CaptureController then
                vu:CaptureController()
            end
            local sw = cached_sw or 1920
            local sh = cached_sh or 1080
            local pt = Vector2.new(sw * 0.5, sh * 0.5)
            if vu.Button1Down and vu.Button1Up then
                vu:Button1Down(pt)
                vu:Button1Up(pt)
            elseif vu.ClickButton1 then
                vu:ClickButton1(pt)
            end
        end)
    end
end

local function is_melee_or_utility_tool(name)
    if not name or name == "" then return false end
    local clean = name:lower()
    if clean:find("rock") or clean:find("pick") or clean:find("axe") or clean:find("hatchet")
       or clean:find("torch") or clean:find("hammer") or clean:find("plan") or clean:find("bandage")
       or clean:find("syringe") or clean:find("pumpkin") or clean:find("corn") or clean:find("meat") then
        return true
    end
    return false
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
    local mx, my = get_safe_mouse_pos()
    local lmb = (is_mouse1_pressed and is_mouse1_pressed()) or false

    local header_h = 26

    if cfg.inv_enabled then
        local px = inv_panel.x
        local py = inv_panel.y
        local pw = inv_panel.w

        if lmb then
            if not inv_panel.dragging and not inv_bb_panel.dragging then
                if mx >= px and mx <= (px + pw) and my >= py and my <= (py + header_h) then
                    inv_panel.dragging = true
                    inv_panel.drag_ox = mx - px
                    inv_panel.drag_oy = my - py
                end
            elseif inv_panel.dragging then
                inv_panel.x = clamp(mx - inv_panel.drag_ox, 0, cached_sw - pw)
                inv_panel.y = clamp(my - inv_panel.drag_oy, 0, cached_sh - 40)
            end
        else
            inv_panel.dragging = false
        end
    end

    if cfg.bb_viewer_enabled then
        local bpx = inv_bb_panel.x
        local bpy = inv_bb_panel.y
        local bpw = inv_bb_panel.w

        if lmb then
            if not inv_bb_panel.dragging and not inv_panel.dragging then
                if mx >= bpx and mx <= (bpx + bpw) and my >= bpy and my <= (bpy + header_h) then
                    inv_bb_panel.dragging = true
                    inv_bb_panel.drag_ox = mx - bpx
                    inv_bb_panel.drag_oy = my - bpy
                end
            elseif inv_bb_panel.dragging then
                inv_bb_panel.x = clamp(mx - inv_bb_panel.drag_ox, 0, cached_sw - bpw)
                inv_bb_panel.y = clamp(my - inv_bb_panel.drag_oy, 0, cached_sh - 40)
            end
        else
            inv_bb_panel.dragging = false
        end
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
    cfg.aim_auto_bow= menu.get("aim_auto_bow")
    if cfg.aim_auto_bow == nil then cfg.aim_auto_bow = true end
    cfg.aim_target_npcs = menu.get("aim_target_npcs") or false
    cfg.aim_vis_check  = menu.get("aim_vis_check") or false
    cfg.aim_team_check = menu.get("aim_team_check") or false
    cfg.aim_highlight  = menu.get("aim_target_highlight") or false
    cfg.aim_hl_col     = menu.get_color("aim_target_highlight") or { 1.0, 0.30, 0.30, 1.0 }
    cfg.aim_speed   = menu.get("aim_proj_speed") or 350
    cfg.aim_bone_idx= menu.get("aim_bone") or 0
    cfg.aim_fov     = menu.get("aim_fov") or 140
    cfg.aim_smooth  = math.max(1, menu.get("aim_smooth") or 4)

    -- Gun Mods
    cfg.gun_recoil       = menu.get("gun_recoil_enabled") or false
    cfg.gun_recoil_pct   = menu.get("gun_recoil_pct") or 80
    cfg.gun_rapid        = menu.get("gun_rapid_fire") or false
    cfg.gun_rapid_delay  = menu.get("gun_rapid_delay") or 120
    cfg.gun_trigger      = menu.get("gun_triggerbot") or false
    cfg.gun_trigger_delay= menu.get("gun_trigger_delay") or 25
    cfg.gun_trigger_npcs = menu.get("gun_trigger_npcs")
    if cfg.gun_trigger_npcs == nil then cfg.gun_trigger_npcs = true end

    -- Camera & Zoom
    cfg.zoom_enabled= menu.get("zoom_enabled") or false
    local zk = menu.get_key and menu.get_key("zoom_enabled") or 0
    if zk and zk > 0 then cfg.zoom_key = zk else cfg.zoom_key = 0 end
    cfg.zoom_fov    = menu.get("zoom_fov") or 30
    cfg.zoom_smooth = math.max(1, menu.get("zoom_smooth") or 6)

    cfg.no_fog      = menu.get("no_fog") or false

    -- Inventory Viewer
    cfg.inv_enabled = menu.get("inv_enabled") or false
    cfg.inv_mode    = menu.get("inv_mode") or 0
    cfg.inv_weapons = menu.get("inv_show_weapons")
    if cfg.inv_weapons == nil then cfg.inv_weapons = true end
    cfg.inv_wear    = menu.get("inv_show_wear")
    if cfg.inv_wear == nil then cfg.inv_wear = true end
    cfg.inv_pack    = menu.get("inv_show_pack")
    if cfg.inv_pack == nil then cfg.inv_pack = true end
    cfg.inv_grid    = menu.get("inv_show_grid")
    if cfg.inv_grid == nil then cfg.inv_grid = true end
    local px = menu.get("inv_panel_x")
    local py = menu.get("inv_panel_y")
    local pw = menu.get("inv_panel_w")
    if not inv_panel.dragging then
        if px then inv_panel.x = px end
        if py then inv_panel.y = py end
        if pw then inv_panel.w = pw end
    end

    -- Animals ESP
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

    -- NPCs ESP
    cfg.npc_enabled = menu.get("npcs_esp_enabled") or false
    cfg.npc_soldier = menu.get("npc_soldier") or false
    cfg.npc_sol_col = menu.get_color("npc_soldier") or { 0.25, 0.85, 1.00, 1.0 }
    cfg.npc_heli    = menu.get("npc_patrol_heli") or false
    cfg.npc_heli_col= menu.get_color("npc_patrol_heli") or { 1.00, 0.20, 0.20, 1.0 }
    cfg.npc_skel    = menu.get("npc_skeleton") or false
    cfg.npc_skel_col= menu.get_color("npc_skeleton") or { 1.00, 0.35, 0.35, 1.0 }
    cfg.npc_aimbot  = menu.get("npc_aimbot") or false
    cfg.npc_name    = menu.get("npcs_show_name") or false
    cfg.npc_dist    = menu.get("npcs_show_dist") or false
    cfg.npc_hp      = menu.get("npcs_show_health") or false
    cfg.npc_tracers = menu.get("npcs_tracers") or false
    local npc_range = menu.get("npcs_max_dist") or 450
    cfg.npc_max_sq  = (npc_range / 0.28) * (npc_range / 0.28)
    cfg.npc_font    = menu.get("npcs_font_size") or 13

    -- Player ESP
    cfg.p_enabled   = menu.get("player_esp_enabled") or false
    cfg.p_box       = menu.get("player_box") or false
    cfg.p_box_col   = menu.get_color("player_box") or { 1, 1, 1, 0.85 }
    cfg.p_skel      = menu.get("player_skeleton") or false
    cfg.p_skel_col  = menu.get_color("player_skeleton") or { 1, 0.35, 0.35, 1 }
    cfg.p_chams     = menu.get("player_chams") or false
    cfg.p_chams_col = menu.get_color("player_chams") or { 0.95, 0.25, 0.25, 0.25 }
    cfg.p_hp        = menu.get("player_health") or false
    cfg.p_held      = menu.get("player_held") or false
    cfg.p_held_col  = menu.get_color("player_held") or { 1, 0.85, 0.3, 1 }
    cfg.p_name      = menu.get("player_name") or false
    cfg.p_dist      = menu.get("player_dist") or false
    cfg.p_tracers   = menu.get("player_tracers") or false
    cfg.p_tracers_col= menu.get_color("player_tracers") or { 1, 1, 1, 0.35 }
    cfg.p_sleepers  = menu.get("player_sleepers") or false
    cfg.p_sleep_col = menu.get_color("player_sleepers") or { 0.65, 0.70, 0.85, 0.85 }
    local p_range   = menu.get("player_max_dist") or 500
    cfg.p_max_sq    = (p_range / 0.28) * (p_range / 0.28)
    cfg.p_font      = menu.get("player_font_size") or 13

    -- Ore Nodes ESP
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

    -- Pickups ESP
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

    -- Dropped Items ESP
    cfg.d_enabled   = menu.get("dropped_esp_enabled") or false
    cfg.d_col       = menu.get_color("dropped_color") or { 1, 0.4, 0.9, 1 }
    cfg.d_tracers   = menu.get("dropped_tracers") or false
    cfg.d_dist      = menu.get("dropped_show_dist") or false
    local d_range   = menu.get("dropped_max_dist") or 150
    cfg.d_max_sq    = (d_range / 0.28) * (d_range / 0.28)
    cfg.d_font      = menu.get("dropped_font_size") or 12

    -- Body Bags ESP
    cfg.bb_enabled  = menu.get("bodybag_enabled") or false
    cfg.bb_col      = menu.get_color("bodybag_enabled") or { 0.90, 0.25, 0.35, 1.0 }
    cfg.bb_dist     = menu.get("bodybag_show_dist") or false
    cfg.bb_tracers  = menu.get("bodybag_tracers") or false
    local bb_range  = menu.get("bodybag_max_dist") or 500
    cfg.bb_max_sq   = (bb_range / 0.28) * (bb_range / 0.28)
    cfg.bb_font     = menu.get("bodybag_font_size") or 13

    -- Body Bag & Container Viewer
    cfg.bb_viewer_enabled = menu.get("bodybag_viewer_enabled") or false
    cfg.bb_viewer_mode    = menu.get("bodybag_viewer_mode") or 0
    local bpx = menu.get("bodybag_panel_x")
    local bpy = menu.get("bodybag_panel_y")
    local bpw = menu.get("bodybag_panel_w")
    if not inv_bb_panel.dragging then
        if bpx then inv_bb_panel.x = bpx end
        if bpy then inv_bb_panel.y = bpy end
        if bpw then inv_bb_panel.w = bpw end
    end

    -- Loot Containers ESP
    cfg.loot_enabled        = menu.get("loot_esp_enabled") or false
    cfg.loot_show_world_cat = menu.get("loot_show_world_cat")
    if cfg.loot_show_world_cat == nil then cfg.loot_show_world_cat = true end
    cfg.loot_show_barrels   = menu.get("loot_show_barrels")
    if cfg.loot_show_barrels == nil then cfg.loot_show_barrels = true end
    cfg.loot_col_barrels    = menu.get_color("loot_show_barrels") or { 0.25, 0.75, 1.0, 1.0 }

    cfg.loot_show_crates    = menu.get("loot_show_crates")
    if cfg.loot_show_crates == nil then cfg.loot_show_crates = true end
    cfg.loot_col_crates     = menu.get_color("loot_show_crates") or { 0.95, 0.70, 0.25, 1.0 }

    cfg.loot_show_military  = menu.get("loot_show_military")
    if cfg.loot_show_military == nil then cfg.loot_show_military = true end
    cfg.loot_col_military   = menu.get_color("loot_show_military") or { 0.20, 1.00, 0.40, 1.0 }

    cfg.loot_show_elite     = menu.get("loot_show_elite")
    if cfg.loot_show_elite == nil then cfg.loot_show_elite = true end
    cfg.loot_col_elite      = menu.get_color("loot_show_elite") or { 0.95, 0.25, 0.45, 1.0 }

    cfg.loot_show_base_cat  = menu.get("loot_show_base_cat")
    if cfg.loot_show_base_cat == nil then cfg.loot_show_base_cat = true end
    cfg.loot_show_large_box = menu.get("loot_show_large_box")
    if cfg.loot_show_large_box == nil then cfg.loot_show_large_box = true end
    cfg.loot_col_large_box  = menu.get_color("loot_show_large_box") or { 0.95, 0.65, 0.20, 1.0 }

    cfg.loot_show_small_box = menu.get("loot_show_small_box")
    if cfg.loot_show_small_box == nil then cfg.loot_show_small_box = true end
    cfg.loot_col_small_box  = menu.get_color("loot_show_small_box") or { 0.85, 0.50, 0.15, 1.0 }

    cfg.loot_show_tc        = menu.get("loot_show_tc")
    if cfg.loot_show_tc == nil then cfg.loot_show_tc = true end
    cfg.loot_col_tc         = menu.get_color("loot_show_tc") or { 0.20, 0.85, 1.00, 1.0 }

    cfg.loot_show_locker    = menu.get("loot_show_locker")
    if cfg.loot_show_locker == nil then cfg.loot_show_locker = true end
    cfg.loot_col_locker     = menu.get_color("loot_show_locker") or { 0.70, 0.75, 0.90, 1.0 }

    cfg.loot_show_furnace   = menu.get("loot_show_furnace")
    if cfg.loot_show_furnace == nil then cfg.loot_show_furnace = true end
    cfg.loot_col_furnace    = menu.get_color("loot_show_furnace") or { 1.00, 0.42, 0.15, 1.0 }

    cfg.loot_show_workbench = menu.get("loot_show_workbench")
    if cfg.loot_show_workbench == nil then cfg.loot_show_workbench = true end
    cfg.loot_col_workbench  = menu.get_color("loot_show_workbench") or { 0.60, 0.85, 0.40, 1.0 }

    cfg.loot_show_shelves   = menu.get("loot_show_shelves")
    if cfg.loot_show_shelves == nil then cfg.loot_show_shelves = true end
    cfg.loot_col_shelves    = menu.get_color("loot_show_shelves") or { 0.80, 0.60, 0.35, 1.0 }

    cfg.loot_show_sleeping_bag = menu.get("loot_show_sleeping_bag")
    if cfg.loot_show_sleeping_bag == nil then cfg.loot_show_sleeping_bag = true end
    cfg.loot_col_sleeping_bag  = menu.get_color("loot_show_sleeping_bag") or { 0.45, 0.90, 0.65, 1.0 }

    cfg.loot_dist           = menu.get("loot_show_dist")
    if cfg.loot_dist == nil then cfg.loot_dist = true end
    cfg.loot_tracers        = menu.get("loot_tracers") or false
    local loot_range        = menu.get("loot_max_dist") or 350
    cfg.loot_max_sq         = (loot_range / 0.28) * (loot_range / 0.28)
    cfg.loot_font           = menu.get("loot_font_size") or 12

    -- Settings & Misc
    cfg.watermark      = menu.get("watermark_enabled")
    if cfg.watermark == nil then cfg.watermark = true end
    cfg.anti_afk       = menu.get("anti_afk")
    if cfg.anti_afk == nil then cfg.anti_afk = true end
    cfg.notifs         = menu.get("notifications_enabled")
    if cfg.notifs == nil then cfg.notifs = true end
    cfg.os_players     = menu.get("offscreen_players") or false
    cfg.os_npcs        = menu.get("offscreen_npcs") or false

    -- Toast trigger: check each tracked toggle for state change
    for _, t in ipairs(TRACK_TOGGLES) do
        local cur = cfg[t.key]
        if _prev_toggles[t.key] ~= nil and _prev_toggles[t.key] ~= cur then
            push_notification(t.label .. (cur and " [ON]" or " [OFF]"),
                cur and t.on or t.off, 2.2)
        end
        _prev_toggles[t.key] = cur
    end

    -- Resolution-aware drag clamp
    if inv_panel.dragging then
        inv_panel.x = clamp(inv_panel.x, 0, cached_sw - inv_panel.w)
        inv_panel.y = clamp(inv_panel.y, 0, cached_sh - 40)
    end
    if inv_bb_panel.dragging then
        inv_bb_panel.x = clamp(inv_bb_panel.x, 0, cached_sw - inv_bb_panel.w)
        inv_bb_panel.y = clamp(inv_bb_panel.y, 0, cached_sh - 40)
    end
end

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
-- =========================================================================
-- GUN MODS: RECOIL CONTROL SYSTEM (RCS), FULL AUTO & TRIGGERBOT
-- =========================================================================
local last_rcs_time = 0
local last_rapid_time = 0
local last_trigger_time = 0


local function update_gun_mods()
    if not cfg.gun_recoil and not cfg.gun_rapid and not cfg.gun_trigger then return end

    local now = os.clock()
    local is_lmb_down = is_mouse1_pressed()

    -- 1. Recoil Control System (RCS)
    if cfg.gun_recoil and is_lmb_down then
        local is_melee = is_melee_or_utility_tool(cached_local_tool)
        if not is_melee and (now - last_rcs_time >= 0.032) then
            last_rcs_time = now
            local base_pull = 6.2
            local p = match_gun_profile(cached_local_tool)
            if p then
                local pat = p.pattern or ""
                if pat:find("ak") or pat:find("sar") or pat:find("rifle") or pat:find("hmar") or pat:find("lr") then
                    base_pull = 8.5
                elseif pat:find("smg") or pat:find("thompson") or pat:find("mp5") then
                    base_pull = 5.6
                elseif pat:find("revolver") or pat:find("python") or pat:find("pistol") then
                    base_pull = 6.8
                end
            end

            local pull_y = (cfg.gun_recoil_pct / 100.0) * base_pull
            if utility and utility.mouse_move then
                pcall(function() utility.mouse_move(0, pull_y) end)
            elseif input and input.mouse_move then
                pcall(function() input.mouse_move(0, pull_y) end)
            end
        end
    end

    -- 2. Full Auto / Rapid Fire
    if cfg.gun_rapid and is_lmb_down then
        local is_melee = is_melee_or_utility_tool(cached_local_tool)
        if not is_melee then
            local interval = (cfg.gun_rapid_delay or 120) / 1000.0
            if now - last_rapid_time >= interval then
                last_rapid_time = now
                do_click_mouse1()
            end
        end
    end

    -- 3. Triggerbot (Auto Shoot when Crosshair aligns on Enemy)
    if cfg.gun_trigger then
        local sw = cached_sw or 1920
        local sh = cached_sh or 1080
        local scx = sw * 0.5
        local scy = sh * 0.5
        local on_target = false

        -- Check Cached Players
        if not on_target and cached_players then
            for i = 1, #cached_players do
                local p = cached_players[i]
                if p.hp > 0 and (not p.is_sleeping) then
                    local skip_team = false
                    if cfg.aim_team_check and p.is_team then skip_team = true end
                    if not skip_team then
                        local parts = { p.head, p.root }
                        for k = 1, #parts do
                            local part = parts[k]
                            if part then
                                local px, py, pz = safe_pos(part)
                                if px then
                                    local sx, sy, vis = utility.world_to_screen(px, py, pz)
                                    if vis then
                                        local fdx = sx - scx
                                        local fdy = sy - scy
                                        local dist_sq = fdx * fdx + fdy * fdy
                                        local d_studs = math.sqrt((px - cam_x)^2 + (py - cam_y)^2 + (pz - cam_z)^2)
                                        local tol = clamp(1300 / math.max(15, d_studs), 15, 40)
                                        if dist_sq <= (tol * tol) then
                                            if not cfg.aim_vis_check or is_target_visible(px, py, pz) then
                                                on_target = true
                                                break
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                if on_target then break end
            end
        end

        -- Check Cached NPCs (Soldiers / Scientists / Patrol Heli)
        if not on_target and cfg.gun_trigger_npcs and cached_npcs then
            for i = 1, #cached_npcs do
                local n = cached_npcs[i]
                if n.hp > 0 then
                    local parts = { n.head, n.root }
                    for k = 1, #parts do
                        local part = parts[k]
                        if part then
                            local px, py, pz = safe_pos(part)
                            if px then
                                local sx, sy, vis = utility.world_to_screen(px, py, pz)
                                if vis then
                                    local fdx = sx - scx
                                    local fdy = sy - scy
                                    local dist_sq = fdx * fdx + fdy * fdy
                                    local d_studs = math.sqrt((px - cam_x)^2 + (py - cam_y)^2 + (pz - cam_z)^2)
                                    local tol = clamp(1300 / math.max(15, d_studs), 15, 40)
                                    if dist_sq <= (tol * tol) then
                                        if not cfg.aim_vis_check or is_target_visible(px, py, pz) then
                                            on_target = true
                                            break
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
                if on_target then break end
            end
        end

        if on_target then
            local delay_sec = (cfg.gun_trigger_delay or 25) / 1000.0
            if now - last_trigger_time >= delay_sec then
                last_trigger_time = now
                do_click_mouse1()
            end
        end
    end
end

function on_frame()
    cached_sw, cached_sh = utility.get_screen_size()

    local now = os.clock()
    frame_dt  = now - frame_last_t
    if frame_dt <= 0 then frame_dt = 0.001 end
    frame_last_t = now

    pcall(refresh_menu_config)
    pcall(refresh_local_team)
    pcall(update_camera)
    pcall(handle_inventory_drag)

    if cfg.p_enabled then
        for i = 1, #cached_players do
            render_player_esp(cached_players[i])
        end
    end

    render_animals()
    render_npcs()
    render_bodybags()
    render_loot()
    render_dropped()
    render_nodes()
    render_pickups()
    render_all_offscreen_arrows()
    render_inventory_panel()
    render_bodybag_viewer_panel()
    update_aimbot_and_zoom()
    pcall(update_gun_mods)
    render_aim_target_highlight()
    render_watermark()
    render_notifications()
end

-- Fallback for environments with client table
if client and client.register_callback then
    pcall(function() client.register_callback("on_frame", on_frame) end)
end

-- =========================================================================
-- LOW-TICK BACKGROUND WORKER THREADS
-- =========================================================================
-- Anti-AFK Handler (Idled signal)
pcall(function()
    local rep_players = game.Players or (game.get_service and game.get_service("Players"))
    if rep_players and rep_players.LocalPlayer and rep_players.LocalPlayer.Idled then
        rep_players.LocalPlayer.Idled:Connect(function()
            if cfg.anti_afk then
                pcall(function()
                    local vu = get_roblox_service("VirtualUser")
                    if vu and vu.CaptureController then
                        vu:CaptureController()
                        vu:ClickButton2(Vector2.new())
                    end
                end)
            end
        end)
    end
end)

local function anti_afk_task()
    if not cfg.anti_afk then return end
    pcall(function()
        local vu = get_roblox_service("VirtualUser")
        if vu and vu.CaptureController then
            vu:CaptureController()
            vu:ClickButton2(Vector2.new())
        elseif utility and utility.mouse_move then
            utility.mouse_move(1, 0)
            utility.mouse_move(-1, 0)
        elseif input and input.mouse_move then
            input.mouse_move(1, 0)
            input.mouse_move(-1, 0)
        end
    end)
end

thread.create(anti_afk_task, 30000)
thread.create(scan_players_task, 350)
thread.create(scan_animals_task, 800)
thread.create(scan_npcs_task, 800)
thread.create(scan_bodybags_task, 800)
thread.create(scan_nodes_task, 1500)
thread.create(scan_pickups_task, 1500)
thread.create(scan_loot_task, 1200)
thread.create(scan_dropped_task, 1200)
thread.create(scan_local_inventory_task, 400)
thread.create(update_visuals_task, 1000)

print("[Hamster Hub] CREDIT TO CERTFIED_BISCUT7.")
