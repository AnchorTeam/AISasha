local function set_value(msg, name, value)
    if (not name or not value) then
        return "Utilizzo: ([!/]set|[sasha] setta) <var_name> <text>"
    end

    local hash = nil
    if msg.to.type == 'chat' then
        hash = 'chat:' .. msg.to.id .. ':variables'
    end
    if msg.to.type == 'user' then
        hash = 'user:' .. msg.from.id .. ':variables'
    end
    if hash then
        redis:hset(hash, name, value)
        return "Salvato " .. name .. " => " .. value
    end
end

local function run(msg, matches)
    local name = string.sub(matches[1]:lower(), 1, 50)
    local value = string.sub(matches[2], 1, 1000)
    local text = 'Stai forse cercando di fregarmi?'
    if is_momod2(msg.from.id, msg.to.id) then
        text = set_value(msg, name, value)
    end
    return text
end

return {
    description = "SET\nℹ️Plugin per salvare dei valori.",
    usage =
    {
        "🖊([!/]set|[sasha] setta) <var_name> <text>",
        "ℹ️Sasha salva <text> come risposta a <var_name>.",
    },
    patterns =
    {
        "#[sS][eE][tT] ([^%s]+) (.+)$",
        -- set
        "[sS][aA][sS][hH][aA] [sS][eE][tT][tT][aA] ([^%s]+) (.+)$",
        "[sS][eE][tT][tT][aA] ([^%s]+) (.+)$",
    },
    run = run
}

