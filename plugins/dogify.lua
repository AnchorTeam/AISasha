local function run(msg, matches)
    local base = "http://dogr.io/"
    local path = string.gsub(matches[1], " ", "%%20")
    local url = base .. path .. '.png?split=false&.png'
    local urlm = "https?://[%%%w-_%.%?%.:/%+=&]+"

    if string.match(url, urlm) == url then
        local receiver = get_receiver(msg)
        send_photo_from_url(receiver, url)
    else
        print("Can't build a good URL with parameter " .. matches[1])
    end
end

return {
    patterns =
    {
        "^#[Ss][Aa][Ss][Hh][Aa] (.+)$",
        -- dogify
        "^[sS][aA][sS][hH][aA] [Dd][Oo][Gg][Ee] (.+)$",
        "^[Dd][Oo][Gg][Ee] (.+)$",
    },
    run = run
}