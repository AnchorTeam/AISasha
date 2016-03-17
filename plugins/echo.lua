local function run(msg, matches)
    local text = matches[1]
    return text
end

return {
    patterns =
    {
        "^#[Ee][Cc][Hh][Oo] +(.+)$",
        -- echo
        "^[Ss][Aa][Ss][Hh][Aa] [Rr][Ii][Pp][Ee][Tt][Ii] +(.+)$",
    },
    run = run
}
