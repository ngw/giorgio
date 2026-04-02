# 🏰 Il Labirinto Perduto – Guida ai concetti

Questo gioco introduce diversi concetti nuovi di Ruby che non abbiamo ancora visto nei giochi precedenti. Leggi questa guida **dopo aver provato a giocare** almeno una volta!

Per lanciare il gioco:

```bash
ruby labirinto/labirinto.rb
```

Per giocare ai **tuoi** labirinti personalizzati:

```bash
ruby labirinto/labirinto.rb percorso/alla/tua/cartella/
```

## 🎮 Comandi

| Tasto | Azione |
|-------|--------|
| W | Muovi su (nord) |
| A | Muovi a sinistra (ovest) |
| S | Muovi giù (sud) |
| D | Muovi a destra (est) |
| M | Mostra la mappa esplorata |
| I | Apri l'inventario e le statistiche |
| Q | Esci dal gioco |

## 🗺️ Simboli sulla mappa

| Simbolo | Significato |
|---------|-------------|
| ☺ | Tu (il giocatore) |
| ⚑ | Uscita del labirinto |
| ✦ | Chiave (serve per porte e uscite) |
| ● | Moneta (+10 punti) |
| ◆ | Gemma (+50 punti) |
| ♥ | Pozione (+1 vita) |
| ☠ | Trappola (-1 vita!) |
| ▒ | Porta (serve una chiave) |
| ◎ | Teletrasporto |
| ? | Indizio |
| ⚉ | Nemico (si muove! -1 vita se ti tocca) |
| ░ | Nebbia (zona non ancora esplorata) |

---

## 📐 Matrici (Array bidimensionali)

Nei giochi precedenti abbiamo usato gli Array come liste semplici:

```ruby
inventario = ["spada", "scudo", "pozione"]
```

Un labirinto, però, è una **griglia**: ha righe e colonne. Per rappresentarlo usiamo un **Array di Array**, detto anche **matrice**:

```ruby
griglia = [
  ["#", "#", "#", "#"],   # riga 0
  ["#", ".", ".", "#"],   # riga 1
  ["#", ".", "E", "#"],   # riga 2
  ["#", "#", "#", "#"]    # riga 3
]
```

Per accedere a una cella scriviamo `griglia[riga][colonna]`:

```ruby
griglia[1][1]   # => "."   (riga 1, colonna 1 – corridoio)
griglia[2][2]   # => "E"   (riga 2, colonna 2 – uscita)
griglia[0][0]   # => "#"   (riga 0, colonna 0 – muro)
```

Pensa a una matrice come a un foglio a quadretti: la prima coordinata dice **quale riga** (dall'alto in basso) e la seconda **quale colonna** (da sinistra a destra).

### Come creiamo la matrice nel gioco

Partiamo da stringhe e usiamo `map` con `.chars`:

```ruby
layout = ["##.S", "#..#"]

griglia = layout.map { |riga| riga.chars }
# => [["#", "#", ".", "S"], ["#", ".", ".", "#"]]
```

`map` prende ogni elemento dell'Array, gli applica il blocco `{ ... }` e restituisce un **nuovo** Array con i risultati. È come dire: "per ogni riga, trasformala in un Array di caratteri".

### Nebbia di guerra: un'altra matrice

La visibilità è una matrice di `true`/`false`:

```ruby
@visibilita = Array.new(righe) { Array.new(colonne, false) }
```

- `Array.new(righe)` crea un Array con `righe` elementi
- Il blocco `{ Array.new(colonne, false) }` viene eseguito per **ogni** elemento e produce una riga tutta a `false`
- Quando il giocatore si avvicina a una cella, mettiamo `true`

---

## 📦 Moduli (`module` e `include`)

Fin qui abbiamo messo tutti i metodi dentro le classi. Ma se due classi diverse hanno bisogno della **stessa capacità** (ad esempio muoversi su una griglia), dovremmo copiarla e incollarla? No! Usiamo un **modulo**.

```ruby
module Muovibile
  DIREZIONI = {
    "w" => [-1, 0],
    "s" => [1, 0],
    "a" => [0, -1],
    "d" => [0, 1]
  }.freeze

  def calcola_nuova_posizione(direzione)
    delta = DIREZIONI[direzione]
    return nil unless delta
    [@riga + delta[0], @colonna + delta[1]]
  end
end
```

Un modulo è come una **scatola di attrezzi**: contiene metodi pronti all'uso ma **non è una classe** (non puoi fare `Muovibile.new`). Per usarli, li "includi" in una classe:

```ruby
class Giocatore < Entita
  include Muovibile
end
```

Nel gioco usiamo addirittura **due** moduli sullo stesso `Giocatore`:

```ruby
class Giocatore < Entita
  include Muovibile      # sa muoversi
  include Descrivibile   # sa descriversi
  include Comparable     # sa confrontarsi con altri giocatori
end
```

### Modulo vs Ereditarietà

| | Ereditarietà | Modulo |
|---|---|---|
| Sintassi | `class Figlia < Madre` | `include NomeModulo` |
| Quanti? | Solo **1** classe madre | **Molti** moduli |
| Quando usarlo | Le classi sono "una versione di" | Le classi "sanno fare qualcosa" |

Pensa così: un gatto **è** un animale (ereditarietà), ma un gatto **sa** nuotare (modulo "Nuotabile").

### Modulo `Descrivibile` e metodi astratti

```ruby
module Descrivibile
  def descrizione
    raise NotImplementedError, "#{self.class} deve implementare #descrizione"
  end
end
```

Questo modulo definisce un metodo "astratto": se lo includi in una classe ma non lo ridefinisci, Ruby lancia un errore. È un modo per **obbligare** le classi a implementare certi metodi.

---

## 🧬 Ereditarietà (`<` e `super`)

Nel gioco abbiamo una classe base `Entita` e **due** classi figlie: `Giocatore` e `Nemico`.

```ruby
class Entita
  attr_reader :riga, :colonna, :simbolo

  def initialize(riga, colonna, simbolo)
    @riga    = riga
    @colonna = colonna
    @simbolo = simbolo
  end
end

class Giocatore < Entita    # eredita da Entita
  def initialize(riga, colonna, nome)
    super(riga, colonna, SIMBOLI[:giocatore])   # chiama Entita#initialize
    @nome = nome
    @inventario = []
  end
end

class Nemico < Entita        # anche Nemico eredita da Entita!
  include Muovibile

  def initialize(riga, colonna)
    super(riga, colonna, SIMBOLI[:nemico])
  end
end
```

`super` chiama lo stesso metodo nella classe madre. Il vantaggio è che `Giocatore` e `Nemico` condividono tutto il codice di `Entita` senza duplicarlo:

```
        Entita
       /      \
  Giocatore  Nemico
  + Muovibile  + Muovibile
  + Descrivibile
  + Comparable
```

---

## 🧊 `freeze` – Rendere immutabili gli oggetti

```ruby
SIMBOLI = { muro: "█", corridoio: " " }.freeze
SIMBOLI[:nuovo] = "X"    # ERRORE! FrozenError: can't modify frozen Hash
```

Usiamo `freeze` sulle costanti (`SIMBOLI`, `DIREZIONI`, `LIVELLI`, `MESSAGGI_MURO`) per proteggerle da modifiche accidentali.

**Regola pratica**: se un Hash o Array non deve mai cambiare, metti `.freeze` alla fine.

---

## 🚨 Gestione errori (`begin` / `rescue`)

```ruby
begin
  dati = LIVELLI[livello]
  raise "Livello #{livello + 1} non esiste!" if dati.nil?
rescue => errore
  puts "Errore: #{errore.message}"
  puts "Uso il livello 1 come predefinito."
  dati = LIVELLI[0]
end
```

- `begin` – "prova a eseguire questo codice…"
- `raise` – "c'è un problema, lancia un errore"
- `rescue => errore` – "se succede un errore, catturalo"

Con Snake avevamo già visto `ensure`. Ora il quadro completo:

```ruby
begin
  # codice che potrebbe fallire
rescue TipoErrore => e
  # gestisci l'errore
ensure
  # eseguito SEMPRE
end
```

---

## 🔢 `each_with_index` – Iterare sapendo "dove siamo"

Quando disegniamo la matrice, ci serve sapere **posizione** e **contenuto**:

```ruby
@griglia.each_with_index do |riga, r|       # r = indice della riga
  riga.each_with_index do |cella, c|        # c = indice della colonna
    if r == giocatore.riga && c == giocatore.colonna
      print "☺"
    elsif cella == "#"
      print "█"
    end
  end
end
```

---

## 🔍 `select`, `reject`, `count` – Filtrare Array e Hash

Questi tre metodi sono fondamentali per lavorare con collezioni di dati.

### `select` – tieni solo quelli che vuoi

```ruby
# Trova tutte le chiavi rimaste nel labirinto
chiavi = @oggetti.select { |_pos, tipo| tipo == :chiave }
# => { [5,3] => :chiave, [9,7] => :chiave }
```

`select` scorre ogni elemento e **tiene** solo quelli per cui il blocco restituisce `true`.

### `reject` – butta via quelli che non vuoi

```ruby
# Tutti gli oggetti che NON sono chiavi
altri = @oggetti.reject { |_pos, tipo| tipo == :chiave }
```

`reject` è l'**opposto** di `select`: tiene solo quelli per cui il blocco restituisce `false`.

### `count` – conta gli elementi

```ruby
# Quante chiavi ha il giocatore?
chiavi = @inventario.count { |o| o == "chiave" }
# => 2
```

### `group_by` – raggruppa per criterio

Nell'inventario usiamo `group_by` per mostrare gli oggetti raggruppati:

```ruby
inventario = ["chiave", "chiave", "moneta"]
inventario.group_by { |o| o }
# => { "chiave" => ["chiave", "chiave"], "moneta" => ["moneta"] }
```

---

## 🎯 Lambda – funzioni come oggetti

Questo è un concetto potente: in Ruby puoi **salvare una funzione in una variabile** e usarla dopo. Si chiama **lambda** (o Proc).

```ruby
# Creare una lambda con la sintassi ->
saluto = ->(nome) { "Ciao, #{nome}!" }

# Chiamarla con .call
saluto.call("Giorgio")   # => "Ciao, Giorgio!"
```

Nel gioco le usiamo per le **porte condizionali**: ogni porta ha una lambda che controlla se il giocatore può aprirla:

```ruby
# La porta si apre solo se il giocatore ha una chiave
@porte[[r, c]] = ->(g) { g.ha_oggetto?("chiave") }

# Quando il giocatore prova ad aprire la porta:
if @porte[[r, c]].call(giocatore)   # chiama la lambda passando il giocatore
  # La porta si apre!
end
```

Perché è utile? Perché ogni porta può avere **condizioni diverse**:

```ruby
# Porta che richiede 2 chiavi
porta_doppia = ->(g) { g.conta_oggetti("chiave") >= 2 }

# Porta che richiede almeno 100 punti
porta_punti = ->(g) { g.punti >= 100 }

# Porta che si apre solo con vita piena
porta_vita = ->(g) { g.vite == 5 }
```

Le lambda sono come biglietti con una **ricetta**: non cucini subito, ma conservi le istruzioni per dopo.

---

## ⚖️ `Comparable` – Confrontare oggetti

Il modulo `Comparable` di Ruby permette di usare `<`, `>`, `==`, `<=`, `>=` e `.sort` su oggetti personalizzati. Basta definire **un solo** metodo: `<=>` (detto "nave spaziale"):

```ruby
class Giocatore
  include Comparable

  def <=>(altro)
    @punti <=> altro.punti
  end
end

# Ora possiamo fare:
giocatore1 > giocatore2    # => true se ha più punti
[g1, g2, g3].sort          # ordina per punteggio
[g1, g2, g3].max           # il giocatore con più punti
```

`<=>` restituisce:
- `-1` se il primo è **minore**
- `0` se sono **uguali**
- `1` se il primo è **maggiore**

---

## 🗺️ Come funziona il gioco

### Struttura delle classi

```
 ┌─────────────────┐
 │     Entita       │  ← classe base
 └───────▲─────────┘
        ╱ ╲
 ┌─────┴───┐  ┌────┴────┐
 │Giocatore │  │ Nemico   │
 │+Muovibile│  │+Muovibile│
 │+Descrivib│  └──────────┘
 │+Comparabl│
 └──────────┘
       │ usato da
 ┌─────┴──────────┐
 │ GiocoLabirinto  │──▶ Labirinto
 └────────────────┘
```

### I 4 livelli

| # | Nome | Dimensione | Elementi speciali |
|---|------|------------|-------------------|
| 1 | Il Risveglio | 23×21 | Monete, raggio visibilità 3 |
| 2 | Le Catacombe | 27×27 | Trappole, chiave, porta, pozione |
| 3 | Il Tempio Sommerso | 31×31 | Gemme, nemici, 2 chiavi, teletrasporto |
| 4 | La Fortezza Finale | 35×35 | Tutto! Nemici, indizi, portali, porte |

### Flusso del gioco

1. `GiocoLabirinto` crea un `Labirinto` dal livello corrente
2. Il `Labirinto` trasforma le stringhe in matrice e trova tutti gli elementi
3. A ogni turno:
   - I nemici si muovono in direzione casuale
   - Disegna la mappa (solo celle visibili)
   - Il giocatore può: muoversi, vedere inventario, consultare mappa
   - Si controllano collisioni, oggetti, porte, teletrasporti
4. Uscita raggiunta (con tutte le chiavi) → prossimo livello
5. Vite a zero → game over (può riprovare)

### Nebbia di guerra

Il giocatore vede solo le celle vicine (**distanza di Manhattan**):

```ruby
distanza = (riga_giocatore - r).abs + (colonna_giocatore - c).abs
```

Il raggio cambia per livello: 3 nel primo (più facile), 2 negli altri.

---

## � Crea i tuoi labirinti!

I livelli del gioco sono salvati come semplici file di testo nella cartella `livelli/`. Puoi creare i tuoi!

### Usare il generatore di modelli

```bash
ruby labirinto/crea_livello.rb
```

Lo script ti chiede nome, dimensioni e raggio di visibilità, e genera un file-modello con una griglia vuota pronta da riempire.

### Formato dei file livello

Ogni file `.txt` contiene tre righe di intestazione e poi la mappa:

```
nome: La Mia Stanza Segreta
descrizione: Il mio primo labirinto!
raggio_visibilita: 3

###########
#S........#
#.###.###.#
#...#.#.M.#
#.#.#.#.#.#
#.#...#K#.#
#.###.#.#.#
#.....#P..#
#.#######.#
#........E#
###########
```

### Simboli disponibili

| Simbolo | Significato |
|---------|-------------|
| `#` | Muro |
| `.` | Corridoio |
| `S` | Punto di partenza (uno solo!) |
| `E` | Uscita (una sola!) |
| `M` | Moneta (+10 punti) |
| `K` | Chiave (apre le porte P) |
| `T` | Trappola (-1 vita!) |
| `P` | Porta (serve una chiave) |
| `H` | Pozione (+1 vita) |
| `G` | Gemma (+50 punti) |
| `O` | Teletrasporto (mettine 2!) |
| `N` | Nemico |
| `?` | Indizio |

### Regole importanti

1. Il bordo esterno deve essere tutto muri (`#`)
2. Tutte le righe devono avere la **stessa larghezza**
3. Ci deve essere **esattamente un** `S` e **un** `E`
4. Il giocatore deve poter raggiungere `E` partendo da `S`!
5. Metti `K` e `P` in coppia: ogni porta ha bisogno di una chiave

### Giocare ai tuoi livelli

Metti i tuoi file `.txt` in una cartella (es. `miei_livelli/`) e lancia:

```bash
ruby labirinto/labirinto.rb miei_livelli/
```

I livelli vengono caricati in ordine alfabetico per nome del file. Usa numeri all'inizio per controllare l'ordine: `01_facile.txt`, `02_medio.txt`, ecc.

Il gioco **controlla** che i livelli siano validi: se manca la `S`, l'`E`, o le righe hanno larghezze diverse, ti dirà cosa correggere!

### Concetto Ruby: leggere file esterni

Il gioco carica i livelli da file con `File.read` e li analizza linea per linea con `each_line`:

```ruby
contenuto = File.read("mio_livello.txt")
contenuto.each_line do |linea|
  linea = linea.chomp        # rimuove il \n finale
  if linea.match?(/\Anome:/) # \A = inizio stringa (regex)
    nome = linea.sub(/\Anome:\s*/, "")
  end
end
```

Questo è un pattern molto comune in Ruby: leggere un file, processare ogni riga, estrarre le informazioni che servono.

---

## �🏋️ Esercizi

### Facili

1. **Nuovi simboli**: cambia i caratteri nell'Hash `SIMBOLI` per personalizzare la grafica.

2. **Messaggi muro**: aggiungi altri messaggi divertenti all'Array `MESSAGGI_MURO`.

3. **Raggio di visibilità**: modifica `raggio_visibilita` nei livelli per rendere il gioco più facile o più difficile.

4. **Messaggio di livello**: aggiungi un messaggio unico all'inizio di ogni livello (suggerimento: usa il campo `descrizione` nel Hash del livello).

### Medi

5. **Nuovo livello**: disegna un livello 5 e aggiungilo all'Array `LIVELLI`. Deve avere `S`, `E`, e almeno un elemento di ogni tipo. Ricorda che deve essere circondato da `#`.

6. **Contatore tempo**: registra `Time.now` all'inizio e mostra i secondi trascorsi nella barra di stato:
   ```ruby
   inizio = Time.now
   secondi = (Time.now - inizio).to_i
   ```

7. **Porta con condizione diversa**: crea una porta che richiede almeno 100 punti per aprirsi (modifica la lambda):
   ```ruby
   @porte[[r, c]] = ->(g) { g.punti >= 100 }
   ```

8. **Nemici più intelligenti**: modifica `scegli_mossa_casuale` per far muovere i nemici **verso** il giocatore (inseguimento). Suggerimento: confronta le coordinate del nemico con quelle del giocatore.

9. **Classifica con Comparable**: dopo ogni partita, salva il giocatore in un Array e usa `.sort` e `.max` per mostrare la classifica.

### Difficili

10. **Salvataggio su file**: usa `File.write` e `JSON` per salvare e caricare la partita:
    ```ruby
    require "json"
    dati = { livello: 2, punti: 50, vite: 2, posizione: [5, 3] }
    File.write("salvataggio.json", JSON.generate(dati))
    ```

11. **Generatore di labirinti**: scrivi un metodo che genera labirinti casuali con l'algoritmo "Recursive Backtracking": parti da una griglia tutta di muri e "scava" corridoi.

12. **Porte con timer**: crea una porta che si apre solo dopo un certo numero di mosse (usa una lambda che cattura una variabile esterna):
    ```ruby
    mosse_necessarie = 50
    @porte[[r, c]] = ->(g) { g.mosse >= mosse_necessarie }
    ```

13. **Sistema di combattimento**: quando il giocatore tocca un nemico, invece di perdere automaticamente una vita, entra in una "modalità combattimento" con scelte (attacca/difendi/fuggi). Crea un modulo `Combattente` con i metodi necessari e includilo nel Giocatore.

14. **Multi-giocatore locale**: aggiungi un secondo giocatore (tasti I/J/K/L) che compete nello stesso labirinto. Usa `Comparable` per determinare il vincitore alla fine di ogni livello.
