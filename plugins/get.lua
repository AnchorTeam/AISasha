﻿local function get_variables_hash(msg)
    if msg.to.type == 'channel' then
        return 'channel:' .. msg.to.id .. ':variables'
    end
    if msg.to.type == 'chat' then
        return 'chat:' .. msg.to.id .. ':variables'
    end
    if msg.to.type == 'user' then
        return 'user:' .. msg.from.id .. ':variables'
    end
end

local function get_value(msg, var_name)
    local hash = get_variables_hash(msg)
    if hash then
        local value = redis:hget(hash, var_name)
        if value then
            return value
        else
            return
        end
    end
end

local function list_variables(msg)
    local hash = get_variables_hash(msg)

    if hash then
        local names = redis:hkeys(hash)
        local text = ''
        for i = 1, #names do
            text = text .. names[i] .. '\n'
        end
        return text
    end
end

local function run(msg, matches)
    if (matches[1]:lower() == 'get' or matches[1]:lower() == 'getlist' or matches[1]:lower() == 'sasha lista') and not matches[2] then
        return list_variables(msg)
    else
        if matches[2] and string.match(matches[2]:lower(), 'chat_add_user_link') then
            return
        end
        local vars = list_variables(msg)
        if vars ~= nil then
            local t = vars:split('\n')
            for i, word in pairs(t) do
                if word:lower() ~= 'get' and string.find(msg.text:lower(), word:lower()) then
                    send_large_msg(get_receiver(msg), get_value(msg, word:lower()))
                end
            end
            --[[
        for i, word in pairs(matches) do
            if word ~= 'get' then
                return get_value(msg, string.lower(word))
            end
        end]]
        end
    end
end

return {
    patterns =
    {
        "^[#!/]([Gg][Ee][Tt][Ll][Ii][Ss][Tt])$",
        "^[#!/]([Gg][Ee][Tt]) ([^%s]+)$",
        -- getlist
        "^[#!/]([Gg][Ee][Tt])$",
        "^([Ss][Aa][Ss][Hh][Aa] [Ll][Ii][Ss][Tt][Aa])$",
        -- get
        "^([^%s]+) (.+)$",
        "^([^%s]+)$",
    },
    run = run
}
