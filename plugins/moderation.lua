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

local function is_muted_user(user_id, chat_id)
    local hash = 'muted:' .. chat_id .. ':user'
    local muted = redis:hget(hash, user_id)
    return muted or false
end

local function mute_user(user_id, chat_id)
    local hash = 'muted:' .. chat_id .. ':user'
    redis:hset(hash, user_id, true)
end

local function unmute_user(user_id, chat_id)
    local hash = 'muted:' .. chat_id .. ':user'
    redis:hdel(hash, user_id)
end

local function muted_list(chat_id)
    local hash = 'muted:' .. chat_id .. ':user'
    local users = redis:hkeys(hash)
    local text = ''
    for i = 1, #users do
        text = text .. users[i] .. '\n'
    end
    return text
end

local function mute_by_reply(extra, success, result)
    result = backward_msg_format(result)
    local msg = result
    local chat = msg.to.id
    local user = msg.from.id
    local name = msg.from.username
    mute_user(user, chat)
    if msg.to.type == 'chat' then
        send_msg('chat#id' .. chat, 'ℹ️ ' .. lang_text(chat, 'userMuted:1') .. ' ' .. name .. ' (' .. user .. ') ' .. lang_text(chat, 'userMuted:2'), ok_cb, true)
    elseif msg.to.type == 'channel' then
        send_msg('channel#id' .. chat, 'ℹ️ ' .. lang_text(chat, 'userMuted:1') .. ' ' .. name .. ' (' .. user .. ') ' .. lang_text(chat, 'userMuted:2'), ok_cb, true)
    end
end

local function unmute_by_reply(extra, success, result)
    result = backward_msg_format(result)
    local msg = result
    local chat = msg.to.id
    local user = msg.from.id
    local name = msg.from.username
    unmute_user(user, chat)
    if msg.to.type == 'chat' then
        send_msg('chat#id' .. chat, 'ℹ️ ' .. lang_text(chat, 'userUnmuted:1') .. ' ' .. name .. ' (' .. user .. ') ' .. lang_text(chat, 'userUnmuted:2'), ok_cb, true)
    elseif msg.to.type == 'channel' then
        send_msg('channel#id' .. chat, 'ℹ️ ' .. lang_text(chat, 'userUnmuted:1') .. ' ' .. name .. ' (' .. user .. ') ' .. lang_text(chat, 'userUnmuted:2'), ok_cb, true)
    end
end

local function mute_by_username(cb_extra, success, result)
    chat_type = cb_extra.chat_type
    chat_id = cb_extra.chat_id
    user_id = result.peer_id
    user_username = result.username
    mute_user(user_id, chat_id)
    if chat_type == 'chat' then
        send_msg('chat#id' .. chat_id, 'ℹ️ ' .. lang_text(chat_id, 'userMuted:1') .. ' ' .. user_username .. ' (' .. user_id .. ') ' .. lang_text(chat_id, 'userMuted:2'), ok_cb, true)
    elseif chat_type == 'channel' then
        send_msg('channel#id' .. chat_id, 'ℹ️ ' .. lang_text(chat_id, 'userMuted:1') .. ' ' .. user_username .. ' (' .. user_id .. ') ' .. lang_text(chat_id, 'userMuted:2'), ok_cb, true)
    end
end

local function unmute_by_username(cb_extra, success, result)
    chat_type = cb_extra.chat_type
    chat_id = cb_extra.chat_id
    user_id = result.peer_id
    user_username = result.username
    unmute_user(user_id, chat_id)
    if chat_type == 'chat' then
        send_msg('chat#id' .. chat_id, 'ℹ️ ' .. lang_text(chat_id, 'userMuted:1') .. ' ' .. user_username .. ' (' .. user_id .. ') ' .. lang_text(chat_id, 'userUnmuted:2'), ok_cb, true)
    elseif chat_type == 'channel' then
        send_msg('channel#id' .. chat_id, 'ℹ️ ' .. lang_text(chat_id, 'userMuted:1') .. ' ' .. user_username .. ' (' .. user_id .. ') ' .. lang_text(chat_id, 'userUnmuted:2'), ok_cb, true)
    end
end

local function kick_user(user_id, chat_id)
    local chat = 'chat#id' .. chat_id
    local user = 'user#id' .. user_id
    local channel = 'channel#id' .. chat_id
    if user_id == tostring(our_id) then
        print("I won't kick myself!")
    else
        chat_del_user(chat, user, ok_cb, true)
        channel_kick_user(channel, user, ok_cb, true)
    end
end

local function kick_by_reply(extra, success, result)
    result = backward_msg_format(result)
    local msg = result
    local chat = msg.to.id
    local user = msg.from.id
    local chat_type = msg.to.type
    kick_user(user, chat)
    if chat_type == 'chat' then
        send_msg('chat#id' .. chat, 'ℹ️ ' .. lang_text(chat, 'kickUser:1') .. ' ' .. user .. ' ' .. lang_text(chat, 'kickUser:2'), ok_cb, true)
    elseif chat_type == 'channel' then
        send_msg('channel#id' .. chat, 'ℹ️ ' .. lang_text(chat, 'kickUser:1') .. ' ' .. user .. ' ' .. lang_text(chat, 'kickUser:2'), ok_cb, true)
    end
end

local function kick_by_username(cb_extra, success, result)
    chat_id = cb_extra.chat_id
    user_id = result.peer_id
    chat_type = cb_extra.chat_type
    user_username = result.username
    kick_user(user_id, chat_id)
    if chat_type == 'chat' then
        send_msg('chat#id' .. chat_id, 'ℹ️ ' .. lang_text(chat_id, 'kickUser:1') .. ' @' .. user_username .. ' (' .. user_id .. ') ' .. lang_text(chat_id, 'kickUser:2'), ok_cb, false)
    elseif chat_type == 'channel' then
        send_msg('channel#id' .. chat_id, 'ℹ️ ' .. lang_text(chat_id, 'kickUser:1') .. ' @' .. user_username .. ' (' .. user_id .. ') ' .. lang_text(chat_id, 'kickUser:2'), ok_cb, false)
    end
end

local function kickidsnouser_chat(cb_extra, success, result)
    local chat_id = cb_extra.chat_id
    for k, v in pairs(result.members) do
        if not v.username then
            print(v.id .. " kicked from group " .. chat_id)
            kick_user(v.id, chat_id)
        end
    end
end

local function kickidsnouser_channel(extra, success, result)
    local chat_id = cb_extra.chat_id
    for k, v in ipairs(result) do
        if not v.username then
            print(v.id .. " kicked from channel " .. chat_id)
            kick_user(v.id, chat_id)
        end
    end
end

local function is_banned(user_id, chat_id)
    local hash = 'banned:' .. chat_id
    local banned = redis:sismember(hash, user_id)
    return banned or false
end

local function ban_user(user_id, chat_id)
    if user_id == tostring(our_id) then
        print('I won\'t ban myself!')
    else
        -- Save to redis
        local hash = 'banned:' .. chat_id
        redis:sadd(hash, user_id)
        kick_user(user_id, chat_id)
    end
end

local function unban_user(user_id, chat_id)
    local hash = 'banned:' .. chat_id
    redis:srem(hash, user_id)
end

local function ban_list(chat_id)
    local hash = 'banned:' .. chat_id
    local list = redis:smembers(hash)
    local text = ''
    for k, v in pairs(list) do
        text = text .. k .. " - " .. v .. "\n"
    end
    return text
end

local function ban_by_reply(extra, success, result)
    result = backward_msg_format(result)
    local msg = result
    local chat = msg.to.id
    local user = msg.from.id
    local chat_type = msg.to.type
    ban_user(user, chat)
    if chat_type == 'chat' then
        send_msg('chat#id' .. chat, 'ℹ️ ' .. lang_text(chat, 'banUser:1') .. ' ' .. user .. ' ' .. lang_text(chat, 'banUser:2'), ok_cb, true)
    elseif chat_type == 'channel' then
        send_msg('channel#id' .. chat, 'ℹ️ ' .. lang_text(chat, 'banUser:1') .. ' ' .. user .. ' ' .. lang_text(chat, 'banUser:2'), ok_cb, true)
    end
end

local function unban_by_reply(extra, success, result)
    result = backward_msg_format(result)
    local msg = result
    local chat = msg.to.id
    local user = msg.from.id
    local chat_type = msg.to.type
    unban_user(user, chat)
    if chat_type == 'chat' then
        send_msg('chat#id' .. chat, 'User ' .. user .. ' unbanned', ok_cb, true)
    elseif chat_type == 'channel' then
        send_msg('channel#id' .. chat, 'User ' .. user .. ' unbanned', ok_cb, true)
    end
end

local function ban_by_username(cb_extra, success, result)
    chat_type = cb_extra.chat_type
    chat_id = cb_extra.chat_id
    user_id = result.peer_id
    user_username = result.username
    ban_user(user_id, chat_id)
    if chat_type == 'chat' then
        send_msg('chat#id' .. chat_id, 'ℹ️ ' .. lang_text(chat_id, 'banUser:1') .. ' @' .. user_username .. ' (' .. user_id .. ') ' .. lang_text(chat_id, 'banUser:2'), ok_cb, false)
    elseif chat_type == 'channel' then
        send_msg('channel#id' .. chat_id, 'ℹ️ ' .. lang_text(chat_id, 'banUser:1') .. ' @' .. user_username .. ' (' .. user_id .. ') ' .. lang_text(chat_id, 'banUser:2'), ok_cb, false)
    end
end

local function unban_by_username(cb_extra, success, result)
    chat_type = cb_extra.chat_type
    chat_id = cb_extra.chat_id
    user_id = result.peer_id
    user_username = result.username
    unban_user(user_id, chat_id)
    if chat_type == 'chat' then
        send_msg('chat#id' .. chat_id, 'ℹ️ ' .. lang_text(chat_id, 'unbanUser:1') .. ' @' .. user_username .. ' (' .. user_id .. ') ' .. lang_text(chat_id, 'unbanUser:2'), ok_cb, false)
    elseif chat_type == 'channel' then
        send_msg('channel#id' .. chat_id, 'ℹ️ ' .. lang_text(chat_id, 'unbanUser:1') .. ' @' .. user_username .. ' (' .. user_id .. ') ' .. lang_text(chat_id, 'unbanUser:2'), ok_cb, false)
    end
end

local function is_gbanned(user_id)
    local hash = 'gban'
    local banned = redis:sismember(hash, user_id)
    return banned or false
end

local function gban_user(user_id)
    if user_id == tostring(our_id) then
        print('I won\'t gban myself!')
    else
        -- Save to redis
        local hash = 'gban'
        redis:sadd(hash, user_id)
    end
end

local function ungban_user(user_id)
    local hash = 'gban'
    redis:srem(hash, user_id)
end

local function gban_list()
    local hash = 'gban'
    local list = redis:smembers(hash)
    local text = ''
    for k, v in pairs(list) do
        text = text .. k .. ' - ' .. v .. '\n'
    end
    return text
end

local function gban_by_reply(extra, success, result)
    result = backward_msg_format(result)
    local msg = result
    local chat = msg.to.id
    local user = msg.from.id
    gban_user(user)
    kick_user(user, chat)
    if msg.to.type == 'chat' then
        send_msg('chat#id' .. chat, 'ℹ️ ' .. lang_text(chat, 'gbanUser:1') .. ' ' .. user .. ' ' .. lang_text(chat, 'gbanUser:2'), ok_cb, true)
    elseif msg.to.type == 'channel' then
        send_msg('channel#id' .. chat, 'ℹ️ ' .. lang_text(chat, 'gbanUser:1') .. ' ' .. user .. ' ' .. lang_text(chat, 'gbanUser:2'), ok_cb, true)
    end
end

local function ungban_by_reply(extra, success, result)
    result = backward_msg_format(result)
    local msg = result
    local chat = msg.to.id
    local user = msg.from.id
    ungban_user(user)
    if msg.to.type == 'chat' then
        send_msg('chat#id' .. chat, 'ℹ️ ' .. lang_text(chat, 'ungbanUser:1') .. ' ' .. user .. ' ' .. lang_text(chat, 'ungbanUser:2'), ok_cb, true)
    elseif msg.to.type == 'channel' then
        send_msg('channel#id' .. chat, 'ℹ️ ' .. lang_text(chat, 'ungbanUser:1') .. ' ' .. user .. ' ' .. lang_text(chat, 'ungbanUser:2'), ok_cb, true)
    end
end

local function gban_by_username(cb_extra, success, result)
    local chat_id = cb_extra.chat_id
    local user_id = result.peer_id
    local user_username = result.username
    local chat_type = cb_extra.chat_type
    gban_user(user_id)
    kick_user(user_id, chat_id)
    if chat_type == 'chat' then
        send_msg('chat#id' .. chat_id, 'ℹ️ ' .. lang_text(chat_id, 'gbanUser:1') .. ' @' .. user_username .. ' (' .. user_id .. ') ' .. lang_text(chat_id, 'gbanUser:2'), ok_cb, false)
    elseif chat_type == 'channel' then
        send_msg('channel#id' .. chat_id, 'ℹ️ ' .. lang_text(chat_id, 'gbanUser:1') .. ' @' .. user_username .. ' (' .. user_id .. ') ' .. lang_text(chat_id, 'gbanUser:2'), ok_cb, false)
    end
end

local function ungban_by_username(cb_extra, success, result)
    local chat_id = cb_extra.chat_id
    local user_id = result.peer_id
    local user_username = result.username
    local chat_type = cb_extra.chat_type
    ungban_user(user_id)
    if chat_type == 'chat' then
        send_msg('chat#id' .. chat_id, 'ℹ️ ' .. lang_text(chat_id, 'ungbanUser:1') .. ' @' .. user_username .. ' (' .. user_id .. ') ' .. lang_text(chat_id, 'ungbanUser:2'), ok_cb, false)
    elseif chat_type == 'channel' then
        send_msg('channel#id' .. chat_id, 'ℹ️ ' .. lang_text(chat_id, 'ungbanUser:1') .. ' @' .. user_username .. ' (' .. user_id .. ') ' .. lang_text(chat_id, 'ungbanUser:2'), ok_cb, false)
    end
end

local function add_user(user_id, chat_id)
    local chat = 'chat#id' .. chat_id
    local user = 'user#id' .. user_id
    local channel = 'channel#id' .. chat_id
    chat_add_user(chat, user, ok_cb, false)
    channel_invite_user(channel, user, ok_cb, false)
end

local function add_by_reply(extra, success, result)
    result = backward_msg_format(result)
    local msg = result
    local chat = msg.to.id
    local user = msg.from.id
    local chat_type = msg.to.type
    add_user(user, chat)
    if chat_type == 'chat' then
        send_msg('chat#id' .. chat, 'ℹ️ ' .. lang_text(chat, 'addUser:1') .. ' ' .. user .. ' ' .. lang_text(chat, 'addUser:2'), ok_cb, true)
    elseif chat_type == 'channel' then
        send_msg('channel#id' .. chat, 'ℹ️ ' .. lang_text(chat, 'addUser:1') .. ' ' .. user .. ' ' .. lang_text(chat, 'addUser:3'), ok_cb, true)
    end
end

local function add_by_username(cb_extra, success, result)
    local chat_type = cb_extra.chat_type
    local chat_id = cb_extra.chat_id
    local user_id = result.peer_id
    local user_username = result.username
    add_user(user_id, chat_id)
    if chat_type == 'chat' then
        send_msg('chat#id' .. chat_id, 'ℹ️ ' .. lang_text(chat_id, 'addUser:1') .. ' @' .. user_username .. ' (' .. user_id .. ') ' .. lang_text(chat_id, 'addUser:2'), ok_cb, false)
    elseif chat_type == 'channel' then
        send_msg('channel#id' .. chat_id, 'ℹ️ ' .. lang_text(chat_id, 'addUser:1') .. ' @' .. user_username .. ' (' .. user_id .. ') ' .. lang_text(chat_id, 'addUser:3'), ok_cb, false)
    end
end

local function pre_process(msg)
    -- Checking mute
    if is_muted_user(msg.from.id, msg.to.id) then
        if msg.to.type == 'chat' then
            delete_msg(msg.id, ok_cb, true)
        elseif msg.to.type == 'channel' then
            delete_msg(msg.id, ok_cb, true)
        end
    end

    -- SERVICE MESSAGE
    if msg.action and msg.action.type then
        local action = msg.action.type
        -- Check if banned user joins chat
        if action == 'chat_add_user' or action == 'chat_add_user_link' then
            local user_id
            local hash = 'lockmember:' .. msg.to.id
            if redis:get(hash) then
                if msg.action.link_issuer then
                    user_id = msg.from.id
                else
                    user_id = msg.action.user.id
                end
                kick_user(user_id, msg.to.id)
                delete_msg(msg.id, ok_cb, true)
            end
            if msg.action.link_issuer then
                user_id = msg.from.id
            else
                user_id = msg.action.user.id
            end
            print('Checking invited user ' .. user_id)
            local banned = is_banned(user_id, msg.to.id) or is_gbanned(user_id)
            if banned then
                print('User is banned!')
                kick_user(user_id, msg.to.id)
            end
        end
        -- No further checks
        return msg
    end

    -- BANNED USER TALKING
    if msg.to.type == 'chat' or msg.to.type == 'channel' then
        local user_id = msg.from.id
        local chat_id = msg.to.id
        local banned = is_banned(user_id, chat_id) or is_gbanned(user_id, msg.to.id)
        if banned then
            print('Banned user talking!')
            ban_user(user_id, chat_id)
            kick_user(user_id, chat_id)
            msg.text = ''
        end
        hash = 'antibot:' .. msg.to.id
        if redis:get(hash) then
            if string.sub(msg.from.username,(string.len(msg.from.username) -2), string.len(msg.from.username)) == 'bot' then
                kick_user(user_id, chat_id)
            end
        end
    end
    return msg
end

local function run(msg, matches)
    local chat_id = msg.to.id
    local chat_type = msg.to.type
    local user_id
    local member
    if matches[1]:lower() == 'mute' or matches[1]:lower() == 'sasha togli voce' or matches[1]:lower() == 'togli voce' then
        if permissions(msg.from.id, msg.to.id, "mute") then
            if msg.reply_id then
                get_message(msg.reply_id, mute_by_reply, false)
                return
            end
            if not is_id(matches[2]) then
                member = string.gsub(matches[2], '@', '')
                resolve_username(member, mute_by_username, { chat_id = chat_id, member = member, chat_type = chat_type })
                return
            else
                user_id = matches[2]
                mute_user(user, chat_id)
                if msg.to.type == 'chat' then
                    send_msg('chat#id' .. msg.to.id, 'ℹ️ ' .. lang_text(chat_id, 'userMuted:1') .. ' ' .. matches[2] .. ' ' .. lang_text(chat_id, 'userMuted:2'), ok_cb, true)
                elseif msg.to.type == 'channel' then
                    send_msg('channel#id' .. msg.to.id, 'ℹ️ ' .. lang_text(chat_id, 'userMuted:1') .. ' ' .. matches[2] .. ' ' .. lang_text(chat_id, 'userMuted:2'), ok_cb, true)
                end
                return
            end
        else
            return '🚫 ' .. lang_text(msg.to.id, 'require_mod')
        end
    elseif matches[1]:lower() == 'unmute' or matches[1]:lower() == 'sasha dai voce' or matches[1]:lower() == 'dai voce' then
        if permissions(msg.from.id, msg.to.id, "unmute") then
            if msg.reply_id then
                get_message(msg.reply_id, unmute_by_reply, false)
                return
            end
            if not is_id(matches[2]) then
                member = string.gsub(matches[2], '@', '')
                resolve_username(member, unmute_by_username, { chat_id = chat_id, member = member, chat_type = chat_type })
                return
            else
                user_id = matches[2]
                unmute_user(user, chat_id)
                if msg.to.type == 'chat' then
                    send_msg('chat#id' .. msg.to.id, 'ℹ️ ' .. lang_text(chat_id, 'userUnmuted:1') .. ' ' .. matches[2] .. ' ' .. lang_text(chat_id, 'userUnmuted:2'), ok_cb, true)
                elseif msg.to.type == 'channel' then
                    send_msg('channel#id' .. msg.to.id, 'ℹ️ ' .. lang_text(chat_id, 'userUnmuted:1') .. ' ' .. matches[2] .. ' ' .. lang_text(chat_id, 'userUnmuted:2'), ok_cb, true)
                end
                return
            end
        else
            return '🚫 ' .. lang_text(msg.to.id, 'require_mod')
        end
    elseif matches[1]:lower() == 'mutelist' or matches[1]:lower() == 'sasha lista muti' or matches[1]:lower() == 'lista muti' then
        if permissions(msg.from.id, msg.to.id, "mutelist") then
            return muted_list(chat_id)
        else
            return '🚫 ' .. lang_text(msg.to.id, 'require_mod')
        end
    elseif matches[1]:lower() == 'kickme' or matches[1]:lower() == 'sasha uccidimi' or matches[1]:lower() == 'uccidimi' then
        local hash = 'kickme:' .. msg.to.id
        if redis:get(hash) then
            user_id = msg.from.id
            kick_user(user_id, chat_id)
            if msg.to.type == 'chat' then
                send_msg('chat#id' .. msg.to.id, '👋🏽 ' .. lang_text(chat_id, 'kickmeBye') .. ' @' .. msg.from.username .. ' (' .. msg.from.id .. ').', ok_cb, true)
            elseif msg.to.type == 'channel' then
                send_msg('channel#id' .. msg.to.id, '👋🏽 ' .. lang_text(chat_id, 'kickmeBye') .. ' @' .. msg.from.username .. ' (' .. msg.from.id .. ').', ok_cb, true)
            end
        end
    elseif matches[1]:lower() == 'kick' or matches[1]:lower() == 'sasha uccidi' or matches[1]:lower() == 'uccidi' or matches[1]:lower() == 'spara' then
        if permissions(msg.from.id, msg.to.id, "kick") then
            if msg.reply_id then
                get_message(msg.reply_id, kick_by_reply, false)
                return
            end
            if not is_id(matches[2]) then
                member = string.gsub(matches[2], '@', '')
                resolve_username(member, kick_by_username, { chat_id = chat_id, member = member, chat_type = chat_type })
                return
            else
                user_id = matches[2]
                kick_user(user_id, chat_id)
                if msg.to.type == 'chat' then
                    send_msg('chat#id' .. chat_id, 'ℹ️ ' .. lang_text(chat_id, 'kickUser:1') .. ' ' .. user_id .. ' ' .. lang_text(chat_id, 'kickUser:2'), ok_cb, false)
                elseif msg.to.type == 'channel' then
                    send_msg('channel#id' .. chat_id, 'ℹ️ ' .. lang_text(chat_id, 'kickUser:1') .. ' ' .. user_id .. ' ' .. lang_text(chat_id, 'kickUser:2'), ok_cb, false)
                end
                return
            end
        else
            return '🚫 ' .. lang_text(msg.to.id, 'require_mod')
        end
    elseif matches[1]:lower() == 'kicknouser' or matches[1]:lower() == 'sasha uccidi nouser' or matches[1]:lower() == 'spara nouser' then
        if permissions(msg.from.id, msg.to.id, "kicknouser") then
            if msg.to.type == 'chat' then
                local chat = 'chat#id' .. msg.to.id
                chat_info(chat, kickidsnouser_chat, { chat_id = msg.to.id })
            elseif msg.to.type == 'channel' then
                local chan =("%s#id%s"):format(msg.to.type, msg.to.id)
                channel_get_users(chan, kickidsnouser_channel, { chat_id = msg.to.id })
            end
        else
            return '🚫 ' .. lang_text(msg.to.id, 'require_mod')
        end
    elseif matches[1]:lower() == 'ban' or matches[1]:lower() == 'sasha banna' or matches[1]:lower() == 'sasha decompila' or matches[1]:lower() == 'banna' or matches[1]:lower() == 'decompila' or matches[1]:lower() == 'esplodi' or matches[1]:lower() == 'kaboom' then
        if permissions(msg.from.id, msg.to.id, "ban") then
            if msg.reply_id then
                if msg.to.type == 'chat' then
                    get_message(msg.reply_id, ban_by_reply, false)
                elseif msg.to.type == 'channel' then
                    get_message(msg.reply_id, ban_by_reply, { receiver = get_receiver(msg) })
                end
                return
            end
            if not is_id(matches[2]) then
                member = string.gsub(matches[2], '@', '')
                resolve_username(member, ban_by_username, { chat_id = chat_id, member = member, chat_type = chat_type })
                return
            else
                user_id = matches[2]
                ban_user(user_id, chat_id)
                if chat_type == 'chat' then
                    send_msg('chat#id' .. chat_id, 'ℹ️ ' .. lang_text(chat_id, 'banUser:1') .. ' ' .. user_id .. ' ' .. lang_text(chat, 'banUser:2'), ok_cb, false)
                elseif chat_type == 'channel' then
                    send_msg('channel#id' .. chat_id, 'ℹ️ ' .. lang_text(chat_id, 'banUser:1') .. ' ' .. user_id .. ' ' .. lang_text(chat, 'banUser:2'), ok_cb, false)
                end
                ban_user(user_id, chat_id)
                return
            end
        else
            return '🚫 ' .. lang_text(msg.to.id, 'require_mod')
        end
    elseif matches[1]:lower() == 'unban' or matches[1]:lower() == 'sasha sbanna' or matches[1]:lower() == 'sasha ricompila' or matches[1]:lower() == 'sasha compila' or matches[1]:lower() == 'sbanna' or matches[1]:lower() == 'ricompila' or matches[1]:lower() == 'compila' then
        if permissions(msg.from.id, msg.to.id, "unban") then
            if msg.reply_id then
                if msg.to.type == 'chat' then
                    get_message(msg.reply_id, unban_by_reply, false)
                elseif msg.to.type == 'channel' then
                    get_message(msg.reply_id, unban_by_reply, false)
                end
                return
            end
            if not is_id(matches[2]) then
                member = string.gsub(matches[2], '@', '')
                resolve_username(member, unban_by_username, { chat_id = chat_id, member = member, chat_type = chat_type })
                return
            else
                user_id = matches[2]
                unban_user(user_id, chat_id)
                if chat_type == 'chat' then
                    send_msg('chat#id' .. chat_id, 'ℹ️ ' .. lang_text(chat_id, 'unbanUser:1') .. ' ' .. user_id .. ' ' .. lang_text(chat_id, 'unbanUser:2'), ok_cb, false)
                elseif chat_type == 'channel' then
                    send_msg('channel#id' .. chat_id, 'ℹ️ ' .. lang_text(chat_id, 'unbanUser:1') .. ' ' .. user_id .. ' ' .. lang_text(chat_id, 'unbanUser:2'), ok_cb, false)
                end
            end
        else
            return '🚫 ' .. lang_text(msg.to.id, 'require_mod')
        end
    elseif matches[1]:lower() == 'banlist' or matches[1]:lower() == 'sasha lista ban' or matches[1]:lower() == 'lista ban' then
        if permissions(msg.from.id, msg.to.id, "banlist") then
            return ban_list(chat_id)
        else
            return '🚫 ' .. lang_text(msg.to.id, 'require_admin')
        end
    elseif matches[1]:lower() == 'gban' or matches[1]:lower() == 'sasha superbanna' or matches[1]:lower() == 'superbanna' then
        if permissions(msg.from.id, msg.to.id, "gban") then
            if msg.reply_id then
                get_message(msg.reply_id, gban_by_reply, false)
                return
            end
            if not is_id(matches[2]) then
                member = string.gsub(matches[2], '@', '')
                resolve_username(member, gban_by_username, { chat_id = chat_id, member = member, chat_type = chat_type })
                return
            else
                user_id = matches[2]
                gban_user(user_id)
                if chat_type == 'chat' then
                    send_msg('chat#id' .. chat_id, 'ℹ️ ' .. lang_text(chat_id, 'gbanUser:1') .. ' ' .. user_id .. ' ' .. lang_text(chat_id, 'gbanUser:2'), ok_cb, false)
                    chat_del_user('chat#id' .. chat_id, 'user#id' .. user_id, ok_cb, false)
                elseif chat_type == 'channel' then
                    send_msg('channel#id' .. chat_id, 'ℹ️ ' .. lang_text(chat_id, 'gbanUser:1') .. ' ' .. user_id .. ' ' .. lang_text(chat_id, 'gbanUser:2'), ok_cb, false)
                    channel_kick_user('channel#id' .. chat_id, 'user#id' .. user_id, ok_cb, false)
                end
                return
            end
        else
            return '🚫 ' .. lang_text(msg.to.id, 'require_admin')
        end
    elseif matches[1]:lower() == 'ungban' or matches[1]:lower() == 'sasha supersbanna' or matches[1]:lower() == 'supersbanna' then
        if permissions(msg.from.id, msg.to.id, "ungban") then
            if msg.reply_id then
                get_message(msg.reply_id, ungban_by_reply, false)
                return
            end
            if not is_id(matches[2]) then
                member = string.gsub(matches[2], '@', '')
                resolve_username(member, ungban_by_username, { chat_id = chat_id, member = member, chat_type = chat_type })
                return
            else
                user_id = matches[2]
                ungban_user(user_id)
                if chat_type == 'chat' then
                    send_msg('chat#id' .. chat_id, 'ℹ️ ' .. lang_text(chat_id, 'ungbanUser:1') .. ' ' .. user_id .. ' ' .. lang_text(chat_id, 'ungbanUser:2'), ok_cb, false)
                elseif chat_type == 'channel' then
                    send_msg('channel#id' .. chat_id, 'ℹ️ ' .. lang_text(chat_id, 'ungbanUser:1') .. ' ' .. user_id .. ' ' .. lang_text(chat_id, 'ungbanUser:2'), ok_cb, false)
                end
                return
            end
        else
            return '🚫 ' .. lang_text(msg.to.id, 'require_mod')
        end
    elseif matches[1]:lower() == 'gbanlist' or matches[1]:lower() == 'sasha lista superban' or matches[1]:lower() == 'lista superban' then
        if permissions(msg.from.id, msg.to.id, "gbanlist") then
            return gban_list()
        else
            return '🚫 ' .. lang_text(msg.to.id, 'require_admin')
        end
    elseif matches[1]:lower() == 'add' or matches[1]:lower() == 'invite' or matches[1]:lower() == 'sasha invita' or matches[1]:lower() == 'sasha resuscita' or matches[1]:lower() == 'invita' or matches[1]:lower() == 'resuscita' then
        if permissions(msg.from.id, msg.to.id, "add") then
            if msg.reply_id then
                get_message(msg.reply_id, add_by_reply, false)
                return
            end
            if not is_id(matches[2]) then
                member = string.gsub(matches[2], '@', '')
                resolve_username(member, add_by_username, { chat_id = chat_id, member = member, chat_type = chat_type })
                return
            else
                user_id = matches[2]
                add_user(user_id, chat_id)
                if chat_type == 'chat' then
                    send_msg('chat#id' .. chat_id, 'ℹ️ ' .. lang_text(chat_id, 'addUser:1') .. ' ' .. user_id .. ' ' .. lang_text(chat_id, 'addUser:2'), ok_cb, false)
                elseif chat_type == 'channel' then
                    send_msg('channel#id' .. chat_id, 'ℹ️ ' .. lang_text(chat_id, 'addUser:1') .. ' ' .. user_id .. ' ' .. lang_text(chat_id, 'addUser:3'), ok_cb, false)
                end
                return
            end
        else
            return '🚫 ' .. lang_text(msg.to.id, 'require_mod')
        end
    end
end

return {
    patterns =
    {
        "^#([Kk][Ii][Cc][Kk][Mm][Ee])$",
        '^#([Mm][Uu][Tt][Ee]) (.*)$',
        '^#([Mm][Uu][Tt][Ee])$',
        '^#([Uu][Nn][Mm][Uu][Tt][Ee]) (.*)$',
        '^#([Uu][Nn][Mm][Uu][Tt][Ee])$',
        -- "^#([Mm][Uu][Tt][Ee][lL][iI][sS][tT]) (.*)$",
        "^#([Mm][Uu][Tt][Ee][lL][iI][sS][tT])$",
        "^#([Kk][Ii][Cc][Kk]) (.*)$",
        "^#([Kk][Ii][Cc][Kk])$",
        "^#([Kk][Ii][Cc][Kk][Nn][Oo][Uu][Ss][Ee][Rr])$",
        "^#([Bb][Aa][Nn]) (.*)$",
        "^#([Bb][Aa][Nn])$",
        "^#([Uu][Nn][Bb][Aa][Nn]) (.*)$",
        "^#([Uu][Nn][Bb][Aa][Nn])$",
        -- "^#([Bb][Aa][Nn][lL][iI][sS][tT]) (.*)$",
        "^#([Bb][Aa][Nn][lL][iI][sS][tT])$",
        "^#([Gg][Bb][Aa][Nn]) (.*)$",
        "^#([Gg][Bb][Aa][Nn])$",
        "^#([Uu][Nn][Gg][Bb][Aa][Nn]) (.*)$",
        "^#([Uu][Nn][Gg][Bb][Aa][Nn])$",
        "^#([Gg][Bb][Aa][Nn][lL][iI][sS][tT])$",
        "^#([Aa][Dd][Dd]) (.*)$",
        "^#([Aa][Dd][Dd])$",
        "^#([Ii][Nn][Vv][Ii][Tt][Ee]) (.*)$",
        "^#([Ii][Nn][Vv][Ii][Tt][Ee])$",
        "^!!tgservice (.*)$",
        -- mute
        "^([Ss][Aa][Ss][Hh][Aa] [Tt][Oo][Gg][Ll][Ii] [Vv][Oo][Cc][Ee]) (.*)$",
        "^([Ss][Aa][Ss][Hh][Aa] [Tt][Oo][Gg][Ll][Ii] [Vv][Oo][Cc][Ee])$",
        "^([Tt][Oo][Gg][Ll][Ii] [Vv][Oo][Cc][Ee]) (.*)$",
        "^([Tt][Oo][Gg][Ll][Ii] [Vv][Oo][Cc][Ee])$",
        -- unmute
        "^([Ss][Aa][Ss][Hh][Aa] [Dd][Aa][Ii] [Vv][Oo][Cc][Ee]) (.*)$",
        "^([Ss][Aa][Ss][Hh][Aa] [Dd][Aa][Ii] [Vv][Oo][Cc][Ee])$",
        "^([Dd][Aa][Ii] [Vv][Oo][Cc][Ee]) (.*)$",
        "^([Dd][Aa][Ii] [Vv][Oo][Cc][Ee])$",
        -- mutelist
        -- "^([Ss][Aa][Ss][Hh][Aa] [Ll][Ii][Ss][Tt][Aa] [Mm][Uu][Tt][Ii]) (.*)$",
        "^([Ss][Aa][Ss][Hh][Aa] [Ll][Ii][Ss][Tt][Aa] [Mm][Uu][Tt][Ii])$",
        -- "^([Ll][Ii][Ss][Tt][Aa] [Mm][Uu][Tt][Ii]) (.*)$",
        "^([Ll][Ii][Ss][Tt][Aa] [Mm][Uu][Tt][Ii])$",
        -- kickme
        "^([Ss][Aa][Ss][Hh][Aa] [Uu][Cc][Cc][Ii][Dd][Ii][mM][iI])$",
        "^([uU][cC][cC][iI][dD][iI][mM][iI])$",
        -- kick
        "^([Ss][Aa][Ss][Hh][Aa] [Uu][Cc][Cc][Ii][Dd][Ii]) (.*)$",
        "^([Ss][Aa][Ss][Hh][Aa] [Uu][Cc][Cc][Ii][Dd][Ii])$",
        "^([Uu][Cc][Cc][Ii][Dd][Ii]) (.*)$",
        "^([Uu][Cc][Cc][Ii][Dd][Ii])$",
        "^([Ss][Pp][Aa][Rr][Aa]) (.*)$",
        "^([Ss][Pp][Aa][Rr][Aa])$",
        -- kicknouser
        "^([Ss][Aa][Ss][Hh][Aa] [Uu][Cc][Cc][Ii][Dd][Ii] [Nn][Oo][Uu][Ss][Ee][Rr])$",
        "^([Ss][Pp][Aa][Rr][Aa] [Nn][Oo][Uu][Ss][Ee][Rr])$",
        -- ban
        "^([Ss][Aa][Ss][Hh][Aa] [Bb][Aa][Nn][Nn][Aa]) (.*)$",
        "^([Ss][Aa][Ss][Hh][Aa] [Bb][Aa][Nn][Nn][Aa])$",
        "^([Ss][Aa][Ss][Hh][Aa] [Dd][Ee][Cc][Oo][Mm][Pp][Ii][Ll][Aa]) (.*)$",
        "^([Ss][Aa][Ss][Hh][Aa] [Dd][Ee][Cc][Oo][Mm][Pp][Ii][Ll][Aa])$",
        "^([Bb][Aa][Nn][Nn][Aa]) (.*)$",
        "^([Bb][Aa][Nn][Nn][Aa])$",
        "^([Dd][Ee][Cc][Oo][Mm][Pp][Ii][Ll][Aa]) (.*)$",
        "^([Dd][Ee][Cc][Oo][Mm][Pp][Ii][Ll][Aa])$",
        "^([Ee][Ss][Pp][Ll][Oo][Dd][Ii]) (.*)$",
        "^([Ee][Ss][Pp][Ll][Oo][Dd][Ii])$",
        "^([Kk][Aa][Bb][Oo][Oo][Mm]) (.*)$",
        "^([Kk][Aa][Bb][Oo][Oo][Mm])$",
        -- unban
        "^([Ss][Aa][Ss][Hh][Aa] [Ss][Bb][Aa][Nn][Nn][Aa]) (.*)$",
        "^([Ss][Aa][Ss][Hh][Aa] [Ss][Bb][Aa][Nn][Nn][Aa])$",
        "^([Ss][Aa][Ss][Hh][Aa] [Rr][Ii][Cc][Oo][Mm][Pp][Ii][Ll][Aa]) (.*)$",
        "^([Ss][Aa][Ss][Hh][Aa] [Rr][Ii][Cc][Oo][Mm][Pp][Ii][Ll][Aa])$",
        "^([Ss][Aa][Ss][Hh][Aa] [Cc][Oo][Mm][Pp][Ii][Ll][Aa]) (.*)$",
        "^([Ss][Aa][Ss][Hh][Aa] [Cc][Oo][Mm][Pp][Ii][Ll][Aa])$",
        "^([Ss][Bb][Aa][Nn][Nn][Aa]) (.*)$",
        "^([Ss][Bb][Aa][Nn][Nn][Aa])$",
        "^([Rr][Ii][Cc][Oo][Mm][Pp][Ii][Ll][Aa]) (.*)$",
        "^([Rr][Ii][Cc][Oo][Mm][Pp][Ii][Ll][Aa])$",
        "^([Cc][Oo][Mm][Pp][Ii][Ll][Aa]) (.*)$",
        "^([Cc][Oo][Mm][Pp][Ii][Ll][Aa])$",
        -- banlist
        -- "^([Ss][Aa][Ss][Hh][Aa] [Ll][Ii][Ss][Tt][Aa] [Bb][Aa][Nn]) (.*)$",
        "^([Ss][Aa][Ss][Hh][Aa] [Ll][Ii][Ss][Tt][Aa] [Bb][Aa][Nn])$",
        -- "^([Ll][Ii][Ss][Tt][Aa] [Bb][Aa][Nn]) (.*)$",
        "^([Ll][Ii][Ss][Tt][Aa] [Bb][Aa][Nn])$",
        -- gban
        "^([Ss][Aa][Ss][Hh][Aa] [Ss][Uu][Pp][Ee][Rr][Bb][Aa][Nn][Nn][Aa]) (.*)$",
        "^([Ss][Aa][Ss][Hh][Aa] [Ss][Uu][Pp][Ee][Rr][Bb][Aa][Nn][Nn][Aa])$",
        "^([Ss][Uu][Pp][Ee][Rr][Bb][Aa][Nn][Nn][Aa]) (.*)$",
        "^([Ss][Uu][Pp][Ee][Rr][Bb][Aa][Nn][Nn][Aa])$",
        -- ungban
        "^([Ss][Aa][Ss][Hh][Aa] [Ss][Uu][Pp][Ee][Rr][Ss][Bb][Aa][Nn][Nn][Aa]) (.*)$",
        "^([Ss][Aa][Ss][Hh][Aa] [Ss][Uu][Pp][Ee][Rr][Ss][Bb][Aa][Nn][Nn][Aa])$",
        "^([Ss][Uu][Pp][Ee][Rr][Ss][Bb][Aa][Nn][Nn][Aa]) (.*)$",
        "^([Ss][Uu][Pp][Ee][Rr][Ss][Bb][Aa][Nn][Nn][Aa])$",
        -- gbanlist
        "^([Ss][Aa][Ss][Hh][Aa] [Ll][Ii][Ss][Tt][Aa] [Ss][Uu][Pp][Ee][Rr][Bb][Aa][Nn])$",
        "^([Ll][Ii][Ss][Tt][Aa] [Ss][Uu][Pp][Ee][Rr][Bb][Aa][Nn])$",
        -- add|invite
        "^([Ss][Aa][Ss][Hh][Aa] [Ii][Nn][Vv][Ii][Tt][Aa]) (.*)$",
        "^([Ss][Aa][Ss][Hh][Aa] [Ii][Nn][Vv][Ii][Tt][Aa])$",
        "^([Ss][Aa][Ss][Hh][Aa] [Rr][Ee][Ss][Uu][Ss][Cc][Ii][Tt][Aa]) (.*)$",
        "^([Ss][Aa][Ss][Hh][Aa] [Rr][Ee][Ss][Uu][Ss][Cc][Ii][Tt][Aa])$",
        "^([Ii][Nn][Vv][Ii][Tt][Aa]) (.*)$",
        "^([Ii][Nn][Vv][Ii][Tt][Aa])$",
        "^([Rr][Ee][Ss][Uu][Ss][Cc][Ii][Tt][Aa]) (.*)$",
        "^([Rr][Ee][Ss][Uu][Ss][Cc][Ii][Tt][Aa])$",
    },
    run = run,
    pre_process = pre_process
}