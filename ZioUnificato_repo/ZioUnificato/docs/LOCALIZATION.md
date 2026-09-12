# 🌍 Localizzazione

ZioUnificato supporta 4 lingue di default: Italiano (`it`), English (`en`), Español (`es`), Português BR (`pt`). La lingua è selezionabile dall'UI Obsidian nella tab "Aspetto".

## File lingua

Ogni file `lang/*.lua` è una tabella con le stesse chiavi. Il main carica tutti i file all'avvio via `HttpGet` e li conserva in memoria.

## Aggiungere una nuova lingua

1. Copia `lang/it.lua` come `lang/xx.lua` (es. `lang/de.lua` per tedesco)
2. Traduci tutte le stringhe
3. Aggiungi il codice nel file `init.lua` alla lista `LOCALE_URLS`:

```lua
local LOCALE_URLS = {
    it = "https://raw.githubusercontent.com/TUO_USER/ZioUnificato/main/lang/it.lua",
    en = "https://raw.githubusercontent.com/TUO_USER/ZioUnificato/main/lang/en.lua",
    es = "https://raw.githubusercontent.com/TUO_USER/ZioUnificato/main/lang/es.lua",
    pt = "https://raw.githubusercontent.com/TUO_USER/ZioUnificato/main/lang/pt.lua",
    de = "https://raw.githubusercontent.com/TUO_USER/ZioUnificato/main/lang/de.lua",  -- nuova
}
```

## Chiavi obbligatorie

Vedi `lang/it.lua` per la lista completa. Categorie:

- `code`, `name` — metadata della lingua
- `notif_*` — notifiche in-game
- `tab_*` — nomi delle tab UI
- `btn_*` — testi dei bottoni
- `lbl_*` — label vari
- `badge_unlocked`, `preview_*` — popup badge
- `hints_phase1`, `hints_phase2` — hint di morte (array di stringhe)
- `entity_phase1`, `entity_phase2` — nomi delle entità

## Placeholder `%s` e `%d`

Alcune stringhe usano `string.format`. Le tenere identiche:

- `notif_exorcised = "%s ha bandito lo Zio."` — `%s` è il nome della luce
- `notif_url_copied = "URL copiato — incolla (%s)"` — `%s` è la keyword
- `lbl_stats = "Run: %d | ..."` — `%d` sono i contatori

Se ometti un placeholder, `string.format` va in errore in runtime.
