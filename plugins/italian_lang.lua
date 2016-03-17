--------------------------------------------------
--      ____  ____ _____                        --
--     |    \|  _ )_   _|___ ____   __  __      --
--     | |_  )  _ \ | |/ ·__|  _ \_|  \/  |     --
--     |____/|____/ |_|\____/\_____|_/\/\_|     --
--                                              --
--------------------------------------------------
--                                              --
--       Developers: @Josepdal & @MaSkAoS       --
--     Support: @Skneos,  @iicc1 & @serx666     --
--                                              --
--           Translated by: @baconnn            --
--                                              --
--------------------------------------------------

local LANG = 'it'

local function run(msg, matches)
    if permissions(msg.from.id, msg.to.id, "lang_install") then

        -------------------------
        -- Translation version --
        -------------------------
        set_text(LANG, 'versione', '0.1')
        set_text(LANG, 'versionExtended', 'Versione traduzione 0.1')

        -------------
        -- Plugins --
        -------------

        -- global plugins --
        set_text(LANG, 'require_sudo', 'Questo plugin richiede i privilegi di sudo.')
        set_text(LANG, 'require_admin', 'Questo plugin richiede privilegi da admin o superiori.')
        set_text(LANG, 'require_mod', 'Questo plugin richiede privilegi da moderatore o superiori.')

        -- Spam.lua --
        set_text(LANG, 'reportUser', 'UTENTE')
        set_text(LANG, 'reportReason', 'Segnalato per')
        set_text(LANG, 'reportGroup', 'Gruppo')
        set_text(LANG, 'reportMessage', 'Messaggio')

        set_text(LANG, 'allowedSpamT', 'Lo spam è ora consentito in questo gruppo.')
        set_text(LANG, 'allowedSpamL', 'Lo spam è ora consentito in questo supergruppo.')
        set_text(LANG, 'notAllowedSpamT', 'Lo spam non è consentito in questo gruppo.')
        set_text(LANG, 'notAllowedSpamL', 'Lo spam non è consentito in questo supegruppo.')

        -- bot.lua --
        set_text(LANG, 'botOn', 'Sono tornata.')
        set_text(LANG, 'botOff', 'Nulla da fare qui.')

        -- settings.lua --
        set_text(LANG, 'user', 'Utente')
        set_text(LANG, 'isFlooding', 'sta floodando')

        set_text(LANG, 'noStickersT', 'Gli stickers non sono consentiti in questo gruppo.')
        set_text(LANG, 'noStickersL', 'Gli stickers non sono consentiti in questo supergruppo.')
        set_text(LANG, 'stickersT', 'Gli stickers sono ora consentiti in questo gruppo.')
        set_text(LANG, 'stickersL', 'Gli stickers non sono consentiti in questo supegruppo.')

        set_text(LANG, 'gifsT', 'Le gif sono ora consentite in questo gruppo.')
        set_text(LANG, 'gifsL', 'Le gif sono ora consentite in questo supergruppo.')
        set_text(LANG, 'noGifsT', 'Le gif non sono consentite in questo gruppo.')
        set_text(LANG, 'noGifsL', 'Le gif non sono consentite in questo supergruppo.')

        set_text(LANG, 'photosT', 'Le immagini sono ora consentite in questo gruppo.')
        set_text(LANG, 'photosL', 'Le immagini sono ora consentite in questo supergruppo.')
        set_text(LANG, 'noPhotosT', 'Le immagini non sono consentite in questo gruppo.')
        set_text(LANG, 'noPhotosL', 'Le immagini non sono consentite in questo supergruppo.')

        set_text(LANG, 'botsT', 'Bots are now allowed in this chat.')
        set_text(LANG, 'botsL', 'Bots are now allowed in this supergroup.')
        set_text(LANG, 'noBotsT', 'Bots are not allowed in this chat.')
        set_text(LANG, 'noBotsL', 'Bots are not allowed in this supergroup.')

        set_text(LANG, 'arabicT', 'I caratteri arabi sono ora consentiti in questo gruppo.')
        set_text(LANG, 'arabicL', 'I caratteri arabi sono ora consentiti in questo supergruppo.')
        set_text(LANG, 'noArabicT', 'I caratteri arabi non sono consentiti in questo gruppo.')
        set_text(LANG, 'noArabicL', 'I caratteri arabi non sono consentiti in questo supergruppo.')

        set_text(LANG, 'audiosT', 'I vocali sono ora consentiti in questo gruppo.')
        set_text(LANG, 'audiosL', 'I vocali sono ora consentiti in questo supergruppo.')
        set_text(LANG, 'noAudiosT', 'I vocali non consentiti in questo gruppo.')
        set_text(LANG, 'noAudiosL', 'I vocali non consentiti in questo supergruppo.')

        set_text(LANG, 'kickmeT', 'L\'autokick è ora abilitato in questo gruppo.')
        set_text(LANG, 'kickmeL', 'L\'autokick è ora abilitato in questo supergruppo.')
        set_text(LANG, 'noKickmeT', 'L\'autokick non è abilitato in questo gruppo.')
        set_text(LANG, 'noKickmeL', 'L\'autokick non è abilitato in questo supergruppo.')

        set_text(LANG, 'floodT', 'Il flood è ora consentito in questo gruppo.')
        set_text(LANG, 'floodL', 'Il flood è ora consentito in questo supergruppo.')
        set_text(LANG, 'noFloodT', 'Il flood non è consentito in questo gruppo.')
        set_text(LANG, 'noFloodL', 'Il flood non è consentito in questo supergruppo.')

        set_text(LANG, 'floodTime', 'L\'intervallo di tempo per il controllo del flood è stato impostato a ')
        set_text(LANG, 'floodMax', 'Il numero di messaggi per floodare è stato impostato a ')

        set_text(LANG, 'gSettings', 'Impostazioni del gruppo')
        set_text(LANG, 'sSettings', 'Impostazioni del supergruppo')

        set_text(LANG, 'allowed', 'consentito')
        set_text(LANG, 'noAllowed', 'non consentito')
        set_text(LANG, 'noSet', 'non impostato')

        set_text(LANG, 'stickers', 'Stickers')
        set_text(LANG, 'links', 'Link')
        set_text(LANG, 'arabic', 'Caratteri arabi')
        set_text(LANG, 'bots', 'Bot')
        set_text(LANG, 'gifs', 'Gif')
        set_text(LANG, 'photos', 'Immagini')
        set_text(LANG, 'audios', 'Vocali')
        set_text(LANG, 'kickme', 'Kickme')
        set_text(LANG, 'spam', 'Spam')
        set_text(LANG, 'gName', 'Nome del gruppo')
        set_text(LANG, 'flood', 'Flood')
        set_text(LANG, 'language', 'Linguaggio')
        set_text(LANG, 'mFlood', 'Flood massimo')
        set_text(LANG, 'tFlood', 'Intervallo flood')
        set_text(LANG, 'setphoto', 'Immagine del gruppo')

        set_text(LANG, 'photoSaved', 'Foto salvata!')
        set_text(LANG, 'photoFailed', 'Errore, per favore prova di nuovo!')
        set_text(LANG, 'setPhotoAborted', 'Interruzione impostazione della foto...')
        set_text(LANG, 'sendPhoto', 'Per favore, invia un\'immagine')

        set_text(LANG, 'chatSetphoto', 'Puoi usare setphoto in questo gruppo.')
        set_text(LANG, 'channelSetphoto', 'Puoi usare setphoto in questo supergruppo.')
        set_text(LANG, 'notChatSetphoto', 'Non puoi usare setphoto in questo gruppo.')
        set_text(LANG, 'notChannelSetphoto', 'Non puoi usare setphoto in questo supergruppo.')
        set_text(LANG, 'setPhotoError', 'Per favore abilita l\'impostazione setphoto.')

        set_text(LANG, 'linkSaved', 'Nuovo link salvato.')
        set_text(LANG, 'groupLink', 'Link del gruppo')
        set_text(LANG, 'sGroupLink', 'Link del supergruppo')
        set_text(LANG, 'noLinkSet', 'Il link non è ancora stato settato. Per favore impostalo con #setlink [Link].')

        set_text(LANG, 'chatRename', 'Ora il gruppo può essere rinominato.')
        set_text(LANG, 'channelRename', 'Ora il supergruppo può essere rinominato.')
        set_text(LANG, 'notChatRename', 'Ora il gruppo non può essere rinominato.')
        set_text(LANG, 'notChannelRename', 'Ora il supergruppo non può essere rinominato.')

        set_text(LANG, 'lockMembersT', 'Il numero di membri è stato bloccato in questo gruppo.')
        set_text(LANG, 'lockMembersL', 'Il numero di membri è stato bloccato in questo supergruppo.')

        set_text(LANG, 'notLockMembersT', 'Il numero di membri è stato sbloccato in questo gruppo.')
        set_text(LANG, 'notLockMembersL', 'Il numero di membri è stato sbloccato in questo supergruppo.')

        set_text(LANG, 'langUpdated', 'La lingua del bot è stata aggiornata a: ')

        set_text(LANG, 'chatUpgrade', 'Chat aggiornata con successo.')
        set_text(LANG, 'notInChann', 'Non puoi farlo in un supergruppo.')
        set_text(LANG, 'desChanged', 'La descrizione del supergruppo è stata cambiata.')
        set_text(LANG, 'desOnlyChannels', 'La descrizione può essere cambiata solo nei supergruppi.')

        set_text(LANG, 'muteAll', 'Tutti sono silenziati.')
        set_text(LANG, 'unmuteAll', 'Tutti sono desilenziati.')
        set_text(LANG, 'muteAllX:1', 'Questo supergruppo è stato silenziato per')
        set_text(LANG, 'muteAllX:2', 'secondi.')

        set_text(LANG, 'createGroup:1', 'Group')
        set_text(LANG, 'createGroup:2', 'created.')
        set_text(LANG, 'newGroupWelcome', 'Welcome to your new group.')

        -- giverank.lua --
        set_text(LANG, 'alreadyAdmin', 'Questo utente è già un amministratore.')
        set_text(LANG, 'alreadyMod', 'Questo utente è già un moderatore.')

        set_text(LANG, 'newAdmin', 'Nuovo amministratore')
        set_text(LANG, 'newMod', 'Nuovo moderatore')
        set_text(LANG, 'nowUser', 'è ora un utente.')

        set_text(LANG, 'modList', 'Lista dei moderatori')
        set_text(LANG, 'adminList', 'Lista degli amministratori')
        set_text(LANG, 'modEmpty', 'La lista dei moderatori è vuota in questo gruppo.')
        set_text(LANG, 'adminEmpty', 'La lista degli amministratori è vuota.')

        -- id.lua --
        set_text(LANG, 'user', 'Utente')
        set_text(LANG, 'supergroupName', 'Nome del supergruppo')
        set_text(LANG, 'chatName', 'Nome del gruppo')
        set_text(LANG, 'supergroup', 'Supergruppo')
        set_text(LANG, 'chat', 'Gruppo')

        -- moderation.lua --
        set_text(LANG, 'userUnmuted:1', 'Utente')
        set_text(LANG, 'userUnmuted:2', 'desilenziato.')

        set_text(LANG, 'userMuted:1', 'Utente')
        set_text(LANG, 'userMuted:2', 'silenziato.')

        set_text(LANG, 'kickUser:1', 'Utente')
        set_text(LANG, 'kickUser:2', 'kickato.')

        set_text(LANG, 'banUser:1', 'Utente')
        set_text(LANG, 'banUser:2', 'bannato.')

        set_text(LANG, 'unbanUser:1', 'Utente')
        set_text(LANG, 'unbanUser:2', 'unbannato.')

        set_text(LANG, 'gbanUser:1', 'Utente')
        set_text(LANG, 'gbanUser:2', 'bannato globalmente.')

        set_text(LANG, 'ungbanUser:1', 'Utente')
        set_text(LANG, 'ungbanUser:2', 'unbannato globalmente.')

        set_text(LANG, 'addUser:1', 'Utente')
        set_text(LANG, 'addUser:2', 'aggiunto al gruppo.')
        set_text(LANG, 'addUser:3', 'aggiunto al supergruppo.')

        set_text(LANG, 'kickmeBye', 'ciao.')

        -- plugins.lua --
        set_text(LANG, 'plugins', 'Plugins')
        set_text(LANG, 'installedPlugins', 'plugins installati.')
        set_text(LANG, 'pEnabled', 'abilitato.')
        set_text(LANG, 'pDisabled', 'disabilitato.')

        set_text(LANG, 'isEnabled:1', 'Il plugin')
        set_text(LANG, 'isEnabled:2', 'è abilitato.')

        set_text(LANG, 'notExist:1', 'Il plugin')
        set_text(LANG, 'notExist:2', 'non esiste.')

        set_text(LANG, 'notEnabled:1', 'Il plugin')
        set_text(LANG, 'notEnabled:2', 'non è abilitato.')

        set_text(LANG, 'pNotExists', 'Il plugin non esiste.')

        set_text(LANG, 'pDisChat:1', 'Il plugin')
        set_text(LANG, 'pDisChat:2', 'è disabilitato in questa chat.')

        set_text(LANG, 'anyDisPlugin', 'Non ci sono plugin diabilitati.')
        set_text(LANG, 'anyDisPluginChat', 'Non ci sono plugin disabilitati in questa chat.')
        set_text(LANG, 'notDisabled', 'Questo plugin non è diabilitato')

        set_text(LANG, 'enabledAgain:1', 'Il plugin')
        set_text(LANG, 'enabledAgain:2', 'è di nuovo abilitato')

        -- commands.lua --
        set_text(LANG, 'commandsT', 'Comandi')
        set_text(LANG, 'errorNoPlug', 'Questo plugin non esiste o non ha una descrizione.')

        -- rules.lua --
        set_text(LANG, 'setRules', 'Regole chat aggiornate.')
        set_text(LANG, 'remRules', 'Regole chat rimosse.')

        -- feedback.lua --
        set_text(LANG, 'feedStart', '@EricSolinas hai ricevuto un feedback: #newfeedback\n\nMittente')
        set_text(LANG, 'feedName', '\nNome: ')
        set_text(LANG, 'feedSurname', '\nCognome: ')
        set_text(LANG, 'feedUsername', '\nUsername: @')
        set_text(LANG, 'feedSent', 'Feedback inviato!')

        -- qr.lua --
        set_text(LANG, 'opsError', 'Ops, errore.')

        -- apod.lua --
        set_text(LANG, 'opsError', 'Ops, errore.')

        -- pokedex.lua --
        set_text(LANG, 'noPoke', 'Nessun pokémon trovato.')
        set_text(LANG, 'pokeName', 'Nome: ')
        set_text(LANG, 'pokeWeight', 'Peso: ')
        set_text(LANG, 'pokeHeight', 'Altezza: ')
        set_text(LANG, 'pokeSpeed', 'Velocità: ')

        -- urbandictionary.lua --
        set_text(LANG, 'opsError', 'Ops, errore.')

        -- wiki.lua --
        set_text(LANG, 'extractNotFound', 'Estratto non trovato per ')
        set_text(LANG, 'noResult', 'Nessun risultato trovato')
        set_text(LANG, 'opsError', 'Ops, errore.')

        ------------------
        -- General info --
        ------------------
        set_text(LANG, 'generalInfo:1', 'Ogni \'#\' può essere sostituito con i simboli \'!\' o \'/\'.')
        set_text(LANG, 'generalInfo:2', 'Tutti i comandi sono Case Insensitive.')
        set_text(LANG, 'generalInfo:3', 'Le parentesi quadre significano opzionale.')
        set_text(LANG, 'generalInfo:4', 'Le parentesi tonde indicano una scelta evidenziata da \'|\' che significa "oppure".')

        ------------
        -- Usages --
        ------------

        -- bot.lua --
        set_text(LANG, 'bot:0', 2)
        set_text(LANG, 'bot:1', 'BOT')
        set_text(LANG, 'bot:2', '(#bot|sasha) on|off: abilita|disabilita il bot sul gruppo corrente.')

        -- commands.lua --
        set_text(LANG, 'commands:0', 3)
        set_text(LANG, 'commands:1', 'COMMANDS')
        set_text(LANG, 'commands:2', '#(commands|help all)|sasha aiuto tutto: mostra la descrizione di ogni plugin.')
        set_text(LANG, 'commands:3', '(#(commands|help)|sasha aiuto) <plugin>: descrizione di <plugin>.')

        -- giverank.lua --
        set_text(LANG, 'giverank:0', 7)
        set_text(LANG, 'giverank:1', 'GIVE RANK')
        set_text(LANG, 'giverank:2', '(#(rank|promote)|[sasha] promuovi) admin <id>|<username>|<reply>: promuovi ad amministratore.')
        set_text(LANG, 'giverank:3', '(#(rank|promote)|[sasha] promuovi) mod <id>|<username>|<reply>: promuovi a moderatore.')
        set_text(LANG, 'giverank:4', '#rank guest <id>|<username>|<reply>: togli ogni carica all\'utente.')
        set_text(LANG, 'giverank:5', '#admin[s][list]|[sasha] lista admin: lista amministratori del gruppo.')
        set_text(LANG, 'giverank:6', '#mod[s][list]|[sasha] lista mod: lista moderatori del gruppo.')
        set_text(LANG, 'giverank:7', '#member[s][list]|[sasha] lista membri: lista membri del gruppo.')

        -- id.lua --
        set_text(LANG, 'id:0', 7)
        set_text(LANG, 'id:1', 'ID')
        set_text(LANG, 'id:2', '#id: mostra il tuo ID e l\'ID del gruppo se ti trovi in una chat.')
        set_text(LANG, 'id:3', '#ids chat: mostra gli ID dei membri del gruppo.')
        set_text(LANG, 'id:4', '#ids channel: mostra gli ID dei membri del supergruppo.')
        set_text(LANG, 'id:5', '#id <username>: mostra l\'ID dell\'utente in questa chat.')
        set_text(LANG, 'id:6', '#whois <id_utente>|<username>: mostra lo username.')
        set_text(LANG, 'id:7', '#whois (risposta): mostra l\'ID.')

        -- moderation.lua --
        set_text(LANG, 'moderation:0', 14)
        set_text(LANG, 'moderation:1', 'MODERATION')
        set_text(LANG, 'moderation:2', '(#kickme|[sasha] uccidimi): fatti rimuovere.')
        set_text(LANG, 'moderation:3', '(#mute|[sasha] togli voce) <id>|<username>|<reply>: silenzia un utente nel supergruppo, ogni suo messaggio verrà cancellato.')
        set_text(LANG, 'moderation:4', '(#unmute|[sasha] dai voce) <id>|<username>|<reply>: desilenzia un utente nel supergruppo.')
        set_text(LANG, 'moderation:5', '(#mutelist|[sasha] lista muti): manda la lista degli utenti muti.')
        set_text(LANG, 'moderation:6', '#kick|[sasha] uccidi|spara <id>|<username>|<reply>: rimuovi un utente dal gruppo/supergruppo.')
        set_text(LANG, 'moderation:7', '(#kicknouser|[sasha] uccidi nouser|spara nouser): rimuovi tutti gli utenti senza username dal gruppo/supergruppo.')
        set_text(LANG, 'moderation:8', '#ban|[sasha] banna|[sasha] decompila|esplodi|kaboom <id>|<username>|<reply>: banna un utente dal gruppo/supergruppo.')
        set_text(LANG, 'moderation:9', '(#unban|[sasha] sbanna|[sasha] [ri]compila) <id>|<username>|<reply>: unbanna un utente dal gruppo/supergruppo.')
        set_text(LANG, 'moderation:10', '(#banlist|[sasha] lista ban): manda la lista degli utenti bannati.')
        set_text(LANG, 'moderation:11', '(#gban|[sasha] superbanna) <id>|<username>|<reply>: banna globalmente un utente da ogni gruppo/supergruppo.')
        set_text(LANG, 'moderation:12', '(#ungban|[sasha] supersbanna) <id>|<username>|<reply>: unbanna globalmente un utente da ogni gruppo/supergruppo.')
        set_text(LANG, 'moderation:13', '(#gbanlist|[sasha] lista superban): manda la lista degli utenti bannati globalmente.')
        set_text(LANG, 'moderation:14', '(#add|#invite|[sasha] invita|[sasha] resuscita) <id>|<username>|<reply>: aggiungi un utente al gruppo/supergruppo.')

        -- settings.lua --
        set_text(LANG, 'settings:0', 23)
        set_text(LANG, 'settings:1', 'SETTINGS')
        set_text(LANG, 'settings:2', '#settings stickers enable|disable: quando abilitato, ogni sticker verrà rimosso.')
        set_text(LANG, 'settings:3', '#settings links enable|disable: quando abilitato, ogni link verrà rimosso.')
        set_text(LANG, 'settings:4', '#settings arabic enable|disable: quando abilitato, ogni messaggio contenente caratteri arabi e persiani verrà rimosso.')
        set_text(LANG, 'settings:5', '#settings bots enable|disable: quando abilitato, ogni ogni bot aggiunto verrà rimosso.')
        set_text(LANG, 'settings:6', '#settings gifs enable|disable: quando abilitato, ogni gif verrà rimossa.')
        set_text(LANG, 'settings:7', '#settings photos enable|disable: quando abilitato, ogni immagine verrà rimossa.')
        set_text(LANG, 'settings:8', '#settings audios enable|disable: quando abilitato, ogni vocale verrà rimosso.')
        set_text(LANG, 'settings:9', '#settings kickme enable|disable: quando abilitato, gli utenti possono kickarsi autonomamente.')
        set_text(LANG, 'settings:10', '#settings spam enable|disable: quando abilitato, ogni link spam verrà rimosso.')
        set_text(LANG, 'settings:11', '#settings setphoto enable|disable: quando abilitato, se un utente cambia icona del gruppo, il bot ripristinerà quella salvata.')
        set_text(LANG, 'settings:12', '#settings setname enable|disable: quando abilitato, se un utente cambia il nome del gruppo, il bot ripristinerà il nome salvato.')
        set_text(LANG, 'settings:13', '#settings lockmembers enable|disable: quando abilitato, il bot rimuoverà ogni utente che etrerà nel gruppo.')
        set_text(LANG, 'settings:14', '#settings floodtime <secondi>: imposta l\'intervallo di monitoraggio del flood.')
        set_text(LANG, 'settings:15', '#settings maxflood <messaggi>: imposta il numero di messaggi inviati nel floodtime affinchè vengano considerati flood.')
        set_text(LANG, 'settings:16', '#setname <name>: cambia il nome della chat.')
        set_text(LANG, 'settings:17', '(#setdescription|sasha imposta descrizione) <text>: cambia la descrizione del supergruppo.')
        set_text(LANG, 'settings:18', '#setphoto <poi invia la foto>: cambia la foto della chat.')
        set_text(LANG, 'settings:19', '#lang <language (en, es...)>: cambia l\'idioma del bot.')
        set_text(LANG, 'settings:20', '(#newlink|sasha crea link) <link>: crea il link del gruppo.')
        set_text(LANG, 'settings:21', '(#setlink|sasha imposta link) <link>: salva il link del gruppo.')
        set_text(LANG, 'settings:22', '[#]link: mostra il link del gruppo.')
        set_text(LANG, 'settings:23', '#rem <reply>: rimuove un messaggio.')

        -- plugins.lua --
        set_text(LANG, 'plugins:0', 5)
        set_text(LANG, 'plugins:1', 'PLUGINS')
        set_text(LANG, 'plugins:2', '(#plugins|[sasha] lista plugins): mostra una lista di tutti i plugin.')
        set_text(LANG, 'plugins:3', '(#[plugin[s]] enable|disable)|([sasha] abilita|attiva|disabilita|disattiva) <plugin>: abilita|disabilita il plugin specificato.')
        set_text(LANG, 'plugins:4', '(#[plugin[s]] enable|disable)|([sasha] abilita|attiva|disabilita|disattiva) <plugin> chat: abilita|disabilita il plugin specificato solo sulla chat corrente.')
        set_text(LANG, 'plugins:5', '(#[plugin[s]] reload)|([sasha] ricarica): ricarica tutti i plugin.')

        -- version.lua --
        set_text(LANG, 'version:0', 2)
        set_text(LANG, 'version:1', 'VERSION')
        set_text(LANG, 'version:2', '#version: mostra la versione del bot.')

        -- rules.lua --
        set_text(LANG, 'rules:0', 4)
        set_text(LANG, 'rules:1', 'RULES')
        set_text(LANG, 'rules:2', '#rules|sasha regole: mostra le regole della chat.')
        set_text(LANG, 'rules:3', '(#setrules|sasha imposta regole) <text>: imposta le regole della chat.')
        set_text(LANG, 'rules:4', '#remrules|sasha rimuovi regole: rimuove le regole della chat.')

        -- get.lua --
        set_text(LANG, 'get:0', 3)
        set_text(LANG, 'get:1', 'GET')
        set_text(LANG, 'get:2', '(#get|#getlist|sasha lista): mostra la lista delle variabili settate.')
        set_text(LANG, 'get:3', '[#get] <var_name>: manda il testo associato a <var_name>.')

        -- set.lua --
        set_text(LANG, 'set:0', 2)
        set_text(LANG, 'set:1', 'SET')
        set_text(LANG, 'set:2', '(#set|[sasha] setta) <var_name> <text>: setta <text> in risposta a <var_name>.')

        -- unset.lua --
        set_text(LANG, 'unset:0', 2)
        set_text(LANG, 'unset:1', 'UNSET')
        set_text(LANG, 'unset:2', '(#unset|[sasha] unsetta) <var_name>: elimina <var_name>.')

        -- tagall.lua --
        set_text(LANG, 'tagall:0', 2)
        set_text(LANG, 'tagall:1', 'TAGALL')
        set_text(LANG, 'tagall:2', '(#tagall|sasha tagga tutti) <text>: tagga tutti gli utenti con username del gruppo/supergruppo.')

        -- shout.lua --
        set_text(LANG, 'shout:0', 2)
        set_text(LANG, 'shout:1', 'SHOUT')
        set_text(LANG, 'shout:2', '([#]shout|[sasha] grida|[sasha] urla) <text>: "urla" <text>.')

        -- ruleta.lua --
        set_text(LANG, 'ruleta:0', 3)
        set_text(LANG, 'ruleta:1', 'RULETA')
        set_text(LANG, 'ruleta:2', '[#]ruleta: estrae un numero casuale tra 0 e 10, se è uguale rimuove l\'utente dal gruppo/supergruppo.')
        set_text(LANG, 'ruleta:3', '#kick|[sasha] uccidi|spara random: sceglie un utente a caso e lo rimuove dal gruppo supergruppo.')

        -- feedback.lua --
        set_text(LANG, 'feedback:0', 2)
        set_text(LANG, 'feedback:1', 'FEEDBACK')
        set_text(LANG, 'feedback:2', '[#]feedback: invia un feedback al creatore del bot.')

        -- echo.lua --
        set_text(LANG, 'echo:0', 1)
        set_text(LANG, 'echo:1', 'ECHO')
        set_text(LANG, 'echo:2', '(#echo|sasha ripeti) <text>: ripete <text>.')

        -- dogify.lua --
        set_text(LANG, 'dogify:0', 2)
        set_text(LANG, 'dogify:1', 'DOGIFY')
        set_text(LANG, 'dogify:2', '(#dogify|[sasha] doge) <your/words/with/slashes>: crea un\'immagine col doge e le parole specificate.')

        -- words.lua --
        set_text(LANG, 'words:0', 2)
        set_text(LANG, 'words:1', 'WORDS')
        set_text(LANG, 'words:2', 'gangbang|maometto|maometo|cancaroman|mohammed|nazi|hitler')

        -- tex.lua --
        set_text(LANG, 'tex:0', 2)
        set_text(LANG, 'tex:1', 'TEX')
        set_text(LANG, 'tex:2', '(#tex|[sasha] equazione) <equation>: converte <equation> in immagine.')

        -- qr.lua --
        set_text(LANG, 'qr:0', 2)
        set_text(LANG, 'qr:1', 'QR')
        set_text(LANG, 'qr:2', '[#]|[sasha] qr ["<background_color>" "<data_color>"] <text>: crea il QR Code di <text> e se specificato lo colora, i colori possono essere specificati come segue:\nTesto => red|green|blue|purple|black|white|gray.\nNotazione Esadecimale => (\"a56729\" è marrone).\nNotazione Decimale => (\"255-192-203\" è rosa).')

        -- apod.lua --
        set_text(LANG, 'apod:0', 4)
        set_text(LANG, 'apod:1', 'APOD')
        set_text(LANG, 'apod:2', '#(apod|astro) [<date>]: manda l\'APOD.')
        set_text(LANG, 'apod:3', '#(apod|astro)hd [<date>]: manda l\'APOD in HD.')
        set_text(LANG, 'apod:4', '#(apod|astro)text [<date>]: manda la spiegazione dell\'APOD.')

        -- google.lua --
        set_text(LANG, 'google:0', 2)
        set_text(LANG, 'google:1', 'GOOGLE')
        set_text(LANG, 'google:2', '(#google|[sasha] googla) <terms>: manda i primi risultati di google.')

        -- pokedex.lua --
        set_text(LANG, 'pokedex:0', 2)
        set_text(LANG, 'pokedex:1', 'POKÉDEX')
        set_text(LANG, 'pokedex:2', '#(pokémon|pokédex) <name>|<id>: manda le informazioni del pokémon.')

        -- urbandictionary.lua --
        set_text(LANG, 'urbandictionary:0', 2)
        set_text(LANG, 'urbandictionary:1', 'URBAN DICTIONARY')
        set_text(LANG, 'urbandictionary:2', '(#urbandictionary|([#]|[sasha] urban)|([#]|[sasha] ud)) <text>: mostra la definizione dell\'urban dictionary di <text>.')

        -- webshot.lua --
        set_text(LANG, 'webshot:0', 2)
        set_text(LANG, 'webshot:1', 'WEBSHOT')
        set_text(LANG, 'webshot:2', '[#]|[sasha] webshot <link>: manda lo screenshot di un sito.')

        -- wiki.lua --
        set_text(LANG, 'wiki:0', 2)
        set_text(LANG, 'wiki:1', 'WIKI')
        set_text(LANG, 'wiki:2', '[#]|[sasha] wiki[lang] <text>: manda un estratto da [lang] Wikipedia.')
        set_text(LANG, 'wiki:2', '[#]|[sasha] wiki[lang] search <text>: manda gli articoli di [lang] Wikipedia.')

        if matches[1]:lower() == 'install' then
            return 'ℹ️¸ L\'italiano è stato installato come lingua del bot.'
        elseif matches[1]:lower() == 'update' then
            return 'ℹ️ Stringhe italiane aggiornate.'
        end
    else
        return "ℹ️ Questo plugin richiede i privilegi di sudo."
    end
end

return {
    patterns =
    {
        '#([iI][nN][sS][tT][aA][lL][lL]) (italian_lang)$',
        '#([uU][pP][dD][aA][tT][eE]) (italian_lang)$',
        '#([iI][nN][sS][tT][aA][lL][lL]) ([Ii][Tt])$',
        '#([uU][pP][dD][aA][tT][eE]) ([Ii][Tt])$',
    },
    run = run
}
