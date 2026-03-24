# 🐍 Come Funziona Snake

Analizziamo il gioco Snake (`snake/snake.rb`) per capire come funziona e imparare nuovi concetti di Ruby.

---

## 🎯 Obiettivo del Gioco

Controlli un serpente che si muove sullo schermo. Devi:
1. **Mangiare il cibo** (`$`) per crescere e fare punti
2. **Non sbattere contro i muri** (`#`)
3. **Non sbattere contro te stesso** — più cresci, più è difficile!

Il serpente non si ferma mai, diventa sempre più veloce man mano che mangi. Quanto riesci a resistere?

---

## 💻 Come Installare e Avviare il Gioco

### Su Chromebook con Linux

Il Chromebook ha un terminale Linux nascosto. Ecco come attivarlo e preparare tutto:

#### 1. Attiva il terminale Linux

1. Apri **Impostazioni** del Chromebook
2. Cerca **"Linux"** nella barra di ricerca
3. Clicca su **"Ambiente di sviluppo Linux"** → **Attiva**
4. Aspetta che finisca l'installazione (ci vogliono alcuni minuti)
5. Si aprirà un terminale! 🎉

#### 2. Installa Ruby

```bash
# Aggiorna la lista dei programmi disponibili
sudo apt update

# Installa Ruby e le librerie necessarie per compilare le gemme
sudo apt install -y ruby ruby-dev build-essential libncurses-dev
```

> **Cosa vuol dire `sudo`?** È come dire "per favore fallo come amministratore".
> Il computer ti chiederà la password per essere sicuro che sei tu.

> **Cosa vuol dire `apt`?** È il "negozio di programmi" di Linux. `apt install`
> scarica e installa un programma.

> **Cosa è `libncurses-dev`?** È la libreria che permette di disegnare sullo
> schermo del terminale (muri, serpente, colori...). La gemma `curses` di Ruby
> ha bisogno di questa libreria per funzionare.

#### 3. Installa Bundler

```bash
# Installa bundler — il gestore di gemme di Ruby
sudo gem install bundler
```

> **Cosa è Bundler?** Quando un programma Ruby ha bisogno di librerie esterne
> (chiamate "gemme"), Bundler le scarica e le installa tutte insieme.
> È come un assistente che prepara tutto il necessario prima di iniziare.

#### 4. Scarica e avvia il gioco

```bash
# Entra nella cartella del gioco
cd snake

# Installa le gemme necessarie (legge il file Gemfile)
bundle install

# Avvia il gioco!
bundle exec ruby snake.rb
```

> **Perché `bundle exec`?** Dice a Ruby: "usa le gemme che Bundler ha installato".
> Senza `bundle exec`, Ruby potrebbe non trovare la gemma `curses`.

---

## 📂 I File del Progetto

```
snake/
  Gemfile        ← lista delle gemme necessarie
  Gemfile.lock   ← versioni esatte installate (creato da bundle install)
  snake.rb       ← il codice del gioco
```

### Il Gemfile

```ruby
source "https://rubygems.org"

gem "curses", "~> 1.4"
```

Questo file dice a Bundler: "Ho bisogno della gemma `curses`, versione 1.4 o superiore. Scaricala da rubygems.org."

---

## 🧠 Concetti Nuovi

### 1. Curses (ncurses) — Disegnare nel Terminale

Normalmente, il terminale scrive il testo riga per riga, dall'alto in basso, come un libro. Non puoi tornare indietro e modificare una riga già scritta.

**Curses** cambia le regole: trasforma il terminale in una "lavagna" dove puoi scrivere **dovunque** e **cancellare** quello che vuoi. Perfetto per i giochi!

```ruby
require "curses"

# Attiva la modalità "lavagna"
Curses.init_screen

# Scrivi "Ciao!" alla riga 5, colonna 10
Curses.stdscr.setpos(5, 10)
Curses.stdscr.addstr("Ciao!")

# Mostra tutto sullo schermo
Curses.stdscr.refresh

# Aspetta un tasto
Curses.stdscr.getch

# Ripristina il terminale normale
Curses.close_screen
```

Le funzioni principali che usiamo in Snake:

| Funzione | Cosa fa |
|----------|---------|
| `init_screen` | Attiva la modalità curses (schermo pieno) |
| `close_screen` | Torna al terminale normale |
| `curs_set(0)` | Nasconde il cursore lampeggiante |
| `noecho` | Non mostra i tasti che premi |
| `cbreak` | Legge i tasti subito (senza aspettare Invio) |
| `keypad(true)` | Permette di leggere le frecce della tastiera |
| `nodelay = true` | **Il trucco!** Non aspetta un tasto, continua subito |
| `setpos(riga, colonna)` | Sposta il "pennello" in una posizione |
| `addstr("testo")` | Scrive del testo nella posizione corrente |
| `refresh` | Mostra tutto sullo schermo in un colpo solo |
| `getch` | Legge un tasto premuto |

#### nodelay — Il Trucco Magico

Normalmente `getch` **si ferma** e aspetta che tu prema un tasto. Ma in un gioco il serpente deve muoversi SEMPRE, anche se non premi niente!

```ruby
# SENZA nodelay: il gioco si ferma finché non premi un tasto 😴
tasto = win.getch  # ...aspetta...aspetta...aspetta...

# CON nodelay: se non premi niente, ritorna nil e continua! 🏃
win.nodelay = true
tasto = win.getch  # → nil (nessun tasto premuto, ma il gioco continua!)
```

### 2. Il Game Loop — Il Cuore di Ogni Gioco

Ogni gioco funziona con un ciclo che si ripete all'infinito:

```
  ┌──────────────────────────────────────┐
  │                                      │
  │   1. Leggi input (tasti premuti)     │
  │              ↓                       │
  │   2. Aggiorna (muovi, collisioni)    │
  │              ↓                       │
  │   3. Disegna (mostra sullo schermo)  │
  │              ↓                       │
  │   4. Pausa (sleep)                   │
  │              ↓                       │
  │         Ricomincia!                  │
  │                                      │
  └──────────────────────────────────────┘
```

In Ruby:

```ruby
until @game_over
  leggi_input     # 1. Che tasto hai premuto?
  aggiorna        # 2. Muovi il serpente, controlla se ha mangiato o è morto
  disegna         # 3. Ridisegna tutto lo schermo
  sleep(0.25)     # 4. Aspetta un po' (altrimenti è troppo veloce!)
end
```

### 3. Struct — Mini-Classi Veloci

Per dire "il serpente è alla colonna 5, riga 3" abbiamo bisogno di un oggetto con `x` e `y`. Potremmo fare una classe intera, ma `Struct` è più veloce:

```ruby
# Crea una mini-classe chiamata Punto con due campi: x e y
Punto = Struct.new(:x, :y)

# Ora possiamo creare punti facilmente!
posizione = Punto.new(5, 3)
puts posizione.x  # → 5
puts posizione.y  # → 3

# Creare un altro punto
cibo = Punto.new(10, 7)

# Confrontarli
puts posizione.x == cibo.x  # → false (5 non è uguale a 10)
```

### 4. Array Come Coda (Queue)

Il corpo del serpente è un Array usato come una "fila al supermercato":
- **push**: una nuova persona si mette IN FONDO alla fila
- **shift**: la prima persona ESCE dalla fila

```ruby
# Il serpente si muove verso destra:
corpo = [Punto.new(3, 5), Punto.new(4, 5), Punto.new(5, 5)]
#        ^coda                               ^testa

# 1. La testa avanza: push aggiunge la nuova testa in fondo
corpo.push(Punto.new(6, 5))
# corpo = [3,5  4,5  5,5  6,5]
#          ^coda           ^nuova testa

# 2. La coda sparisce: shift toglie il primo elemento
corpo.shift
# corpo = [4,5  5,5  6,5]
#          ^coda      ^testa
# Il serpente si è spostato di 1!

# Se invece mangia il cibo: fai push MA NON shift!
# Così il corpo cresce di 1 pezzo.
```

### 5. Hash Come Lookup Veloce

Per disegnare ogni cella, dobbiamo sapere: "c'è il serpente qui?"

Modo LENTO (controllare tutto l'array ogni volta):
```ruby
# Per ogni cella dello schermo (32 × 18 = 576 celle!)
# scorri tutto il corpo del serpente...
corpo.any? { |p| p.x == x && p.y == y }  # LENTO se il serpente è lungo!
```

Modo VELOCE (usare un Hash come "elenco telefonico"):
```ruby
# Prima: crea un Hash con tutte le posizioni
corpo_pos = {}
corpo.each { |p| corpo_pos[[p.x, p.y]] = true }

# Poi: cerca in un istante!
corpo_pos[[5, 3]]  # → true (il serpente è qui!)
corpo_pos[[8, 2]]  # → nil  (qui non c'è)
```

> Un Hash è come un elenco telefonico: se cerchi "Mario Rossi" lo trovi subito,
> senza leggere tutti i nomi dall'inizio!

### 6. case/when — Scelta Multipla

Invece di scrivere tanti `if`/`elsif`, usa `case`/`when`:

```ruby
# PRIMA (brutto e lungo):
if tasto == Curses::KEY_UP
  direzione = :su
elsif tasto == Curses::KEY_DOWN
  direzione = :giu
elsif tasto == Curses::KEY_LEFT
  direzione = :sinistra
elsif tasto == Curses::KEY_RIGHT
  direzione = :destra
end

# DOPO (bello e pulito!):
direzione = case tasto
            when Curses::KEY_UP    then :su
            when Curses::KEY_DOWN  then :giu
            when Curses::KEY_LEFT  then :sinistra
            when Curses::KEY_RIGHT then :destra
            end
```

### 7. ensure — Ripulisci Sempre!

Cosa succede se il gioco crasha? Il terminale resta in modalità curses e diventa inutilizzabile! `ensure` risolve il problema:

```ruby
def gioca
  Curses.init_screen   # Attiva la lavagna
  # ... gioca ...
  # 💥 Ops! Un errore! Il programma crasherebbe qui!
ensure
  Curses.close_screen  # Questo viene eseguito SEMPRE.
  # Anche se c'è un errore, il terminale torna normale. 😌
end
```

> È come dire: "qualunque cosa succeda, ricordati di spegnere la luce
> quando esci dalla stanza."

### 8. Colori nel Terminale

Curses gestisce i colori con "coppie" (testo + sfondo):

```ruby
# Crea la coppia di colori numero 1: testo verde su sfondo nero
Curses.init_pair(1, Curses::COLOR_GREEN, Curses::COLOR_BLACK)

# Usa questa coppia per scrivere
win.attron(Curses.color_pair(1)) do
  win.addstr("Questo testo è verde!")
end

# Colori disponibili:
# COLOR_BLACK, COLOR_RED, COLOR_GREEN, COLOR_YELLOW,
# COLOR_BLUE, COLOR_MAGENTA, COLOR_CYAN, COLOR_WHITE
```

---

## ⚙️ Le Impostazioni

In cima al file `snake.rb` ci sono delle **costanti** che puoi cambiare:

```ruby
LARGHEZZA = 32           # Prova 20 (piccolo) o 50 (enorme!)
ALTEZZA   = 18           # Prova 10 (stretto) o 25 (alto!)
VELOCITA  = 250          # 300=lumaca, 200=normale, 80=impossibile!
PUNTI_PER_CIBO = 10      # Prova 50 per fare tanti punti!
LUNGHEZZA_INIZIALE = 3   # Prova 10 per partire già lungo!
SIMBOLO_TESTA = "O"      # Prova "@" o "X"
SIMBOLO_CIBO  = "$"      # Prova "♥" o "★"
```

> Le costanti si scrivono in MAIUSCOLO. Ruby ti avvisa se provi a cambiarle
> mentre il programma sta girando — sono fatte per essere modificate PRIMA
> di avviare il gioco, non durante!

---

## 🏋️ Esercizi

Prova a modificare il gioco! Parti dal più facile e vai avanti.

### ⭐ Esercizio 1 — Personalizza (facilissimo)

Cambia le impostazioni in cima al file per creare la TUA versione:
- Campo gigante (50 × 25), serpente lentissimo, 100 punti per cibo
- Campo minuscolo (15 × 10), serpente velocissimo, 1 punto per cibo

Avvia il gioco dopo ogni modifica per vedere l'effetto!

---

### ⭐⭐ Esercizio 2 — Conta i Cibi Mangiati

Aggiungi un contatore che mostra quanti cibi hai mangiato (non solo i punti).

**Suggerimento:** Aggiungi `@cibi_mangiati = 0` in `initialize`, poi incrementalo quando il serpente mangia. Mostralo nella riga del punteggio nel metodo `disegna`.

---

### ⭐⭐ Esercizio 3 — Muri Colorati Diversi

Cambia il colore dei muri orizzontali (sopra e sotto) rispetto a quelli verticali (sinistra e destra).

**Suggerimento:** Nel metodo `disegna`, il codice che disegna i muri è:
```ruby
if y == 0 || y == ALTEZZA - 1 || x == 0 || x == LARGHEZZA - 1
```
Puoi dividerlo in due condizioni separate:
```ruby
if y == 0 || y == ALTEZZA - 1
  # muro orizzontale → colore 1
elsif x == 0 || x == LARGHEZZA - 1
  # muro verticale → colore 2
```

---

### ⭐⭐⭐ Esercizio 4 — Aggiungi un Cibo Speciale

Ogni 5 cibi normali, fai apparire un **cibo speciale** (usa `"★"`) che vale il triplo dei punti ma scompare dopo 5 secondi.

**Suggerimenti:**
1. Aggiungi `@cibi_mangiati` per contare quanti cibi hai mangiato
2. Aggiungi `@cibo_speciale` (un `Punto`, oppure `nil` se non c'è)
3. Aggiungi `@tempo_cibo_speciale` per sapere quando è apparso (`Time.now`)
4. Nel metodo `aggiorna`, controlla se sono passati 5 secondi:
   ```ruby
   if @cibo_speciale && Time.now - @tempo_cibo_speciale > 5
     @cibo_speciale = nil  # è scaduto!
   end
   ```
5. Nel metodo `disegna`, disegnalo con un colore diverso (es. giallo)

---

### ⭐⭐⭐ Esercizio 5 — Pausa

Aggiungi la possibilità di mettere in **pausa** il gioco premendo `P`.

**Suggerimenti:**
1. Aggiungi `@pausa = false` in `initialize`
2. In `leggi_input`, aggiungi:
   ```ruby
   when "p", "P" then @pausa = !@pausa
   ```
   (`!` inverte: se era `true` diventa `false`, e viceversa)
3. In `game_loop`, non aggiornare se sei in pausa:
   ```ruby
   leggi_input
   aggiorna unless @pausa
   disegna
   ```
4. In `disegna`, mostra "PAUSA" al centro dello schermo quando `@pausa` è `true`

---

### ⭐⭐⭐⭐ Esercizio 6 — Salva il Record

Salva il punteggio più alto su un file, così resta anche dopo che chiudi il gioco!

**Suggerimenti:**
```ruby
# Leggere il record dal file:
def carica_record
  if File.exist?("record.txt")
    File.read("record.txt").to_i
  else
    0
  end
end

# Salvare il record:
def salva_record(punteggio)
  record = carica_record
  if punteggio > record
    File.write("record.txt", punteggio.to_s)
  end
end
```

Chiama `salva_record(@punteggio)` nella schermata di game over!

---

### ⭐⭐⭐⭐⭐ Esercizio 7 — Il Serpente Attraversa i Muri!

Invece di morire quando tocca un muro, il serpente **rientra dall'altro lato** (come in Pac-Man).

**Suggerimento:** Nel metodo `aggiorna`, invece di fare game over quando tocca un muro, fa "wrap around":

```ruby
# Invece di:
if nuova_testa.x <= 0
  @game_over = true
end

# Fai:
if nuova_testa.x <= 0
  nuova_testa = Punto.new(LARGHEZZA - 2, nuova_testa.y)
elsif nuova_testa.x >= LARGHEZZA - 1
  nuova_testa = Punto.new(1, nuova_testa.y)
end
# (fai lo stesso per y!)
```
