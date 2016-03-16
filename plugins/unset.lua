local function unset_var(msg, name)
    if (not name) then
        return "Utilizzo: ([!/]unset|[sasha] unsetta) <var_name>"
    end

    local hash = nil
    if msg.to.type == 'chat' then
        hash = 'chat:' .. msg.to.id .. ':variables'
    end
    if msg.to.type == 'user' then
        hash = 'user:' .. msg.from.id .. ':variables'
    end
    if hash then
        redis:hdel(hash, name)
        return name .. " eliminato"
    end
end

local function run(msg, matches)
    local name = string.sub(matches[1], 1, 50)

    local text = 'Stai forse cercando di fregarmi?'
    if is_momod2(msg.from.id, msg.to.id) then
        text = unset_var(msg, name:lower())
    end
    return text
end

return {
    description = "UNSET\nℹ️Plugin per l'eliminazione dei valori salvati.",
    usage =
    {
        "🖊([!/]unset|[sasha] unsetta) <var_name>",
        "ℹ️Sasha elimina <var_name>.",
    },
    patterns =
    {
        "^[!/][uU][nN][sS][eE][tT] ([^%s]+)$",
        -- unset
        "^[sS][aA][sS][hH][aA] [uU][nN][sS][eE][tT][tT][aA] ([^%s]+)$",
        "^[uU][nN][sS][eE][tT][tT][aA] ([^%s]+)$",
    },
    run = run
}