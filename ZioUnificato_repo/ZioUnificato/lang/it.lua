--[[
    Italiano — ZioUnificato
    Chiavi usate ovunque nel main. Aggiungi/modifica liberamente.
]]--

return {
    code = "it",
    name = "Italiano",

    -- Notifiche
    notif_ready         = "ZioUnificato pronto. Menu con RightControl.",
    notif_session_busy  = "Sessione già attiva.",
    notif_p1_fail       = "Fase 1 fallita — sei in DOORS Hotel?",
    notif_p2_fail       = "Fase 2 fallita.",
    notif_anomaly       = "Presenze anomale rilevate.",
    notif_zio_here      = "LO ZIO È QUI.",
    notif_rebound       = ">> RIMBALZO",
    notif_leaving       = "Si allontana...",
    notif_exorcised     = "%s ha bandito lo Zio.",
    notif_url_copied    = "URL copiato — incolla nel browser (%s)",
    notif_no_clipboard  = "setclipboard non supportato dal tuo executor",
    notif_light_loaded  = "Luce caricata: %s",
    notif_light_fail    = "URL non valido o file rotto",
    notif_reset_done    = "Progressi cancellati.",

    -- UI Tabs
    tab_session   = "Sessione",
    tab_phases    = "Fasi",
    tab_sounds    = "Suoni",
    tab_models    = "Modelli",
    tab_lights    = "Luci",
    tab_look      = "Aspetto",
    tab_badges    = "Badge",

    -- UI Buttons
    btn_start     = "Avvia lo Zio",
    btn_stop      = "Ferma sessione",
    btn_preview   = "Anteprima popup",
    btn_reset     = "Reset progressi",
    btn_load      = "Carica luce",
    btn_refresh   = "Aggiorna",
    btn_search    = "+  cerca «%s»",

    -- UI Labels
    lbl_glitch    = "Glitch VFX",
    lbl_speed     = "Velocità",
    lbl_damage    = "Danno",
    lbl_rooms     = "Stanze al rush",
    lbl_rebound_min = "Rebound min",
    lbl_rebound_max = "Rebound max",
    lbl_crucifix  = "Crocifisso",
    lbl_accent    = "Accent",
    lbl_title     = "Titolo",
    lbl_desc      = "Descrizione",
    lbl_stats     = "Run: %d  |  Sopravvivenze: %d  |  Morti: %d",

    -- Popup badge
    badge_unlocked = "BADGE SBLOCCATO",
    preview_title  = "Anteprima",
    preview_desc   = "Ecco come apparirà un badge.",

    -- Death hints (Fase 1 e 2)
    hints_phase1 = { "Lo sentivi, vero?", "Era sempre lì.", "Guardava dal buio.", "Aspettava il momento." },
    hints_phase2 = { "Non potevi scappare.", "Era già davanti a te.", "Lo Zio non perdona.", "Correvi. Lui era più veloce." },

    -- Nomi entità (mostrati come "Killed by …")
    entity_phase1 = "Zio — Ombra",
    entity_phase2 = "Zio — Scatto",
}
