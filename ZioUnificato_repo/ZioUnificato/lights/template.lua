--[[
    Custom Light — Template
    Copia questo file, modifica i valori, hostalo su GitHub (raw) o Pastebin.
    Poi nell'UI di ZioUnificato: tab "Luci" → incolla URL → "Carica luce".

    Il file DEVE fare `return` di una tabella con questi campi.
]]--

return {
    -- Nome visibile nel dropdown "Tipo Crocifisso"
    Name = "MiaLuce",

    -- Base animazione: "Guiding" (blu neutro) o "Curious" (giallo caldo)
    Architecture = "Guiding",

    -- Colore del pentagramma + glow del crocifisso
    Color = Color3.fromRGB(255, 128, 0),

    -- Colore del flash schermo quando esorcizza
    FlashColor = Color3.fromRGB(255, 96, 0),

    -- (opzionale) Suono aggiuntivo durante l'esorcismo
    SoundId = nil,  -- es. "rbxassetid://4559876899"
}
