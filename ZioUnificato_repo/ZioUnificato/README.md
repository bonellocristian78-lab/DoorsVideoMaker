# 🌙 ZioUnificato

**Sistema entità ibrida bifasica per DOORS**, con UI Obsidian, 17 badge custom, crocifissi custom via file esterni, multi-lingua e config in-game.

> ⚡ *Loadstring pronto. Editabile in-game senza riavviare.*

---

## 🚀 Quickstart

Esegui nel tuo executor:

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/TUO_USER/ZioUnificato/main/init.lua"))()
```

L'UI Obsidian si apre automaticamente. Menu su/giù con **RightControl**.

Sostituisci `TUO_USER` con il tuo username GitHub dopo aver clonato il repo.

---

## 📁 Struttura del repo

```
ZioUnificato/
├── init.lua                 # Entrypoint principale — questo è il loadstring
├── LICENSE                  # MIT
├── src/
│   └── config_default.lua   # Config isolato (leggibilità)
├── lang/                    # Stringhe multi-lingua
│   ├── it.lua               # Italiano
│   ├── en.lua               # English
│   ├── es.lua               # Español
│   └── pt.lua               # Português
├── lights/                  # Custom lights per il crocifisso
│   ├── template.lua         # Template da copiare
│   ├── infernal.lua         # Rosso sangue
│   ├── neon.lua             # Verde neon
│   └── frost.lua            # Bianco ghiaccio
├── assets/                  # ID audio/decal curati
│   ├── sounds.lua
│   └── decals.lua
└── docs/
    ├── QUICKSTART.md
    ├── BADGES.md
    ├── CUSTOM_LIGHTS.md
    └── LOCALIZATION.md
```

---

## ✨ Feature

- **Bifasico** — Fase 1 stalking silenzioso (Speed 25), Fase 2 rush ad alta velocità (Speed 160) con rebounding Ambush
- **UI Obsidian a 7 tab** — Sessione, Fasi, Suoni, Modelli, Luci, Aspetto, Badge
- **17 badge** — sblocco automatico, salvati locali via writefile (see [docs/BADGES.md](docs/BADGES.md))
- **6 crocifissi predefiniti** + Custom Lights da file esterno
- **Multi-lingua** — IT, EN, ES, PT selezionabile in-game
- **"+ Cerca Toolbox"** — pulsante accanto a ogni campo ID che copia l'URL della Creator Marketplace
- **Popup badge personalizzabile** — Accent/Titolo/Testo con ColorPicker
- **Glitch VFX** — vignetta rossa + scanline durante Fase 2, toggle on/off

---

## 🏆 Badge (17 totali)

Vedi [docs/BADGES.md](docs/BADGES.md) per la lista completa. In sintesi:

| Categoria | Numero |
|-----------|--------|
| Prima volta | 3 |
| Crocifissi (uno per tipo) | 7 |
| Comportamento | 3 |
| Cumulativi | 4 |

---

## 🎨 Personalizzazione

**In-game** (tab Aspetto):
- ColorPicker per Accent / Titolo / Descrizione del popup badge
- Icona badge tramite `rbxassetid://`

**Fuori dal gioco** (file):
- `src/config_default.lua` — cambia i default che vengono caricati
- `lights/*.lua` — crea nuovi crocifissi
- `lang/*.lua` — traduzioni

---

## 🌈 Custom Lights

Crea un file `.lua` e hostalo (raw GitHub / Pastebin):

```lua
return {
    Name         = "Infernal",
    Architecture = "Curious",
    Color        = Color3.fromRGB(200, 20, 20),
    FlashColor   = Color3.fromRGB(180,  0,  0),
    SoundId      = "rbxassetid://4559876899",
}
```

Poi in-game: **tab Luci → incolla URL → Carica luce**. Vedi [docs/CUSTOM_LIGHTS.md](docs/CUSTOM_LIGHTS.md).

---

## 🙏 Crediti

- **[RegularVynixu](https://github.com/RegularVynixu)** — [DOORS Entity Spawner V2](https://github.com/RegularVynixu/DOORS-Entity-Spawner-V2) e [DOORS Custom Achievements](https://github.com/RegularVynixu/DOORS-Custom-Achievements)
- **[deividcomsono](https://github.com/deividcomsono)** — [Obsidian UI Library](https://github.com/deividcomsono/Obsidian)
- **Larpbase** — design & implementation di ZioUnificato

---

## 📜 Licenza

MIT — vedi [LICENSE](LICENSE).
