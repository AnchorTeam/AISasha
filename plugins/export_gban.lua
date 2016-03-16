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

local function run(msg, matches)
    if permissions(msg.from.id, msg.to.id, "export_gban") then
        if matches[1]:lower() == 'gbans' then
            local receiver = get_receiver(msg)
            if matches[2]:lower() == 'installer' then
                local text = 'local function run(msg)\nif permissions(msg.from.id, msg.to.id, "gban_installer") then\n'
                local count = 0
                for v, user in pairs(_gbans.gbans_users) do
                    text = text .. 'gban_id(' .. user .. ')\n'
                    count = count + 1
                end

                local text = text .. [[
                        if msg.to.type == 'chat' then
                            send_msg('chat#id'..msg.to.id, ']] .. count .. ' ' .. lang_text(msg.to.id, 'accountsGban') .. [[ ☠', ok_cb, false)
                        elseif msg.to.type == 'channel' then
                            send_msg('channel#id'..msg.to.id, ']] .. count .. ' ' .. lang_text(msg.to.id, 'accountsGban') .. [[ ☠', ok_cb, false)
                        end
                        else
                            return '🚫 '..lang_text(msg.to.id, 'require_sudo')
                        end
                    end

                        return {
                            description = 'Add gbans into your bot. A gbanlist command.',
                            usage = {},
                            patterns = {
                                "^#([iI][nN][sS][tT][aA][lL][lL]) ([Gg][Bb][Aa][Nn][Ss])$"
                            },
                            run = run
                        }]]

                local file = io.open("./plugins/gban_installer.lua", "w")
                file:write(text)
                file:close()

                send_document(receiver, './plugins/gban_installer.lua', ok_cb, false)
            elseif matches[2]:lower() == 'list' then
                send_document(receiver, './data/gbans.lua', ok_cb, false)
            end
        end
    else
        return '🚫 ' .. lang_text(msg.to.id, 'require_admin')
    end
end

return {
    patterns =
    {
        "^#([Gg][Bb][Aa][Nn][Ss]) (.*)$"
    },
    run = run
}
