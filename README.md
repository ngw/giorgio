
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

---

## � Come Funziona il Guessing Game

Analizziamo passo passo il gioco "Indovina il Numero" (`guessing_game.rb`) per capire come funziona:

### 1. Preparazione del Gioco

```ruby
secret_number = rand(1..100)
attempts = 0
max_attempts = 10
```

- `rand(1..100)` genera un numero casuale tra 1 e 100 che il giocatore deve indovinare
- `attempts` conta quanti tentativi ha fatto il giocatore (parte da 0)
- `max_attempts` è il limite massimo di tentativi disponibili

### 2. Il Ciclo Principale

```ruby
loop do
  # Il gioco continua finché non si usa "break"
end
```

Il gioco usa un ciclo infinito `loop do...end` che si ripete continuamente. Il ciclo si ferma solo quando:
- Il giocatore indovina il numero (`break`)
- Finiscono i tentativi (`break`)

### 3. Leggere l'Input del Giocatore

```ruby
print "Enter your guess: "
guess = gets.chomp.to_i
attempts += 1
```

- `gets.chomp` legge quello che scrive l'utente
- `.to_i` converte il testo in numero
- `attempts += 1` aumenta il contatore dei tentativi

### 4. Controllare la Risposta

Il gioco usa una catena di `if/elsif/else` per controllare la risposta:

**Caso 1: Numero Indovinato! 🎉**
```ruby
if guess == secret_number
  puts "🎉 Congratulations! You guessed it!"
  break  # Esce dal ciclo
end
```

**Caso 2: Tentativi Esauriti 😞**
```ruby
elsif attempts >= max_attempts
  puts "Game Over!"
  break  # Esce dal ciclo
end
```

**Caso 3: Numero Troppo Basso**
```ruby
elsif guess < secret_number
  puts "Too low! Try again."
end
```

**Caso 4: Numero Troppo Alto**
```ruby
else  # se non è uguale e non è minore, allora è maggiore
  puts "Too high! Try again."
end
```

### 5. Esempio di Partita

Immaginiamo che il numero segreto sia **42**:

```
Tentativo 1: giocatore scrive 50
→ "Too high!" (tentativi rimanenti: 9)

Tentativo 2: giocatore scrive 30
→ "Too low!" (tentativi rimanenti: 8)

Tentativo 3: giocatore scrive 40
→ "Too low!" (tentativi rimanenti: 7)

Tentativo 4: giocatore scrive 42
→ "🎉 Congratulations! You guessed it!"
→ Gioco finito in 4 tentativi
```

### 6. Perché È Interessante?

Questo gioco combina diversi concetti:
- **Variabili**: per memorizzare numero segreto, tentativi, ecc.
- **Input/Output**: leggere dalla tastiera e stampare sullo schermo
- **Cicli**: `loop do` per ripetere il gioco
- **Condizionali**: `if/elsif/else` per fare scelte
- **Operatori**: confronti come `==`, `<`, `>`, `>=`
- **Break**: per uscire dal ciclo quando necessario

È un ottimo esempio di come diversi concetti di programmazione lavorano insieme per creare qualcosa di divertente!

---

## �🌟 Suggerimenti Utili

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

## 🚀 Esercizi da Provare

1. Crea una classe `Robot` con nome e livello di batteria
2. Scrivi un programma che stampa i numeri da 1 a 100
3. Fai un array dei tuoi colori preferiti e stampali tutti
4. Crea un programma che dice se un numero è pari o dispari
5. Fai un ciclo che conta alla rovescia da 10 a 0!

---

## 🎓 Ricorda

- **Divertiti!** Programmare è come giocare con i LEGO digitali
- **Prova tutto**: non aver paura di sperimentare
- **Gli errori sono normali**: anche i programmatori esperti li fanno
- **Pratica**: più programmi, più diventi bravo!

Buon divertimento con Ruby! 💎✨
