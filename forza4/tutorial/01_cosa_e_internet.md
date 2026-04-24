# Capitolo 1 — Cos'è Internet?

## Internet è come una città enorme

Immagina una città gigantesca con milioni di case.
Ogni casa è un **computer**.
Le strade che collegano le case sono i **cavi** (o le onde WiFi).

Quando vuoi andare a trovare un amico, prendi una strada e
bussi alla sua porta. Su Internet funziona uguale:
il tuo computer "bussa" al computer di qualcun altro per chiedergli qualcosa.

```
[Il tuo computer] ---strada (Internet)--- [Computer di Google]
```

## Indirizzi: come si trovano i computer?

Nella città ogni casa ha un **indirizzo** (via Roma 5, Milano).
Su Internet ogni computer ha un indirizzo chiamato **indirizzo IP**.

Un indirizzo IP assomiglia a questo:

```
142.250.180.46
```

Quattro numeri separati da punti — facile no?

Ma ricordare `142.250.180.46` è difficile.
Per questo esistono i **nomi di dominio**, tipo `google.com` oppure `forza4.onrender.com`.
È come dire "vado da Giovanni" invece di "vado in Via Roma 5".

Un servizio speciale chiamato **DNS** (Domain Name System)
traduce `google.com` → `142.250.180.46` ogni volta che digiti un indirizzo nel browser.

```
Tu digiti: google.com
    ↓
DNS dice: "google.com è al numero 142.250.180.46"
    ↓
Il browser si connette a 142.250.180.46
```

## I dati viaggiano a pezzetti

Quando mandi una foto a un amico, la foto non viaggia intera.
Viene tagliata in tanti piccoli pezzetti chiamati **pacchetti**.
Ogni pacchetto fa la sua strada, poi arriva a destinazione
e il computer li rimette insieme nell'ordine giusto.

È un po' come spedire un puzzle con tante buste separate!

---

[← Indice](README.md) | [Prossimo: Client e Server →](02_client_e_server.md)
