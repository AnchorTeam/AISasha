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

    if permissions(msg.from.id, msg.to.id, "unset") then
        return unset_var(msg, name:lower())
    else
        return '🚫 ' .. lang_text(msg.to.id, 'require_mod')
    end
end

return {
    patterns =
    {
        "^[#!/][Uu][Nn][Ss][Ee][Tt] ([^%s]+)$",
        -- unset
        "^[Ss][Aa][Ss][Hh][Aa] [Uu][Nn][Ss][Ee][Tt][Tt][Aa] ([^%s]+)$",
        "^[Uu][Nn][Ss][Ee][Tt][Tt][Aa] ([^%s]+)$",
    },
    run = run
}