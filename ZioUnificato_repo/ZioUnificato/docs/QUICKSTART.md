# 🚀 Quickstart

## 1. Fork o clona il repo

```bash
git clone https://github.com/TUO_USER/ZioUnificato.git
```

Oppure fai fork dal browser su GitHub.

## 2. Aggiorna gli URL

Nel file `init.lua`, sezione `LOCALE_URLS`, sostituisci `TUO_USER` con il tuo username GitHub:

```lua
local LOCALE_URLS = {
    it = "https://raw.githubusercontent.com/TUO_USER/ZioUnificato/main/lang/it.lua",
    -- ...
}
```

Fai commit e push.

## 3. Ottieni il tuo loadstring

L'URL raw del `init.lua`:

```
https://raw.githubusercontent.com/TUO_USER/ZioUnificato/main/init.lua
```

Il loadstring finale:

```lua
loadstring(game:HttpGet("https://raw.githubusercontent.com/TUO_USER/ZioUnificato/main/init.lua"))()
```

## 4. Usa in-game

- Apri **DOORS** o **DOORS Hotel** su Roblox
- Esegui il loadstring nel tuo executor
- Apparirà una notifica "ZioUnificato pronto"
- Premi **RightControl** per aprire il menu Obsidian

## 5. Prima run

Tab **Sessione** → **Avvia lo Zio**.

Fase 1 stalking silenzioso, dopo 4 stanze → Fase 2 rush. Sopravvivi o usa il crocifisso per sbloccare i primi badge 🏆

## Troubleshooting

**Non vedo niente in-game**
Vedi la console (F9 su desktop, o il debug menu del tuo executor). Se lo script non stampa `[ZioUnif] 1. avvio`, l'executor non lo sta eseguendo — usa lo `zio_diagnostic.lua` per capire dove si ferma.

**"Failed to load sound"**
Il place ha permessi audio ristretti. Vai in tab **Suoni** e sostituisci con altri ID (usa il pulsante "+ cerca" per trovarli sulla Marketplace).

**"Fase 1 fallita"**
Non sei in DOORS o DOORS Hotel. Il Spawner V2 di Vynixu è hardcoded per quegli universi. Su altri place non funziona.

**Badge non si sblocca**
Verifica che il tuo executor supporti `writefile` e `readfile` (Delta / Wave / Solara sì, Codex no).

**Custom Light non carica**
Controlla che il file `.lua` termini con `return { ... }` e che `Name` sia una stringa. Log in console dopo la richiesta di caricamento.
