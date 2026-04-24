# Capitolo 2 — Client e Server

## Chi chiede e chi risponde

Su Internet esistono due ruoli principali:

| Ruolo | Chi è | Cosa fa |
|-------|-------|---------|
| **Client** | Il tuo browser | Fa le richieste: "voglio vedere quella pagina!" |
| **Server** | Un computer remoto | Risponde alle richieste e manda le pagine |

È come al bar:
- **Tu** (client) dici: "Un cappuccino, per favore!"
- Il **barista** (server) prepara il cappuccino e te lo porta.

```
[CLIENT - il tuo browser]  →  "Voglio forza4.onrender.com"
                           ←  "Ecco la pagina HTML!"
[SERVER - computer Render]
```

## Il server è sempre sveglio

Il tuo computer si accende e spegne quando vuoi.
Il server invece è **sempre acceso**, 24 ore su 24, 7 giorni su 7,
pronto a rispondere a chiunque bussi.

Per questo le aziende che ospitano i server (come **Render**, **Heroku**, **AWS**)
hanno enormi sale piene di computer che non si spengono mai —
si chiamano **data center**.

## Uno si molti

Un server può rispondere a **tante persone contemporaneamente**.
Quando tu e il tuo amico aprite `forza4.onrender.com` nello stesso momento,
il server risponde a entrambi in parallelo, quasi come due baristi allo stesso bancone.

## Il server del nostro gioco

Nel progetto Forza 4, il server è scritto in **Ruby** usando una libreria
chiamata **Sinatra**. Sinatra è come un piccolo assistente che:

1. **Ascolta** le richieste in arrivo
2. **Capisce** cosa vuole il browser
3. **Elabora** la mossa (dove cade il disco?)
4. **Risponde** con la pagina aggiornata

```ruby
# Quando il browser apre la pagina principale:
get '/' do
  # Prepara i dati e manda la pagina HTML
  erb :index
end

# Quando il giocatore preme una colonna:
post '/gioca/3' do
  # Inserisci il disco nella colonna 3
  # Controlla se qualcuno ha vinto
  # Manda la pagina aggiornata
  redirect '/'
end
```

---

[← Internet](01_cosa_e_internet.md) | [Prossimo: HTTP →](03_http.md)
