function run(msg, matches)
    local text = '@EricSolinas hai ricevuto un feedback: #newfeedback \n\nMittente'
    if msg.from.first_name then
        text = text .. '\nNome: ' .. msg.from.first_name
    end
    if msg.from.last_name then
        text = text .. '\nCognome: ' .. msg.from.last_name
    end
    if msg.from.username then
        text = text .. '\nUsername: @' .. msg.from.username
    end
    text = text .. '\nId: ' .. msg.from.id ..
    '\n\nFeedback:\n' .. matches[1]
    send_large_msg('chat#id120307338', text)
    return 'Feedback inviato!'
end

return {
    patterns =
    {
        "^#[Ff][Ee][Ee][Dd][Bb][Aa][Cc][Kk] (.*)$",
        "^[Ff][Ee][Ee][Dd][Bb][Aa][Cc][Kk] (.*)$"
    },
    run = run
}