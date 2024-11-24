local RSGCore = exports['rsg-core']:GetCoreObject()
local fToken = 'Bot '..Config.Discord.botToken

-- Function to make Discord API requests
local function discordRequest(method, endpoint, jsondata)
    local data = nil
    PerformHttpRequest("https://discordapp.com/api/"..endpoint, function(errorCode, resultData, resultHeaders)
        data = {data=resultData, code=errorCode, headers=resultHeaders}
    end, method, #jsondata > 0 and json.encode(jsondata) or "", {["Content-Type"] = "application/json", ["Authorization"] = fToken})
    
    while data == nil do
        Wait(0)
    end
    return data
end

-- Function to get Discord ID from player identifiers
local function GetDiscordId(source)
    local discId = nil
    for _, v in ipairs(GetPlayerIdentifiers(source)) do
        if string.match(v, 'discord:') then
            discId = string.gsub(v, 'discord:', '')
            break
        end
    end
    return discId
end

-- Function to check if user has a specific role
local function HasRole(userRoles, roleName)
    if not Config.Roles[roleName] then
        if Config.Discord.Debug then
            print("[Discord Debug] Role not found in config:", roleName)
        end
        return false
    end

    local roleId = Config.Roles[roleName].roleId
    if type(userRoles) ~= 'table' then return false end
    
    for _, role in ipairs(userRoles) do
        if tostring(role) == tostring(roleId) then
            return true
        end
    end
    return false
end

-- Main event for checking roles and sending menu data to client
RegisterNetEvent('suu_drmenu:checkRoles', function()
    local src = source
    local discordId = GetDiscordId(src)
    local allowedMenus = {}
    
    -- Check if player has Discord ID
    if not discordId then
        if Config.Discord.Debug then
            print("[Discord Debug] No Discord ID found for player")
        end
        TriggerClientEvent('suu_drmenu:addMenus', src, allowedMenus)
        return
    end

    -- Get member data from Discord
    local endpoint = ('guilds/%s/members/%s'):format(Config.Discord.guildID, discordId)
    local member = discordRequest("GET", endpoint, {})

    if member.code ~= 200 then
        if Config.Discord.Debug then
            print("[Discord Debug] Failed to fetch member data")
        end
        TriggerClientEvent('suu_drmenu:addMenus', src, allowedMenus)
        return
    end

    local data = json.decode(member.data)
    local userRoles = data.roles

    -- Check which menus the player should have access to
    for menuName, menuData in pairs(Config.Menus) do
        if HasRole(userRoles, menuData.role) then
            allowedMenus[menuName] = true
        end
    end

    if Config.Discord.Debug then
        print("[Discord Debug] Allowed menus for player " .. src .. ":", json.encode(allowedMenus))
    end

    TriggerClientEvent('suu_drmenu:addMenus', src, allowedMenus)
end)

-- Test Discord connection when resource starts
AddEventHandler('onResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then return end
    
    local testEndpoint = 'users/@me'
    local test = discordRequest("GET", testEndpoint, {})
    
    if test.code == 200 then
        print('[Discord] Bot successfully connected!')
    else
        print('[Discord] Failed to connect bot. Check your token.')
    end
end)
