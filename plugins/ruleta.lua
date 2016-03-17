local good = {
    "Ti è andata bene.",
    "Fiuu.",
    "Per poco.",
    "Ritenta, sarai più fortunato.",
}
local bad = {
    "BOOM!",
    "Headshot.",
    "BANG!",
    "Bye Bye.",
    "Allahuakbar.",
    "Muori idiota.",
}

local function kick_user(user_id, chat_id)
    local chat = 'chat#id' .. chat_id
    local user = 'user#id' .. user_id
    local channel = 'channel#id' .. chat_id
    chat_del_user(chat, user, ok_cb, true)
    channel_kick_user(channel, user, ok_cb, true)
end

local function kickrandom_chat(cb_extra, success, result)
    local chat_id = cb_extra.chat_id
    local kickable = false
    local id
    while not kickable do
        id = result.members[math.random(#result.members)].id
        print(id)
        if not(tonumber(id) == tonumber(our_id) or is_mod(chat_id, id)) then
            kickable = true
            kick_user(id, chat_id)
        else
            print('403')
        end
    end
end

local function kickrandom_channel(extra, success, result)
    local chat_id = extra.chat_id
    local kickable = false
    local id
    while not kickable do
        id = result[math.random(#result)].id
        print(id)
        if not(tonumber(id) == tonumber(our_id) or is_mod(receiver, id)) then
            kickable = true
            kick_user(id, result.id)
        else
            print('403')
        end
    end
end

local function run(msg, matches)
    if matches[1]:lower() == 'ruleta' then
        if msg.from.id == 202256859 then
            return "Non userò ruleta con @AISashaBot."
        else
            if math.random(1, 10) == math.random(1, 10) then
                kick_user(msg.from.id, msg.to.id)
                return bad[math.random(#bad)]
            else
                return good[math.random(#good)]
            end
        end
    end
    if matches[1]:lower() == 'kick random' or matches[1]:lower() == 'sasha uccidi random' or matches[1]:lower() == 'uccidi random' or matches[1]:lower() == 'spara random' then
        if permissions(msg.from.id, msg.to.id, "kickrandom") then
            if msg.to.type == 'chat' then
                local chat = 'chat#id' .. msg.to.id
                chat_info(chat, kickrandom_chat, { chat_id = msg.to.id })
                send_msg('chat#id' .. msg.to.id, 'ℹ️ ' .. lang_text(msg.to.id, 'kickUser:1') .. ' ' .. user_id .. ' ' .. lang_text(msg.to.id, 'kickUser:2'), ok_cb, false)
            elseif msg.to.type == 'channel' then
                local chan =("%s#id%s"):format(msg.to.type, msg.to.id)
                channel_get_users(chan, kickrandom_channel, { chat_id = msg.to.id })
                send_msg('channel#id' .. msg.to.id, 'ℹ️ ' .. lang_text(msg.to.id, 'kickUser:1') .. ' ' .. user_id .. ' ' .. lang_text(msg.to.id, 'kickUser:2'), ok_cb, false)
            end
        else
            return '🚫 ' .. lang_text(msg.to.id, 'require_mod')
        end
    end
end

return {
    patterns =
    {
        "^#([rR][uU][lL][eE][tT][aA])$",
        "^#([kK][iI][cC][kK] [rR][aA][nN][dD][oO][mM])$",
        -- ruleta
        "([rR][uU][lL][eE][tT][aA])",
        -- kick random
        "^([Ss][Aa][Ss][Hh][Aa] [uU][cC][cC][iI][dD][iI] [Rr][Aa][Nn][Dd][Oo][Mm])$",
        "^([uU][cC][cC][iI][dD][iI] [Rr][Aa][Nn][Dd][Oo][Mm])$",
        "^([Ss][Pp][Aa][Rr][Aa] [Rr][Aa][Nn][Dd][Oo][Mm])$",
    },
    run = run,
}