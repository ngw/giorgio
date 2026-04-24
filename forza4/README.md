# Forza 4 — Sinatra Web App

Gioco Forza 4 per 2 giocatori, costruito con Ruby + Sinatra.

## Avvio in locale

```bash
cd forza4
bundle install
bundle exec ruby app.rb
# oppure con puma:
bundle exec puma
```

Apri il browser su <http://localhost:4567>.

## Deploy su Render

1. Fai il push di questa cartella su un repository GitHub.
2. Crea un account su [render.com](https://render.com).
3. Clicca **New → Web Service**, seleziona il repo.
4. Render legge `render.yaml` automaticamente e configura tutto.
5. Clicca **Deploy** — in pochi minuti il gioco è online!

## Struttura

```
forza4/
├── app.rb          ← logica del server (Ruby / Sinatra)
├── config.ru       ← punto di ingresso Rack / Puma
├── Gemfile         ← dipendenze Ruby
├── render.yaml     ← configurazione deploy Render
├── public/
│   └── style.css   ← stili CSS
├── views/
│   ├── layout.erb  ← scheletro HTML della pagina
│   └── index.erb   ← tabellone di gioco
└── tutorial/       ← tutorial per bambini
```

## Tutorial

Nella cartella `tutorial/` trovi una guida pensata per chi vuole capire
come funziona tutto — da internet alle basi di HTML.
