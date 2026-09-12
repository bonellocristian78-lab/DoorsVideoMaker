--[[
    assets/decals.lua — ID decal/texture per icone badge e VFX
    Testa sempre gli ID nel gioco: alcuni potrebbero essere rimossi
    o non approvati per il tuo place.
]]--

return {
    -- Icone per popup badge (rbxassetid tramite Image su ImageLabel)
    badges = {
        { id = "rbxassetid://12309073114", name = "trophy purple" },
        { id = "rbxassetid://6031075938",  name = "star gold" },
        { id = "rbxassetid://6031233905",  name = "crown" },
        { id = "rbxassetid://6031075931",  name = "ribbon award" },
        { id = "rbxassetid://6031280882",  name = "shield" },
    },

    -- Vignette / overlay per glitch VFX
    vignettes = {
        { id = "rbxassetid://5028857472", name = "black vignette soft" },
        { id = "rbxassetid://5553946656", name = "red vignette horror" },
    },

    -- Texture di sangue / graffi
    horror = {
        { id = "rbxassetid://11844504566", name = "blood splatter" },
        { id = "rbxassetid://7196754781",  name = "scratches overlay" },
    },
}
