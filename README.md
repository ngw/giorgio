
# 🎮 Guida Ruby per Giovani Programmatori

Una guida semplice per imparare Ruby, con esempi facili da capire!

---

## 📦 Tipi di Dato

I tipi di dato sono come contenitori diversi per le informazioni.

### Numeri (Numbers)

Puoi usare numeri interi o decimali:

```ruby
eta = 10
altezza = 1.45
punteggio = 100
```

Operazioni con i numeri:
```ruby
somma = 5 + 3        # 8
sottrazione = 10 - 4  # 6
moltiplicazione = 6 * 7  # 42
divisione = 20 / 4    # 5
```

### Stringhe (Strings)

Le stringhe sono testi tra virgolette:

```ruby
nome = "Mario"
saluto = "Ciao, come stai?"
messaggio = 'Benvenuto nel mondo Ruby!'
```

Puoi unire le stringhe:
```ruby
nome = "Luca"
saluto = "Ciao " + nome + "!"  # "Ciao Luca!"

# Oppure usa l'interpolazione (più facile!):
saluto = "Ciao #{nome}!"  # "Ciao Luca!"
```

### Booleani (Booleans)

Vero o falso - come un interruttore acceso/spento:

```ruby
sono_felice = true
piove = false
ho_fame = true
```

### Nil (Nulla)

`nil` rappresenta "nessun valore" o "niente". È come una scatola vuota:

```ruby
risposta = nil
punti = nil

# Controllare se qualcosa è nil:
if risposta.nil?
  puts "Non hai ancora risposto!"
end

if risposta == nil
  puts "Questo funziona anche!"
end
```

**Importante:** `nil` è diverso da `false`!
```ruby
false.nil?  # false
nil.nil?    # true

# nil e false sono entrambi "falsi" nei controlli if:
if nil
  puts "Questo non si stampa"
end

if false
  puts "Neanche questo si stampa"
end
```

### Simboli (Symbols)

I simboli sono come etichette uniche. Si scrivono con i due punti `:` davanti:

```ruby
:nome
:colore
:stato
```

**Quando usare simboli invece di stringhe?**

Usa simboli per "etichette" o "identificatori" che non cambiano:
```ruby
# ❌ Stringhe (pesanti, ogni volta è nuovo oggetto)
persona = {"nome" => "Mario", "eta" => 10}

# ✅ Simboli (leggeri, sempre lo stesso oggetto)
persona = {nome: "Mario", eta: 10}
# oppure
persona = {:nome => "Mario", :eta => 10}
```

**Differenza pratica:**
```ruby
# Le stringhe sono diverse anche se uguali:
"ciao".object_id == "ciao".object_id  # false (due oggetti diversi)

# I simboli con lo stesso nome sono lo stesso oggetto:
:ciao.object_id == :ciao.object_id     # true (stesso oggetto)
```

Usa simboli quando:
- Sono chiavi in un hash
- Sono identificatori che non cambiano
- Vuoi essere più efficiente (usano meno memoria)

Usa stringhe quando:
- Il testo può cambiare
- È input dell'utente
- È un messaggio da mostrare

### Array (Liste)

Un array è come uno zaino dove metti tante cose:

```ruby
frutti = ["mela", "banana", "arancia"]
numeri = [1, 2, 3, 4, 5]
misto = ["ciao", 42, true]

# Accedere agli elementi (si parte da 0!):
primo_frutto = frutti[0]  # "mela"
secondo_frutto = frutti[1]  # "banana"

# Aggiungere elementi:
frutti.push("pera")  # ora: ["mela", "banana", "arancia", "pera"]
```

### Hash (Dizionari)

Un hash è come un dizionario - ogni parola ha la sua definizione:

```ruby
persona = {
  "nome" => "Sofia",
  "eta" => 10,
  "colore_preferito" => "blu"
}

# Accedere ai valori:
il_nome = persona["nome"]  # "Sofia"

# Con simboli (più comune):
animale = {
  nome: "Rex",
  tipo: "cane",
  eta: 3
}

nome_animale = animale[:nome]  # "Rex"
```

### ✏️ Esercizi - Primissimi Passi

Ora che conosci i tipi di dato base, prova questi esercizi:

1. Crea una variabile con il tuo nome e stampala
2. Fai una somma di due numeri e stampa il risultato  
3. Crea un array con 3 nomi di animali e stampalo
4. Crea un hash con simboli come chiavi: `{nome: "Mario", eta: 10}`

---

## 🔀 Condizionali

I condizionali ti permettono di fare scelte - come un bivio in un videogioco!

### If / Else (Se / Altrimenti)

```ruby
eta = 10

if eta >= 18
  puts "Sei maggiorenne"
else
  puts "Sei minorenne"
end
```

### If / Elsif / Else

```ruby
voto = 8

if voto >= 9
  puts "Eccellente!"
elsif voto >= 7
  puts "Bravo!"
elsif voto >= 6
  puts "Sufficiente"
else
  puts "Devi studiare di più"
end
```

### Operatori di Confronto

```ruby
5 == 5   # uguale a (true)
5 != 3   # diverso da (true)
5 > 3    # maggiore di (true)
5 < 10   # minore di (true)
5 >= 5   # maggiore o uguale (true)
5 <= 4   # minore o uguale (false)
```

### Operatori Logici

```ruby
# AND (&&) - entrambe le condizioni devono essere vere
eta = 10
ha_permesso = true

if eta >= 8 && ha_permesso
  puts "Puoi giocare!"
end

# OR (||) - almeno una condizione deve essere vera
e_sabato = true
e_domenica = false

if e_sabato || e_domenica
  puts "È weekend!"
end

# NOT (!) - inverte la condizione
piove = false

if !piove
  puts "Possiamo uscire!"
end
```

### Unless (A meno che)

```ruby
stanco = false

unless stanco
  puts "Andiamo a giocare!"
end

# È come dire: if !stanco
```

### Case / When (Scegli tra tante opzioni)

Quando hai tante opzioni da controllare, `case/when` è più chiaro di tanti `elsif`:

```ruby
giorno = "lunedì"

case giorno
when "lunedì"
  puts "Inizia la settimana!"
when "venerdì"
  puts "Quasi weekend!"
when "sabato", "domenica"  # Puoi controllare più valori insieme
  puts "È weekend! 🎉"
else
  puts "Un giorno normale"
end
```

**Esempio con numeri - Valutazione voto:**
```ruby
voto = 8

case voto
when 10
  puts "Perfetto!"
when 9
  puts "Eccellente!"
when 7, 8
  puts "Bravo!"
when 6
  puts "Sufficiente"
else
  puts "Devi migliorare"
end
```

**Esempio con range:**
```ruby
eta = 15

case eta
when 0..2
  puts "Sei un bebè"
when 3..12
  puts "Sei un bambino"
when 13..17
  puts "Sei un adolescente"
when 18..64
  puts "Sei un adulto"
else
  puts "Sei un anziano"
end
```

**Esempio pratico - Menu di gioco:**
```ruby
print "Scegli (1=Inizia, 2=Carica, 3=Opzioni, 4=Esci): "
scelta = gets.chomp.to_i

case scelta
when 1
  puts "Avvio nuovo gioco..."
when 2
  puts "Caricamento partita salvata..."
when 3
  puts "Apertura opzioni..."
when 4
  puts "Arrivederci!"
else
  puts "Scelta non valida!"
end
```

### ✏️ Esercizi - Condizionali e Case/When

Mettiamo in pratica if, elsif, unless e case/when:

1. Scrivi un programma che dice se un numero è pari o dispari
2. Usa un `unless` per stampare un messaggio se NON piove
3. Crea un if che controlla se un numero è maggiore di 10
4. Usa `case/when` per tradurre numeri 1-7 in giorni della settimana
5. Crea un menu semplice (1=Gioca, 2=Opzioni, 3=Esci) con `case/when`
6. Fai un programma che controlla se una variabile è `nil` prima di usarla
7. Scrivi un metodo che restituisce un valore o `nil` in base a una condizione

---

## 🔁 Cicli

I cicli servono per ripetere azioni - come saltare la corda più volte!

### Loop Times (Ripeti N volte)

```ruby
# Ripeti 5 volte
5.times do
  puts "Ciao!"
end

# Con un contatore:
5.times do |numero|
  puts "Questo è il giro numero #{numero}"
end
# Stampa: 0, 1, 2, 3, 4
```

### Loop For / Each (Per ogni elemento)

```ruby
animali = ["gatto", "cane", "coniglio", "pesce"]

animali.each do |animale|
  puts "Mi piacciono i #{animale}"
end
```

Con i numeri:
```ruby
(1..5).each do |numero|
  puts "Numero: #{numero}"
end
# Stampa: 1, 2, 3, 4, 5
```

### Loop While (Finché)

```ruby
contatore = 1

while contatore <= 5
  puts "Conto: #{contatore}"
  contatore = contatore + 1
end
```

### Loop Until (Fino a quando)

```ruby
numero = 1

until numero > 5
  puts numero
  numero = numero + 1
end
```

### Loop For con Range

```ruby
# Da 1 a 10
for i in 1..10
  puts i
end

# Da 1 a 10 (esclude il 10)
for i in 1...10
  puts i
end
```

### Controllare i Cicli

```ruby
# Break - esci dal ciclo
(1..10).each do |numero|
  break if numero > 5  # fermati quando numero è maggiore di 5
  puts numero
end

# Next - salta al prossimo giro
(1..10).each do |numero|
  next if numero % 2 == 0  # salta i numeri pari
  puts numero  # stampa solo i dispari
end
```

### ✏️ Esercizi - Cicli

Pratica con i cicli:

1. Usa un ciclo `.times` per stampare "Ciao!" 5 volte
2. Fai un ciclo che stampa i numeri da 1 a 10
3. Crea un array di colori e stampali uno per uno con `.each`
4. Fai un ciclo che conta alla rovescia da 10 a 0
5. Usa `.each` con un range per stampare i numeri da 1 a 20

---

## 🔧 Metodi

I metodi (o funzioni) sono come ricette: un insieme di istruzioni con un nome che puoi riutilizzare!

### Creare un Metodo Semplice

```ruby
def saluta
  puts "Ciao!"
end

# Chiamare il metodo:
saluta  # Stampa: Ciao!
```

### Metodi con Parametri

I parametri sono come ingredienti della ricetta:

```ruby
def saluta_persona(nome)
  puts "Ciao #{nome}!"
end

saluta_persona("Marco")   # Ciao Marco!
saluta_persona("Sofia")   # Ciao Sofia!
```

Con più parametri:
```ruby
def somma(a, b)
  risultato = a + b
  puts "#{a} + #{b} = #{risultato}"
end

somma(5, 3)   # 5 + 3 = 8
somma(10, 7)  # 10 + 7 = 17
```

### Metodi che Restituiscono Valori

I metodi possono calcolare e restituire un valore:

```ruby
def moltiplica(a, b)
  return a * b
end

risultato = moltiplica(4, 5)
puts risultato  # 20

# In Ruby, return è opzionale (restituisce l'ultima riga):
def dividi(a, b)
  a / b  # viene restituito automaticamente
end

puts dividi(10, 2)  # 5
```

### Parametri con Valori Predefiniti

Puoi dare valori di default ai parametri:

```ruby
def saluta(nome = "amico")
  puts "Ciao #{nome}!"
end

saluta("Luca")  # Ciao Luca!
saluta          # Ciao amico!
```

### Metodi Utili

Esempio di metodi pratici:

```ruby
# Controllare se un numero è pari
def pari?(numero)
  numero % 2 == 0
end

puts pari?(4)   # true
puts pari?(7)   # false

# Nota: in Ruby i metodi che restituiscono true/false
# spesso finiscono con ?

# Calcolare l'area di un rettangolo
def area_rettangolo(base, altezza)
  base * altezza
end

area = area_rettangolo(5, 3)
puts "L'area è #{area}"  # L'area è 15

# Convertire temperatura Celsius in Fahrenheit
def celsius_a_fahrenheit(celsius)
  (celsius * 9.0 / 5.0) + 32
end

puts celsius_a_fahrenheit(0)    # 32.0
puts celsius_a_fahrenheit(100)  # 212.0
```

### Metodi con Più Return

Puoi uscire prima da un metodo:

```ruby
def puo_guidare(eta)
  if eta < 18
    return "Troppo giovane!"
  end
  
  if eta >= 90
    return "Forse è meglio il taxi!"
  end
  
  "Puoi guidare!"
end

puts puo_guidare(15)  # Troppo giovane!
puts puo_guidare(25)  # Puoi guidare!
puts puo_guidare(95)  # Forse è meglio il taxi!
```

### ✏️ Esercizi - Metodi

Pratica la creazione di metodi:

1. Crea un metodo `saluta(nome)` che stampa "Ciao [nome]!"
2. Scrivi un metodo `raddoppia(numero)` che restituisce il doppio
3. Fai un metodo `e_maggiorenne?(eta)` che restituisce true/false
4. Crea un metodo `somma_tre(a, b, c)` che somma tre numeri
5. Scrivi un metodo con un parametro predefinito: `presenta(nome = "Ospite")`

---

## 🧊 Costanti e `freeze`

### Costanti

Le costanti si scrivono in MAIUSCOLO. Servono per valori che non cambiano:

```ruby
VELOCITA = 250
PUNTI_PER_CIBO = 10
LARGHEZZA = 32
```

Ruby ti avvisa se provi a cambiare una costante durante l'esecuzione.

### `freeze` – Rendere gli oggetti immutabili

Hash e Array possono essere modificati per sbaglio. `freeze` li blocca:

```ruby
SIMBOLI = { muro: "█", corridoio: " ", giocatore: "☺" }.freeze
SIMBOLI[:nuovo] = "X"   # ERRORE! FrozenError: can't modify frozen Hash

MESSAGGI = ["Ciao", "Mondo"].freeze
MESSAGGI.push("Ops")    # ERRORE! FrozenError: can't modify frozen Array
```

**Regola pratica**: se un Hash o Array non deve mai cambiare, metti `.freeze` alla fine.

---

## 📐 Matrici (Array di Array)

Fin qui abbiamo usato gli Array come liste semplici. Ma un gioco con una mappa ha bisogno di **righe e colonne** – serve un Array di Array, detto **matrice**:

```ruby
griglia = [
  ["#", "#", "#", "#"],   # riga 0
  ["#", ".", ".", "#"],   # riga 1
  ["#", ".", "E", "#"],   # riga 2
  ["#", "#", "#", "#"]    # riga 3
]
```

Per accedere a una cella: `griglia[riga][colonna]`

```ruby
griglia[1][1]   # => "."   (riga 1, colonna 1 – corridoio)
griglia[2][2]   # => "E"   (riga 2, colonna 2 – uscita)
griglia[0][0]   # => "#"   (riga 0, colonna 0 – muro)
```

Pensa a un foglio a quadretti: la prima coordinata dice **quale riga** (dall'alto in basso) e la seconda **quale colonna** (da sinistra a destra).

### Creare una matrice da stringhe

```ruby
layout = ["##.S", "#..#"]
griglia = layout.map { |riga| riga.chars }
# => [["#", "#", ".", "S"], ["#", ".", ".", "#"]]
```

`map` prende ogni elemento, gli applica il blocco `{ ... }` e restituisce un **nuovo** Array con i risultati.

### Creare una matrice vuota

```ruby
righe = 10
colonne = 15
matrice = Array.new(righe) { Array.new(colonne, false) }
# 10 righe × 15 colonne, tutte a false
```

---

## 🔢 `each_with_index` – Sapere dove siamo

Con `each` scorriamo gli elementi, ma non sappiamo a che posizione siamo. `each_with_index` ci dà anche l'**indice**:

```ruby
frutti = ["mela", "banana", "arancia"]

frutti.each_with_index do |frutto, i|
  puts "#{i}: #{frutto}"
end
# 0: mela
# 1: banana
# 2: arancia
```

Per le matrici usiamo due `each_with_index` annidati:

```ruby
griglia.each_with_index do |riga, r|       # r = numero riga
  riga.each_with_index do |cella, c|       # c = numero colonna
    print "Alla posizione [#{r},#{c}] c'è: #{cella}  "
  end
  puts
end
```

---

## 🔍 `select`, `reject`, `count`, `group_by` – Filtrare dati

Questi metodi servono per cercare, filtrare e contare elementi in Array e Hash.

### `select` – tieni solo quelli che vuoi

```ruby
numeri = [1, 2, 3, 4, 5, 6, 7, 8]
pari = numeri.select { |n| n % 2 == 0 }
# => [2, 4, 6, 8]
```

### `reject` – butta via quelli che non vuoi

```ruby
numeri = [1, 2, 3, 4, 5, 6, 7, 8]
no_pari = numeri.reject { |n| n % 2 == 0 }
# => [1, 3, 5, 7]
```

`reject` è l'**opposto** di `select`.

### `count` – conta gli elementi

```ruby
voti = [8, 6, 9, 10, 7, 6, 8]
sufficienti = voti.count { |v| v >= 6 }
# => 7 (tutti!)

eccellenti = voti.count { |v| v >= 9 }
# => 2
```

### `group_by` – raggruppa per criterio

```ruby
animali = ["gatto", "cane", "gallina", "cavallo", "coniglio"]
per_iniziale = animali.group_by { |a| a[0] }
# => { "g" => ["gatto", "gallina"], "c" => ["cane", "cavallo", "coniglio"] }
```

### Funzionano anche sugli Hash

```ruby
inventario = { spada: 1, scudo: 2, pozione: 5, arco: 1 }
tanti = inventario.select { |_nome, quantita| quantita > 1 }
# => { scudo: 2, pozione: 5 }
```

### ✏️ Esercizi - Filtrare dati

1. Da un Array di numeri, usa `select` per tenere solo quelli maggiori di 10
2. Da un Array di nomi, usa `reject` per togliere quelli più corti di 4 lettere
3. Usa `count` per contare quanti numeri pari ci sono in un Array
4. Usa `group_by` per raggruppare un Array di parole per lunghezza

---

## 📚 Array come Coda (push/shift)

Un Array può funzionare come una fila al supermercato: si entra in fondo e si esce davanti.

```ruby
# push: aggiungi in fondo
fila = ["Anna", "Bruno"]
fila.push("Carlo")
# => ["Anna", "Bruno", "Carlo"]

# shift: togli il primo
fila.shift
# => "Anna"
# fila ora è: ["Bruno", "Carlo"]
```

Nel gioco Snake il corpo del serpente funziona così:

```ruby
corpo = [Punto.new(3, 5), Punto.new(4, 5), Punto.new(5, 5)]
#        ^coda                               ^testa

# Il serpente si muove: push nuova testa + shift la coda
corpo.push(Punto.new(6, 5))   # nuova testa
corpo.shift                    # la coda sparisce

# Se mangia il cibo: push MA NON shift! Così cresce
corpo.push(Punto.new(6, 5))   # nuova testa, niente shift
```

---

## ⚡ Hash come Lookup veloce

Cercare un elemento in un Array è lento: Ruby deve controllare uno per uno. Un Hash trova qualsiasi cosa **in un istante**:

```ruby
# LENTO – controlla tutto l'Array ogni volta
corpo = [Punto.new(3, 5), Punto.new(4, 5), Punto.new(5, 5)]
corpo.any? { |p| p.x == 5 && p.y == 3 }   # deve scorrere tutto!

# VELOCE – crea un Hash e cerca in un istante
posizioni = {}
corpo.each { |p| posizioni[[p.x, p.y]] = true }
posizioni[[5, 3]]   # => true o nil, immediato!
```

Un Hash è come un elenco telefonico: cerchi un nome e trovi subito il numero, senza leggere tutte le pagine.

---

## 🏗️ Classi

Le classi sono come stampi per creare oggetti. Immagina uno stampo per i biscotti!

### Creare una Classe Semplice

```ruby
class Cane
  # Il metodo initialize si chiama automaticamente quando crei un nuovo cane
  def initialize(nome, razza)
    @nome = nome    # @ significa che è una variabile della classe
    @razza = razza
  end
  
  # Metodo per far abbaiare il cane
  def abbaia
    puts "#{@nome} fa: Bau bau!"
  end
  
  # Metodo per mostrare informazioni
  def informazioni
    puts "Mi chiamo #{@nome} e sono un #{@razza}"
  end
end

# Creare oggetti dalla classe:
il_mio_cane = Cane.new("Fido", "Labrador")
il_mio_cane.abbaia  # Fido fa: Bau bau!
il_mio_cane.informazioni  # Mi chiamo Fido e sono un Labrador
```

### Esempio: Classe Giocatore

```ruby
class Giocatore
  def initialize(nome)
    @nome = nome
    @punti = 0
  end
  
  def guadagna_punti(quantita)
    @punti = @punti + quantita
    puts "#{@nome} ha guadagnato #{quantita} punti!"
  end
  
  def mostra_punteggio
    puts "#{@nome} ha #{@punti} punti"
  end
end

# Giochiamo!
giocatore1 = Giocatore.new("Marco")
giocatore1.guadagna_punti(10)  # Marco ha guadagnato 10 punti!
giocatore1.guadagna_punti(5)   # Marco ha guadagnato 5 punti!
giocatore1.mostra_punteggio    # Marco ha 15 punti
```

### ✏️ Esercizi - Classi

Crea le tue prime classi:

1. Crea una classe `Cane` con nome e metodo `abbaia`
2. Fai una classe `Contatore` che può aumentare/diminuire un numero
3. Scrivi una classe `Robot` con nome e livello di batteria
4. Crea una classe `Studente` con nome, voti (array), e metodo per calcolare la media

---

## 🧬 Ereditarietà

A volte vuoi creare classi simili: ad esempio `Cane` e `Gatto` condividono nome, età, e un metodo `mangia`. Invece di copiare il codice, usi l'**ereditarietà**: crei una classe "madre" e le figlie ereditano tutto.

```ruby
class Animale
  def initialize(nome, eta)
    @nome = nome
    @eta = eta
  end

  def mangia
    puts "#{@nome} sta mangiando!"
  end
end

class Cane < Animale   # Cane eredita da Animale
  def abbaia
    puts "#{@nome} fa: Bau bau!"
  end
end

class Gatto < Animale  # Gatto eredita da Animale
  def miagola
    puts "#{@nome} fa: Miaoo!"
  end
end

rex = Cane.new("Rex", 3)
rex.mangia    # ereditato da Animale!
rex.abbaia    # metodo solo di Cane
```

### `super` – Chiamare il metodo della classe madre

Se la classe figlia ha il suo `initialize` ma vuole anche eseguire quello della madre, usa `super`:

```ruby
class Giocatore < Entita
  def initialize(riga, colonna, nome)
    super(riga, colonna, "☺")   # chiama Entita#initialize
    @nome = nome                 # aggiunge roba sua
    @punti = 0
  end
end
```

`super` dice: "prima fai quello che fa la classe madre, poi continuo io".

### Quando usare l'ereditarietà

Usala quando la classe figlia **è una versione** della madre:
- `Cane` **è un** `Animale` ✅
- `Giocatore` **è una** `Entita` ✅
- `Cane` **è un** `Veicolo` ❌ non ha senso!

### ✏️ Esercizi - Ereditarietà

1. Crea `Animale` con nome e metodo `parla`. Poi crea `Cane` e `Gatto` che ereditano e hanno ciascuno il proprio verso
2. Crea `Veicolo` con velocità, poi `Auto` e `Bici` che ereditano e aggiungono metodi propri
3. Usa `super` in una classe figlia per estendere `initialize` della madre

---

## 📦 Moduli (`module` e `include`)

Con l'ereditarietà puoi avere **una sola** classe madre. Ma se vuoi che due classi diverse sappiano fare la stessa cosa? Usi un **modulo**.

Un modulo è come una **scatola di attrezzi**: contiene metodi pronti all'uso, ma non è una classe (non puoi fare `.new`).

```ruby
module Salutabile
  def saluta
    puts "Ciao! Sono #{@nome}"
  end
end

class Giocatore
  include Salutabile   # ora Giocatore sa salutare!

  def initialize(nome)
    @nome = nome
  end
end

class Nemico
  include Salutabile   # anche Nemico sa salutare!

  def initialize(nome)
    @nome = nome
  end
end
```

La differenza chiave: una classe può includere **molti** moduli, ma ereditare da **una sola** classe madre:

```ruby
class Giocatore < Entita
  include Muovibile      # sa muoversi
  include Descrivibile   # sa descriversi
  include Comparable     # sa confrontarsi
end
```

### Modulo vs Ereditarietà

| | Ereditarietà | Modulo |
|---|---|---|
| Sintassi | `class Figlia < Madre` | `include NomeModulo` |
| Quanti? | Solo **1** classe madre | **Molti** moduli |
| Quando usarlo | La classe **è** una versione di | La classe **sa fare** qualcosa |

Pensa così: un gatto **è** un animale (ereditarietà), ma un gatto **sa** nuotare (modulo Nuotabile).

### ✏️ Esercizi - Moduli

1. Crea un modulo `Stampabile` con un metodo `stampa_info` e includilo in due classi diverse
2. Crea un modulo `Calcolabile` con metodi `somma` e `media`, e includilo in una classe `VotiStudente`
3. Prova a includere **due** moduli nella stessa classe

---

## 🏷️ Struct – Mini-classi veloci

Se ti serve un oggetto semplice con pochi campi, `Struct` è più veloce di scrivere un'intera classe:

```ruby
# Crea una mini-classe con due campi: x e y
Punto = Struct.new(:x, :y)

posizione = Punto.new(5, 3)
puts posizione.x   # 5
puts posizione.y   # 3

cibo = Punto.new(10, 7)
puts posizione == cibo   # false
```

Senza Struct avresti dovuto scrivere:

```ruby
class Punto
  attr_reader :x, :y
  def initialize(x, y)
    @x = x
    @y = y
  end
end
```

Struct fa tutto questo in una riga!

---

## ⚖️ `Comparable` – Confrontare oggetti

Come fai a dire che un giocatore è "più grande" di un altro? Con il modulo `Comparable`! Basta definire **un solo** metodo: `<=>` (detto "nave spaziale"):

```ruby
class Giocatore
  include Comparable
  attr_reader :punti

  def initialize(nome, punti)
    @nome = nome
    @punti = punti
  end

  def <=>(altro)
    @punti <=> altro.punti
  end
end

g1 = Giocatore.new("Alice", 150)
g2 = Giocatore.new("Bob", 200)

puts g1 > g2    # false (150 non è > 200)
puts g1 < g2    # true

classifica = [g1, g2].sort   # ordina per punti
migliore = [g1, g2].max      # quello con più punti
```

`<=>` restituisce: `-1` se minore, `0` se uguale, `1` se maggiore.

---

## 🎯 Lambda – Funzioni come oggetti

In Ruby puoi **salvare una funzione in una variabile** e usarla dopo. Si chiama **lambda**:

```ruby
# Creare una lambda
saluto = ->(nome) { "Ciao, #{nome}!" }

# Chiamarla con .call
puts saluto.call("Giorgio")   # => "Ciao, Giorgio!"

# Lambda senza parametri
dì_ciao = -> { puts "Ciao!" }
dì_ciao.call   # => Ciao!
```

Perché è utile? Perché puoi passare funzioni come se fossero dati:

```ruby
operazioni = {
  somma:       ->(a, b) { a + b },
  sottrazione: ->(a, b) { a - b },
  doppio:      ->(n) { n * 2 }
}

puts operazioni[:somma].call(3, 5)       # 8
puts operazioni[:doppio].call(7)         # 14
```

Nel gioco del labirinto le usiamo per le **porte condizionali** – ogni porta ha la sua regola:

```ruby
# La porta si apre solo se hai una chiave
porta_chiave = ->(g) { g.ha_oggetto?("chiave") }

# La porta si apre solo se hai almeno 100 punti
porta_punti = ->(g) { g.punti >= 100 }
```

Le lambda sono come biglietti con una **ricetta**: non cucini subito, ma conservi le istruzioni per dopo.

---

## 🚨 Gestione errori (`begin` / `rescue` / `ensure`)

A volte il codice può fallire: un file non esiste, un numero è sbagliato, la rete non funziona. Invece di far crashare il programma, puoi **catturare** l'errore:

```ruby
begin
  # codice che potrebbe fallire
  risultato = 10 / 0
rescue ZeroDivisionError => errore
  # cosa fare se fallisce
  puts "Errore: #{errore.message}"
end
```

### `raise` – Lanciare un errore

Puoi creare i tuoi errori:

```ruby
def controlla_eta(eta)
  raise "L'età non può essere negativa!" if eta < 0
  puts "Hai #{eta} anni"
end

begin
  controlla_eta(-5)
rescue => errore
  puts errore.message   # "L'età non può essere negativa!"
end
```

### `ensure` – Eseguire codice SEMPRE

`ensure` viene eseguito sia che il codice funzioni, sia che fallisca:

```ruby
begin
  # apri un file, fai qualcosa...
  file = File.open("dati.txt")
rescue => errore
  puts "Errore: #{errore.message}"
ensure
  file.close if file   # chiudi il file SEMPRE!
end
```

È come dire: "qualunque cosa succeda, ricordati di spegnere la luce quando esci."

---

## 📂 Leggere e scrivere file

### Leggere un file

```ruby
# Leggere tutto il contenuto
contenuto = File.read("messaggio.txt")
puts contenuto

# Leggere riga per riga
File.read("lista.txt").each_line do |riga|
  puts riga.chomp   # chomp toglie il \n finale
end
```

### Scrivere un file

```ruby
# Scrivere (sovrascrive il file!)
File.write("punteggio.txt", "150")

# Scrivere più righe
File.open("diario.txt", "w") do |f|
  f.puts "Oggi ho imparato Ruby!"
  f.puts "È stato divertente."
end
```

### Controllare se un file esiste

```ruby
if File.exist?("salvataggio.txt")
  dati = File.read("salvataggio.txt")
  puts "Partita caricata!"
else
  puts "Nessun salvataggio trovato."
end
```

### Esempio pratico: salvare e caricare un record

```ruby
def carica_record
  if File.exist?("record.txt")
    File.read("record.txt").to_i
  else
    0
  end
end

def salva_record(punteggio)
  record = carica_record
  if punteggio > record
    File.write("record.txt", punteggio.to_s)
    puts "Nuovo record: #{punteggio}!"
  end
end
```

---

## 🔄 Il Game Loop – Il cuore di ogni gioco

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
  │   4. Aspetta un po' (sleep)          │
  │              ↓                       │
  │         Ricomincia!                  │
  │                                      │
  └──────────────────────────────────────┘
```

In Ruby:

```ruby
until game_over
  leggi_input     # 1. Che tasto hai premuto?
  aggiorna        # 2. Muovi, controlla collisioni
  disegna         # 3. Ridisegna lo schermo
  sleep(0.15)     # 4. Aspetta (altrimenti è troppo veloce!)
end
```

`sleep` prende un numero in secondi. `sleep(0.15)` = pausa di 150 millisecondi.

### ✏️ Esercizi - Concetti avanzati

1. Crea una matrice 5×5 di numeri casuali e stampa quello alla posizione [2][3]
2. Usa `select` e `reject` su un Array di voti per separare sufficienti e insufficienti
3. Crea una lambda che calcola l'area di un rettangolo e chiamala con `.call`
4. Scrivi una classe con `Comparable` che confronta studenti per media voti
5. Usa `begin/rescue` per gestire la divisione per zero senza far crashare il programma
6. Scrivi e leggi un file di testo con `File.write` e `File.read`
7. Simula un serpente con un Array e `push`/`shift`: muovilo di 5 posizioni

---

## 🎯 Esempi Completi

### Esempio 1: Gioco Indovina il Numero

```ruby
numero_segreto = 7
indovinato = false

while !indovinato
  print "Indovina il numero (1-10): "
  tentativo = gets.chomp.to_i
  
  if tentativo == numero_segreto
    puts "🎉 Bravo! Hai indovinato!"
    indovinato = true
  elsif tentativo < numero_segreto
    puts "Troppo basso! Riprova."
  else
    puts "Troppo alto! Riprova."
  end
end
```

### Esempio 2: Calcolatrice Semplice

```ruby
class Calcolatrice
  def somma(a, b)
    a + b
  end
  
  def sottrai(a, b)
    a - b
  end
  
  def moltiplica(a, b)
    a * b
  end
  
  def dividi(a, b)
    if b != 0
      a / b
    else
      "Non si può dividere per zero!"
    end
  end
end

calc = Calcolatrice.new
puts calc.somma(5, 3)        # 8
puts calc.moltiplica(4, 5)   # 20
puts calc.dividi(10, 2)      # 5
```

### Esempio 3: Lista della Spesa

```ruby
class ListaSpesa
  def initialize
    @prodotti = []
  end
  
  def aggiungi(prodotto)
    @prodotti.push(prodotto)
    puts "✓ Aggiunto: #{prodotto}"
  end
  
  def mostra_lista
    if @prodotti.empty?
      puts "La lista è vuota!"
    else
      puts "\n📝 La tua lista della spesa:"
      @prodotti.each_with_index do |prodotto, indice|
        puts "#{indice + 1}. #{prodotto}"
      end
    end
  end
  
  def conta_prodotti
    "Hai #{@prodotti.length} prodotti nella lista"
  end
end

lista = ListaSpesa.new
lista.aggiungi("Latte")
lista.aggiungi("Pane")
lista.aggiungi("Mele")
lista.mostra_lista
puts lista.conta_prodotti
```

### ✏️ Progetti Completi - Metti Tutto Insieme!

Ora che conosci tutti i concetti, prova questi progetti:

1. **Calcolatrice**: chiedi due numeri e un'operazione (+, -, *, /), usa `case/when` per scegliere
2. **Quiz Game**: crea 3-5 domande, conta le risposte corrette, mostra il punteggio finale
3. **Lista della spesa**: classe con array di prodotti, metodi per aggiungere/rimuovere/mostrare
4. **Sistema di battaglia**: due personaggi (classi) che attaccano a turno finché uno perde
5. **Gestore di contatti**: salva nome/telefono in hash, cerca per nome, aggiungi nuovi contatti
6. **Mini avventura**: più stanze (usa simboli), raccogli oggetti, usa case/when per azioni, vinci trovando il tesoro!

**💡 Vuoi vedere come funzionano i giochi di esempio?**
- [Spiegazione Guessing Game](esempi/guessing_game.md) – Analisi del gioco "Indovina il Numero"
- [Spiegazione Jungle Adventure](esempi/jungle_adventure.md) – Analisi del gioco avventura testuale
- [Spiegazione Snake](snake/snake.md) – Game loop, Struct, Array come coda, Hash come lookup, ensure
- [Spiegazione Labirinto](labirinto/labirinto.md) – Matrici, moduli, ereditarietà, lambda, Comparable, crea i tuoi livelli!

---

## 🌟 Suggerimenti Utili

1. **Commenti**: Usa `#` per scrivere note nel codice
   ```ruby
   # Questo è un commento
   eta = 10  # Questa è la mia età
   ```

2. **Stampare a schermo**: 
   ```ruby
   puts "Ciao"   # va a capo dopo
   print "Ciao"  # non va a capo
   p [1, 2, 3]   # utile per debug
   ```

3. **Leggere input dall'utente**:
   ```ruby
   print "Come ti chiami? "
   nome = gets.chomp  # chomp rimuove l'invio
   puts "Ciao #{nome}!"
   ```

4. **Convertire tipi**:
   ```ruby
   "10".to_i      # stringa → numero intero (10)
   "3.14".to_f    # stringa → numero decimale (3.14)
   10.to_s        # numero → stringa ("10")
   ```

---

## 🎓 Ricorda

- **Divertiti!** Programmare è come giocare con i LEGO digitali
- **Prova tutto**: non aver paura di sperimentare
- **Gli errori sono normali**: anche i programmatori esperti li fanno
- **Pratica**: più programmi, più diventi bravo!

Buon divertimento con Ruby! 💎✨
