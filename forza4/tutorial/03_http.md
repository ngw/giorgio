# Capitolo 3 — HTTP: il linguaggio di Internet

## Parlare la stessa lingua

Per capirsi, client e server devono usare la stessa lingua.
Questa lingua si chiama **HTTP** — HyperText Transfer Protocol.

*Protocol* significa "insieme di regole": come un galateo che dice
"prima dici ciao, poi fai la richiesta, poi aspetti la risposta".

Oggi si usa spesso **HTTPS** (con la S di Sicuro):
i messaggi vengono cifrati così nessuno può spiare.

## Una richiesta HTTP

Quando scrivi `https://forza4.onrender.com` nel browser,
lui manda al server un messaggio simile a questo:

```
GET / HTTP/1.1
Host: forza4.onrender.com
```

Questo si chiama **richiesta** (request). Contiene:

- **Il metodo** — cosa vuoi fare (`GET` = "dammi questa pagina")
- **Il percorso** — quale pagina vuoi (`/` = la pagina iniziale)
- **L'intestazione** — informazioni extra (es. il nome del browser)

## Una risposta HTTP

Il server risponde così:

```
HTTP/1.1 200 OK
Content-Type: text/html

<!DOCTYPE html>
<html>
  <body>Ecco la pagina!</body>
</html>
```

Contiene:
- **Il codice di stato** — `200 OK` significa "tutto bene!"
- **L'intestazione** — tipo di contenuto, data, ecc.
- **Il corpo** — il contenuto vero (l'HTML della pagina)

## I codici di stato più famosi

| Codice | Significato | Quando succede |
|--------|-------------|----------------|
| `200 OK` | Tutto bene | Pagina trovata e consegnata |
| `301 Moved` | Pagina spostata | Il server ti manda altrove |
| `404 Not Found` | Non trovato | La pagina non esiste |
| `500 Server Error` | Errore del server | Il server ha un problema |

Quando giochi a Forza 4 e premi una colonna, il browser manda una richiesta
`POST /gioca/3` — che vuol dire "esegui l'azione sulla colonna 3".
Il server risponde con `302 Found` e dice "torna alla pagina `/`".
Il browser allora fa una seconda richiesta `GET /` e mostra
il tabellone aggiornato.

## GET e POST — qual è la differenza?

| Metodo | Quando si usa | Esempio |
|--------|---------------|---------|
| **GET** | Per *leggere* qualcosa | Aprire una pagina web |
| **POST** | Per *fare* qualcosa, inviare dati | Premere un pulsante, inviare un modulo |

Con **GET** i parametri stanno nell'indirizzo:
`/cerca?parola=forza4`

Con **POST** i parametri viaggiano nascosti nel corpo della richiesta
(per questo si usa per le azioni importanti).

## Prova tu!

Apri il browser, vai sul gioco e premi `F12` (o tasto destro → Ispeziona).
Vai nella scheda **Network** (Rete) e premi una colonna del tabellone.
Vedrai la richiesta HTTP comparire in tempo reale — benvenuto
nel mondo dei developer! 🕵️

---

[← Client e Server](02_client_e_server.md) | [Prossimo: HTML →](04_html.md)
