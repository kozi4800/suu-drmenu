Config = {}

-- Discord Configuration
Config.Discord = {
    botToken = 'YOUR_BOT_TOKEN',
    guildID = 'YOUR_GUILD_ID',
    Debug = false
}

-- Define all roles and their IDs in one place
Config.Roles = {
    Staff = {
        name = 'Staff',
        roleId = 'YOUR_ROLE_ID'
    },
    VIP = {
        name = 'VIP',
        roleId = 'YOUR_ROLE_ID'
    }
    -- Add more roles here as needed
}

-- Menu Configuration
Config.Menus = {
    -- Staff Menu Configuration
    Staff = {
        id = 'staff_menu',
        title = 'Staff',
        icon = 'user-tie',
        role = 'Staff', -- References role in Config.Roles
        items = {
            {
                id = 'staff_adminmenu',
                title = 'Admin Menu',
                icon = 'screwdriver-wrench',
                type = 'command',
                event = 'adminmenu',
                shouldClose = true
            },
            {
                id = 'staff_doorlock',
                title = 'Door Lock',
                icon = 'door-open',
                type = 'command',
                event = 'doorlock',
                shouldClose = true
            },
            {
                id = 'staff_tx',
                title = 'TX',
                icon = 'gavel',
                type = 'command',
                event = 'tx',
                shouldClose = true
            }
        }
    },
    -- VIP Menu Configuration
    VIP = {
        id = 'vip_menu',
        title = 'VIP',
        icon = 'crown',
        role = 'VIP', -- References role in Config.Roles
        items = {
            {
                id = 'Store',
                title = 'Store',
                icon = 'store',
                type = 'command',
                event = 'shop',
                shouldClose = true
            }
            -- Add more VIP items here
        }
    }
    -- Add more menus here as needed
}
