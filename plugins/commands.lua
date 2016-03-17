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
    local space = '\n'
    local text = ''
    -- general info
    for i = 1, tonumber(lang_text(msg.to.id, 'generalInfo:0')), 1 do
        text = text .. lang_text(msg.to.id, 'generalInfo:' .. i) .. space
    end
    text = space .. text .. '#⃣ ' .. lang_text(msg.to.id, 'commandsT') .. ':' .. space
    if (matches[1]:lower() == 'commands' or matches[1]:lower() == 'help all' or matches[1]:lower() == 'sasha aiuto tutto') and not matches[2] then
        if permissions(msg.from.id, msg.to.id, "mod_commands") then
            local langHash = 'langset:' .. msg.to.id
            local lang = redis:get(langHash)
            for v, plugin in pairs(_config.enabled_plugins) do
                local textHash = 'lang:' .. lang .. ':' .. plugin .. ':0'
                if redis:get(textHash) then
                    for i = 1, tonumber(lang_text(msg.to.id, plugin .. ':0')), 1 do
                        text = text .. lang_text(msg.to.id, plugin .. ':' .. i) .. space
                    end
                    text = text .. space
                end
            end
        else
            text = text .. lang_text(msg.to.id, 'moderation:2') .. space
            text = text .. lang_text(msg.to.id, 'version:1') .. space
            text = text .. lang_text(msg.to.id, 'rules:1') .. space
        end
    elseif (matches[1]:lower() == 'commands' or matches[1]:lower() == 'help' or matches[1]:lower() == 'sasha aiuto') and matches[2] then
        if permissions(msg.from.id, msg.to.id, "mod_commands") then
            local langHash = 'langset:' .. msg.to.id
            local lang = redis:get(langHash)
            for v, plugin in pairs(_config.enabled_plugins) do
                if plugin == matches[2] then
                    local textHash = 'lang:' .. lang .. ':' .. plugin .. ':0'
                    if redis:get(textHash) then
                        for i = 1, tonumber(lang_text(msg.to.id, plugin .. ':0')), 1 do
                            text = text .. lang_text(msg.to.id, plugin .. ':' .. i) .. space
                        end
                    end
                    return text
                end
            end
            return 'ℹ️ ' .. lang_text(msg.to.id, 'errorNoPlug')
        else
            return '🚫 ' .. lang_text(msg.to.id, 'require_mod')
        end
    end
    return text
end

return {
    patterns =
    {
        "^[#!/]([Cc][Oo][Mm][Mm][Aa][Nn][Dd][sS])$",
        "^[#!/]([Cc][Oo][Mm][Mm][Aa][Nn][Dd][sS]) (.+)",
        -- commands
        "^[#!/]([hH][eE][lL][pP] [aA][lL][lL])$",
        "^[#!/]([hH][eE][lL][pP]) (.+)",
        "^([sS][aA][sS][hH][aA] [aA][iI][uU][tT][oO] [tT][uU][tT][tT][oO])$",
        "^([sS][aA][sS][hH][aA] [aA][iI][uU][tT][oO]) (.+)",
    },
    run = run
}