# 🌈 Custom Lights

Il crocifisso in ZioUnificato supporta 5 preset built-in + un numero illimitato di **Custom Lights** caricate da file esterni.

## Formato del file

Un Custom Light è un file `.lua` che fa `return` di una tabella:

```lua
return {
    -- Nome visibile nel dropdown
    Name = "MiaLuce",

    -- Base animazione: "Guiding" (blu neutro) o "Curious" (giallo caldo)
    Architecture = "Guiding",

    -- Colore del pentagramma
    Color = Color3.fromRGB(255, 128, 0),

    -- Colore del flash schermo quando esorcizza
    FlashColor = Color3.fromRGB(255, 96, 0),

    -- (opzionale) Suono aggiuntivo durante l'esorcismo
    SoundId = "rbxassetid://4559876899",
}
```

## Preset built-in

| Nome | Architecture | Colore |
|------|--------------|--------|
| `Guiding` | Guiding | Blu neutro |
| `Curious` | Curious | Giallo caldo |
| `Starlight` | Guiding | Viola-argento |
| `Moonlight` | Guiding | Blu-ciano |
| `Mischievous` | Curious | Arancio-rosso |

## Custom Lights nel repo

Nella cartella `lights/`:

- `template.lua` — template base da copiare
- `infernal.lua` — rosso sangue (Curious base)
- `neon.lua` — verde acido (Guiding base)
- `frost.lua` — bianco ghiaccio (Guiding base)

Tutti gli URL diretti sono:

```
https://raw.githubusercontent.com/TUO_USER/ZioUnificato/main/lights/infernal.lua
https://raw.githubusercontent.com/TUO_USER/ZioUnificato/main/lights/neon.lua
https://raw.githubusercontent.com/TUO_USER/ZioUnificato/main/lights/frost.lua
```

## Come caricare in-game

1. Ottieni un URL "raw" del file `.lua` (GitHub → Raw, oppure Pastebin `pastebin.com/raw/XXX`)
2. Nell'UI: **tab "Luci" → incolla URL nel campo → premi "Carica luce"**
3. Il nome della tua luce apparirà nel dropdown "Crocifisso" nelle tab Fasi

## Come funziona (dietro le quinte)

Quando eseguirei l'esorcismo, la callback `CrucifixionOverwrite` del modulo Spawner intercetta l'animazione hardcoded e ne fa una custom:

1. Rimuove il tool Crocifisso dal character
2. Setta l'attributo `BeingBanished` sull'entità
3. Sovrappone un `Frame` full-screen con `FlashColor` (fade 4.5s)
4. Se `SoundId` è presente, lo riproduce via `SoundService`
5. Aspetta 5 secondi e chiama `entity:Despawn()`

**Architecture** determina quale animazione base viene comunque riprodotta dallo Spawner sotto il flash — è un dettaglio: "Guiding" e "Curious" hanno movimenti diversi dell'entità mentre viene bandita.
