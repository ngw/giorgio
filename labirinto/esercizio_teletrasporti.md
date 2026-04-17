# ◎ Esercizio: Più di Due Teletrasporti!

## La storia

Nel labirinto ci sono dei portali magici (`◎`). Calpesti un portale… WHOOSH!
Ti ritrovi da un'altra parte.

La guida in `labirinto.md` dice *"mettine 2!"*, ma il codice è più furbo di
così. Con una piccola modifica puoi avere **3, 4, 5 portali** o quanti ne vuoi,
e ogni volta che ci entri vieni mandato in un posto **a caso** tra quelli disponibili.

Questo esercizio ha due parti:

| Parte | Cosa fai |
|-------|----------|
| **1** | Aggiungi 4 portali a un livello `.txt` (zero codice Ruby) |
| **2** | Modifica il metodo `teletrasporto_a` per destinazione casuale |

---

## Parte 1 — Aggiungi portali a un livello

Apri il file `labirinto/livelli/03_il_tempio_sommerso.txt`.  
Cerca le due `O` già presenti e aggiungine altre due in posizioni diverse del
labirinto (qualsiasi cella `.` va bene, basta che non sia `#` o `S` o `E`).

Esempio: cambia due `.` in `O`:

```
#.........O.....#    ← terzo portale
#...O............#   ← quarto portale
```

Poi lancia il gioco e raggiungile:

```bash
ruby labirinto/labirinto.rb
```

Vedrai scritto `◎ WHOOSH! Teletrasportato!` ogni volta che le calpesti.

### Cosa succede con 4 portali?

Il codice li mette in una lista nell'ordine in cui li incontra nella mappa
(dall'alto al basso, da sinistra a destra). Li chiameremo A, B, C, D.

Con il codice attuale l'ordine è **circolare fisso**:  
A → B → C → D → A → B → …

Quindi se entri in B arrivi sempre in C. Non è molto divertente con 4 portali!
La Parte 2 risolve questo.

---

## Parte 2 — Destinazione casuale

### Il metodo da modificare

Cerca in `labirinto.rb` il commento `# Controlla se c'è un teletrasporto` e
leggi il metodo sotto:

```ruby
def teletrasporto_a(riga, colonna)
  @teletrasporti.each_with_index do |pos, i|
    if pos == [riga, colonna]
      # Il teletrasporto manda all'altro teletrasporto (circolare)
      destinazione = @teletrasporti[(i + 1) % @teletrasporti.length]
      return destinazione if destinazione != pos
    end
  end
  nil
end
```

**Cosa fa adesso?**  
Scorre la lista `@teletrasporti` tenendo traccia dell'indice `i`.  
Quando trova il portale su cui sei, prende quello all'indice `i + 1`  
(con `%` per "avvolgere" alla fine della lista).

**Cosa vogliamo invece?**  
Prendere uno dei portali a caso, tra quelli diversi dal portale corrente.

---

### Gli strumenti che ti servono

#### `include?` – controlla se un elemento è in una lista

```ruby
numeri = [10, 20, 30]
numeri.include?(20)   # => true
numeri.include?(99)   # => false
```

#### `reject` – rimuovi elementi indesiderati

```ruby
numeri = [10, 20, 30, 40]
numeri.reject { |n| n == 20 }
# => [10, 30, 40]
```

Nel nostro caso vogliamo la lista di portali **senza quello su cui siamo**:

```ruby
altri_portali = @teletrasporti.reject { |pos| pos == [riga, colonna] }
```

#### `sample` – elemento casuale da una lista

```ruby
frutta = ["mela", "pera", "banana"]
frutta.sample   # => "pera" (ogni volta diverso!)
frutta.sample   # => "mela"
```

#### `nil` – niente da restituire

Se il portale su cui stai non è nella lista, il metodo deve restituire `nil`
(significa "non c'è destinazione").

---

### Il tuo compito

Riscrivi `teletrasporto_a` usando questi 4 strumenti.  
Il nuovo metodo deve:

1. Controllare se `[riga, colonna]` è nella lista `@teletrasporti`  
   → se non c'è, restituisci `nil`
2. Costruire una lista con tutti i portali tranne quello corrente  
   → usa `reject`
3. Scegliere uno a caso  
   → usa `sample`
4. Restituirlo (oppure `nil` se la lista è vuota)

Pensa a come scriverlo prima di leggere i suggerimenti!

---

## Sono bloccato! 🆘

### Blocco 1: come faccio a controllare se `[riga, colonna]` è nella lista?

`@teletrasporti` è un Array come questo: `[[5, 3], [12, 7], [4, 18], [19, 2]]`.  
Ogni elemento è a sua volta un Array `[riga, colonna]`.

`include?` funziona anche con Array dentro Array:

```ruby
@teletrasporti.include?([riga, colonna])
# => true se quel portale esiste
```

---

### Blocco 2: come faccio "ritorna subito nil" se non esiste?

Usa `return nil unless ...` (oppure `return nil if not ...`):

```ruby
return nil unless @teletrasporti.include?([riga, colonna])
# ← da qui in poi sei sicuro che il portale esiste
```

---

### Blocco 3: come costruisco la lista degli altri portali?

```ruby
altri = @teletrasporti.reject { |pos| pos == [riga, colonna] }
```

`pos` è ogni elemento dell'Array: `[5, 3]`, `[12, 7]`, ecc.  
`reject` tiene solo quelli per cui la condizione è `false`,  
cioè tiene tutti i portali che **non** sono quello corrente.

---

### Blocco 4: cosa faccio se `altri` è vuoto?

Se c'è un solo portale nel labirinto, `altri` sarà `[]` e `[].sample` restituisce `nil`.  
Va benissimo! Il gioco già controlla `if dest` prima di teletrasportare.  
Quindi se il metodo restituisce `nil`, non succede niente.

---

### Blocco 5: come metto insieme tutto?

```ruby
def teletrasporto_a(riga, colonna)
  return nil unless ...          # controlla che il portale esista
  altri = @teletrasporti.reject { |pos| ... }  # lista senza il corrente
  altri.sample                   # uno a caso (nil se lista vuota)
end
```

Riesci a riempire i puntini?

---

## ✅ Soluzione completa (non guardare prima di provare!)

<details>
<summary>Clicca per rivelare la soluzione</summary>

```ruby
def teletrasporto_a(riga, colonna)
  return nil unless @teletrasporti.include?([riga, colonna])
  altri = @teletrasporti.reject { |pos| pos == [riga, colonna] }
  altri.sample
end
```

Sostituisci il vecchio metodo `teletrasporto_a` in `labirinto.rb` con questo.

</details>

---

## Come sapere se funziona?

1. Crea una versione del livello 3 con **4 portali** (come spiegato nella Parte 1)
2. Entra nello stesso portale più volte  
3. Dovresti finire in posti diversi ogni volta!

Se finisci sempre nello stesso posto, controlla che tutti e 4 i portali siano
raggiungibili (no muri intorno) e che la mappa sia valida.

---

## L'operatore `%` — cosa faceva il vecchio codice?

Il vecchio codice usava:

```ruby
@teletrasporti[(i + 1) % @teletrasporti.length]
```

`%` è l'operatore **modulo**: restituisce il resto della divisione.

```ruby
5 % 3   # => 2   (5 diviso 3 = 1 resto 2)
6 % 3   # => 0   (6 diviso 3 = 2 resto 0)
7 % 3   # => 1   (7 diviso 3 = 2 resto 1)
```

Con una lista di 3 elementi (indici 0, 1, 2):

```ruby
(0 + 1) % 3   # => 1   (portale 0 va al portale 1)
(1 + 1) % 3   # => 2   (portale 1 va al portale 2)
(2 + 1) % 3   # => 0   (portale 2 torna al portale 0!) ← il trucco!
```

`%` serve a **"avvolgere"** l'indice: quando arriva in fondo ricomincia da 0.
È un trucco molto comune per spostarsi in modo circolare su una lista.

---

## 🚀 Sfide extra

### Sfida 1: portali con colori diversi
Aggiungi al dizionario `SIMBOLI` un simbolo diverso per ogni gruppo di portali
(es. `◉` per il gruppo B). Poi modifica `analizza_griglia` per leggere un
carattere diverso (`Q` al posto di `O`) e salvarlo in una lista separata
`@teletrasporti_b`. Infine, fai in modo che i portali `O` mandino solo agli
altri `O`, e i portali `Q` solo agli altri `Q`.

### Sfida 2: portale a senso unico
Invece di `@teletrasporti` (lista di coppie), trasforma la struttura in un
Hash: `{ [riga_partenza, col_partenza] => [riga_arrivo, col_arrivo] }`.  
Così ogni portale ha una destinazione fissa e diversa. Come dovresti cambiare
`analizza_griglia` e `teletrasporto_a`?

### Sfida 3: conto dei salti
Aggiungi una variabile `@salti_teletrasporto` in `Giocatore` che conta quante
volte il giocatore è stato teletrasportato. Mostrala nell'inventario (tasto `I`).

---

## 💡 Cosa hai imparato

| Concetto | Dove l'hai usato |
|----------|-----------------|
| **`include?`** | Controllare se un portale esiste nella lista |
| **`reject`** | Filtrare la lista tenendo solo i portali diversi dal corrente |
| **`sample`** | Scegliere un elemento a caso da una lista |
| **`return nil unless`** | Uscire subito dal metodo se la condizione non è soddisfatta |
| **`%` (modulo)** | Capire come funzionava il vecchio codice circolare |
| **Array di Array** | `@teletrasporti` è una lista dove ogni elemento è `[riga, colonna]` |
