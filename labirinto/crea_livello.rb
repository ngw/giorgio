# ═══════════════════════════════════════════════════════════
# CREA UN NUOVO LIVELLO PER IL LABIRINTO PERDUTO
#
# Questo script genera un file-modello che puoi modificare
# per creare il tuo labirinto personale!
# ═══════════════════════════════════════════════════════════

puts "🏰 CREA IL TUO LABIRINTO!"
puts

# ── Chiedi il nome del livello ────────────────────────────
print "Nome del livello: "
nome = $stdin.gets.chomp.strip
nome = "Il Mio Labirinto" if nome.empty?

# ── Chiedi le dimensioni ─────────────────────────────────
puts
puts "Le dimensioni devono essere numeri DISPARI."
puts "Più grande = più difficile!"
puts

print "Larghezza (11-41) [15]: "
larghezza = $stdin.gets.chomp.strip
larghezza = larghezza.empty? ? 15 : larghezza.to_i
larghezza = 15 unless larghezza.between?(11, 41) && larghezza.odd?

print "Altezza (9-35) [11]: "
altezza = $stdin.gets.chomp.strip
altezza = altezza.empty? ? 11 : altezza.to_i
altezza = 11 unless altezza.between?(9, 35) && altezza.odd?

# ── Chiedi il raggio di visibilità ────────────────────────
print "Raggio visibilità (2-5) [3]: "
raggio = $stdin.gets.chomp.strip
raggio = raggio.empty? ? 3 : raggio.to_i
raggio = 3 unless raggio.between?(2, 5)

# ── Chiedi la descrizione ─────────────────────────────────
print "Descrizione (opzionale): "
descrizione = $stdin.gets.chomp.strip
descrizione = "Un labirinto creato da me!" if descrizione.empty?

# ── Genera la griglia vuota ───────────────────────────────
griglia = Array.new(altezza) do |r|
  if r == 0 || r == altezza - 1
    "#" * larghezza
  else
    "#" + "." * (larghezza - 2) + "#"
  end
end

# Piazza S in alto a sinistra e E in basso a destra
griglia[1] = "#S" + "." * (larghezza - 3) + "#"
griglia[altezza - 2] = "#" + "." * (larghezza - 3) + "E#"

# ── Chiedi il nome del file ───────────────────────────────
puts
nome_file_default = nome.downcase.gsub(/[^a-z0-9]/, "_").gsub(/_+/, "_")
print "Nome del file [#{nome_file_default}.txt]: "
nome_file = $stdin.gets.chomp.strip
nome_file = "#{nome_file_default}.txt" if nome_file.empty?
nome_file += ".txt" unless nome_file.end_with?(".txt")

# ── Chiedi dove salvare ──────────────────────────────────
directory = ARGV[0] || File.join(File.dirname(__FILE__), "livelli")
Dir.mkdir(directory) unless Dir.exist?(directory)
percorso = File.join(directory, nome_file)

if File.exist?(percorso)
  print "Il file '#{nome_file}' esiste già. Sovrascrivere? (s/n): "
  risposta = $stdin.gets.chomp.downcase
  unless risposta == "s"
    puts "Annullato."
    exit
  end
end

# ── Scrivi il file ────────────────────────────────────────
File.open(percorso, "w") do |f|
  f.puts "COME CREARE IL TUO LABIRINTO"
  f.puts "============================"
  f.puts ""
  f.puts "Apri questo file con un editor di testo (va bene anche"
  f.puts "l'app Testo del Chromebook). Scorri in basso fino alla"
  f.puts "griglia e sostituisci i punti (.) con i simboli che vuoi."
  f.puts ""
  f.puts ""
  f.puts "LEGENDA DEI SIMBOLI"
  f.puts "--------------------"
  f.puts ""
  f.puts "  #   muro         Non si puo' attraversare."
  f.puts "                    Usalo per creare corridoi e stanze."
  f.puts ""
  f.puts "  .   corridoio    Passaggio libero dove il giocatore cammina."
  f.puts ""
  f.puts "  S   partenza     Dove il giocatore inizia. METTINE UNO SOLO!"
  f.puts ""
  f.puts "  E   uscita       Dove il giocatore deve arrivare. UNA SOLA!"
  f.puts ""
  f.puts "  M   moneta       Il giocatore la raccoglie e guadagna 10 punti."
  f.puts ""
  f.puts "  K   chiave       Serve per aprire una porta (P). Se metti"
  f.puts "                    una porta, metti anche almeno una chiave!"
  f.puts ""
  f.puts "  P   porta        Blocca il passaggio. Si apre solo con una"
  f.puts "                    chiave (K). Metti K e P in coppia."
  f.puts ""
  f.puts "  T   trappola     Toglie 1 vita al giocatore! Cattiva!"
  f.puts ""
  f.puts "  H   pozione      Da' 1 vita in piu' al giocatore."
  f.puts ""
  f.puts "  G   gemma        Vale 50 punti! Piu' rara della moneta."
  f.puts ""
  f.puts "  O   portale      Teletrasporta il giocatore. METTINE"
  f.puts "                    ESATTAMENTE 2: il giocatore entra in uno"
  f.puts "                    e sbuca dall'altro!"
  f.puts ""
  f.puts "  N   nemico       Si muove da solo e toglie 1 vita se tocca"
  f.puts "                    il giocatore. Pericoloso!"
  f.puts ""
  f.puts "  ?   indizio      Da' un suggerimento al giocatore."
  f.puts ""
  f.puts ""
  f.puts "COME SCRIVERE I SIMBOLI SULLA TASTIERA DEL CHROMEBOOK"
  f.puts "------------------------------------------------------"
  f.puts ""
  f.puts "  #   Cancelletto   AltGr + a' (il tasto a' e' a destra della L)"
  f.puts "                    Oppure: Ctrl+Shift+U, poi scrivi 23, poi Invio"
  f.puts ""
  f.puts "  .   Punto         Il tasto punto normale (vicino alla virgola)"
  f.puts ""
  f.puts "  ?   Punto di domanda   Shift + ' (l'apostrofo, a destra dello 0)"
  f.puts ""
  f.puts "  Tutti gli altri simboli (S E M K P T H G O N) sono"
  f.puts "  lettere normali. Scrivili MAIUSCOLI (tieni premuto Shift)."
  f.puts ""
  f.puts "  SUGGERIMENTO: il modo piu' facile per fare # e' copiare e"
  f.puts "  incollare: seleziona un # che c'e' gia' nel file, premi"
  f.puts "  Ctrl+C per copiare, poi Ctrl+V per incollare dove vuoi."
  f.puts ""
  f.puts ""
  f.puts "REGOLE"
  f.puts "------"
  f.puts ""
  f.puts "  1. Il bordo esterno DEVE essere tutto muri (#)."
  f.puts "     (la griglia qui sotto lo ha gia' fatto per te!)"
  f.puts ""
  f.puts "  2. Tutte le righe devono avere la stessa lunghezza."
  f.puts "     Non aggiungere e non togliere caratteri da una riga!"
  f.puts ""
  f.puts "  3. Ci deve essere ESATTAMENTE un punto S e un punto E."
  f.puts ""
  f.puts "  4. Il giocatore deve poter raggiungere E partendo da S!"
  f.puts "     Controlla che i corridoi siano collegati."
  f.puts ""
  f.puts "  5. Metti K e P in coppia: ogni porta ha bisogno di una chiave."
  f.puts ""
  f.puts ""
  f.puts "COME FARE"
  f.puts "---------"
  f.puts ""
  f.puts "  1. Guarda la griglia qui sotto: e' una stanza vuota con"
  f.puts "     S (partenza) in alto a sinistra e E (uscita) in basso"
  f.puts "     a destra."
  f.puts ""
  f.puts "  2. Sostituisci alcuni . con # per creare muri e corridoi."
  f.puts "     Crea un percorso che va da S a E, non troppo facile!"
  f.puts ""
  f.puts "  3. Aggiungi monete (M), gemme (G), trappole (T), chiavi (K),"
  f.puts "     porte (P), nemici (N) e quello che vuoi."
  f.puts ""
  f.puts "  4. Salva il file e giocaci con:"
  f.puts "     ruby labirinto.rb #{directory}"
  f.puts ""
  f.puts ""
  f.puts "========== IL TUO LABIRINTO (modifica sotto!) =========="
  f.puts ""
  f.puts "nome: #{nome}"
  f.puts "descrizione: #{descrizione}"
  f.puts "raggio_visibilita: #{raggio}"
  f.puts ""
  griglia.each { |riga| f.puts riga }
end

puts
puts "✅ File creato: #{percorso}"
puts
puts "Adesso aprilo con un editor di testo e disegna il tuo labirinto!"
puts "Quando hai finito, giocaci con:"
puts "  ruby labirinto.rb #{directory}"
puts
