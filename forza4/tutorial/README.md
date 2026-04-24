# Tutorial: Come funziona il gioco Forza 4 su Internet

Ciao! 👋 In questa guida scoprirai come funziona davvero un gioco sul web.
Imparerai un sacco di cose fighe usate dai programmatori veri!

## Indice

| Capitolo | Argomento |
|----------|-----------|
| [01 - Cos'è Internet](01_cosa_e_internet.md) | Come funziona la rete |
| [02 - Client e Server](02_client_e_server.md) | Chi fa cosa? |
| [03 - HTTP](03_http.md) | Il linguaggio di Internet |
| [04 - HTML](04_html.md) | Come si fa una pagina web |
| [05 - Il codice del gioco](05_il_codice.md) | Come funziona Forza 4 |
| [06 - Multiplayer](06_multiplayer.md) | Due giocatori, due browser, un server |
| [07 - Debian su Chromebook](07_debian_chromebook.md) | Installare Ruby e avviare il gioco su Linux |

## Concetti Ruby che incontrerai

Man mano che leggi i capitoli troverai questi concetti Ruby — eccoli in breve
così sai già cosa aspettarti:

| Concetto | Dove si usa | Spiegazione breve |
|----------|-------------|-------------------|
| `Array.new(6) { Array.new(7, nil) }` | Tabellone | Crea una griglia 6×7 piena di `nil` (vuoto) |
| `downto` | Caduta del disco | Conta alla rovescia: `5, 4, 3, 2, 1, 0` |
| `between?` | Verifica bordi | Controlla se un numero è dentro un intervallo |
| `nil?` | Cella vuota | Restituisce `true` se il valore è assente |
| `none?` | Tabellone pieno | `true` se nessun elemento soddisfa la condizione |
| `include?` | Celle vincenti | Controlla se un elemento è in un array |
| `Hash` `{ chiave => valore }` | Stato partita | Struttura dati chiave→valore (come un dizionario) |
| `Mutex` | Accesso condiviso | Evita che due richieste modifichino i dati nello stesso istante |
| `SecureRandom.hex` | Codice partita | Genera una stringa casuale sicura |
| `ENV.fetch` | Variabili d'ambiente | Legge la configurazione dall'ambiente (es. Render) |
| `session[]` | Memoria per browser | Ricorda chi sei tra una richiesta e l'altra |
| `content_type :json` | Polling | Dice al browser che la risposta è JSON, non HTML |
| `to_json` / `.to_i` | Conversioni | Converte tra tipi: Hash→stringa JSON, stringa→numero |
| `redirect` | Dopo una mossa | Manda il browser su un'altra pagina (pattern PRG) |
| `halt` | Errori | Ferma la richiesta e risponde con un codice HTTP |
| `MUTEX.synchronize { }` | Thread safety | Il blocco dentro viene eseguito da un solo thread alla volta |

## Cosa ti serve per iniziare

- Un computer con Ruby installato (o segui il [capitolo 7](07_debian_chromebook.md) per il Chromebook)
- Un terminale
- Un browser (Chrome, Firefox, Safari…)
- Curiosità! 🚀

Parti dal [primo capitolo →](01_cosa_e_internet.md)
