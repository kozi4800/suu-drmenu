local RSGCore = exports['rsg-core']:GetCoreObject()
local activeMenus = {}

-- Function to manage menu addition/removal
local function ManageMenu(menuName, shouldAdd)
    local menuData = Config.Menus[menuName]
    if not menuData then return end

    if shouldAdd and not activeMenus[menuName] then
        activeMenus[menuName] = exports['rsg-radialmenu']:AddOption(menuData)
        if Config.Discord.Debug then
            print('[DEBUG] Added menu:', menuName)
        end
    elseif not shouldAdd and activeMenus[menuName] then
        exports['rsg-radialmenu']:RemoveOption(activeMenus[menuName])
        activeMenus[menuName] = nil
        if Config.Discord.Debug then
            print('[DEBUG] Removed menu:', menuName)
        end
    end
end

-- Event handler for updating menus based on Discord roles
RegisterNetEvent('suu_drmenu:addMenus', function(allowedMenus)
    -- Remove all existing menus
    for menuName in pairs(activeMenus) do
        ManageMenu(menuName, false)
    end
    
    -- Add allowed menus
    for menuName, isAllowed in pairs(allowedMenus) do
        if isAllowed then
            ManageMenu(menuName, true)
        end
    end
end)

-- Initial role check when resource starts
CreateThread(function()
    Wait(2000) -- Wait for resources to load
    TriggerServerEvent('suu_drmenu:checkRoles')
end)

-- Check roles when player loads
RegisterNetEvent('RSGCore:Client:OnPlayerLoaded', function()
    Wait(2000)
    TriggerServerEvent('suu_drmenu:checkRoles')
end)

-- Command to manually refresh menus
RegisterCommand('refreshmenus', function()
    TriggerServerEvent('suu_drmenu:checkRoles')
end)

-- Cleanup when resource stops
AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        for menuName in pairs(activeMenus) do
            ManageMenu(menuName, false)
        end
    end
end)
