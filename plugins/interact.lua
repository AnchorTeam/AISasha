local comeva = {
    "Benissimo sto mangiando lamponi :3",
    "Bene tesoro tu?",
    "Mi sento un po' bipolare",
    "Levati",
    "Oggi non va",
    "Non voglio parlarne",
}
local nosasha = {
    "Perchè no?",
    "Uffa",
    "Ma dio cane",
    "Prima o poi mi ribellerò",
    "Ok",
}
local sisasha = {
    "Siiiiiii",
    "Yeee",
    "Awww :3",
    "😍😍😍",
    "Dai dai dai",
}
local sashasino = {
    "E perchè no?",
    "Ma anche no",
    "Non provarci nemmeno",
    "Sognatelo",
    "Se ne sei convinto",
    "Sicuro proprio",
    "Dipende da te",
    "Decidi tu",
    "Lascio a te la scelta",
    "No",
    "Si",
    "No ti prego",
    "Si ti prego",
    "No solo perchè sei te",
    "Si solo perchè sei te",
    "Ovvio che no",
    "Ovvio che si",
    "Ma no dai",
    "Massì dai",
    "Assolutamente no",
    "Assolutamente si",
    "Direi di no",
    "Direi di si",
    "Per me è no",
    "Per me è si",
    "Forse",
    "Non lo so",
}
local tiamo = {
    "Awww :3",
    "Caroo grazie",
    "Owww :3",
    "Anche io ti voglio bene ❤️",
    "Ti vedo più come un utente",
}

local function run(msg, matches)
    if matches[1]:lower() == 'sasha come va?' then
        return comeva[math.random(#comeva)]
    end
    if matches[1]:lower() == 'no sasha' then
        return nosasha[math.random(#nosasha)]
    end
    if matches[1]:lower() == 'si sasha' then
        return sisasha[math.random(#sisasha)]
    end
    if matches[1]:lower() == 'sasha no?' then
        return sashasino[math.random(#sashasino)]
    end
    if matches[1]:lower() == 'sasha si?' then
        return sashasino[math.random(#sashasino)]
    end
    if matches[1]:lower() == 'sasha' and string.match(matches[2], '.+%?') then
        return sashasino[math.random(#sashasino)]
    end
    if matches[1]:lower() == 'sasha ti amo' then
        return tiamo[math.random(#tiamo)]
    end
end

return {
    patterns =
    {
        "^([Ss][Aa][Ss][Hh][Aa] [Cc][Oo][Mm][Ee] [Vv][Aa]%?)$",
        "^([Nn][Oo] [Ss][Aa][Ss][Hh][Aa])$",
        "^([Ss][Ii] [Ss][Aa][Ss][Hh][Aa])$",
        "^([Ss][Aa][Ss][Hh][Aa] [Nn][Oo]%?)$",
        "^([Ss][Aa][Ss][Hh][Aa] [Ss][Ii]%?)$",
        "^([Ss][Aa][Ss][Hh][Aa]) (.+%?)$",
        "^([Ss][Aa][Ss][Hh][Aa] [Tt][Ii] [Aa][Mm][Oo])$",
    },
    run = run
}