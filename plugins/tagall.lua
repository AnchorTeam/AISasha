local function tagall_chat(cb_extra, success, result)
    local chat_id = cb_extra.chat_id
    local text = ""
    for k, v in pairs(result.members) do
        if v.username then
            if v.username ~= 'AISasha' and string.sub(v.username:lower(), -3) ~= 'bot' then
                text = text .. "@" .. v.username .. "\n"
            end
        end
    end
    text = text .. "\n" .. cb_extra.msg_text
    return send_large_msg('chat#id' .. chat_id, text, ok_cb, true)
end

local function tagall_channel(extra, success, result)
    local chat_id = extra.chat_id
    local text = ""
    for k, v in pairs(result) do
        if v.username then
            if v.username ~= 'AISasha' and string.sub(v.username:lower(), -3) ~= 'bot' then
                text = text .. "@" .. v.username .. "\n"
            end
        end
    end
    text = text .. "\n" .. extra.msg_text
    return send_large_msg('channel#id' .. chat_id, text, ok_cb, true)
end

local function run(msg, matches)
    if permissions(msg.from.id, msg.to.id, "tagall") then
        if matches[1] then
            if msg.to.type == 'chat' then
                local receiver = 'chat#id' .. msg.to.id
                chat_info(receiver, tagall_chat, { chat_id = msg.to.id, msg_text = matches[1] })
            elseif msg.to.type == 'channel' then
                local chan =("%s#id%s"):format(msg.to.type, msg.to.id)
                channel_get_users(chan, tagall_channel, { chat_id = msg.to.id, msg_text = matches[1] })
            end
        end
    else
        return '🚫 ' .. lang_text(msg.to.id, 'require_mod')
    end
end

return {
    patterns =
    {
        "^[#!/][Tt][Aa][Gg][Aa][Ll][Ll] +(.+)$",
        "^[Ss][Aa][Ss][Hh][Aa] [Tt][Aa][Gg][Gg][Aa] [Tt][Uu][Tt][Tt][Ii] +(.+)$",
    },
    run = run
}
