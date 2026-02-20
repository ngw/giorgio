# 🌴 Come Funziona Jungle Adventure

Analizziamo il gioco di avventura testuale "Jungle Adventure" (`jungle_adventure.rb`) per capire come usa concetti avanzati di Ruby.

---

## 🎯 Obiettivo del Gioco

Il giocatore deve esplorare una giungla, raccogliere oggetti e trovare un tesoro nascosto. Deve:
1. Trovare il **machete** per entrare nella grotta
2. Trovare la **liana** per attraversare il fiume
3. Raggiungere il **tesoro** per vincere!

---

## 🏗️ Struttura del Programma

### 1. La Classe Giocatore

```ruby
class Giocatore
  attr_reader :nome, :inventario, :posizione
  
  def initialize(nome)
    @nome = nome
    @inventario = []
    @posizione = :entrata
    @punti = 0
  end
  # ... altri metodi
end
```

**Concetti chiave:**
- `attr_reader` crea automaticamente metodi per leggere le variabili
- `@variabili` sono variabili di istanza (ogni giocatore ha le sue)
- `:simboli` sono usati per identificare le posizioni

### 2. Uso dei Simboli

I simboli sono usati per rappresentare le posizioni:

```ruby
:entrata    # Inizio del gioco
:fiume      # Davanti al fiume
:grotta     # Entrata della grotta
:tesoro     # Camera del tesoro
:tempio     # Tempio antico
```

**Perché simboli e non stringhe?**
- Più efficienti in memoria
- Perfetti come identificatori che non cambiano
- Standard per hash e stati in Ruby

### 3. Hash per lo Stato del Gioco

```ruby
stato = {
  trovato_machete: false,
  attraversato_fiume: false,
  aperto_tesoro: false,
  gioco_attivo: true
}
```

**Cosa controlla:**
- Traccia quali oggetti sono stati trovati
- Previene di fare azioni più volte
- Gestisce quando il gioco è attivo

---

## 🔧 Metodi Principali

### 1. Descrizione dei Luoghi

```ruby
def descrivi_luogo(luogo)
  case luogo
  when :entrata
    puts "\n🌴 Sei all'entrata della giungla."
  when :fiume
    puts "\n🌊 Sei arrivato a un fiume."
  # ... altri casi
  end
end
```

**Concetto:** Usa `case/when` con simboli per gestire tanti casi in modo pulito.

### 2. Mostrare le Opzioni

```ruby
def mostra_opzioni(luogo, giocatore)
  puts "\nCosa vuoi fare?"
  
  case luogo
  when :entrata
    puts "1. Vai verso il fiume"
    puts "2. Esplora la grotta"
    # ...
  end
end
```

**Concetto:** Ogni luogo ha opzioni diverse - il menu si adatta!

### 3. Gestire le Azioni

Ogni luogo ha un metodo dedicato:

```ruby
def gestisci_fiume(scelta, giocatore, stato)
  case scelta
  when 1  # Attraversa
    if giocatore.ha_oggetto?("liana")
      puts "Usi la liana per attraversare!"
      giocatore.muovi_a(:tempio)
    else
      puts "Il fiume è troppo pericoloso!"
    end
  # ... altre scelte
  end
end
```

**Concetto:** Azioni diverse basate su cosa ha il giocatore.

---

## 💎 Concetti Avanzati Utilizzati

### 1. Nil e Controlli

```ruby
if nome_giocatore.nil? || nome_giocatore.empty?
  nome_giocatore = "Esploratore"
end
```

Controlla che l'input non sia nullo o vuoto prima di usarlo.

### 2. Metodi che Verificano Condizioni

```ruby
def ha_oggetto?(oggetto)
  @inventario.include?(oggetto)
end
```

Il `?` alla fine indica che il metodo restituisce `true`/`false`.

### 3. Stati Mutabili

```ruby
stato[:trovato_machete] = true
```

Usa hash per tracciare lo stato che cambia durante il gioco.

### 4. Organizzazione del Codice

Il gioco è diviso in tanti metodi piccoli:
- `descrivi_luogo()` - mostra dove sei
- `mostra_opzioni()` - mostra cosa puoi fare
- `gestisci_entrata()`, `gestisci_fiume()` - gestisce le azioni

**Perché?** È più facile leggere e modificare!

---

## 🎮 Loop Principale del Gioco

```ruby
while stato[:gioco_attivo]
  descrivi_luogo(giocatore.posizione)
  mostra_opzioni(giocatore.posizione, giocatore)
  
  scelta = gets.chomp.to_i
  
  case giocatore.posizione
  when :entrata
    gestisci_entrata(scelta, giocatore, stato)
  when :fiume
    gestisci_fiume(scelta, giocatore, stato)
  # ... altri luoghi
  end
end
```

**Flusso:**
1. Mostra dove sei
2. Mostra opzioni disponibili
3. Leggi scelta del giocatore
4. Esegui azione in base a posizione e scelta
5. Ripeti finché `gioco_attivo` è true

---

## 📊 Confronto con Guessing Game

| Aspetto | Guessing Game | Jungle Adventure |
|---------|---------------|------------------|
| **Ciclo** | `loop do` semplice | `while` con condizione complessa |
| **Dati** | Variabili semplici | Classe + Hash complessi |
| **Scelte** | `if/elsif` lineari | `case/when` annidati |
| **Stato** | Contatore tentativi | Hash con simboli |
| **Complessità** | Lineare | Ramificata (più percorsi) |

---

## 🌟 Cosa Impari da Questo Gioco

1. **Classi**: Creare oggetti con stato e comportamento
2. **Simboli**: Usarli come identificatori efficienti
3. **Hash**: Gestire stato complesso con chiavi simboliche
4. **Case/When**: Gestire tante opzioni in modo pulito
5. **Organizzazione**: Dividere codice in funzioni logiche
6. **Nil**: Controllare valori prima di usarli
7. **Array di oggetti**: Inventario come collezione

---

## 💡 Idee per Estenderlo

Prova ad aggiungere:

1. **Più luoghi e oggetti**
   - Aggiungi `:deserto`, `:montagna`, `:caverna_segreta`
   - Nuovi oggetti: torcia, mappa, chiave

2. **Sistema di combattimento**
   - Incontri con animali selvatici
   - Usa oggetti per difenderti

3. **Enigmi e puzzle**
   - Porte con codici da indovinare
   - Combinazioni di oggetti

4. **Sistema di salvataggio**
   - Salva posizione e inventario in un file
   - Riprendi dove hai lasciato

5. **Più finali**
   - Finali diversi in base alle scelte
   - Collezionismo oggetti segreti

---

## 🎯 Perché È un Buon Esempio Avanzato?

1. **Mostra programmazione reale** - come organizzare un progetto più grande
2. **Combina tutti i concetti** - classi, metodi, simboli, hash, nil
3. **Scalabile** - facile aggiungere nuovi luoghi/oggetti
4. **Manutenibile** - codice organizzato e leggibile
5. **Divertente** - motiva a imparare i concetti!

---

**File completo:** [jungle_adventure.rb](../jungle_adventure.rb)

**Mappa del gioco:**
```
        [Tempio]
            |
        (fiume)
            |
    [Entrata]───[Grotta]───[Tesoro]
    
Oggetti necessari:
- Machete: per entrare in grotta
- Liana: per attraversare il fiume
```

---

## 🎯 Esercizi per Espandere il Gioco

### 🌱 Livello Facile - Aggiungi Contenuti

**1. Nuova Stanza: La Cascata**
```ruby
# Aggiungi nei simboli delle posizioni
:cascata

# Nel metodo descrivi_luogo:
when :cascata
  puts "\n💧 Una bellissima cascata!"
  puts "Senti il rumore dell'acqua che scorre."
```
*Concetti: Aggiungere casi a case/when, simboli*

**2. Nuovo Oggetto da Raccogliere**
Aggiungi una "torcia" che trovi al tempio:
```ruby
# Nel gestisci_tempio:
when 2
  if !stato[:trovato_torcia]
    giocatore.aggiungi_oggetto("torcia")
    stato[:trovato_torcia] = true
    puts "Hai trovato una torcia antica!"
  end
```
*Concetti: Hash di stato, controllo booleani*

**3. Descrizioni Più Ricche**
Aggiungi più dettagli alle descrizioni dei luoghi:
```ruby
when :grotta
  puts "\n🕳️  Una grotta misteriosa e buia."
  puts "Vedi pipistrelli appesi al soffitto."
  puts "Un odore strano proviene dall'interno."
  if giocatore.ha_oggetto?("torcia")
    puts "La tua torcia illumina l'entrata."
  end
```
*Concetti: Descrizioni dinamiche, condizionali*

### 🌿 Livello Medio - Nuove Meccaniche

**4. Sistema di Vita**
Aggiungi punti vita al giocatore:
```ruby
class Giocatore
  def initialize(nome)
    @nome = nome
    @inventario = []
    @posizione = :entrata
    @punti = 0
    @vita = 100  # Nuovo!
  end
  
  def subisci_danno(danno)
    @vita -= danno
    puts "💔 Hai perso #{danno} punti vita! (Vita: #{@vita})"
  end
  
  def e_vivo?
    @vita > 0
  end
end
```
*Concetti: Attributi classe, metodi booleani*

**5. Incontri con Animali**
Aggiungi animali che possono attaccare:
```ruby
def gestisci_fiume(scelta, giocatore, stato)
  case scelta
  when 1
    if !stato[:coccodrillo_sconfitto]
      puts "Un coccodrillo ti attacca!"
      giocatore.subisci_danno(20)
      stato[:coccodrillo_sconfitto] = true
    end
    # ... resto del codice ...
  end
end
```
*Concetti: Eventi casuali, stato del gioco*

**6. Usa Oggetti**
Rendi la torcia necessaria per entrare nella grotta:
```ruby
def gestisci_grotta(scelta, giocatore, stato)
  case scelta
  when 1
    if !giocatore.ha_oggetto?("torcia")
      puts "È troppo buio! Hai bisogno di una torcia."
      return
    end
    if giocatore.ha_oggetto?("machete")
      puts "Usi il machete per tagliare le liane..."
      giocatore.muovi_a(:tesoro)
    else
      puts "Le liane bloccano l'entrata!"
    end
  end
end
```
*Concetti: Dipendenze multiple, return anticipato*

### 🌳 Livello Avanzato - Sistemi Complessi

**7. Mappa Interattiva**
Aggiungi comando per vedere la mappa:
```ruby
def mostra_mappa(posizione_attuale)
  mappa = {
    entrata: "[TU]───Grotta    Fiume",
    fiume: "Entrata    [TU]│Tempio",
    grotta: "Entrata───[TU]───Tesoro",
    tesoro: "Grotta───[TU] 💎",
    tempio: "Fiume│[TU] 🏛️"
  }
  
  puts "\n📍 MAPPA:"
  puts mappa[posizione_attuale]
end

# Nel loop principale:
if scelta == 8
  mostra_mappa(giocatore.posizione)
end
```
*Concetti: Hash complessi, rappresentazione visiva*

**8. Sistema di Combinazione Oggetti**
Combina oggetti per crearne di nuovi:
```ruby
class Giocatore
  def combina_oggetti(oggetto1, oggetto2)
    case [oggetto1, oggetto2].sort
    when ["liana", "machete"]
      @inventario.delete("liana")
      @inventario.delete("machete")
      aggiungi_oggetto("rampino")
      puts "Hai creato un rampino!"
      return true
    else
      puts "Questi oggetti non possono essere combinati."
      return false
    end
  end
end
```
*Concetti: Logica complessa, modifiche inventario*

**9. Enigmi e Puzzle**
Aggiungi enigmi da risolvere:
```ruby
def enigma_tempio(giocatore)
  puts "\n🧩 Vedi un'iscrizione:"
  puts "'Sono alto al mattino, basso al mezzogiorno'"
  puts "'Lungo alla sera. Chi sono?'"
  
  print "Risposta: "
  risposta = gets.chomp.downcase
  
  if risposta == "ombra" || risposta == "l'ombra"
    puts "✅ Corretto! Si apre un passaggio segreto!"
    giocatore.aggiungi_punti(20)
    return :passaggio_segreto
  else
    puts "❌ Sbagliato... non succede nulla."
    return nil
  end
end
```
*Concetti: Input testuale, logica di puzzle*

**10. Sistema di Tempo**
Aggiungi limiti di tempo/mosse:
```ruby
mosse_totali = 0
mosse_massime = 50

# Nel loop principale:
mosse_totali += 1

if mosse_totali >= mosse_massime
  puts "⏰ Il sole tramonta... la giungla diventa pericolosa!"
  stato[:gioco_attivo] = false
end

# Mostra warning a 40 mosse
if mosse_totali == 40
  puts "⚠️  Attenzione: ti restano solo 10 mosse!"
end
```
*Concetti: Contatori, pressure sul giocatore*

### 🎄 Progetti Completi

**11. Espansione Completa della Giungla**
Aggiungi:
- 5+ nuove stanze (villaggio, rovine, palude, vulcano, spiaggia)
- 10+ oggetti diversi
- Sistema di combattimento con armi
- NPC (personaggi non giocatori) con cui parlare
- Multipli finali in base alle scelte

**12. Sistema di Salvataggio**
Salva e carica il progresso:
```ruby
require 'json'

def salva_gioco(giocatore, stato)
  dati = {
    nome: giocatore.nome,
    posizione: giocatore.posizione,
    inventario: giocatore.inventario,
    stato: stato
  }
  
  File.write('salvataggio.json', JSON.generate(dati))
  puts "✅ Gioco salvato!"
end

def carica_gioco
  if File.exist?('salvataggio.json')
    dati = JSON.parse(File.read('salvataggio.json'), symbolize_names: true)
    # Ricrea giocatore e stato...
    puts "✅ Gioco caricato!"
    return dati
  else
    puts "Nessun salvataggio trovato."
    return nil
  end
end
```
*Concetti: File I/O, JSON, persistenza*

**13. Modalità Multiplayer Cooperativa**
Due giocatori esplorano insieme:
```ruby
giocatore1 = Giocatore.new("Giocatore 1")
giocatore2 = Giocatore.new("Giocatore 2")

turno = 1

# Nel loop:
giocatore_corrente = turno % 2 == 1 ? giocatore1 : giocatore2
puts "\nTurno di #{giocatore_corrente.nome}"
# ...
turno += 1
```
*Concetti: Multipli giocatori, alternanza turni*

---

## 📚 Cosa Impari con Questi Esercizi

| Livello | Esercizi | Concetti Chiave |
|---------|----------|------------------|
| 🌱 Facile | 1-3 | Simboli, case/when, stato |
| 🌿 Medio | 4-6 | Classi avanzate, dipendenze oggetti |
| 🌳 Avanzato | 7-10 | Hash complessi, logica avanzata, timer |
| 🎄 Progetti | 11-13 | File I/O, JSON, sistemi completi |

---

## 💡 Consigli per Espandere

1. **Inizia piccolo**: aggiungi una stanza alla volta
2. **Testa spesso**: gioca dopo ogni modifica per verificare che funzioni
3. **Commenta il codice**: scrivi note per ricordare cosa fa ogni parte
4. **Usa metodi**: dividi funzionalità complesse in metodi più piccoli
5. **Sii creativo**: è il TUO gioco, aggiungi quello che ti piace!

---

## 🏆 Sfida Finale

Crea il tuo gioco originale usando Jungle Adventure come base:
- Cambia ambientazione (spazio, castello, città moderna)
- Inventa nuove meccaniche di gioco
- Aggiungi emoji e disegni fatti con simboli 🎨
- Crea una storia coinvolgente
- Condividi con gli amici!
