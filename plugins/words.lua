do
    function run(msg, matches)
        if matches[1]:lower() == 'gangbang' then
            return ".    👇🏿\n👉🏾👌🏻👈🏾\n      👆🏿"
        end
        if matches[1]:lower() == 'maometto' or matches[1]:lower() == 'maometo' or matches[1]:lower() == 'cancaroman' then
            return "D\n  I\n    O\n     o\n     o\n      o\n     o\n     。\n    。\n   .\n   .\n    .\n    .\nC \nA\n  N\n    C\n  A\n    R\n      o\n       o\n      o\n     。\n    。\n   .\n   .\n    .\n    .\n🚴"
        end
        if matches[1]:lower() == 'mohammed' then
            return "☁️☀️    ☁️         ☁️  ☁️\n       ☁️                🚁   ☁️\n\n_🌵_🌻________🌵_____\n                 /  |   \\\n        🌴  / 🚔    \\ 🌴\n             /      |       \\\n    🌴   /      🚔      \\ 🌴\n         /          |    🚔  \\\n⛽️  /  🚔     |   🚔     \\ 🌴\n     /            🚔             \\ 🌴\n   /                |                \\\n /                  |        👳🏿      \\\n"
        end
        if matches[1]:lower() == 'nazi' or matches[1]:lower() == 'hitler' then
            return "❤️❤️❤️❤️❤️❤️❤️❤️❤️\n❤️⚫️❤️❤️⚫️⚫️⚫️⚫️❤️\n❤️⚫️❤️❤️⚫️❤️❤️❤️❤️\n❤️⚫️❤️❤️⚫️❤️❤️❤️❤️\n❤️⚫️⚫️⚫️⚫️⚫️⚫️⚫️❤️\n❤️❤️❤️❤️⚫️❤️❤️⚫️❤️\n❤️❤️❤️❤️⚫️❤️❤️⚫️❤️\n❤️⚫️⚫️⚫️⚫️❤️❤️⚫️❤️\n❤️❤️❤️❤️❤️❤️❤️❤️❤️"
        end
    end

    return {
        patterns =
        {
            "([Gg][Aa][Nn][Gg][Bb][Aa][Nn][Gg])",
            "([Mm][Aa][Oo][Mm][Ee][Tt][Tt][Oo])",
            "([Mm][Aa][Oo][Mm][Ee][Tt][Oo])",
            "([Cc][Aa][Nn][Cc][Aa][Rr][Oo][Mm][Aa][Nn])",
            "([Mm][Oo][Hh][Aa][Mm][Mm][Ee][Dd])",
            "([Nn][Aa][Zz][Ii])",
            "([Hh][Ii][Tt][Ll][Ee][Rr])",
        },
        run = run
    }
end
