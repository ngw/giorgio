# ═══════════════════════════════════════════════════════════════
# 🏰 IL LABIRINTO PERDUTO
# Un gioco di labirinti per imparare Ruby!
#
# Concetti nuovi:
#   - Matrici (Array bidimensionali)
#   - Moduli (module/include)
#   - Ereditarietà (class Figlia < Madre)
#   - Gestione errori (begin/rescue)
#   - freeze (rendere immutabili gli oggetti)
#   - each_with_index e map
#   - Nebbia di guerra con Array 2D di booleani
#   - Proc / lambda (porte con condizioni)
#   - select / reject / count (filtrare Array)
#   - Comparable (confronto tra oggetti)
# ═══════════════════════════════════════════════════════════════

# ── COSTANTI ──────────────────────────────────────────────────
# freeze rende l'Hash immutabile: nessuno potrà modificarlo
# per errore durante il gioco.

SIMBOLI = {
  muro:        "█",
  corridoio:   " ",
  giocatore:   "☺",
  uscita:      "⚑",
  chiave:      "✦",
  trappola:    "☠",
  moneta:      "●",
  nebbia:      "░",
  porta:       "▒",
  pozione:     "♥",
  gemma:       "◆",
  teletrasporto: "◎",
  indizio:     "?",
  nemico:      "⚉",
  diana:       "⚆",
  lola:        "⚈",
  cacca:       "·"
}.freeze

# Messaggi casuali quando il giocatore sbatte contro un muro.
# select, reject, sample: li usiamo dopo per filtrare liste.
MESSAGGI_MURO = [
  "🧱 Ahi! C'è un muro!",
  "🧱 Non si passa di qui!",
  "🧱 Muro! Prova un'altra direzione.",
  "🧱 Toc toc... è un muro.",
  "🧱 Niente da fare, è solido!"
].freeze

# ── MODULO: Muovibile ────────────────────────────────────────
# Un modulo è un "pacchetto" di metodi che possiamo aggiungere
# a qualsiasi classe con `include`. È diverso dall'ereditarietà:
# una classe può includere MOLTI moduli, ma può ereditare
# da UNA sola classe madre.

module Muovibile
  DIREZIONI = {
    "w" => [-1, 0],   # su
    "s" => [1, 0],    # giù
    "a" => [0, -1],   # sinistra
    "d" => [0, 1]     # destra
  }.freeze

  NOMI_DIREZIONI = {
    "w" => "nord",
    "s" => "sud",
    "a" => "ovest",
    "d" => "est"
  }.freeze

  # Calcola la nuova posizione senza muovere davvero l'entità.
  # Restituisce [nuova_riga, nuova_colonna] oppure nil.
  def calcola_nuova_posizione(direzione)
    delta = DIREZIONI[direzione]
    return nil unless delta

    [@riga + delta[0], @colonna + delta[1]]
  end
end

# ── MODULO: Descrivibile ─────────────────────────────────────
# Un secondo modulo che mostra come una classe può
# includere PIÙ moduli contemporaneamente.

module Descrivibile
  def descrizione
    raise NotImplementedError, "#{self.class} deve implementare #descrizione"
  end
end

# ── CLASSE BASE: Entita ──────────────────────────────────────
# Tutte le "cose" che occupano una cella del labirinto
# (giocatore, nemici…) condividono riga, colonna e simbolo.
# Mettiamo queste proprietà in una classe madre e poi
# le estendiamo con l'EREDITARIETÀ.

class Entita
  attr_reader :riga, :colonna, :simbolo

  def initialize(riga, colonna, simbolo)
    @riga    = riga
    @colonna = colonna
    @simbolo = simbolo
  end

  def posizione
    [@riga, @colonna]
  end

  def stessa_posizione?(altra)
    posizione == altra.posizione
  end
end

# ── NEMICO ────────────────────────────────────────────────────
# I nemici ereditano da Entita e includono Muovibile:
# si muovono a caso per il labirinto. Mostrano come
# l'ereditarietà permette di riusare codice.

class Nemico < Entita
  include Muovibile

  def initialize(riga, colonna)
    super(riga, colonna, SIMBOLI[:nemico])
    @direzioni_possibili = Muovibile::DIREZIONI.keys
  end

  def scegli_mossa_casuale
    dir = @direzioni_possibili.sample
    calcola_nuova_posizione(dir)
  end

  def sposta_a(riga, colonna)
    @riga    = riga
    @colonna = colonna
  end
end

# ── DIANA ─────────────────────────────────────────────────────
# Diana è la cagnolina del labirinto!
# Eredita da Entita e include Muovibile, proprio come Nemico.
# La differenza: Diana gira pacificamente e lascia piccole cacche
# che sporcano gli stivali del giocatore (ma non fanno danno).
#
# Nota per i curiosi: Diana e Nemico condividono quasi tutto il
# codice. In un programma più grande potremmo creare una classe
# intermedia "EntitaMobile" da cui entrambi ereditano.

class Diana < Entita
  include Muovibile

  def initialize(riga, colonna)
    super(riga, colonna, SIMBOLI[:diana])
    @direzioni_possibili = Muovibile::DIREZIONI.keys
  end

  # Sceglie una direzione a caso e calcola la nuova posizione.
  def scegli_mossa_casuale
    dir = @direzioni_possibili.sample
    calcola_nuova_posizione(dir)
  end

  def sposta_a(riga, colonna)
    @riga    = riga
    @colonna = colonna
  end
end

# ═══════════════════════════════════════════════════════════════
# 🐾 ESERCIZIO: CREA LA CLASSE LOLA
#
# Lola è la sorella coraggiosa di Diana.
# Gira per il labirinto e quando trova un nemico... lo elimina!
#
# Il tuo compito: completare questa classe seguendo i passi
# descritti nel file esercizio_lola.md
# ═══════════════════════════════════════════════════════════════

class Lola < Diana
  # ── Passo 1: cambia il simbolo di Lola ──────────────────────
  # Diana usa SIMBOLI[:diana] (impostato in initialize).
  # Ma Lola vuole il SUO simbolo: SIMBOLI[:lola].
  #
  # Suggerimento: ridefinisci initialize in questo modo:
  #
  #   def initialize(riga, colonna)
  #     super(riga, colonna)        # chiama Diana#initialize
  #     @simbolo = SIMBOLI[:lola]   # poi cambia il simbolo!
  #   end

  # ── Passo 2: elimina i nemici nella tua posizione ───────────
  # Questo metodo riceve la lista di TUTTI i nemici del labirinto.
  # Deve restituire la lista SENZA i nemici nella posizione di Lola.
  #
  # Suggerimento: usa reject con una condizione sulle coordinate:
  #   nemici.reject { |n| n.riga == @riga && n.colonna == @colonna }
  #
  # ────────────────────────────────────────────────────────────
  # Per ora Lola non fa nulla di speciale: tocca a te!
  def elimina_nemici(nemici)
    nemici   # ← restituisce la lista invariata. Cambia questo!
  end
end

# ── GIOCATORE ─────────────────────────────────────────────────
# Giocatore eredita da Entita (ha riga, colonna, simbolo)
# e include DUE moduli: Muovibile e Descrivibile.
#
#   Entita   ← classe madre (dati di posizione)
#     ↑
#   Giocatore + Muovibile + Descrivibile

class Giocatore < Entita
  include Muovibile
  include Descrivibile

  # include Comparable ci permette di confrontare giocatori
  # per punteggio con < > == (utile per classifiche).
  # Basta definire il metodo <=> (nave spaziale).
  include Comparable

  attr_reader :inventario, :punti, :vite, :nome
  attr_reader :mosse, :monete_raccolte, :chiavi_usate

  def initialize(riga, colonna, nome)
    # `super` chiama il metodo initialize della classe madre (Entita)
    super(riga, colonna, SIMBOLI[:giocatore])
    @nome             = nome
    @inventario       = []
    @punti            = 0
    @vite             = 3
    @mosse            = 0
    @monete_raccolte  = 0
    @chiavi_usate     = 0
  end

  def sposta_a(riga, colonna)
    @riga  = riga
    @colonna = colonna
    @mosse += 1
  end

  def raccogli(oggetto)
    @inventario << oggetto
  end

  def rimuovi_oggetto(oggetto)
    @inventario.delete(oggetto)
  end

  def ha_oggetto?(oggetto)
    @inventario.include?(oggetto)
  end

  # count: conta quanti elementi soddisfano la condizione.
  def conta_oggetti(tipo)
    @inventario.count { |o| o == tipo }
  end

  def aggiungi_punti(quantita)
    @punti += quantita
  end

  def perdi_vita
    @vite -= 1
  end

  def guadagna_vita
    @vite += 1 if @vite < 5
  end

  def vivo?
    @vite > 0
  end

  # Descrivibile: implementiamo il metodo astratto del modulo.
  def descrizione
    "#{@nome} [Vite: #{@vite}, Punti: #{@punti}, Oggetti: #{@inventario.length}]"
  end

  # Comparable: il metodo <=> ("nave spaziale") confronta
  # due giocatori per punteggio. Restituisce -1, 0 o 1.
  def <=>(altro)
    @punti <=> altro.punti
  end
end

# ── LABIRINTO ─────────────────────────────────────────────────
# Il cuore del gioco: trasforma un disegno testuale in una
# MATRICE (Array di Array) e gestisce visibilità e oggetti.

class Labirinto
  attr_reader :righe, :colonne, :nome_livello, :descrizione_livello
  attr_reader :diana, :lola, :cacce

  # Legenda:
  #   # = muro    . = corridoio   S = start     E = uscita
  #   K = chiave  T = trappola    M = moneta    P = porta
  #   H = pozione G = gemma       O = teletrasporto  ? = indizio
  #   N = nemico

  # ── Caricamento livelli da file ──────────────────────────
  # I livelli sono salvati come file .txt nella cartella livelli/.
  # Puoi creare i tuoi livelli con: ruby crea_livello.rb
  # E giocarci con: ruby labirinto.rb percorso/alla/cartella/

  @@livelli = []

  def self.livelli
    @@livelli
  end

  def self.carica_da_directory(directory)
    files = Dir.glob(File.join(directory, "*.txt")).sort
    if files.empty?
      puts "❌ Nessun livello trovato in '#{directory}'"
      puts "   Crea un livello con: ruby crea_livello.rb"
      exit 1
    end
    @@livelli = files.map { |f| carica_livello_da_file(f) }
  end

  def self.carica_livello_da_file(percorso)
    contenuto = File.read(percorso)
    nome = "Livello sconosciuto"
    descrizione = ""
    raggio = 2
    mappa = []

    contenuto.each_line do |linea|
      linea = linea.chomp
      if linea.match?(/\Anome:\s*/)
        nome = linea.sub(/\Anome:\s*/, "")
      elsif linea.match?(/\Adescrizione:\s*/)
        descrizione = linea.sub(/\Adescrizione:\s*/, "")
      elsif linea.match?(/\Araggio_visibilita:\s*/)
        raggio = linea.sub(/\Araggio_visibilita:\s*/, "").to_i
      elsif linea.match?(/\A[#.SKETMPHGON?]+\z/)
        mappa << linea
      end
    end

    # Validazione: controlliamo che il livello sia corretto
    errori = []
    errori << "la mappa è vuota" if mappa.empty?
    unless mappa.empty?
      conteggio_s = mappa.sum { |r| r.count("S") }
      conteggio_e = mappa.sum { |r| r.count("E") }
      errori << "manca il punto di partenza (S)" if conteggio_s == 0
      errori << "ci sono #{conteggio_s} punti S, ne serve uno solo" if conteggio_s > 1
      errori << "manca l'uscita (E)" if conteggio_e == 0
      errori << "ci sono #{conteggio_e} uscite E, ne serve una sola" if conteggio_e > 1
      larghezze = mappa.map(&:length).uniq
      errori << "le righe hanno larghezze diverse (#{larghezze.join(', ')})" if larghezze.length > 1
    end

    unless errori.empty?
      puts "⚠️  Errori nel file '#{File.basename(percorso)}':"
      errori.each { |e| puts "   - #{e}" }
      puts "   Correggi il file e riprova!"
      exit 1
    end

    { nome: nome, descrizione: descrizione, raggio_visibilita: raggio, mappa: mappa }
  end

  def initialize(livello)
    # begin/rescue: proviamo a caricare il livello.
    # Se qualcosa va storto, gestiamo l'errore con grazia.
    begin
      dati = @@livelli[livello]
      raise "Livello #{livello + 1} non esiste!" if dati.nil?
    rescue => errore
      puts "Errore: #{errore.message}"
      puts "Uso il livello 1 come predefinito."
      dati = @@livelli[0]
    end

    @nome_livello        = dati[:nome]
    @descrizione_livello = dati[:descrizione]
    @raggio              = dati[:raggio_visibilita]

    # map trasforma ogni stringa in un Array di caratteri → MATRICE
    @griglia = dati[:mappa].map { |riga| riga.chars }

    @righe   = @griglia.length
    @colonne = @griglia[0].length

    # Hash per oggetti e per porte (con lambda come condizione!)
    @oggetti = {}
    @porte   = {}
    @nemici  = []
    @teletrasporti = []
    @indizi  = {}
    @diana   = nil
    @lola    = nil
    @cacce   = {} # Hash [r, c] => true per le cacche di Diana

    # Nebbia di guerra: matrice di booleani
    @visibilita = Array.new(@righe) { Array.new(@colonne, false) }

    analizza_griglia
  end

  def muro?(riga, colonna)
    return true if fuori_limiti?(riga, colonna)
    @griglia[riga][colonna] == "#"
  end

  def uscita?(riga, colonna)
    [riga, colonna] == @posizione_uscita
  end

  def porta?(riga, colonna)
    @porte.key?([riga, colonna])
  end

  # Le porte usano una lambda come condizione.
  # Una lambda è una "funzione anonima" salvata in una variabile.
  # La porta si apre solo se la condizione è vera.
  def porta_apribile?(riga, colonna, giocatore)
    condizione = @porte[[riga, colonna]]
    return true unless condizione
    condizione.call(giocatore)
  end

  def apri_porta(riga, colonna)
    @porte.delete([riga, colonna])
    @griglia[riga][colonna] = "."
  end

  def oggetto_a(riga, colonna)
    @oggetti[[riga, colonna]]
  end

  def rimuovi_oggetto(riga, colonna)
    @oggetti.delete([riga, colonna])
  end

  def indizio_a(riga, colonna)
    @indizi[[riga, colonna]]
  end

  def rimuovi_indizio(riga, colonna)
    @indizi.delete([riga, colonna])
  end

  # select: restituisce solo gli elementi che soddisfano il blocco.
  def chiavi_rimaste
    @oggetti.select { |_pos, tipo| tipo == :chiave }.length
  end

  # reject: restituisce solo gli elementi che NON soddisfano il blocco.
  # (opposto di select)
  def oggetti_non_chiave
    @oggetti.reject { |_pos, tipo| tipo == :chiave }
  end

  def richiede_chiave?
    chiavi_rimaste > 0
  end

  def nemici
    @nemici
  end

  # Controlla se c'è un teletrasporto e restituisce la destinazione.
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

  # Muovi i nemici: ogni nemico prova a muoversi in direzione casuale.
  def muovi_nemici
    @nemici.each do |nemico|
      3.times do
        nuova_pos = nemico.scegli_mossa_casuale
        next unless nuova_pos
        nr, nc = nuova_pos
        unless muro?(nr, nc) || porta?(nr, nc) || uscita?(nr, nc)
          nemico.sposta_a(nr, nc)
          break
        end
      end
    end
  end

  # Controlla se un nemico è in una posizione.
  def nemico_a?(riga, colonna)
    @nemici.any? { |n| n.riga == riga && n.colonna == colonna }
  end

  # ── Diana ──────────────────────────────────────────────────
  # Piazza Diana in un corridoio libero casuale.
  def posiziona_diana
    pos = posizione_corridoio_libera
    @diana = Diana.new(pos[0], pos[1]) if pos
  end

  # Muove Diana di un passo casuale e lascia una cacca dove era.
  def muovi_diana
    return unless @diana
    vecchia_r, vecchia_c = @diana.riga, @diana.colonna
    3.times do
      nuova_pos = @diana.scegli_mossa_casuale
      next unless nuova_pos
      nr, nc = nuova_pos
      next if muro?(nr, nc) || porta?(nr, nc)
      aggiungi_cacca(vecchia_r, vecchia_c)
      @diana.sposta_a(nr, nc)
      return
    end
  end

  def diana_a?(riga, colonna)
    @diana && @diana.riga == riga && @diana.colonna == colonna
  end

  # ── Lola ───────────────────────────────────────────────────
  # Piazza Lola in un corridoio libero casuale.
  def posiziona_lola
    pos = posizione_corridoio_libera
    @lola = Lola.new(pos[0], pos[1]) if pos
  end

  # Muove Lola di un passo casuale.
  # Restituisce il numero di nemici che Lola ha eliminato.
  def muovi_lola
    return 0 unless @lola
    3.times do
      nuova_pos = @lola.scegli_mossa_casuale
      next unless nuova_pos
      nr, nc = nuova_pos
      next if muro?(nr, nc) || porta?(nr, nc)
      @lola.sposta_a(nr, nc)
      nemici_prima   = @nemici.length
      @nemici        = @lola.elimina_nemici(@nemici)
      return nemici_prima - @nemici.length
    end
    0
  end

  def lola_a?(riga, colonna)
    @lola && @lola.riga == riga && @lola.colonna == colonna
  end

  # ── Cacce ──────────────────────────────────────────────────
  def cacca_a?(riga, colonna)
    @cacce.key?([riga, colonna])
  end

  def rimuovi_cacca(riga, colonna)
    @cacce.delete([riga, colonna])
  end


  # Rivela le celle intorno al giocatore.
  def rivela_area(riga, colonna, raggio = nil)
    raggio ||= @raggio
    (riga - raggio..riga + raggio).each do |r|
      (colonna - raggio..colonna + raggio).each do |c|
        next if fuori_limiti?(r, c)
        distanza = (riga - r).abs + (colonna - c).abs
        @visibilita[r][c] = true if distanza <= raggio
      end
    end
  end

  def visibile?(riga, colonna)
    return false if fuori_limiti?(riga, colonna)
    @visibilita[riga][colonna]
  end

  # Disegna la mappa: each_with_index per sapere riga e colonna.
  def disegna(giocatore)
    rivela_area(giocatore.riga, giocatore.colonna)

    bordo = "═" * (@colonne * 2)
    puts "╔#{bordo}╗"

    @griglia.each_with_index do |riga, r|
      print "║"
      riga.each_with_index do |cella, c|
        # Ordine di priorità per il disegno
        simbolo = if r == giocatore.riga && c == giocatore.colonna
                    SIMBOLI[:giocatore]
                  elsif !visibile?(r, c)
                    SIMBOLI[:nebbia]
                  elsif diana_a?(r, c)
                    SIMBOLI[:diana]
                  elsif lola_a?(r, c)
                    SIMBOLI[:lola]
                  elsif nemico_a?(r, c) && visibile?(r, c)
                    SIMBOLI[:nemico]
                  elsif @porte[[r, c]]
                    SIMBOLI[:porta]
                  elsif @indizi[[r, c]]
                    SIMBOLI[:indizio]
                  elsif cacca_a?(r, c)
                    SIMBOLI[:cacca]
                  elsif @oggetti[[r, c]]
                    SIMBOLI[@oggetti[[r, c]]]
                  elsif cella == "E"
                    SIMBOLI[:uscita]
                  elsif cella == "O"
                    SIMBOLI[:teletrasporto]
                  elsif cella == "#"
                    SIMBOLI[:muro]
                  else
                    SIMBOLI[:corridoio]
                  end
        print "#{simbolo} "
      end
      puts "║"
    end

    puts "╚#{bordo}╝"
  end

  def posizione_start
    @posizione_start
  end

  def posizione_uscita
    @posizione_uscita
  end

  # ── Metodi privati ──────────────────────────────────────────
  private

  def fuori_limiti?(riga, colonna)
    riga < 0 || riga >= @righe || colonna < 0 || colonna >= @colonne
  end

  # Trova una cella corridoio libera da nemici, start e uscita.
  def posizione_corridoio_libera
    candidati = []
    @griglia.each_with_index do |riga, r|
      riga.each_with_index do |cella, c|
        next if cella == "#"
        next if [r, c] == @posizione_start
        next if [r, c] == @posizione_uscita
        next if @nemici.any? { |n| n.riga == r && n.colonna == c }
        candidati << [r, c]
      end
    end
    candidati.sample
  end

  # Lascia una cacca nella posizione indicata.
  # Manteniamo al massimo 8 cacce contemporaneamente.
  def aggiungi_cacca(riga, colonna)
    return if [riga, colonna] == @posizione_start
    @cacce[[riga, colonna]] = true
    @cacce.delete(@cacce.keys.first) if @cacce.length > 8
  end


  # Scansiona la griglia per trovare posizioni, oggetti, porte, nemici.
  def analizza_griglia
    @posizione_start  = nil
    @posizione_uscita = nil

    @griglia.each_with_index do |riga, r|
      riga.each_with_index do |cella, c|
        case cella
        when "S"
          @posizione_start = [r, c]
          @griglia[r][c] = "."
        when "E"
          @posizione_uscita = [r, c]
        when "K"
          @oggetti[[r, c]] = :chiave
          @griglia[r][c] = "."
        when "T"
          @oggetti[[r, c]] = :trappola
          @griglia[r][c] = "."
        when "M"
          @oggetti[[r, c]] = :moneta
          @griglia[r][c] = "."
        when "H"
          @oggetti[[r, c]] = :pozione
          @griglia[r][c] = "."
        when "G"
          @oggetti[[r, c]] = :gemma
          @griglia[r][c] = "."
        when "P"
          # Lambda come condizione: la porta si apre solo se il
          # giocatore ha almeno una chiave.
          # ->(param) { corpo } è la sintassi per creare una lambda.
          @porte[[r, c]] = ->(g) { g.ha_oggetto?("chiave") }
          @griglia[r][c] = "P"
        when "O"
          @teletrasporti << [r, c]
        when "N"
          @nemici << Nemico.new(r, c)
          @griglia[r][c] = "."
        when "?"
          @indizi[[r, c]] = genera_indizio(r, c)
          @griglia[r][c] = "."
        end
      end
    end
  end

  # Genera un indizio utile basato sulla mappa.
  def genera_indizio(_r, _c)
    indizi_possibili = []
    indizi_possibili << "L'uscita è a #{direzione_relativa(@posizione_uscita)}." if @posizione_uscita

    chiave_pos = @oggetti.select { |_p, t| t == :chiave }.keys.first
    indizi_possibili << "Una chiave brilla a #{direzione_relativa(chiave_pos)}." if chiave_pos

    nemico_vicino = @nemici.first
    indizi_possibili << "Attenzione! Un guardiano pattuglia a #{direzione_relativa(nemico_vicino.posizione)}." if nemico_vicino

    indizi_possibili << "Le gemme valgono 50 punti ciascuna!"
    indizi_possibili << "Le pozioni rigenerano una vita."
    indizi_possibili.sample
  end

  def direzione_relativa(pos)
    return "???" unless pos
    dr = pos[0] - (@posizione_start ? @posizione_start[0] : 0)
    dc = pos[1] - (@posizione_start ? @posizione_start[1] : 0)
    verticale   = dr > 0 ? "sud" : "nord"
    orizzontale = dc > 0 ? "est"  : "ovest"
    "#{verticale}-#{orizzontale}"
  end
end

# ── GIOCO PRINCIPALE ─────────────────────────────────────────

class GiocoLabirinto
  def initialize
    @livello_corrente  = 0
    @punteggio_totale  = 0
    @mosse_totali      = 0
    @messaggi_log      = []
  end

  def avvia
    mostra_titolo
    nome = chiedi_nome

    loop do
      risultato = gioca_livello(@livello_corrente, nome)

      case risultato
      when :completato
        @livello_corrente += 1
        if @livello_corrente >= Labirinto.livelli.length
          mostra_vittoria_finale(nome)
          break
        else
          puts "\n🎉 Livello completato! Premi INVIO per il prossimo..."
          gets
        end
      when :sconfitta
        print "\nVuoi riprovare questo livello? (s/n): "
        break unless gets.chomp.downcase == "s"
      when :esci
        break
      end
    end

    mostra_punteggio_finale(nome)
  end

  private

  def mostra_titolo
    puts
    puts "╔══════════════════════════════════════════════╗"
    puts "║         🏰 IL LABIRINTO PERDUTO 🏰            ║"
    puts "║                                              ║"
    puts "║  Trova l'uscita di ogni labirinto!            ║"
    puts "║  Raccogli monete, gemme e chiavi.             ║"
    puts "║  Evita trappole e nemici!                     ║"
    puts "║                                              ║"
    puts "║  Comandi:                                     ║"
    puts "║    W/A/S/D = Muovi    M = Mappa completa      ║"
    puts "║    I = Inventario     Q = Esci                ║"
    puts "╚══════════════════════════════════════════════╝"
    puts
  end

  def chiedi_nome
    loop do
      print "Come ti chiami, avventuriero? "
      nome = gets.chomp.strip
      return nome unless nome.empty?
      puts "Devi inserire un nome!"
    end
  end

  def gioca_livello(livello, nome)
    labirinto = Labirinto.new(livello)
    sr, sc    = labirinto.posizione_start
    giocatore = Giocatore.new(sr, sc, nome)
    @messaggi_log = []

    labirinto.posiziona_diana
    labirinto.posiziona_lola

    aggiungi_messaggio("📜 #{labirinto.nome_livello}: #{labirinto.descrizione_livello}")

    loop do
      # I nemici si muovono a ogni turno del giocatore
      labirinto.muovi_nemici if labirinto.nemici.any?

      # Diana gira e lascia cacche
      labirinto.muovi_diana

      # Lola gira e (se il bambino ha implementato il metodo) elimina nemici
      nemici_uccisi = labirinto.muovi_lola
      if nemici_uccisi > 0
        punti_bonus = 30 * nemici_uccisi
        aggiungi_messaggio("🐾 UHUUUU! Lola ha eliminato #{nemici_uccisi} #{nemici_uccisi == 1 ? 'nemico' : 'nemici'}! +#{punti_bonus} punti")
        giocatore.aggiungi_punti(punti_bonus)
      end

      # Controlla collisione con nemico dopo il loro movimento
      if labirinto.nemico_a?(giocatore.riga, giocatore.colonna)
        giocatore.perdi_vita
        aggiungi_messaggio("⚔️  Un nemico ti ha colpito! (Vite: #{giocatore.vite})")
        return :sconfitta unless giocatore.vivo?
      end

      pulisci_schermo
      labirinto.disegna(giocatore)
      mostra_stato(giocatore, livello)
      mostra_messaggi

      print "\n> "
      input = gets.chomp.downcase.strip

      case input
      when "q"
        return :esci
      when "m"
        mostra_minimappa(labirinto, giocatore)
        next
      when "i"
        mostra_inventario(giocatore)
        next
      when "w", "a", "s", "d"
        risultato = esegui_movimento(giocatore, labirinto, input)
        return risultato if risultato == :completato || risultato == :sconfitta
      else
        aggiungi_messaggio("❓ Comando sconosciuto. Usa W/A/S/D, M, I o Q.")
      end
    end
  end

  def esegui_movimento(giocatore, labirinto, direzione)
    nuova_pos = giocatore.calcola_nuova_posizione(direzione)
    return nil unless nuova_pos

    nr, nc = nuova_pos

    # Muro
    if labirinto.muro?(nr, nc)
      aggiungi_messaggio(MESSAGGI_MURO.sample)
      return nil
    end

    # Porta
    if labirinto.porta?(nr, nc)
      if labirinto.porta_apribile?(nr, nc, giocatore)
        labirinto.apri_porta(nr, nc)
        giocatore.rimuovi_oggetto("chiave")
        giocatore.instance_variable_set(:@chiavi_usate, giocatore.chiavi_usate + 1)
        aggiungi_messaggio("🚪 Hai usato una chiave! La porta si apre.")
      else
        chiavi_mancanti = labirinto.chiavi_rimaste
        aggiungi_messaggio("🔒 Porta chiusa! Trova una chiave. (#{chiavi_mancanti} chiav#{chiavi_mancanti == 1 ? 'e' : 'i'} nel labirinto)")
        return nil
      end
    end

    # Uscita con chiavi necessarie
    if labirinto.uscita?(nr, nc) && labirinto.richiede_chiave?
      aggiungi_messaggio("🔒 L'uscita è sigillata! Raccogli tutte le chiavi.")
      return nil
    end

    # Nemico nella cella di destinazione
    if labirinto.nemico_a?(nr, nc)
      giocatore.perdi_vita
      aggiungi_messaggio("⚔️  Sei finito addosso a un nemico! (Vite: #{giocatore.vite})")
      return :sconfitta unless giocatore.vivo?
    end

    giocatore.sposta_a(nr, nc)
    @mosse_totali += 1

    # Cacca di Diana: sporca gli stivali ma non fa danno
    if labirinto.cacca_a?(nr, nc)
      labirinto.rimuovi_cacca(nr, nc)
      aggiungi_messaggio("💩 Eww! Hai calpestato una cacca di Diana. Gli stivali sono sporchi! 👢")
    end

    # Teletrasporto
    dest = labirinto.teletrasporto_a(nr, nc)
    if dest
      giocatore.sposta_a(dest[0], dest[1])
      aggiungi_messaggio("◎ WHOOSH! Teletrasportato!")
    end

    # Indizio
    indizio = labirinto.indizio_a(nr, nc)
    if indizio
      aggiungi_messaggio("💡 Indizio: #{indizio}")
      labirinto.rimuovi_indizio(nr, nc)
    end

    # Oggetti
    oggetto = labirinto.oggetto_a(nr, nc)
    gestisci_oggetto(giocatore, labirinto, oggetto, nr, nc) if oggetto

    return :sconfitta unless giocatore.vivo?

    # Uscita
    if labirinto.uscita?(giocatore.riga, giocatore.colonna) && !labirinto.richiede_chiave?
      bonus = [200 - giocatore.mosse, 0].max
      giocatore.aggiungi_punti(bonus)
      @punteggio_totale += giocatore.punti
      aggiungi_messaggio("🚪 Hai trovato l'uscita! Bonus velocità: +#{bonus}")
      pulisci_schermo
      labirinto.disegna(giocatore)
      mostra_stato(giocatore, @livello_corrente)
      mostra_messaggi
      return :completato
    end

    nil
  end

  def gestisci_oggetto(giocatore, labirinto, oggetto, riga, colonna)
    case oggetto
    when :moneta
      giocatore.aggiungi_punti(10)
      giocatore.instance_variable_set(:@monete_raccolte, giocatore.monete_raccolte + 1)
      labirinto.rimuovi_oggetto(riga, colonna)
      aggiungi_messaggio("💰 Moneta! +10 punti (Totale: #{giocatore.punti})")
    when :chiave
      giocatore.raccogli("chiave")
      labirinto.rimuovi_oggetto(riga, colonna)
      chiavi = giocatore.conta_oggetti("chiave")
      aggiungi_messaggio("🔑 Chiave trovata! (Chiavi: #{chiavi})")
    when :trappola
      giocatore.perdi_vita
      labirinto.rimuovi_oggetto(riga, colonna)
      if giocatore.vivo?
        aggiungi_messaggio("☠️  TRAPPOLA! -1 vita (Rimaste: #{giocatore.vite})")
      else
        aggiungi_messaggio("💀 La trappola ti ha ucciso!")
      end
    when :pozione
      if giocatore.vite < 5
        giocatore.guadagna_vita
        aggiungi_messaggio("💊 Pozione! +1 vita (Vite: #{giocatore.vite})")
      else
        giocatore.aggiungi_punti(25)
        aggiungi_messaggio("💊 Vita al massimo! +25 punti bonus")
      end
      labirinto.rimuovi_oggetto(riga, colonna)
    when :gemma
      giocatore.aggiungi_punti(50)
      labirinto.rimuovi_oggetto(riga, colonna)
      aggiungi_messaggio("💎 GEMMA! +50 punti! (Totale: #{giocatore.punti})")
    end
  end

  def mostra_inventario(giocatore)
    puts
    puts "┌─── 🎒 INVENTARIO ────────────────────┐"
    if giocatore.inventario.empty?
      puts "│  (vuoto)                              │"
    else
      # Usa group_by e map per mostrare oggetti raggruppati
      conteggio = giocatore.inventario.group_by { |o| o }
      conteggio.each do |nome, lista|
        puts "│  #{nome}: x#{lista.length}".ljust(41) + "│"
      end
    end
    puts "│                                       │"
    puts "│  Statistiche:                          │"
    puts "│    Monete raccolte: #{giocatore.monete_raccolte}".ljust(41) + "│"
    puts "│    Chiavi usate:    #{giocatore.chiavi_usate}".ljust(41) + "│"
    puts "│    Mosse:           #{giocatore.mosse}".ljust(41) + "│"
    puts "└───────────────────────────────────────┘"
    puts "\nPremi INVIO per continuare..."
    gets
  end

  def mostra_minimappa(labirinto, giocatore)
    # Mostra tutta la mappa rivelata (senza nebbia) come panoramica
    puts "\n┌─── 🗺️  MAPPA ESPLORATA ─────────────────┐"
    puts "│ Legenda: ☺=Tu  ⚑=Uscita  ✦=Chiave       │"
    puts "│ ●=Moneta ◆=Gemma ♥=Pozione ▒=Porta       │"
    puts "│ ⚆=Diana  ⚈=Lola  ·=Cacca               │"
    puts "│ ◎=Portale ☠=Trappola ⚉=Nemico ?=Indizio  │"
    puts "└───────────────────────────────────────────┘"
    labirinto.disegna(giocatore)
    puts "\nPremi INVIO per continuare..."
    gets
  end

  def mostra_stato(giocatore, livello)
    vite_testo = ("❤️ " * giocatore.vite) + ("🖤 " * ([5 - giocatore.vite, 0].max))
    livello_info = Labirinto.livelli[livello]
    nome_liv = livello_info ? livello_info[:nome] : "???"

    puts "┌───────────────────────────────────────────────────────┐"
    puts "│ 👤 #{giocatore.nome.ljust(16)} #{nome_liv.ljust(20)} Liv #{livello + 1}/#{Labirinto.livelli.length} │"
    puts "│ #{vite_testo.ljust(38)} Mosse: #{giocatore.mosse.to_s.ljust(5)}│"
    puts "│ 💰 #{giocatore.punti.to_s.ljust(6)} punti    🔑 x#{giocatore.conta_oggetti('chiave')}                          │"
    puts "└───────────────────────────────────────────────────────┘"
  end

  def mostra_messaggi
    return if @messaggi_log.empty?
    # Mostra solo gli ultimi 3 messaggi
    ultimi = @messaggi_log.last(3)
    ultimi.each { |m| puts "  #{m}" }
  end

  def aggiungi_messaggio(msg)
    @messaggi_log << msg
    # Teniamo solo gli ultimi 10 messaggi per non usare troppa memoria
    @messaggi_log.shift if @messaggi_log.length > 10
  end

  def mostra_vittoria_finale(nome)
    puts
    puts "╔══════════════════════════════════════════════╗"
    puts "║  🏆 CONGRATULAZIONI, #{nome.ljust(22)}🏆  ║"
    puts "║                                              ║"
    puts "║  Hai completato tutti e 4 i labirinti!        ║"
    puts "║  Punteggio totale: #{@punteggio_totale.to_s.ljust(25)}║"
    puts "║  Mosse totali:     #{@mosse_totali.to_s.ljust(25)}║"
    puts "║                                              ║"
    puts "║  Sei un vero esploratore di labirinti! 🗺️     ║"
    puts "╚══════════════════════════════════════════════╝"
  end

  def mostra_punteggio_finale(nome)
    puts
    puts "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    puts " Grazie per aver giocato, #{nome}!"
    puts " Punteggio finale: #{@punteggio_totale}"
    puts " Mosse totali:     #{@mosse_totali}"
    puts " Livelli superati: #{@livello_corrente}/#{Labirinto.livelli.length}"
    puts "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
  end

  def pulisci_schermo
    system(RUBY_PLATFORM =~ /win|mingw/ ? "cls" : "clear")
  end
end

# ── AVVIO ─────────────────────────────────────────────────────
# Senza argomenti: gioca ai livelli predefiniti (livelli/)
# Con un argomento:  ruby labirinto.rb miei_livelli/
#   → gioca ai livelli nella cartella specificata

directory = ARGV[0] || File.join(File.dirname(__FILE__), "livelli")
Labirinto.carica_da_directory(directory)
GiocoLabirinto.new.avvia
