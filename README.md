# DR-Menu (Discord Radial Menu)
An addon for [rsg-radialmenu](https://github.com/Rexshack-RedM/rsg-radialmenu) that integrates Discord roles to provide dynamic, role-based menu access in RedM.

![Version](https://img.shields.io/badge/version-1.0.0-blue.svg)
![License](https://img.shields.io/badge/license-MIT-green.svg)
![RSG Core](https://img.shields.io/badge/rsg-core-red.svg)

## 🌟 Features
- Dynamic menu system based on Discord roles
- Easy configuration through a single file
- Real-time role verification
- Debug mode for easy troubleshooting
- Support for unlimited menus and sub-items
- Automatic cleanup on resource stop
- Seamless integration with rsg-radialmenu

Preview: https://youtu.be/UiZVDP3HF7w

## 📋 Dependencies
- [rsg-core](https://github.com/Rexshack-RedM/rsg-core)
- [rsg-radialmenu](https://github.com/Rexshack-RedM/rsg-radialmenu)
- Discord Server with Bot Access

## 🔄 Integration with RSG-RadialMenu
This script extends the functionality of rsg-radialmenu by:
- Adding dynamic menu management based on Discord roles
- Providing real-time role verification
- Allowing easy configuration of new menus
- Maintaining the original rsg-radialmenu structure and usage

## ⚙️ Installation
1. Create a folder named `dr-menu` in your resources directory
2. Copy the files into the folder
3. Configure the script in `config.lua`
4. Add to your `server.cfg` in this order:
```cfg
ensure rsg-core
ensure rsg-radialmenu
ensure dr-menu
```

## 🔧 Discord Bot Setup
1. Go to [Discord Developer Portal](https://discord.com/developers/applications)
2. Click "New Application"
3. Name your application
4. Go to the "Bot" section
   - Click "Add Bot"
   - Enable all Privileged Gateway Intents:
     - Presence Intent
     - Server Members Intent
     - Message Content Intent
5. Copy the bot token
6. Go to OAuth2 → URL Generator
   - Select "bot" scope
   - Select these bot permissions:
     - Read Messages/View Channels
     - View Server Insights
7. Use the generated URL to invite the bot to your server

## ⚡ Configuration
```lua
Config.Discord = {
    botToken = 'YOUR_BOT_TOKEN', -- Your Discord bot token
    guildID = 'YOUR_GUILD_ID',   -- Your Discord server ID
    Debug = true                 -- Enable debug messages
}

-- Define roles
Config.Roles = {
    Staff = {
        name = 'Staff',
        roleId = 'YOUR_STAFF_ROLE_ID'
    },
    VIP = {
        name = 'VIP',
        roleId = 'YOUR_VIP_ROLE_ID'
    }
}

-- Add menus
Config.Menus = {
    Staff = {
        id = 'staff_menu',
        title = 'Staff Menu',
        icon = 'user-tie',
        role = 'Staff', -- References role in Config.Roles
        items = {
            {
                id = 'unique_id',
                title = 'Menu Title',
                icon = 'icon-name',
                type = 'command', -- or 'client'
                event = 'event_name',
                shouldClose = true
            }
        }
    }
}
```

## 🎮 Adding New Menus
1. First, add your role in `Config.Roles` if it doesn't exist:
```lua
Config.Roles = {
    -- Existing roles...
    NewRole = {
        name = 'New Role Name',
        roleId = 'YOUR_ROLE_ID'
    }
}
```

2. Then add your menu in `Config.Menus`:
```lua
Config.Menus.NewMenu = {
    id = 'unique_menu_id',
    title = 'Menu Title',
    icon = 'font-awesome-icon',
    role = 'NewRole', -- References the role you created
    items = {
        {
            id = 'item_id',
            title = 'Item Title',
            icon = 'font-awesome-icon',
            type = 'client', -- or 'command'
            event = 'event_name',
            shouldClose = true
        }
    }
}
```

## 📦 Icons
The script uses FontAwesome icons. You can find the available icons at [FontAwesome](https://fontawesome.com/icons).

## 🛠️ Commands
- `/refreshmenus` - Refresh the menus manually

## 🔍 Debug Mode
Enable debug mode in config.lua to see detailed information in server/client console:
```lua
Config.Discord = {
    Debug = true
}
```

## ⚠️ Common Issues
1. **Menu not appearing**
   - Check if your Discord bot token is correct
   - Verify the role IDs
   - Enable debug mode and check the console
   - Make sure rsg-radialmenu is loaded before dr-menu
   
2. **Discord bot offline**
   - This is normal - the script uses API calls only
   - The bot doesn't need to be "online" to function

3. **Roles not updating**
   - Use `/refreshmenus` command
   - Check if the role IDs match your Discord server
   - Verify that your bot has the correct permissions

4. **Integration Issues**
   - Ensure you're using compatible versions of rsg-core and rsg-radialmenu
   - Check the load order in your server.cfg and place this ressource just after Framework ressources
   - Verify that rsg-radialmenu is working correctly on its own

## 🤝 Contributing
1. Fork the repository
2. Create a new branch: `git checkout -b feature/your-feature`
3. Make your changes
4. Push to the branch: `git push origin feature/your-feature`
5. Submit a pull request

## 📄 License
This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🔧 Support
For support:
1. Create an issue on the GitHub repository
2. Enable debug mode and provide logs
3. Provide your config (without sensitive information)

## 🙏 Credits
- RexshackGaming for rsg-radialmenu : https://github.com/Rexshack-RedM
- original creator : https://github.com/qbcore-framework/qb-radialmenu
- Developed for RSG Framework
- Integration with rsg-radialmenu
- Suu Yoshida : https://github.com/kozi4800

## ⚙️ Version History
- 1.0.0
  - Initial release
  - Discord role integration
  - Dynamic menu system
  - RSG-RadialMenu integration
