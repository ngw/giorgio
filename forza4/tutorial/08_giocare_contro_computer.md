# Capitolo 8 — Giocare contro il computer (CPU facile + medio)

In questo capitolo insegniamo al nostro Forza 4 a giocare da solo.
Cosi puoi allenarti anche quando il tuo amico non e online.

## Obiettivo

Aggiungiamo una nuova modalita:

- modalita classica: due persone
- modalita CPU: tu contro il computer

E nella modalita CPU scegli anche il livello:

- facile
- medio

## 1. Nuovi pulsanti nella lobby

Nella lobby abbiamo aggiunto due pulsanti:

- "CPU facile"
- "CPU medio"

Quando ne clicchi uno, il browser manda una richiesta `POST /crea_cpu`
insieme al livello scelto.

## 2. Una partita sa in che modalita e

Ogni partita e un `Hash` Ruby. Ora contiene anche:

- `modo` (`"multi"` oppure `"cpu"`)
- `livello_cpu` (`"facile"` oppure `"medio"`)

Idea importante: il server salva lo stato della partita in memoria.
Quindi basta leggere `modo` per capire come comportarsi.

## 3. Il cervello della CPU

### Livello facile

La CPU facile fa una cosa semplice e corretta:

1. cerca le colonne disponibili
2. ne sceglie una a caso
3. inserisce il disco giallo

In Ruby, per scegliere una colonna casuale usiamo `sample`.

```ruby
colonne = (0...COLS).select { |col| board[0][col].nil? }
colonna_cpu = colonne.sample
```

### Livello medio

La CPU medio usa una mini strategia in 3 passi:

1. se puo vincere in questa mossa, vince subito
2. se tu puoi vincere alla prossima mossa, ti blocca
3. se non ci sono urgenze, preferisce il centro e poi sceglie

Questa e gia una CPU abbastanza furba.

## 4. Quando gioca la CPU?

Dopo la tua mossa, se la partita non e finita, il turno passa al giocatore 2.
Se la modalita e `cpu`, il server chiama subito la funzione della CPU
con il livello che hai scelto.

Questo significa che:

- tu fai click
- il server aggiorna il tabellone
- il server fa anche la mossa del computer
- la pagina si ricarica con la nuova situazione

## 5. Cosa abbiamo imparato

Hai usato tre idee da vero game developer:

- stato di gioco (`modo`, turno, vincitore)
- regole diverse nella stessa app (multiplayer o CPU)
- algoritmo base (scelta casuale valida)
- strategia a priorita (vinci, blocca, poi scegli)

## Mini missione

Prova a migliorare la CPU:

1. Nel livello medio, fai provare prima le colonne centrali.
2. Aggiungi un livello difficile che guarda 2 mosse avanti.
3. Mostra in pagina il livello scelto (facile o medio).

Suggerimento: simula una mossa su una copia della griglia,
controlla se porta a vittoria, poi annulla.

---

[← Debian su Chromebook](07_debian_chromebook.md) | [← Torna all'indice](README.md)
