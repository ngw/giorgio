# 🎯 Come Funziona il Guessing Game

Analizziamo passo passo il gioco "Indovina il Numero" (`guessing_game.rb`) per capire come funziona.

---

## 1. Preparazione del Gioco

```ruby
secret_number = rand(1..100)
attempts = 0
max_attempts = 10
```

**Cosa succede qui?**
- `rand(1..100)` genera un numero casuale tra 1 e 100 che il giocatore deve indovinare
- `attempts` conta quanti tentativi ha fatto il giocatore (parte da 0)
- `max_attempts` è il limite massimo di tentativi disponibili

---

## 2. Il Ciclo Principale

```ruby
loop do
  # Il gioco continua finché non si usa "break"
end
```

Il gioco usa un ciclo infinito `loop do...end` che si ripete continuamente. Il ciclo si ferma solo quando:
- Il giocatore indovina il numero (`break`)
- Finiscono i tentativi (`break`)

---

## 3. Leggere l'Input del Giocatore

```ruby
print "Enter your guess: "
guess = gets.chomp.to_i
attempts += 1
```

**Passo per passo:**
- `print` mostra il messaggio senza andare a capo
- `gets` legge quello che scrive l'utente
- `.chomp` rimuove il carattere "invio" alla fine
- `.to_i` converte il testo in numero intero
- `attempts += 1` aumenta il contatore dei tentativi di 1

---

## 4. Controllare la Risposta

Il gioco usa una catena di `if/elsif/else` per controllare la risposta:

### Caso 1: Numero Indovinato! 🎉
```ruby
if guess == secret_number
  puts "🎉 Congratulations! You guessed it!"
  break  # Esce dal ciclo
end
```
Se il numero è corretto, congratula il giocatore e termina il gioco.

### Caso 2: Tentativi Esauriti 😞
```ruby
elsif attempts >= max_attempts
  puts "Game Over!"
  break  # Esce dal ciclo
end
```
Se sono finiti i tentativi, il gioco termina rivelando il numero segreto.

### Caso 3: Numero Troppo Basso
```ruby
elsif guess < secret_number
  puts "Too low! Try again."
end
```
Dice al giocatore che deve provare con un numero più alto.

### Caso 4: Numero Troppo Alto
```ruby
else  # se non è uguale e non è minore, allora è maggiore
  puts "Too high! Try again."
end
```
Dice al giocatore che deve provare con un numero più basso.

---

## 5. Esempio di Partita

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

---

## 6. Concetti Utilizzati

Questo gioco combina diversi concetti di programmazione:

| Concetto | Dove viene usato |
|----------|------------------|
| **Variabili** | `secret_number`, `attempts`, `max_attempts`, `guess` |
| **Input/Output** | `gets` per leggere, `puts` per stampare |
| **Cicli** | `loop do...end` per ripetere il gioco |
| **Condizionali** | `if/elsif/else` per controllare le risposte |
| **Operatori** | `==`, `<`, `>`, `>=` per confrontare numeri |
| **Break** | Per uscire dal ciclo quando il gioco finisce |
| **Numeri casuali** | `rand()` per generare il numero segreto |

---

## 🎮 Perché È un Buon Esempio?

Questo gioco è perfetto per imparare perché:
1. È **semplice** da capire - tutti sanno come si gioca
2. Usa **concetti fondamentali** che troverai in quasi ogni programma
3. È **interattivo** - l'utente partecipa attivamente
4. È **divertente** - si impara giocando!

---

## 💡 Idee per Migliorarlo

Prova ad aggiungere queste funzionalità:
1. Chiedi al giocatore di scegliere il livello di difficoltà (range 1-50, 1-100, 1-1000)
2. Mostra quanti tentativi sono stati usati in totale
3. Calcola un punteggio basato sui tentativi rimanenti
4. Aggiungi la possibilità di giocare più volte
5. Salva il record del minor numero di tentativi

---

## 🎯 Esercizi per Espandere il Gioco

### 🌱 Livello Facile

**1. Aggiungi un Messaggio di Benvenuto Personalizzato**
```ruby
print "Come ti chiami? "
nome = gets.chomp
puts "Ciao #{nome}! Benvenuto al gioco!"
```
*Concetti: Input utente, interpolazione stringhe*

**2. Conta il Numero Totale di Tentativi**
Alla fine del gioco, mostra quanti tentativi ha fatto il giocatore:
```ruby
puts "Hai fatto #{attempts} tentativ#{attempts == 1 ? 'o' : 'i'}!"
```
*Concetti: Variabili, operatore ternario*

**3. Aggiungi Indizi Più Specifici**
Invece di solo "troppo alto/basso", dai indizi sulla distanza:
- Se la differenza è > 20: "Molto lontano!"
- Se la differenza è 10-20: "Abbastanza vicino!"
- Se la differenza è < 10: "Vicinissimo!"

*Concetti: Calcoli matematici, condizionali multipli*

### 🌿 Livello Medio

**4. Sistema di Livelli di Difficoltà**
Chiedi al giocatore di scegliere:
```ruby
puts "Scegli difficoltà:"
puts "1. Facile (1-50, 15 tentativi)"
puts "2. Medio (1-100, 10 tentativi)"
puts "3. Difficile (1-500, 8 tentativi)"

scelta = gets.chomp.to_i

case scelta
when 1
  range_max = 50
  max_attempts = 15
when 2
  range_max = 100
  max_attempts = 10
when 3
  range_max = 500
  max_attempts = 8
else
  puts "Scelta non valida, uso medio"
  range_max = 100
  max_attempts = 10
end

secret_number = rand(1..range_max)
```
*Concetti: Case/when, variabili dinamiche*

**5. Sistema di Punteggio**
Calcola un punteggio basato sui tentativi rimasti:
```ruby
if guess == secret_number
  punti = (max_attempts - attempts) * 10
  puts "Hai guadagnato #{punti} punti!"
end
```
*Concetti: Calcoli, motivazione del giocatore*

**6. Gioca Più Volte**
Aggiungi un loop esterno che chiede se vuoi giocare ancora:
```ruby
gioca_ancora = true

while gioca_ancora
  # ... tutto il gioco qui ...
  
  print "Vuoi giocare ancora? (s/n): "
  risposta = gets.chomp.downcase
  gioca_ancora = (risposta == 's' || risposta == 'si')
end

puts "Grazie per aver giocato!"
```
*Concetti: Loop while, controllo stringhe*

### 🌳 Livello Avanzato

**7. Salva il Record**
Traccia il miglior punteggio in una variabile:
```ruby
record = nil
punteggio_attuale = max_attempts - attempts

if record.nil? || punteggio_attuale > record
  record = punteggio_attuale
  puts "🏆 Nuovo record! #{record} tentativi risparmiati!"
else
  puts "Record attuale: #{record}"
end
```
*Concetti: Nil, confronto valori, persistenza temporanea*

**8. Modalità Due Giocatori**
Il primo giocatore sceglie il numero, il secondo indovina:
```ruby
puts "Giocatore 1, scegli un numero (1-100):"
secret_number = gets.chomp.to_i

system "clear" # o "cls" su Windows

puts "Giocatore 2, prova ad indovinare!"
# ... resto del gioco ...
```
*Concetti: Interazione multipla, clear screen*

**9. Storico dei Tentativi**
Salva tutti i tentativi in un array e mostrali alla fine:
```ruby
tentativi_fatti = []

# Nel loop:
tentativi_fatti.push(guess)

# Alla fine:
puts "\nI tuoi tentativi: #{tentativi_fatti.join(', ')}"
```
*Concetti: Array, metodi .push e .join*

**10. Sistema di Suggerimenti**
Dopo 5 tentativi sbagliati, offri un suggerimento:
```ruby
if attempts == 5 && !indovinato
  puts "💡 Suggerimento: il numero è #{secret_number.even? ? 'pari' : 'dispari'}"
end
```
*Concetti: Metodi sui numeri (.even?), operatore ternario*

### 🎄 Progetto Completo

**11. Guessing Game Deluxe**
Combina tutte le funzionalità:
- Menu principale con opzioni
- Selezione difficoltà
- Sistema di punteggio e record
- Modalità giocatore singolo/doppio
- Statistiche dettagliate
- Classifica top 5 punteggi
- Salvataggio su file (avanzato)

Suggerimento: usa metodi separati per ogni funzionalità!

```ruby
def menu_principale
  # ...
end

def gioca_partita(difficolta)
  # ...
end

def mostra_statistiche(storico)
  # ...
end

# Loop principale
loop do
  scelta = menu_principale
  break if scelta == 0
  # gestisci scelta
end
```

---

## 📚 Cosa Impari con Questi Esercizi

| Esercizio | Concetti Nuovi |
|-----------|----------------|
| 1-3 | Input utente, condizionali base |
| 4-6 | Case/when, loop complessi, stringhe |
| 7-10 | Nil, array, metodi avanzati |
| 11 | Organizzazione codice, progetto completo |

---

**File completo:** [guessing_game.rb](../guessing_game.rb)
