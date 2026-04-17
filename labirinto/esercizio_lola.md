# 🐾 Esercizio: Crea Lola, la Cacciatrice di Mostri!

## La storia

Nel labirinto vive **Diana**, una cagnolina che gira a caso per i corridoi
lasciando delle piccole cacche sul pavimento. Se ci calpesti sopra, i tuoi
stivali si sporcano (ma non perdi vite, è solo imbarazzante 💩).

Diana è già scritta nel gioco, cerca il commento `# ── DIANA` in `labirinto.rb`.

Ma Diana ha una sorella: **Lola**. Lola è più coraggiosa.  
Gira per il labirinto esattamente come Diana, ma quando si trova
nella stessa cella di un nemico... lo termina! Il giocatore guadagna **30 punti**
per ogni nemico che Lola elimina.

**Il tuo compito**: completare la classe `Lola` che trovi già in `labirinto.rb`,
nel blocco contrassegnato con `# ═══ ESERCIZIO: CREA LA CLASSE LOLA`.

---

## Prima di tutto: capire Diana

Leggi con attenzione il codice di `Diana` in `labirinto.rb`.

```ruby
class Diana < Entita
  include Muovibile

  def initialize(riga, colonna)
    super(riga, colonna, SIMBOLI[:diana])   # ← usa il simbolo ⚆
    @direzioni_possibili = Muovibile::DIREZIONI.keys
  end

  def scegli_mossa_casuale
    dir = @direzioni_possibili.sample
    calcola_nuova_posizione(dir)             # ← viene da Muovibile
  end

  def sposta_a(riga, colonna)
    @riga    = riga
    @colonna = colonna
  end
end
```

### Cosa fa ogni pezzo?

| Riga | Significato |
|------|-------------|
| `class Diana < Entita` | Diana **eredita** da `Entita`: ha già `@riga`, `@colonna`, `@simbolo` |
| `include Muovibile` | Aggiunge il metodo `calcola_nuova_posizione` |
| `super(riga, colonna, SIMBOLI[:diana])` | Chiama `Entita#initialize` passando il simbolo ⚆ |
| `@direzioni_possibili.sample` | Sceglie una direzione a caso da w/s/a/d |
| `calcola_nuova_posizione(dir)` | Restituisce `[nuova_riga, nuova_colonna]` |

### Il movimento casuale passo per passo

1. `sample` pesca a caso uno tra `["w","s","a","d"]`
2. `calcola_nuova_posizione` aggiunge il delta corrispondente a `@riga` e `@colonna`
3. Il labirinto controlla se la cella è libera; se sì, chiama `sposta_a`
4. Prima di spostarsi, il labirinto lascia una cacca nella vecchia posizione

---

## Il tuo compito: la classe Lola

Trova in `labirinto.rb` la classe `Lola` con i commenti `# TODO`. Devi fare
**due cose**:

1. Cambiare il simbolo di Lola (usare `⚈` invece di `⚆`)
2. Scrivere il metodo `elimina_nemici` che rimuove i nemici nella sua posizione

---

## Passo 1 — Cambia il simbolo di Lola

Lola eredita `initialize` da Diana, che imposta `@simbolo = SIMBOLI[:diana]` (⚆).
Ma tu vuoi che Lola appaia con il simbolo ⚈ (`SIMBOLI[:lola]`).

**Suggerimento**: puoi chiamare `super` e poi sovrascrivere `@simbolo`:

```ruby
def initialize(riga, colonna)
  super(riga, colonna)        # chiama Diana#initialize
  @simbolo = SIMBOLI[:lola]   # poi cambia il simbolo
end
```

Perché funziona? Perché `@simbolo` è una variabile di istanza: appartiene
all'oggetto e puoi cambiarla in qualsiasi momento.

---

## Passo 2 — Scrivi `elimina_nemici`

Questo metodo riceve la **lista di tutti i nemici** del labirinto.
Deve restituire una **nuova lista** senza i nemici che si trovano
nella stessa posizione di Lola.

### Come capire se un nemico è nella stessa cella di Lola?

Un `Nemico` ha `.riga` e `.colonna`. Anche Lola ha `@riga` e `@colonna`.
Due entità sono nella stessa cella se hanno la stessa riga E la stessa colonna:

```ruby
nemico.riga == @riga && nemico.colonna == @colonna
```

### Come togliere elementi da una lista?

Usiamo `reject`: restituisce un nuovo Array senza gli elementi per cui
il blocco è `true`:

```ruby
numeri = [1, 2, 3, 4, 5]
numeri.reject { |n| n > 3 }
# => [1, 2, 3]   (ha tolto 4 e 5)
```

### Metti insieme

Il metodo `elimina_nemici` riceve `nemici` (l'Array con tutti i nemici).
Deve fare un `reject` che scarta i nemici **nella posizione di Lola**:

```ruby
def elimina_nemici(nemici)
  nemici.reject { |n| n.riga == @riga && n.colonna == @colonna }
end
```

Sembra semplice! Prova a scriverlo tu nella classe `Lola` prima di leggere
la soluzione in fondo a questo file.

---

## Passo 3 — Prova il gioco

Lancia il labirinto e aspetta qualche turno:

```bash
ruby labirinto/labirinto.rb
```

Quando Lola (simbolo `⚈`) incontra un nemico (simbolo `⚉`), vedrai il messaggio:

```
🐾 Lola ha eliminato 1 nemico! +30 punti
```

Se non compaiono nemici nei primi livelli (il livello 1 non ne ha), vai al
livello 3 o 4 dove ce ne sono molti!

---

## Sono bloccato! 🆘

### Blocco 1: non capisco dove scrivere il codice

Apri `labirinto.rb` e cerca (Cmd+F) la parola `ESERCIZIO`. Trovi il blocco:

```ruby
# ═══════════════════════════════════════════════════════════════
# 🐾 ESERCIZIO: CREA LA CLASSE LOLA
# ═══════════════════════════════════════════════════════════════

class Lola < Diana
  ...
end
```

È lì che scrivi il tuo codice.

---

### Blocco 2: `super` con o senza argomenti?

Ci sono due modi di chiamare `super`:

```ruby
super               # passa automaticamente tutti gli argomenti ricevuti
super(riga, colonna) # passa esattamente questi due argomenti
```

Nel nostro caso entrambi funzionano! Prova prima con `super` senza argomenti.

---

### Blocco 3: `reject` vs `select`

- `select` **tiene** gli elementi per cui il blocco è `true`
- `reject` **butta** gli elementi per cui il blocco è `true`

Per eliminare i nemici nella nostra posizione (condizione: `n.riga == @riga ...`)
vogliamo **buttar via** quelli per cui è vero → usiamo `reject`.

---

### Blocco 4: come faccio a vedere se funziona?

Aggiungi un `puts` temporaneo nel metodo per capire cosa succede:

```ruby
def elimina_nemici(nemici)
  da_eliminare = nemici.select { |n| n.riga == @riga && n.colonna == @colonna }
  puts "Lola ha trovato #{da_eliminare.length} nemici!" if da_eliminare.any?
  nemici.reject { |n| n.riga == @riga && n.colonna == @colonna }
end
```

---

### Blocco 5: tutto funziona ma Lola ha ancora il simbolo ⚆

Hai dimenticato di ridefinire `initialize`! Senza farlo, Lola usa quello
di Diana, che imposta `SIMBOLI[:diana]`. Aggiungi:

```ruby
def initialize(riga, colonna)
  super
  @simbolo = SIMBOLI[:lola]
end
```

---

## ✅ Soluzione completa (non guardare prima di provare!)

<details>
<summary>Clicca per rivelare la soluzione</summary>

```ruby
class Lola < Diana
  def initialize(riga, colonna)
    super
    @simbolo = SIMBOLI[:lola]
  end

  def elimina_nemici(nemici)
    nemici.reject { |n| n.riga == @riga && n.colonna == @colonna }
  end
end
```

</details>

---

## 🚀 Sfide extra (se vuoi andare oltre)

Una volta che Lola funziona, prova a modificarla:

### Sfida 1: Lola lascia anche le cacche
Diana lascia cacche perché il metodo `muovi_diana` lo fa per lei (nel labirinto).
Prova a capire quel metodo e a far sì che anche Lola lasci un simbolo diverso
(magari un'impronta di zampa?) modificando `muovi_lola` in `Labirinto`.

### Sfida 2: Lola ha una "zona di caccia"
Invece di eliminare solo i nemici **sulla stessa cella**, fai in modo che
Lola elimini i nemici nei **4 corridoi adiacenti** (su, giù, sinistra, destra):

```ruby
def elimina_nemici(nemici)
  nemici.reject do |n|
    (n.riga == @riga && (n.colonna - @colonna).abs <= 1) ||
    (n.colonna == @colonna && (n.riga - @riga).abs <= 1)
  end
end
```

### Sfida 3: Lola stanca
Lola non riesce a cacciare all'infinito! Aggiungi una variabile `@energia`
che parte da 5, scende di 1 ogni turno, e blocca l'eliminazione nemici
quando raggiunge 0. Ricarica di 2 quando Lola non trova nemici per 3 turni
di fila. Come lo implementeresti?

---

## 💡 Cosa hai imparato in questo esercizio

| Concetto | Dove l'hai usato |
|----------|-----------------|
| **Ereditarietà** (`<`) | `class Lola < Diana` eredita tutto da Diana |
| **`super`** | Chiama `Diana#initialize` per non riscrivere il codice |
| **Variabili di istanza** (`@simbolo`) | Puoi modificare `@simbolo` dopo aver chiamato `super` |
| **`reject`** | Filtra una lista rimuovendo gli elementi indesiderati |
| **Confronto di posizioni** | `n.riga == @riga && n.colonna == @colonna` |
