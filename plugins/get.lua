﻿local function get_variables_hash(msg)
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

return {
    description = "GET\nℹ️Plugin per mostrare i valori salvati.",
    usage =
    {
        "🖊[/!]getlist|sasha lista|get",
        "ℹ️Sasha mostra una lista delle variabili settate.",
        "🖊[[/!]get] <var_name>",
        "ℹ️Sasha mostra il valore di <var_name>.",
    },
    patterns =
    {
        "^#([gG][eE][tT][lL][iI][sS][tT])$",
        "^#([gG][eE][tT]) ([^%s]+)$",
        -- getlist
        "^#([gG][eE][tT])$",
        "^([sS][aA][sS][hH][aA] [lL][iI][sS][tT][aA])$",
        -- get
        "^([^%s]+) (.+)$",
        "^([^%s]+)$",
    },
    run = run
}