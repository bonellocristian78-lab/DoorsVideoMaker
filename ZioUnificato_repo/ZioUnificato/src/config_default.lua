--[[
    src/config_default.lua — config di default
    Questo file NON viene caricato dal loadstring. È qui per leggibilità
    e per chi vuole vedere il config isolato. Se vuoi cambiare i default
    che si caricano all'avvio, modifica la sezione §1 di init.lua.
]]--

return {
    Locale = "it",  -- "it" | "en" | "es" | "pt"

    Phase1 = {
        Speed = 25, StartDelay = 3.5, RoomsTrigger = 4,
        Damage = 20, DamageRange = 28,
        ModelURL = "https://github.com/RegularVynixu/DOORS-Entity-Spawner-V2/raw/main/Assets/Entities/Rush.rbxm",
        CrucifixType = "Starlight",
    },
    Phase2 = {
        Speed = 160, StartDelay = 0.4,
        Damage = 125, DamageRange = 40,
        ReboundMin = 1, ReboundMax = 3, ReboundDelay = 1.4,
        ModelURL = "https://github.com/RegularVynixu/DOORS-Entity-Spawner-V2/raw/main/Assets/Entities/Ambush.rbxm",
        CrucifixType = "Moonlight",
    },
    Sounds = {
        Whisper   = "rbxassetid://1843576423",
        Heartbeat = "rbxassetid://178948095",
        Jumpscare = "rbxassetid://4559876899",
        Footsteps = "rbxassetid://507777826",
        Static    = "rbxassetid://166189220",
    },
    Achievement = {
        AccentColor = Color3.fromRGB(150, 70, 255),
        TitleColor  = Color3.fromRGB(220, 190, 255),
        TextColor   = Color3.fromRGB(165, 145, 200),
        Image       = "rbxassetid://12309073114",
    },
    GlitchEnabled = true,
}
