# Capitolo 5 — Come funziona il gioco Forza 4

Adesso che conosci Internet, HTTP e HTML, vediamo come funziona davvero
il codice di Forza 4!

## Il tabellone in memoria

Il tabellone 6×7 è una lista di liste (array di array in Ruby):

```ruby
ROWS = 6
COLS = 7

board = Array.new(6) { Array.new(7, nil) }
```

Ogni cella parte a `nil` (vuota). Quando un giocatore inserisce un disco,
la cella diventa `1` (rosso) o `2` (giallo).

```
# Stato del tabellone dopo qualche mossa
[nil, nil, nil, nil, nil, nil, nil]   ← riga 0 (in alto)
[nil, nil, nil, nil, nil, nil, nil]
[nil, nil, nil, nil, nil, nil, nil]
[nil, nil, nil,  1 , nil, nil, nil]
[nil, nil,  2 ,  1 , nil, nil, nil]
[nil,  2 ,  1 ,  2 , nil, nil, nil]   ← riga 5 (in basso)
```

## Come cade il disco

Quando premi la colonna 3, il server fa scorrere la colonna da
**in basso verso l'alto** cercando la prima cella vuota:

```ruby
def inserisci_disco(board, col, giocatore)
  (ROWS - 1).downto(0) do |riga|  # parte dalla riga 5 e sale
    if board[riga][col].nil?       # se la cella è vuota...
      board[riga][col] = giocatore # ...metti il disco!
      return riga                  # e ricorda in che riga è caduto
    end
  end
  nil  # colonna piena, nessuna mossa
end
```

`downto(0)` significa "conta alla rovescia partendo da 5 fino a 0".

## Come si controlla la vittoria

Dopo ogni mossa, il server controlla se ci sono 4 dischi di fila
nelle quattro direzioni possibili:

```
→  orizzontale    (direzione: colonna+1)
↓  verticale      (direzione: riga+1)
↘  diagonale giù  (direzione: riga+1, colonna+1)
↗  diagonale su   (direzione: riga-1, colonna+1)
```

Per ogni direzione, si contano i dischi consecutivi partendo
dall'ultima mossa, andando sia avanti che indietro:

```ruby
def trova_vincitore(board, riga, col, giocatore)
  direzioni = [[0, 1], [1, 0], [1, 1], [1, -1]]

  direzioni.each do |dr, dc|
    celle = [[riga, col]]        # partiamo dall'ultima mossa

    [1, -1].each do |segno|      # andiamo nei due sensi
      i = 1
      loop do
        nr = riga + segno * dr * i
        nc = col  + segno * dc * i
        break unless nr.between?(0, 5) && nc.between?(0, 6)  # fuori dal bordo?
        break unless board[nr][nc] == giocatore               # disco diverso?
        celle << [nr, nc]
        i += 1
      end
    end

    return celle if celle.length >= 4  # abbiamo 4 di fila!
  end
  nil  # nessuna vittoria
end
```

## La sessione: la memoria del gioco

HTTP non ricorda nulla tra una richiesta e l'altra —
ogni volta è come se il server vedesse il browser per la prima volta!

Per questo si usa la **sessione**: un piccolo spazio di memoria
che il server tiene per ogni giocatore, riconoscendolo tramite un **cookie**
(un piccolo dato salvato nel browser).

```ruby
# Salva lo stato del tabellone nella sessione
session[:partita] = partita

# Lo recupera alla prossima richiesta
partita = session[:partita]
```

È come se il server desse a ognuno un foglio con scritto il suo stato
e glielo riprendesse ogni volta che torna.

## Il giro completo di una mossa

Ecco cosa succede quando premi la colonna 3:

```
1. Browser                    → POST /gioca/3
                                 (richiesta HTTP)
2. Server (app.rb)
   - Legge la sessione         → state = session[:partita]
   - Inserisce il disco        → inserisci_disco(board, 3, giocatore)
   - Controlla la vittoria     → trova_vincitore(board, riga, 3, giocatore)
   - Aggiorna la sessione      → session[:partita] = state
   - Risponde con redirect     ← 302 Found → /
3. Browser                    → GET /
4. Server                     ← 200 OK + HTML aggiornato
5. Browser mostra la pagina   ← il tabellone con il nuovo disco
```

Cinque passi per ogni mossa — tutto in meno di un secondo!

## Il deploy su Render

Quando fai il push su GitHub, Render:

1. Legge `render.yaml` e capisce che è un'app Ruby
2. Esegue `bundle install` per installare Sinatra e Puma
3. Avvia il server con `bundle exec puma -p $PORT`
4. Assegna un URL pubblico tipo `forza4.onrender.com`

`$PORT` è una variabile d'ambiente: Render decide su quale porta
ascoltare e lo comunica al programma tramite questa variabile.

## Hai imparato tutto questo!

- 🌐 Come funziona Internet
- 🖥️  Il modello client/server
- 📨 Le richieste e risposte HTTP (GET, POST, codici di stato)
- 🏗️  HTML: tag, attributi, form
- 💎 Come Ruby e Sinatra gestiscono le route
- 🎮 Come un gioco di turni si costruisce sul web

Non male per un tutorial! Ora puoi aprire `app.rb` e modificare
il gioco come vuoi — prova a cambiare i colori, aggiungere un punteggio,
o inventare nuove regole. Il codice è tuo! 🚀

---

[← HTML](04_html.md) | [Prossimo: Multiplayer →](06_multiplayer.md)
