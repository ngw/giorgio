#!/usr/bin/env ruby

# 🌴 JUNGLE ADVENTURE - Un'avventura nella giungla! 🌴
# Questo gioco usa: case/when, metodi, simboli, nil, classi

class Giocatore
  attr_reader :nome, :inventario, :posizione
  
  def initialize(nome)
    @nome = nome
    @inventario = []
    @posizione = :entrata
    @punti = 0
  end
  
  def aggiungi_oggetto(oggetto)
    @inventario.push(oggetto)
    puts "✓ Hai raccolto: #{oggetto}"
  end
  
  def ha_oggetto?(oggetto)
    @inventario.include?(oggetto)
  end
  
  def muovi_a(luogo)
    @posizione = luogo
  end
  
  def aggiungi_punti(punti)
    @punti += punti
    puts "⭐ +#{punti} punti! (Totale: #{@punti})"
  end
  
  def mostra_inventario
    if @inventario.empty?
      puts "📦 Il tuo inventario è vuoto."
    else
      puts "📦 Inventario: #{@inventario.join(", ")}"
    end
  end
  
  def punteggio_finale
    @punti
  end
end

# Metodi per descrivere i luoghi
def descrivi_luogo(luogo)
  case luogo
  when :entrata
    puts "\n🌴 Sei all'entrata della giungla."
    puts "Davanti a te vedi un sentiero che si divide in due."
  when :fiume
    puts "\n🌊 Sei arrivato a un fiume."
    puts "L'acqua scorre veloce ma potresti attraversarlo."
  when :grotta
    puts "\n🕳️  Hai trovato una grotta misteriosa."
    puts "È buio dentro, ma senti strani rumori."
  when :tesoro
    puts "\n💎 Camera del tesoro!"
    puts "Vedi un baule dorato al centro della stanza!"
  when :tempio
    puts "\n🏛️  Un antico tempio in rovina."
    puts "Ci sono strani simboli sui muri."
  else
    puts "\n❓ Non sai dove sei..."
  end
end

# Metodo per mostrare le opzioni disponibili
def mostra_opzioni(luogo, giocatore)
  puts "\nCosa vuoi fare?"
  
  case luogo
  when :entrata
    puts "1. Vai verso il fiume"
    puts "2. Esplora la grotta"
    puts "3. Cerca nel terreno"
  when :fiume
    puts "1. Attraversa il fiume"
    puts "2. Cerca lungo la riva"
    puts "3. Torna all'entrata"
  when :grotta
    puts "1. Entra nella grotta"
    puts "2. Torna all'entrata"
  when :tesoro
    puts "1. Apri il baule"
    puts "2. Esamina la stanza"
    puts "3. Torna indietro"
  when :tempio
    puts "1. Leggi i simboli"
    puts "2. Esplora il tempio"
    puts "3. Torna al fiume"
  end
  
  puts "9. Mostra inventario"
  puts "0. Esci dal gioco"
end

# Metodo principale del gioco
def gioca
  puts "🌴====================================🌴"
  puts "   BENVENUTO IN JUNGLE ADVENTURE!"
  puts "🌴====================================🌴"
  puts
  
  print "Come ti chiami, avventuriero? "
  nome_giocatore = gets.chomp
  
  # Controlla che il nome non sia vuoto (nil o stringa vuota)
  if nome_giocatore.nil? || nome_giocatore.empty?
    nome_giocatore = "Esploratore"
  end
  
  giocatore = Giocatore.new(nome_giocatore)
  
  puts "\nCiao #{giocatore.nome}! La tua avventura inizia..."
  
  # Stato del gioco (usa simboli come chiavi!)
  stato = {
    trovato_machete: false,
    attraversato_fiume: false,
    aperto_tesoro: false,
    gioco_attivo: true
  }
  
  # Loop principale del gioco
  while stato[:gioco_attivo]
    descrivi_luogo(giocatore.posizione)
    mostra_opzioni(giocatore.posizione, giocatore)
    
    print "\n▶ Scelta: "
    scelta = gets.chomp.to_i
    puts
    
    # Logica principale con case/when
    case giocatore.posizione
    when :entrata
      gestisci_entrata(scelta, giocatore, stato)
    when :fiume
      gestisci_fiume(scelta, giocatore, stato)
    when :grotta
      gestisci_grotta(scelta, giocatore, stato)
    when :tesoro
      gestisci_tesoro(scelta, giocatore, stato)
    when :tempio
      gestisci_tempio(scelta, giocatore, stato)
    end
    
    # Opzioni globali
    if scelta == 9
      giocatore.mostra_inventario
    elsif scelta == 0
      stato[:gioco_attivo] = false
      puts "Grazie per aver giocato!"
    end
  end
  
  # Mostra punteggio finale
  puts "\n🏆 GIOCO TERMINATO 🏆"
  puts "#{giocatore.nome}, hai totalizzato #{giocatore.punteggio_finale} punti!"
  
  if giocatore.punteggio_finale >= 50
    puts "Sei un vero esploratore! 🌟"
  elsif giocatore.punteggio_finale >= 30
    puts "Buon lavoro! 👍"
  else
    puts "C'è ancora molto da esplorare! 🗺️"
  end
end

# Metodi per gestire le azioni in ogni luogo

def gestisci_entrata(scelta, giocatore, stato)
  case scelta
  when 1
    giocatore.muovi_a(:fiume)
  when 2
    giocatore.muovi_a(:grotta)
  when 3
    puts "Scavi nel terreno..."
    if !stato[:trovato_machete]
      giocatore.aggiungi_oggetto("machete")
      stato[:trovato_machete] = true
      giocatore.aggiungi_punti(5)
    else
      puts "Non c'è più nulla qui."
    end
  end
end

def gestisci_fiume(scelta, giocatore, stato)
  case scelta
  when 1
    if giocatore.ha_oggetto?("liana")
      puts "Usi la liana per attraversare il fiume in sicurezza!"
      giocatore.muovi_a(:tempio)
      if !stato[:attraversato_fiume]
        giocatore.aggiungi_punti(15)
        stato[:attraversato_fiume] = true
      end
    else
      puts "Il fiume è troppo pericoloso senza un aiuto!"
      puts "Forse c'è qualcosa lungo la riva..."
    end
  when 2
    puts "Cerchi lungo la riva e trovi una liana robusta!"
    giocatore.aggiungi_oggetto("liana")
    giocatore.aggiungi_punti(5)
  when 3
    giocatore.muovi_a(:entrata)
  end
end

def gestisci_grotta(scelta, giocatore, stato)
  case scelta
  when 1
    if giocatore.ha_oggetto?("machete")
      puts "Usi il machete per tagliare le liane e entrare..."
      giocatore.muovi_a(:tesoro)
      giocatore.aggiungi_punti(10)
    else
      puts "Le liane bloccano l'entrata. Serve qualcosa per tagliarle!"
    end
  when 2
    giocatore.muovi_a(:entrata)
  end
end

def gestisci_tesoro(scelta, giocatore, stato)
  case scelta
  when 1
    if !stato[:aperto_tesoro]
      puts "🎉 Hai aperto il baule!"
      puts "Dentro trovi: gemme preziose, monete d'oro, e un amuleto antico!"
      giocatore.aggiungi_oggetto("tesoro")
      giocatore.aggiungi_punti(30)
      stato[:aperto_tesoro] = true
      puts "\n✨ HAI VINTO! ✨"
      stato[:gioco_attivo] = false
    else
      puts "Il baule è vuoto, lo hai già aperto!"
    end
  when 2
    puts "Esamini la stanza e trovi delle antiche iscrizioni..."
    giocatore.aggiungi_punti(5)
  when 3
    giocatore.muovi_a(:grotta)
  end
end

def gestisci_tempio(scelta, giocatore, stato)
  case scelta
  when 1
    puts "I simboli raccontano di un grande tesoro nascosto nella giungla..."
    giocatore.aggiungi_punti(10)
  when 2
    puts "Esplori il tempio ma non trovi nulla di particolare."
  when 3
    giocatore.muovi_a(:fiume)
  end
end

# Avvia il gioco!
gioca
