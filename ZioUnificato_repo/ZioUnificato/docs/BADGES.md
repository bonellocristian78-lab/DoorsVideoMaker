# 🏆 Badge (17 totali)

Ogni badge si sblocca automaticamente al verificarsi della condizione. Sono salvati localmente via `writefile` del tuo executor, quindi persistono tra sessioni.

## Prima volta (3)

| Badge | Titolo | Condizione |
|-------|--------|------------|
| `first_encounter` | Sguardo nel Buio | Vedi lo Zio per la prima volta (LineOfSight) |
| `first_hit` | Prima Ferita | Ricevi il primo danno |
| `first_survive` | Sopravvissuto | Sopravvivi al rush di Fase 2 |

## Crocifissi — uno per tipo (7)

| Badge | Titolo | Condizione |
|-------|--------|------------|
| `crux_guiding` | Guida Divina | Esorcizza con Guiding Light |
| `crux_curious` | Curiosità Domata | Esorcizza con Curious Light |
| `crux_starlight` | Stellare | Esorcizza con Starlight |
| `crux_moonlight` | Lunatico | Esorcizza con Moonlight |
| `crux_mischievous` | Marachella | Esorcizza con Mischievous Light |
| `crux_custom` | Artigiano di Luce | Esorcizza con una Custom Light |
| `crux_all` | Collezionista di Luci | Usa tutti e 5 i tipi predefiniti |

## Comportamento (3)

| Badge | Titolo | Condizione |
|-------|--------|------------|
| `phase1_only` | Zio Timido | Esorcizza durante la Fase 1 |
| `no_damage_run` | Ombra Perfetta | Completa una run senza ricevere danno |
| `speedrun` | Fulmine | Fase 2 despawna in meno di 15 secondi |

## Cumulativi persistenti (4)

| Badge | Titolo | Condizione |
|-------|--------|------------|
| `runs_10` | Assiduo | 10 run totali |
| `runs_50` | Ossessionato | 50 run totali |
| `survives_5` | Cinque Vite | Sopravvivi 5 volte |
| `survives_25` | Immortale | Sopravvivi 25 volte |

## Storage

Il modulo `DOORS Custom Achievements` di RegularVynixu salva i badge sbloccati in `DOORS_Custom_Achievements.json` nella cartella `workspace/` del tuo executor. I contatori (`runs`, `survives`, `deaths`) sono in `ZioUnificato_Stats.json`.

**Per resettare**: usa il pulsante "Reset progressi" nella tab Sessione dell'UI, oppure cancella i due file.

## Aggiungere nuovi badge

Modifica la tabella `BADGES` in `init.lua` (§2). Ogni entry:

```lua
{ id = "identificatore_univoco", title = "Nome visibile", desc = "Descrizione." }
```

Poi chiama `UnlockBadge("identificatore_univoco")` dal callback appropriato in §11.
