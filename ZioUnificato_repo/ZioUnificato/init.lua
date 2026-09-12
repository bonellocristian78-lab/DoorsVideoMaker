--[[
    ╔══════════════════════════════════════════════════════════════════╗
    ║  ZioUnificato — init.lua                                         ║
    ║  Engine  : Roblox Luau (executor, client-only)                   ║
    ║  Version : 6.0.0                                                 ║
    ║  Target  : DOORS / DOORS Hotel                                   ║
    ╠══════════════════════════════════════════════════════════════════╣
    ║  Come funziona in 3 righe:                                       ║
    ║  · Bifasico: Fase 1 stalking (25 speed) → Fase 2 rush (160)      ║
    ║  · UI Obsidian a 7 tab, tutte le config live                     ║
    ║  · 17 badge sbloccabili, salvati via writefile locale            ║
    ╠══════════════════════════════════════════════════════════════════╣
    ║  CREDITS                                                         ║
    ║  RegularVynixu   → DOORS Entity Spawner V2                       ║
    ║  RegularVynixu   → DOORS Custom Achievements                     ║
    ║  deividcomsono   → Obsidian UI Library                           ║
    ║  Larpbase        → design & implementation                       ║
    ╚══════════════════════════════════════════════════════════════════╝
]]--

print("[ZioUnif] 1. avvio")

-- ══════════════════════════════════════════════════════════════════
-- §1  CONFIG DI DEFAULT (modificabile via UI dopo l'avvio)
-- ══════════════════════════════════════════════════════════════════

local CONFIG = {
    Locale = "it",
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

-- ══════════════════════════════════════════════════════════════════
-- §2  BADGE REGISTRY
-- ══════════════════════════════════════════════════════════════════

local BADGES = {
    { id="first_encounter",  title="Sguardo nel Buio",      desc="Vedi lo Zio per la prima volta." },
    { id="first_hit",        title="Prima Ferita",          desc="Ricevi il primo danno." },
    { id="first_survive",    title="Sopravvissuto",         desc="Sopravvivi al rush completo." },
    { id="crux_guiding",     title="Guida Divina",          desc="Esorcizza con la Guiding Light." },
    { id="crux_curious",     title="Curiosità Domata",      desc="Esorcizza con la Curious Light." },
    { id="crux_starlight",   title="Stellare",              desc="Esorcizza con la Starlight." },
    { id="crux_moonlight",   title="Lunatico",              desc="Esorcizza con la Moonlight." },
    { id="crux_mischievous", title="Marachella",            desc="Esorcizza con la Mischievous Light." },
    { id="crux_custom",      title="Artigiano di Luce",     desc="Esorcizza con una Custom Light." },
    { id="crux_all",         title="Collezionista di Luci", desc="Usa tutti e 5 i tipi predefiniti." },
    { id="phase1_only",      title="Zio Timido",            desc="Esorcizza durante la Fase 1." },
    { id="no_damage_run",    title="Ombra Perfetta",        desc="Completa una run senza danno." },
    { id="speedrun",         title="Fulmine",               desc="Fase 2 despawna in <15s." },
    { id="runs_10",          title="Assiduo",               desc="10 run totali." },
    { id="runs_50",          title="Ossessionato",          desc="50 run totali." },
    { id="survives_5",       title="Cinque Vite",           desc="Sopravvivi 5 volte." },
    { id="survives_25",      title="Immortale",             desc="Sopravvivi 25 volte." },
}

-- ══════════════════════════════════════════════════════════════════
-- §3  MULTI-LINGUA
-- Modifica REPO_BASE con il tuo repo raw base (poi commit + push)
-- ══════════════════════════════════════════════════════════════════

local REPO_BASE = "local REPO_BASE = "https://raw.githubusercontent.com/bonellocristian78-lab/DoorsVideoMaker/main/ZioUnificato_repo/ZioUnificato""

local LOCALE_URLS = {
    it = REPO_BASE .. "/lang/it.lua",
    en = REPO_BASE .. "/lang/en.lua",
    es = REPO_BASE .. "/lang/es.lua",
    pt = REPO_BASE .. "/lang/pt.lua",
}

-- Fallback italiano inline (usato se HttpGet dei lang fallisce)
local FALLBACK_LOCALE = {
    code="it", name="Italiano (fallback)",
    notif_ready="ZioUnificato pronto. Menu con RightControl.",
    notif_session_busy="Sessione già attiva.",
    notif_p1_fail="Fase 1 fallita — sei in DOORS Hotel?",
    notif_p2_fail="Fase 2 fallita.",
    notif_anomaly="Presenze anomale rilevate.",
    notif_zio_here="LO ZIO È QUI.",
    notif_rebound=">> RIMBALZO",
    notif_leaving="Si allontana...",
    notif_exorcised="%s ha bandito lo Zio.",
    notif_url_copied="URL copiato — incolla nel browser (%s)",
    notif_no_clipboard="setclipboard non supportato dal tuo executor",
    notif_light_loaded="Luce caricata: %s",
    notif_light_fail="URL non valido o file rotto",
    notif_reset_done="Progressi cancellati.",
    tab_session="Sessione", tab_phases="Fasi", tab_sounds="Suoni",
    tab_models="Modelli",   tab_lights="Luci", tab_look="Aspetto",
    tab_badges="Badge",
    btn_start="Avvia lo Zio", btn_stop="Ferma sessione",
    btn_preview="Anteprima popup", btn_reset="Reset progressi",
    btn_load="Carica luce", btn_refresh="Aggiorna",
    btn_search="+  cerca «%s»",
    lbl_glitch="Glitch VFX", lbl_speed="Velocità", lbl_damage="Danno",
    lbl_rooms="Stanze al rush", lbl_rebound_min="Rebound min",
    lbl_rebound_max="Rebound max", lbl_crucifix="Crocifisso",
    lbl_accent="Accent", lbl_title="Titolo", lbl_desc="Descrizione",
    lbl_stats="Run: %d  |  Sopravvivenze: %d  |  Morti: %d",
    badge_unlocked="BADGE SBLOCCATO",
    preview_title="Anteprima", preview_desc="Ecco come apparirà un badge.",
    hints_phase1={ "Lo sentivi, vero?", "Era sempre lì.", "Guardava dal buio." },
    hints_phase2={ "Non potevi scappare.", "Era già davanti a te.", "Lo Zio non perdona." },
    entity_phase1="Zio — Ombra", entity_phase2="Zio — Scatto",
}

local LOCALES = {}  -- popolato con tutti i lang caricati

local function LoadLocales()
    for code, url in next, LOCALE_URLS do
        local ok, res = pcall(function()
            return loadstring(game:HttpGet(url))()
        end)
        if ok and type(res) == "table" then
            LOCALES[code] = res
            print("[ZioUnif] lang OK:", code)
        else
            print("[ZioUnif] lang FAIL:", code, "→ fallback")
        end
    end
    if not LOCALES[CONFIG.Locale] then
        LOCALES[CONFIG.Locale] = FALLBACK_LOCALE
    end
end

local L = FALLBACK_LOCALE  -- verrà rimpiazzato dopo LoadLocales()

-- ══════════════════════════════════════════════════════════════════
-- §4  SERVIZI + LIBRERIE ESTERNE (ciascuna in pcall)
-- ══════════════════════════════════════════════════════════════════

local HttpService  = game:GetService("HttpService")
local Players      = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local SoundService = game:GetService("SoundService")
local RunService   = game:GetService("RunService")

local LP = Players.LocalPlayer
local PG = LP:WaitForChild("PlayerGui")

print("[ZioUnif] 2. carico locale…")
LoadLocales()
L = LOCALES[CONFIG.Locale] or FALLBACK_LOCALE

print("[ZioUnif] 3. carico Obsidian…")
local Library
do
    local ok, res = pcall(function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/deividcomsono/Obsidian/main/Library.lua"))()
    end)
    if not ok then warn("[ZioUnif] FAIL Obsidian:", res); return end
    Library = res
end

print("[ZioUnif] 4. carico Spawner V2…")
local Spawner
do
    local ok, res = pcall(function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/DOORS-Entity-Spawner-V2/main/init.luau"))()
    end)
    if not ok then warn("[ZioUnif] FAIL Spawner:", res); return end
    Spawner = res
end

print("[ZioUnif] 5. carico Achievements…")
local Achievements
do
    local ok, res = pcall(function()
        return loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/DOORS-Custom-Achievements/main/init.luau"))()
    end)
    if not ok then warn("[ZioUnif] FAIL Achievements:", res); return end
    Achievements = res
end

-- ══════════════════════════════════════════════════════════════════
-- §5  STATS PERSISTENTI (writefile opzionale)
-- ══════════════════════════════════════════════════════════════════

local STATS_FILE = "ZioUnificato_Stats.json"
local Stats = { runs=0, survives=0, deaths=0, cruxUsed={} }

pcall(function()
    if isfile and isfile(STATS_FILE) then
        Stats = HttpService:JSONDecode(readfile(STATS_FILE))
        Stats.cruxUsed = Stats.cruxUsed or {}
    end
end)

local function SaveStats()
    pcall(function()
        if writefile then
            writefile(STATS_FILE, HttpService:JSONEncode(Stats))
        end
    end)
end

-- ══════════════════════════════════════════════════════════════════
-- §6  ACHIEVEMENT POPUP + UNLOCK
-- ══════════════════════════════════════════════════════════════════

local function ShowPopup(title, desc)
    local cfg = CONFIG.Achievement
    local g = Instance.new("ScreenGui")
    g.Name = "ZioAch"; g.ResetOnSpawn = false; g.IgnoreGuiInset = true; g.Parent = PG
    local p = Instance.new("Frame")
    p.Size = UDim2.new(0, 305, 0, 78); p.Position = UDim2.new(1, 10, 1, -125)
    p.BackgroundColor3 = Color3.fromRGB(11, 11, 17); p.BorderSizePixel = 0; p.Parent = g
    Instance.new("UICorner", p).CornerRadius = UDim.new(0, 8)
    local sk = Instance.new("UIStroke"); sk.Color = cfg.AccentColor; sk.Thickness = 1.5; sk.Parent = p

    local iF = Instance.new("Frame")
    iF.Size = UDim2.new(0, 54, 0, 54); iF.Position = UDim2.new(0, 12, 0.5, -27)
    iF.BackgroundColor3 = cfg.AccentColor; iF.BackgroundTransparency = 0.72
    iF.BorderSizePixel = 0; iF.Parent = p
    Instance.new("UICorner", iF).CornerRadius = UDim.new(0, 6)
    local ic = Instance.new("ImageLabel")
    ic.Size = UDim2.new(1, -8, 1, -8); ic.Position = UDim2.new(0, 4, 0, 4)
    ic.BackgroundTransparency = 1; ic.Image = cfg.Image; ic.Parent = iF

    local h = Instance.new("TextLabel")
    h.Size = UDim2.new(1, -82, 0, 15); h.Position = UDim2.new(0, 74, 0, 10)
    h.BackgroundTransparency = 1; h.Text = L.badge_unlocked
    h.TextColor3 = cfg.AccentColor; h.Font = Enum.Font.GothamBold
    h.TextSize = 9; h.TextXAlignment = Enum.TextXAlignment.Left; h.Parent = p

    local t = Instance.new("TextLabel")
    t.Size = UDim2.new(1, -82, 0, 22); t.Position = UDim2.new(0, 74, 0, 24)
    t.BackgroundTransparency = 1; t.Text = title
    t.TextColor3 = cfg.TitleColor; t.Font = Enum.Font.GothamBold
    t.TextSize = 15; t.TextXAlignment = Enum.TextXAlignment.Left; t.Parent = p

    local d = Instance.new("TextLabel")
    d.Size = UDim2.new(1, -82, 0, 13); d.Position = UDim2.new(0, 74, 0, 48)
    d.BackgroundTransparency = 1; d.Text = desc
    d.TextColor3 = cfg.TextColor; d.Font = Enum.Font.Gotham
    d.TextSize = 11; d.TextXAlignment = Enum.TextXAlignment.Left; d.Parent = p

    TweenService:Create(p, TweenInfo.new(0.55, Enum.EasingStyle.Back, Enum.EasingDirection.Out),
        { Position = UDim2.new(1, -320, 1, -125) }):Play()
    task.delay(5, function()
        TweenService:Create(p, TweenInfo.new(0.4), { Position = UDim2.new(1, 10, 1, -125) }):Play()
        task.delay(0.45, function() if g.Parent then g:Destroy() end end)
    end)
end

local function HasBadge(id)
    local ok, res = pcall(Achievements.CheckOwned, Achievements, "ZioUnif_" .. id)
    return ok and res
end

local function BadgeInfo(id)
    for _, b in next, BADGES do if b.id == id then return b end end
end

local function UnlockBadge(id)
    if HasBadge(id) then return false end
    local info = BadgeInfo(id); if not info then return false end
    pcall(function()
        Achievements:Grant({
            Identifier = "ZioUnif_" .. id,
            Title      = info.title,
            Desc       = info.desc,
            Reason     = "ZioUnificato",
            Image      = CONFIG.Achievement.Image,
        }, { CheckOwned = true, Remember = true })
    end)
    ShowPopup(info.title, info.desc)
    print("[ZioUnif] badge:", id)
    return true
end

-- ══════════════════════════════════════════════════════════════════
-- §7  CROCIFISSI
-- ══════════════════════════════════════════════════════════════════

local CRUCIFIX_TYPES = {
    Guiding     = { Name="Guiding",     Architecture="Guiding", Color=Color3.fromRGB(137,207,255), FlashColor=Color3.fromRGB(100,175,255) },
    Curious     = { Name="Curious",     Architecture="Curious", Color=Color3.fromRGB(255,227,137), FlashColor=Color3.fromRGB(240,195, 80) },
    Starlight   = { Name="Starlight",   Architecture="Guiding", Color=Color3.fromRGB(215,195,255), FlashColor=Color3.fromRGB(185,155,255) },
    Moonlight   = { Name="Moonlight",   Architecture="Guiding", Color=Color3.fromRGB(115,200,255), FlashColor=Color3.fromRGB( 80,155,240) },
    Mischievous = { Name="Mischievous", Architecture="Curious", Color=Color3.fromRGB(255,130, 65), FlashColor=Color3.fromRGB(255, 95, 35) },
}

local CRUX_BADGE = {
    Guiding="crux_guiding", Curious="crux_curious", Starlight="crux_starlight",
    Moonlight="crux_moonlight", Mischievous="crux_mischievous",
}

local function GetLightDef(n) return CRUCIFIX_TYPES[n] or CRUCIFIX_TYPES.Guiding end

local function GetLightNames()
    local t = {}
    for k in next, CRUCIFIX_TYPES do t[#t+1] = k end
    table.sort(t)
    return t
end

local function LoadCustomLight(url)
    if not url or url == "" then return end
    local ok, res = pcall(function() return loadstring(game:HttpGet(url))() end)
    if ok and typeof(res) == "table" and res.Name then
        CRUCIFIX_TYPES[res.Name] = res
        return res.Name
    end
end

-- ══════════════════════════════════════════════════════════════════
-- §8  GLITCH VFX + SUONI
-- ══════════════════════════════════════════════════════════════════

local _gg, _gc
local function GlitchStart()
    if _gg or not CONFIG.GlitchEnabled then return end
    _gg = Instance.new("ScreenGui"); _gg.Name = "ZioGlitch"
    _gg.ResetOnSpawn = false; _gg.IgnoreGuiInset = true; _gg.Parent = PG
    local vig = Instance.new("Frame")
    vig.Size = UDim2.new(1,0,1,0); vig.BackgroundColor3 = Color3.fromRGB(88,0,0)
    vig.BackgroundTransparency = 0.72; vig.BorderSizePixel = 0; vig.Parent = _gg
    local lines = {}
    for i=1,5 do
        local l = Instance.new("Frame"); l.BorderSizePixel = 0
        l.BackgroundColor3 = Color3.fromRGB(255,255,255); l.BackgroundTransparency = 0.87
        l.Size = UDim2.new(1,0,0,math.random(1,3))
        l.Position = UDim2.new(0,0,math.random(5,93)/100,0); l.Parent = _gg; lines[i] = l
    end
    _gc = RunService.RenderStepped:Connect(function()
        if not _gg then return end
        for _,l in next,lines do
            if l.Parent then
                l.Position = UDim2.new(0,math.random(-9,9),l.Position.Y.Scale,0)
                l.BackgroundTransparency = 0.82+math.random(0,10)/100
            end
        end
        if vig.Parent then vig.BackgroundTransparency = 0.69+math.random(0,7)/100 end
    end)
end

local function GlitchStop()
    if _gc then _gc:Disconnect(); _gc = nil end
    if not _gg then return end
    local g = _gg; _gg = nil
    task.delay(0.8, function() if g and g.Parent then g:Destroy() end end)
end

local _loops = {}
local function SndPlay(id, vol, pitch, loop)
    if not id or id == "" then return end
    local ok, s = pcall(function()
        local snd = Instance.new("Sound"); snd.SoundId = id; snd.Volume = vol or 0.5
        snd.PlaybackSpeed = pitch or 1; snd.Looped = loop or false
        snd.Parent = SoundService; snd:Play()
        return snd
    end)
    if ok and s and loop then _loops[#_loops+1] = s end
end

local function SndStopAll()
    for _,s in next,_loops do
        if s and s.Parent then
            TweenService:Create(s,TweenInfo.new(1.2),{Volume=0}):Play()
            task.delay(1.3, function() if s.Parent then s:Destroy() end end)
        end
    end
    _loops = {}
end

-- ══════════════════════════════════════════════════════════════════
-- §9  CROCIFISSO OVERWRITE
-- ══════════════════════════════════════════════════════════════════

local function CrucifixFlash(def)
    local g = Instance.new("ScreenGui"); g.Name = "ZioFlash"
    g.ResetOnSpawn = false; g.IgnoreGuiInset = true; g.Parent = PG
    local f = Instance.new("Frame")
    f.Size = UDim2.new(1,0,1,0); f.BackgroundColor3 = def.FlashColor
    f.BackgroundTransparency = 0.32; f.BorderSizePixel = 0; f.Parent = g
    TweenService:Create(f,TweenInfo.new(4.5),{BackgroundTransparency=1}):Play()
    task.delay(5, function() if g.Parent then g:Destroy() end end)
end

local function BindCrucifix(entity, typeName, onExorcised)
    entity:SetCallback("CrucifixionOverwrite", function()
        local def = GetLightDef(typeName)
        local model = entity.Model
        local char = LP.Character
        if char then
            local tool = char:FindFirstChildOfClass("Tool")
            if tool and (tool.Name == "Crucifix" or (tool.HasTag and tool:HasTag("Crucifix"))) then
                tool:Destroy()
            end
        end
        model:SetAttribute("BeingBanished", true)
        model:SetAttribute("Paused", true)

        CrucifixFlash(def)
        GlitchStop()
        Library:Notify(string.format(L.notif_exorcised, def.Name), 3)

        Stats.cruxUsed[def.Name] = true; SaveStats()

        local bId = CRUX_BADGE[def.Name]
        if bId then UnlockBadge(bId) end
        if not CRUX_BADGE[def.Name] then UnlockBadge("crux_custom") end

        local all = true
        for k in next, CRUX_BADGE do
            if not Stats.cruxUsed[k] then all = false; break end
        end
        if all then UnlockBadge("crux_all") end

        if onExorcised then task.spawn(onExorcised) end
        task.delay(5, function()
            if entity:IsAlive() then entity:Despawn() end
        end)
    end)
end

-- ══════════════════════════════════════════════════════════════════
-- §10  SPAWNER CONFIG BUILDER
-- ══════════════════════════════════════════════════════════════════

local function MakeCfg(phase, name, hints, isP2)
    local def = GetLightDef(phase.CrucifixType)
    return {
        Entity      = { Name=name, Asset=phase.ModelURL, HeightOffset=0 },
        Movement    = { Speed=phase.Speed, Delay=phase.StartDelay, Reversed=false },
        Damage      = { Enabled=true, IgnoreHiding=false, Range=phase.DamageRange, Amount=phase.Damage },
        Rebounding  = { Enabled=isP2, Type="Ambush",
                        Min=phase.ReboundMin or 1, Max=phase.ReboundMax or 1,
                        Delay=phase.ReboundDelay or 2 },
        Lights      = { Flicker={Enabled=true,Duration=1}, Shatter=isP2, Repair=false },
        Earthquake  = { Enabled=isP2 },
        CameraShake = { Enabled=true,
                        Range=isP2 and 135 or 70,
                        Values=isP2 and {2.3,30,0.05,0.9} or {0.65,7,0.35,1.3} },
        Crucifixion = { Type=def.Architecture, Enabled=true, Range=40, Resist=false, Break=true },
        Death       = { Type=def.Architecture, Hints=hints, Cause=name },
    }
end

-- ══════════════════════════════════════════════════════════════════
-- §11  SESSIONE
-- ══════════════════════════════════════════════════════════════════

local _running = false
local _entity  = nil

local function StopSession()
    if _entity then pcall(function() if _entity:IsAlive() then _entity:Despawn() end end) end
    _entity = nil; _running = false
    GlitchStop(); SndStopAll()
end

local function StartSession()
    if _running then Library:Notify(L.notif_session_busy, 3); return end
    _running = true
    Stats.runs += 1; SaveStats()
    if Stats.runs >= 10 then UnlockBadge("runs_10") end
    if Stats.runs >= 50 then UnlockBadge("runs_50") end

    local ok, p1 = pcall(function()
        return Spawner:Create(MakeCfg(CONFIG.Phase1, L.entity_phase1, L.hints_phase1, false))
    end)
    if not ok or not p1 then
        Library:Notify(L.notif_p1_fail, 5)
        _running = false; return
    end
    _entity = p1

    BindCrucifix(p1, CONFIG.Phase1.CrucifixType, function()
        UnlockBadge("phase1_only")
        Stats.survives += 1; SaveStats()
        if Stats.survives >= 5  then UnlockBadge("survives_5")  end
        if Stats.survives >= 25 then UnlockBadge("survives_25") end
        _running = false
    end)

    local rooms, fired, dmg = 0, false, false

    p1:SetCallback("OnSpawned", function()
        SndPlay(CONFIG.Sounds.Heartbeat, 0.15, 0.72, true)
        Library:Notify(L.notif_anomaly, 3)
    end)
    p1:SetCallback("OnLookAt", function(los)
        if los then UnlockBadge("first_encounter") end
    end)
    p1:SetCallback("OnStartMoving", function()
        SndPlay(CONFIG.Sounds.Whisper, 0.22, 0.88, false)
    end)
    p1:SetCallback("OnEnterRoom", function(_, first)
        if not first then return end
        rooms += 1
        SndPlay(CONFIG.Sounds.Whisper, 0.18+rooms*0.04, 0.88, false)
        if rooms >= CONFIG.Phase1.RoomsTrigger and not fired then
            fired = true
            task.delay(0.55, function() p1:Despawn() end)
        end
    end)
    p1:SetCallback("OnDamagePlayer", function(hp)
        dmg = true; UnlockBadge("first_hit")
        SndPlay(CONFIG.Sounds.Static, 0.32, 1, false)
        if hp <= 0 then Stats.deaths += 1; SaveStats(); GlitchStop(); SndStopAll(); _running = false end
    end)
    p1:SetCallback("OnDespawned", function()
        SndStopAll()
        if not fired then return end

        task.wait(0.65)
        GlitchStart()
        SndPlay(CONFIG.Sounds.Jumpscare, 0.88, 1, false)
        Library:Notify(L.notif_zio_here, 3)
        task.wait(0.38)

        local ok2, p2 = pcall(function()
            return Spawner:Create(MakeCfg(CONFIG.Phase2, L.entity_phase2, L.hints_phase2, true))
        end)
        if not ok2 or not p2 then
            Library:Notify(L.notif_p2_fail, 4)
            GlitchStop(); _running = false; return
        end
        _entity = p2
        local start = tick()

        BindCrucifix(p2, CONFIG.Phase2.CrucifixType, function()
            Stats.survives += 1; SaveStats()
            if Stats.survives >= 5  then UnlockBadge("survives_5")  end
            if Stats.survives >= 25 then UnlockBadge("survives_25") end
            _running = false
        end)

        p2:SetCallback("OnStartMoving", function()
            SndPlay(CONFIG.Sounds.Footsteps, 0.68, 1.1, false)
        end)
        p2:SetCallback("OnRebounding", function(s)
            if s then GlitchStart() else GlitchStop() end
        end)
        p2:SetCallback("OnDamagePlayer", function(hp)
            dmg = true; UnlockBadge("first_hit")
            SndPlay(CONFIG.Sounds.Static, 0.32, 1, false)
            if hp <= 0 then Stats.deaths += 1; SaveStats(); GlitchStop(); SndStopAll(); _running = false end
        end)
        p2:SetCallback("OnDespawned", function()
            GlitchStop(); SndStopAll()
            local elapsed = tick() - start
            UnlockBadge("first_survive")
            if not dmg then UnlockBadge("no_damage_run") end
            if elapsed < 15 then UnlockBadge("speedrun") end
            Stats.survives += 1; SaveStats()
            if Stats.survives >= 5  then UnlockBadge("survives_5")  end
            if Stats.survives >= 25 then UnlockBadge("survives_25") end
            _running = false
        end)

        p2:Run(true)
    end)

    p1:Run(true)
end

-- ══════════════════════════════════════════════════════════════════
-- §12  UI OBSIDIAN
-- ══════════════════════════════════════════════════════════════════

print("[ZioUnif] 6. costruisco UI…")

local Window = Library:CreateWindow({
    Title = "ZioUnificato",
    Footer = "v6 · Larpbase",
    Center = true, AutoShow = true,
})

local function CopyToolbox(cat, kw)
    local url = "https://create.roblox.com/store/marketplace/" .. cat
                .. "?keyword=" .. kw:gsub(" ", "+")
    local ok = pcall(setclipboard, url)
    if ok then Library:Notify(string.format(L.notif_url_copied, kw), 5)
    else       Library:Notify(L.notif_no_clipboard, 4) end
end

-- Tab Sessione
local TAB1 = Window:AddTab(L.tab_session)
local G1L = TAB1:AddLeftGroupbox("Controlli")
G1L:AddButton({ Text = L.btn_start, Func = StartSession })
G1L:AddButton({ Text = L.btn_stop,   Func = StopSession })
G1L:AddToggle("Glitch", {
    Text = L.lbl_glitch, Default = true,
    Callback = function(v) CONFIG.GlitchEnabled = v end,
})

local G1R = TAB1:AddRightGroupbox("Stats")
G1R:AddLabel(string.format(L.lbl_stats, Stats.runs, Stats.survives, Stats.deaths))

-- Tab Fasi
local TAB2 = Window:AddTab(L.tab_phases)
local G2L = TAB2:AddLeftGroupbox("Fase 1")
G2L:AddSlider("P1Speed",  { Text = L.lbl_speed,   Default = 25,  Min = 5, Max = 200, Rounding = 0, Callback = function(v) CONFIG.Phase1.Speed = v end })
G2L:AddSlider("P1Damage", { Text = L.lbl_damage,  Default = 20,  Min = 0, Max = 200, Rounding = 0, Callback = function(v) CONFIG.Phase1.Damage = v end })
G2L:AddSlider("P1Rooms",  { Text = L.lbl_rooms,   Default = 4,   Min = 1, Max = 15,  Rounding = 0, Callback = function(v) CONFIG.Phase1.RoomsTrigger = v end })
G2L:AddDropdown("P1Crux", { Values = GetLightNames(), Default = "Starlight", Text = L.lbl_crucifix,
    Callback = function(v) CONFIG.Phase1.CrucifixType = v end })

local G2R = TAB2:AddRightGroupbox("Fase 2")
G2R:AddSlider("P2Speed",  { Text = L.lbl_speed,  Default = 160, Min = 50, Max = 400, Rounding = 0, Callback = function(v) CONFIG.Phase2.Speed = v end })
G2R:AddSlider("P2Damage", { Text = L.lbl_damage, Default = 125, Min = 0,  Max = 300, Rounding = 0, Callback = function(v) CONFIG.Phase2.Damage = v end })
G2R:AddSlider("P2Rmin",   { Text = L.lbl_rebound_min, Default = 1, Min = 0, Max = 5, Rounding = 0, Callback = function(v) CONFIG.Phase2.ReboundMin = v end })
G2R:AddSlider("P2Rmax",   { Text = L.lbl_rebound_max, Default = 3, Min = 0, Max = 8, Rounding = 0, Callback = function(v) CONFIG.Phase2.ReboundMax = v end })
G2R:AddDropdown("P2Crux", { Values = GetLightNames(), Default = "Moonlight", Text = L.lbl_crucifix,
    Callback = function(v) CONFIG.Phase2.CrucifixType = v end })

-- Tab Suoni con "+" Toolbox
local TAB3 = Window:AddTab(L.tab_sounds)
local G3 = TAB3:AddLeftGroupbox("ID audio")
local function SoundRow(k, label, kw)
    G3:AddInput(k .. "In", { Text = label, Default = CONFIG.Sounds[k], Finished = true,
        Callback = function(v) CONFIG.Sounds[k] = v end })
    G3:AddButton({ Text = string.format(L.btn_search, kw), Func = function() CopyToolbox("audio", kw) end })
end
SoundRow("Whisper",   "Whisper",   "horror whisper ambient")
SoundRow("Heartbeat", "Heartbeat", "heartbeat slow loop")
SoundRow("Jumpscare", "Jumpscare", "jumpscare sting loud")
SoundRow("Footsteps", "Footsteps", "heavy footsteps monster")
SoundRow("Static",    "Static",    "radio static noise")

-- Tab Modelli
local TAB4 = Window:AddTab(L.tab_models)
local G4 = TAB4:AddLeftGroupbox("URL .rbxm")
G4:AddInput("P1Model", { Text = "Fase 1", Default = CONFIG.Phase1.ModelURL, Finished = true,
    Callback = function(v) CONFIG.Phase1.ModelURL = v end })
G4:AddButton({ Text = string.format(L.btn_search, "doors rush entity"), Func = function() CopyToolbox("models", "doors rush entity") end })
G4:AddInput("P2Model", { Text = "Fase 2", Default = CONFIG.Phase2.ModelURL, Finished = true,
    Callback = function(v) CONFIG.Phase2.ModelURL = v end })
G4:AddButton({ Text = string.format(L.btn_search, "doors ambush entity"), Func = function() CopyToolbox("models", "doors ambush entity") end })

-- Tab Luci
local TAB5 = Window:AddTab(L.tab_lights)
local G5 = TAB5:AddLeftGroupbox("Custom Light")
G5:AddInput("LightURL", { Text = "URL .lua", Default = "", Placeholder = "https://…", Finished = true })
G5:AddButton({ Text = L.btn_load, Func = function()
    local url = Library.Options.LightURL.Value
    local name = LoadCustomLight(url)
    if name then Library:Notify(string.format(L.notif_light_loaded, name), 4)
    else         Library:Notify(L.notif_light_fail, 4) end
end })

-- Tab Aspetto
local TAB6 = Window:AddTab(L.tab_look)
local G6 = TAB6:AddLeftGroupbox("Achievement popup")
G6:AddLabel(L.lbl_accent)
G6:AddColorPicker("AchAcc", { Default = CONFIG.Achievement.AccentColor,
    Callback = function(v) CONFIG.Achievement.AccentColor = v end })
G6:AddLabel(L.lbl_title)
G6:AddColorPicker("AchTtl", { Default = CONFIG.Achievement.TitleColor,
    Callback = function(v) CONFIG.Achievement.TitleColor = v end })
G6:AddLabel(L.lbl_desc)
G6:AddColorPicker("AchTxt", { Default = CONFIG.Achievement.TextColor,
    Callback = function(v) CONFIG.Achievement.TextColor = v end })
G6:AddButton({ Text = L.btn_preview, Func = function()
    ShowPopup(L.preview_title, L.preview_desc)
end })

-- Lingua (locale switcher)
local G6R = TAB6:AddRightGroupbox("Lingua")
local locNames, locByName = {}, {}
for code, tbl in next, LOCALES do
    local n = tbl.name or code
    locNames[#locNames+1] = n
    locByName[n] = code
end
G6R:AddDropdown("Locale", { Values = locNames, Default = L.name,
    Text = "Language",
    Callback = function(v)
        local code = locByName[v]
        if not code then return end
        CONFIG.Locale = code; L = LOCALES[code]
        Library:Notify("Lingua: " .. (L.name or code) .. " — riavvia per applicare tutte le label.", 5)
    end,
})

-- Tab Badge
local TAB7 = Window:AddTab(L.tab_badges)
local G7 = TAB7:AddLeftGroupbox("Badges (17)")
for _, b in next, BADGES do
    local mark = HasBadge(b.id) and "✓" or "✗"
    G7:AddLabel(mark .. "  " .. b.title .. " — " .. b.desc)
end

print("[ZioUnif] 7. tutto pronto")
Library:Notify(L.notif_ready, 5)
