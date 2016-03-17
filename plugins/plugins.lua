--------------------------------------------------
--      ____  ____ _____                        --
--     |    \|  _ )_   _|___ ____   __  __      --
--     | |_  )  _ \ | |/ ·__|  _ \_|  \/  |     --
--     |____/|____/ |_|\____/\_____|_/\/\_|     --
--                                              --
--------------------------------------------------
--                                              --
--       Developers: @Josepdal & @MaSkAoS       --
--     Support: @Skneos,  @iicc1 & @serx666     --
--                                              --
--------------------------------------------------

do

    to_id = ""

    -- Returns the key (index) in the config.enabled_plugins table
    local function plugin_enabled(name)
        for k, v in pairs(_config.enabled_plugins) do
            if name == v then
                return k
            end
        end
        -- If not found
        return false
    end

    -- Returns true if file exists in plugins folder
    local function plugin_exists(name)
        for k, v in pairs(plugins_names()) do
            if name .. '.lua' == v then
                return true
            end
        end
        return false
    end

    local function list_plugins(only_enabled)
        local text = 'ℹ️ ' .. lang_text(to_id, 'plugins') .. ':\n'
        local psum = 0
        for k, v in pairs(plugins_names()) do
            --  ✅ enabled, ❌ disabled
            local status = '❌'
            psum = psum + 1
            pact = 0
            -- Check if is enabled
            for k2, v2 in pairs(_config.enabled_plugins) do
                if v == v2 .. '.lua' then
                    status = '✅'
                end
                pact = pact + 1
            end
            if not only_enabled or status == '✅' then
                -- get the name
                v = string.match(v, "(.*)%.lua")
                text = text .. status .. '  ' .. v .. '\n'
            end
        end
        local text = text .. '\n🔢 ' .. psum .. ' ' .. lang_text(to_id, 'installedPlugins') .. '\n✅ '
        .. pact .. ' ' .. lang_text(to_id, 'pEnabled') .. '\n❌ ' .. psum - pact .. ' ' .. lang_text(to_id, 'pDisabled') .. ''
        return text
    end

    local function reload_plugins()
        plugins = { }
        load_plugins()
        return list_plugins(true)
    end


    local function enable_plugin(plugin_name)
        print('checking if ' .. plugin_name .. ' exists')
        -- Check if plugin is enabled
        if plugin_enabled(plugin_name) then
            return 'ℹ️ ' .. lang_text(to_id, 'isEnabled:1') .. ' ' .. plugin_name .. ' ' .. lang_text(to_id, 'isEnabled:2')
        end
        -- Checks if plugin exists
        if plugin_exists(plugin_name) then
            -- Add to the config table
            table.insert(_config.enabled_plugins, plugin_name)
            print(plugin_name .. ' added to _config table')
            save_config()
            -- Reload the plugins
            return reload_plugins()
        else
            return '⚠️ ' .. lang_text(to_id, 'notExist:1') .. ' ' .. plugin_name .. ' ' .. lang_text(to_id, 'notExist:2')
        end
    end

    local function disable_plugin(name, chat)
        -- Check if plugins exists
        if not plugin_exists(name) then
            return '⚠️ ' .. lang_text(to_id, 'notExist:1') .. ' ' .. name .. ' ' .. lang_text(to_id, 'notExist:2')
        end
        local k = plugin_enabled(name)
        -- Check if plugin is enabled
        if not k then
            return 'ℹ️ ' .. lang_text(to_id, 'notEnabled:1') .. ' ' .. name .. ' ' .. lang_text(to_id, 'notEnabled:2')
        end
        -- Disable and reload
        table.remove(_config.enabled_plugins, k)
        save_config()
        return reload_plugins(true)
    end

    local function disable_plugin_on_chat(receiver, plugin)
        if not plugin_exists(plugin) then
            return '⚠️ ' .. lang_text(to_id, 'pNotExists')
        end

        if not _config.disabled_plugin_on_chat then
            _config.disabled_plugin_on_chat = { }
        end

        if not _config.disabled_plugin_on_chat[receiver] then
            _config.disabled_plugin_on_chat[receiver] = { }
        end

        _config.disabled_plugin_on_chat[receiver][plugin] = true

        save_config()
        return 'ℹ️ ' .. lang_text(to_id, 'pDisChat:1') .. ' ' .. plugin .. ' ' .. lang_text(to_id, 'pDisChat:2')
    end

    local function reenable_plugin_on_chat(receiver, plugin)
        if not _config.disabled_plugin_on_chat then
            return 'ℹ️ ' .. lang_text(to_id, 'anyDisPlugin')
        end

        if not _config.disabled_plugin_on_chat[receiver] then
            return 'ℹ️ ' .. lang_text(to_id, 'anyDisPluginChat')
        end

        if not _config.disabled_plugin_on_chat[receiver][plugin] then
            return 'ℹ️ ' .. lang_text(to_id, 'notDisabled')
        end

        _config.disabled_plugin_on_chat[receiver][plugin] = false
        save_config()
        return 'ℹ️ ' .. lang_text(to_id, 'enabledAgain:1') .. ' ' .. plugin .. ' ' .. lang_text(to_id, 'enabledAgain:2')
    end

    local function run(msg, matches)
        to_id = msg.to.id
        -- Show the available plugins
        if permissions(msg.from.id, msg.to.id, "plugins") then
            if matches[1]:lower() == '#plugins' or matches[1]:lower() == '!plugins' or matches[1]:lower() == '/plugins' or matches[1]:lower() == 'sasha lista plugins' or matches[1]:lower() == 'lista plugins' then
                return list_plugins()
            end

            -- Enable a plugin
            if matches[1]:lower() == 'enable' or matches[1]:lower() == 'sasha abilita' or matches[1]:lower() == 'sasha attiva' or matches[1]:lower() == 'abilita' or matches[1]:lower() == 'attiva' then
                local plugin_name = matches[2]
                print("enable: " .. matches[2])
                return enable_plugin(plugin_name)
            end

            -- Re-enable a plugin for this chat
            if (matches[1]:lower() == 'enable' or matches[1]:lower() == 'sasha abilita' or matches[1]:lower() == 'sasha attiva' or matches[1]:lower() == 'abilita' or matches[1]:lower() == 'attiva') and matches[3]:lower() == 'chat' then
                local receiver = get_receiver(msg)
                local plugin = matches[2]
                print("enable " .. plugin .. ' on this chat')
                return reenable_plugin_on_chat(receiver, plugin)
            end

            -- Disable a plugin
            if matches[1]:lower() == 'disable' or matches[1]:lower() == 'sasha disabilita' or matches[1]:lower() == 'sasha disattiva' or matches[1]:lower() == 'disabilita' or matches[1]:lower() == 'disattiva' then
                print("disable: " .. matches[2])
                return disable_plugin(matches[2])
            end

            -- Disable a plugin on a chat
            if (matches[1]:lower() == 'disable' or matches[1]:lower() == 'sasha disabilita' or matches[1]:lower() == 'sasha disattiva' or matches[1]:lower() == 'disabilita' or matches[1]:lower() == 'disattiva') and matches[3]:lower() == 'chat' then
                local plugin = matches[2]
                local receiver = get_receiver(msg)
                print("disable " .. plugin .. ' on this chat')
                return disable_plugin_on_chat(receiver, plugin)
            end

            -- Reload all the plugins!
            if matches[1]:lower() == 'reload' or matches[1]:lower() == 'sasha ricarica' or matches[1]:lower() == 'ricarica' then
                return reload_plugins(true)
            end
        else
            return '🚫 ' .. lang_text(msg.to.id, 'require_sudo')
        end
    end

    return {
        patterns =
        {
            "^[#!/][Pp][Ll][Uu][Gg][Ii][Nn][Ss]$",
            "^[#!/][Pp][Ll][Uu][Gg][Ii][Nn][Ss]? ([Ee][Nn][Aa][Bb][Ll][Ee]) ([%w_%.%-]+)$",
            "^[#!/][Pp][Ll][Uu][Gg][Ii][Nn][Ss]? ([Dd][Ii][Ss][Aa][Bb][Ll][Ee]) ([%w_%.%-]+)$",
            "^[#!/][Pp][Ll][Uu][Gg][Ii][Nn][Ss]? ([Ee][Nn][Aa][Bb][Ll][Ee]) ([%w_%.%-]+) ([Cc][Hh][Aa][Tt])",
            "^[#!/][Pp][Ll][Uu][Gg][Ii][Nn][Ss]? ([Dd][Ii][Ss][Aa][Bb][Ll][Ee]) ([%w_%.%-]+) ([Cc][Hh][Aa][Tt])",
            "^[#!/][Pp][Ll][Uu][Gg][Ii][Nn][Ss]? ([Rr][Ee][Ll][Oo][Aa][Dd])$",
            -- plugins
            "^[#!/]([Ee][Nn][Aa][Bb][Ll][Ee]) ([%w_%.%-]+)$",
            "^[#!/]([Dd][Ii][Ss][Aa][Bb][Ll][Ee]) ([%w_%.%-]+)$",
            "^[#!/]([Ee][Nn][Aa][Bb][Ll][Ee]) ([%w_%.%-]+) ([Cc][Hh][Aa][Tt])",
            "^[#!/]([Dd][Ii][Ss][Aa][Bb][Ll][Ee]) ([%w_%.%-]+) ([Cc][Hh][Aa][Tt])",
            "^[#!/]([Rr][Ee][Ll][Oo][Aa][Dd])$",
            "^[Ss][Aa][Ss][Hh][Aa] [Ll][Ii][Ss][Tt][Aa] [Pp][Ll][Uu][Gg][Ii][Nn][Ss]$",
            "^[Ss][Aa][Ss][Hh][Aa] ([Aa][Bb][Ii][Ll][Ii][Tt][Aa]) ([%w_%.%-]+)$",
            "^[Ss][Aa][Ss][Hh][Aa] ([Dd][Ii][Ss][Aa][Bb][Ii][Ll][Ii][Tt][Aa]) ([%w_%.%-]+)$",
            "^[Ss][Aa][Ss][Hh][Aa] ([Aa][Bb][Ii][Ll][Ii][Tt][Aa]) ([%w_%.%-]+) ([Cc][Hh][Aa][Tt])",
            "^[Ss][Aa][Ss][Hh][Aa] ([Dd][Ii][Ss][Aa][Bb][Ii][Ll][Ii][Tt][Aa]) ([%w_%.%-]+) ([Cc][Hh][Aa][Tt])",
            "^[Ss][Aa][Ss][Hh][Aa] ([Aa][Tt][Tt][Ii][Vv][Aa]) ([%w_%.%-]+)$",
            "^[Ss][Aa][Ss][Hh][Aa] ([Dd][Ii][Ss][Aa][Tt][Tt][Ii][Vv][Aa]) ([%w_%.%-]+)$",
            "^[Ss][Aa][Ss][Hh][Aa] ([Aa][Tt][Tt][Ii][Vv][Aa]) ([%w_%.%-]+) ([Cc][Hh][Aa][Tt])",
            "^[Ss][Aa][Ss][Hh][Aa] ([Dd][Ii][Ss][Aa][Tt][Tt][Ii][Vv][Aa]) ([%w_%.%-]+) ([Cc][Hh][Aa][Tt])",
            "^[Ss][Aa][Ss][Hh][Aa] ([rR][iI][cC][aA][rR][iI][cC][aA])$",
            "^[Ll][Ii][Ss][Tt][Aa] [Pp][Ll][Uu][Gg][Ii][Nn][Ss]$",
            "^([Aa][Bb][Ii][Ll][Ii][Tt][Aa]) ([%w_%.%-]+)$",
            "^([Dd][Ii][Ss][Aa][Bb][Ii][Ll][Ii][Tt][Aa]) ([%w_%.%-]+)$",
            "^([Aa][Bb][Ii][Ll][Ii][Tt][Aa]) ([%w_%.%-]+) ([Cc][Hh][Aa][Tt])",
            "^([Dd][Ii][Ss][Aa][Bb][Ii][Ll][Ii][Tt][Aa]) ([%w_%.%-]+) ([Cc][Hh][Aa][Tt])",
            "^([Aa][Tt][Tt][Ii][Vv][Aa]) ([%w_%.%-]+)$",
            "^([Dd][Ii][Ss][Aa][Tt][Tt][Ii][Vv][Aa]) ([%w_%.%-]+)$",
            "^([Aa][Tt][Tt][Ii][Vv][Aa]) ([%w_%.%-]+) ([Cc][Hh][Aa][Tt])",
            "^([Dd][Ii][Ss][Aa][Tt][Tt][Ii][Vv][Aa]) ([%w_%.%-]+) ([Cc][Hh][Aa][Tt])",
            "^([Rr][Ii][Cc][Aa][Rr][Ii][Cc][Aa])$",
        },
        run = run
    }

end