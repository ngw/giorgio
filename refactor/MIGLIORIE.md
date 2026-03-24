# Refactoring di giorgio.rb — Migliorie apportate

## 1. Classe al posto di funzioni globali
Il gioco è ora racchiuso in una classe `GiorgioAvventura`. Questo incapsula lo stato (nome del giocatore) e la logica in un unico oggetto, evitando variabili e metodi globali.

## 2. Eliminazione della "piramide" di if annidati
L'originale aveva **7 livelli** di `if` annidati, rendendo il codice quasi illeggibile. La versione refactored usa metodi separati per ogni capitolo, con un flusso lineare nel metodo `gioca`.

## 3. Validazione dell'input con retry
Aggiunto il metodo `ask_scelta` che:
- Mostra le opzioni valide
- Richiede l'input finché non è valido
- Evita che il gioco si blocchi su risposte non previste

Nell'originale, una risposta sbagliata terminava silenziosamente il gioco.

## 4. Struttura a capitoli
Il gioco è diviso in metodi chiari:
- `benvenuto` — introduzione e nome giocatore
- `capitolo_1_bivio` — scelta della strada
- `capitolo_2_fiume` — attraversamento del bosco
- `capitolo_3_paese` — arrivo in paese
- `capitolo_4_citta` — avventura in città
- `capitolo_5_isola` — isola e costruzione
- `vittoria_finale` — conclusione

Ogni capitolo è indipendente e facile da modificare o estendere.

## 5. Fix dello shebang
Corretto `#!/user/bin/env ruby` → `#!/usr/bin/env ruby`.

## 6. Nome del giocatore riutilizzato
Il nome viene salvato in `@player` e usato nel messaggio finale di vittoria, dando un tocco più personale.

## 7. Metodi privati
Tutti i metodi interni sono dichiarati `private`, esponendo solo il metodo `gioca` come interfaccia pubblica.

## 8. Correzioni ortografiche
- "aventura" → "avventura"
- "costuire" → "costruire"
- "ditruggi" → "distruggi"
- "arivato" → "arrivato"
