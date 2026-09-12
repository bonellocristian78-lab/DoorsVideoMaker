--[[
    assets/sounds.lua — ID audio curati per DOORS
    Testati sul main game DOORS. Su DOORS Hotel alcuni potrebbero
    dare "Asset is not approved for the requester" — è un limite del
    place, non dello script. In quel caso lascia il campo vuoto e
    usa quelli nativi del gioco (silenzio è meglio di crash).

    Ricerca sulla Creator Marketplace:
    https://create.roblox.com/store/marketplace/audio
]]--

return {
    -- Sussurri ambientali
    whispers = {
        { id = "rbxassetid://1843576423", name = "whisper ambient soft" },
        { id = "rbxassetid://5153475906", name = "creepy whisper 2" },
        { id = "rbxassetid://9046863754", name = "distant whisper" },
    },

    -- Battiti cardiaci in loop
    heartbeats = {
        { id = "rbxassetid://178948095",  name = "heartbeat slow" },
        { id = "rbxassetid://5578930010", name = "heartbeat medium" },
    },

    -- Jumpscare sting
    jumpscares = {
        { id = "rbxassetid://4559876899", name = "jumpscare sting classic" },
        { id = "rbxassetid://7098976946", name = "jumpscare short blast" },
        { id = "rbxassetid://8300583177", name = "horror hit stinger" },
    },

    -- Passi pesanti
    footsteps = {
        { id = "rbxassetid://507777826",  name = "heavy footsteps" },
        { id = "rbxassetid://9046732418", name = "monster stomps" },
    },

    -- Static / rumore
    statics = {
        { id = "rbxassetid://166189220",  name = "radio static" },
        { id = "rbxassetid://7503097543", name = "tv noise burst" },
    },

    -- Suoni del crocifisso (per Custom Lights)
    crucifix = {
        { id = "rbxassetid://4559876899", name = "banish sting" },
        { id = "rbxassetid://9046863754", name = "divine wind" },
        { id = "rbxassetid://6924067987", name = "holy chime" },
    },
}
