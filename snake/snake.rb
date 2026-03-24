#!/usr/bin/env ruby

# Snake! 🐍
# ==========
# Un gioco classico per imparare Ruby!
#
# COMANDI:
#   Frecce ← ↑ → ↓  = muovi il serpente
#   Q                = esci dal gioco
#
# OBIETTIVO:
#   Mangia il cibo ($) per crescere e fare punti!
#   Non sbattere contro i muri (#) o contro te stesso!
#
# ============================================================================
# CONCETTI RUBY IN QUESTO FILE:
#
# 1.  require / Gemfile  — usare librerie esterne (la gemma "curses")
# 2.  Struct             — creare mini-oggetti per raggruppare dati
# 3.  Simboli            — :su, :giu, :sinistra, :destra
# 4.  Costanti           — valori MAIUSCOLI che non cambiano mai
# 5.  case/when          — scegliere tra molte opzioni (meglio di tanti if)
# 6.  Array come coda    — push (aggiungi in fondo) e shift (togli davanti)
# 7.  rand               — numeri casuali
# 8.  Hash               — dizionario chiave → valore (corpo_pos)
# 9.  freeze             — "congelare" un oggetto così non può essere modificato
# 10. Curses             — libreria per giochi nel terminale (senza Thread!)
# ============================================================================

require "curses"

# ****************************************************************************
# IMPOSTAZIONI DEL GIOCO — MODIFICA QUI! 🎮
# ****************************************************************************
# Prova a cambiare questi numeri e rilancia il gioco per vedere cosa succede!
#
# LARGHEZZA e ALTEZZA: le dimensioni del campo di gioco (in caratteri).
# Più grande = più spazio, più facile. Più piccolo = più difficile!
LARGHEZZA = 32
ALTEZZA   = 18

# VELOCITA: quanto è veloce il serpente all'inizio.
# Numero GRANDE = serpente LENTO (facile)
# Numero PICCOLO = serpente VELOCE (difficile)
# Prova: 300 (lumaca), 200 (normale), 120 (veloce), 80 (impossibile!)
VELOCITA = 250

# VELOCITA_MINIMA: la velocità massima che il serpente può raggiungere.
# Non scenderà mai sotto questo numero, anche con tanti punti.
VELOCITA_MINIMA = 80

# PUNTI_PER_CIBO: quanti punti guadagni ogni volta che mangi il cibo.
# Prova 10 (normale), 50 (tanti punti!), 1 (modalità difficile)
PUNTI_PER_CIBO = 10

# AUMENTO_VELOCITA: di quanto accelera il serpente ogni volta che mangi.
# Numero GRANDE = diventa veloce subito. Numero PICCOLO = accelera piano.
# Prova: 1 (quasi niente), 3 (normale), 10 (diventa pazzo!)
AUMENTO_VELOCITA = 3

# LUNGHEZZA_INIZIALE: di quanti pezzi è lungo il serpente all'inizio.
# Prova: 1 (cortissimo), 3 (normale), 10 (già lungo!)
LUNGHEZZA_INIZIALE = 3

# SIMBOLO_TESTA, SIMBOLO_CORPO, SIMBOLO_CIBO, SIMBOLO_MURO:
# I caratteri usati per disegnare il gioco. Puoi cambiarli!
# Prova: "@" per la testa, "*" per il corpo, "♥" per il cibo...
SIMBOLO_TESTA = "O"
SIMBOLO_CORPO = "o"
SIMBOLO_CIBO  = "$"
SIMBOLO_MURO  = "#"
# ****************************************************************************

# --------------------------------------------------------------------------
# Struct: un modo veloce per creare una "mini-classe" con attributi.
# Punto ha due campi: x (colonna) e y (riga).
# Lo usi così: Punto.new(5, 3) → un punto alla colonna 5, riga 3
# --------------------------------------------------------------------------
Punto = Struct.new(:x, :y)

class Snake
  # freeze: "congela" questo Hash. Se qualcuno prova a modificarlo → errore!
  # Utile per proteggere dati importanti da modifiche accidentali.
  OPPOSTI = {
    su:       :giu,
    giu:      :su,
    sinistra: :destra,
    destra:   :sinistra
  }.freeze

  def initialize
    # Il serpente inizia al centro della mappa
    centro_x = LARGHEZZA / 2
    centro_y = ALTEZZA / 2

    # Crea il corpo del serpente lungo LUNGHEZZA_INIZIALE pezzi
    @corpo = (0...LUNGHEZZA_INIZIALE).map do |i|
      Punto.new(centro_x - LUNGHEZZA_INIZIALE + 1 + i, centro_y)
    end

    @direzione = :destra    # Simbolo: un nome fisso, leggero e veloce
    @punteggio = 0
    @game_over = false
    @velocita  = VELOCITA

    genera_cibo
  end

  # Il metodo principale: avvia curses, gioca, e poi pulisce tutto
  def gioca
    setup_curses
    game_loop
  ensure
    # ensure: questo codice viene eseguito SEMPRE, anche se c'è un errore.
    # Importantissimo! Senza questo il terminale resterebbe "rotto".
    Curses.close_screen
  end

  private

  # --------------------------------------------------------------------------
  # SETUP: prepara lo schermo del terminale per il gioco
  # --------------------------------------------------------------------------
  def setup_curses
    Curses.init_screen     # Attiva la modalità curses (schermo pieno)
    Curses.curs_set(0)     # Nascondi il cursore lampeggiante
    Curses.noecho          # Non mostrare i tasti premuti sullo schermo
    Curses.cbreak          # Leggi i tasti subito (senza aspettare Invio)
    Curses.stdscr.keypad(true)   # Abilita i tasti speciali (frecce!)
    Curses.stdscr.nodelay = true  # NON aspettare un tasto — continua subito
    #                               ^^^^^^^^^^^^^^^^^^^^^^^^
    #                               Questo è il trucco! Senza Thread!
    #                               nodelay fa sì che getch() ritorni subito
    #                               anche se nessun tasto è stato premuto.

    # Attiva i colori se il terminale li supporta
    if Curses.has_colors?
      Curses.start_color
      Curses.init_pair(1, Curses::COLOR_GREEN, Curses::COLOR_BLACK)   # serpente
      Curses.init_pair(2, Curses::COLOR_RED, Curses::COLOR_BLACK)     # cibo
      Curses.init_pair(3, Curses::COLOR_CYAN, Curses::COLOR_BLACK)    # muri
      Curses.init_pair(4, Curses::COLOR_YELLOW, Curses::COLOR_BLACK)  # punteggio
    end
  end

  # --------------------------------------------------------------------------
  # GAME LOOP: il cuore del gioco. Ripete: leggi input → aggiorna → disegna
  # Niente Thread! Tutto in un unico ciclo, semplice e chiaro.
  # --------------------------------------------------------------------------
  def game_loop
    until @game_over
      leggi_input
      aggiorna
      disegna
      sleep(@velocita / 1000.0)  # pausa tra un frame e l'altro
    end

    schermata_game_over
  end

  # --------------------------------------------------------------------------
  # INPUT: leggi quale tasto è stato premuto
  # --------------------------------------------------------------------------
  def leggi_input
    # getch: legge UN tasto. Con nodelay=true, se nessun tasto è premuto
    # ritorna nil subito (non si blocca ad aspettare!)
    tasto = Curses.stdscr.getch

    # case/when: come un if/elsif, ma più bello per confronti multipli.
    # Confronta 'tasto' con ogni valore dopo 'when'.
    nuova = case tasto
            when Curses::KEY_UP    then :su
            when Curses::KEY_DOWN  then :giu
            when Curses::KEY_LEFT  then :sinistra
            when Curses::KEY_RIGHT then :destra
            when "q", "Q" then @game_over = true; return
            end

    # Cambia direzione solo se è valida e non è l'opposto
    # (il serpente non può fare inversione a U — si mangerebbe!)
    if nuova && nuova != OPPOSTI[@direzione]
      @direzione = nuova
    end
  end

  # --------------------------------------------------------------------------
  # LOGICA: muovi il serpente, controlla collisioni, mangia il cibo
  # --------------------------------------------------------------------------
  def aggiorna
    return if @game_over

    testa = @corpo.last  # .last = ultimo elemento = la testa del serpente

    # Calcola la nuova posizione della testa in base alla direzione
    nuova_testa = case @direzione
                  when :su       then Punto.new(testa.x, testa.y - 1)
                  when :giu      then Punto.new(testa.x, testa.y + 1)
                  when :sinistra then Punto.new(testa.x - 1, testa.y)
                  when :destra   then Punto.new(testa.x + 1, testa.y)
                  end

    # Collisione con i muri? Game over!
    if nuova_testa.x <= 0 || nuova_testa.x >= LARGHEZZA - 1 ||
       nuova_testa.y <= 0 || nuova_testa.y >= ALTEZZA - 1
      @game_over = true
      return
    end

    # Collisione con se stesso? Game over!
    if @corpo.any? { |p| p.x == nuova_testa.x && p.y == nuova_testa.y }
      @game_over = true
      return
    end

    # ---- Array come coda (queue) ----
    # push: aggiunge un elemento IN FONDO all'array (la nuova testa)
    @corpo.push(nuova_testa)

    if nuova_testa.x == @cibo.x && nuova_testa.y == @cibo.y
      # Ha mangiato! NON togliamo la coda → il serpente CRESCE di 1
      @punteggio += PUNTI_PER_CIBO
      # Più punti fai, più veloce diventa (ma non sotto VELOCITA_MINIMA!)
      @velocita = [VELOCITA - (@punteggio * AUMENTO_VELOCITA / PUNTI_PER_CIBO), VELOCITA_MINIMA].max
      genera_cibo
    else
      # shift: toglie il PRIMO elemento dell'array (la punta della coda)
      # Così il serpente "si sposta" senza crescere.
      #
      #   prima:  [coda, corpo, corpo, testa]
      #   push:   [coda, corpo, corpo, testa, NUOVA_TESTA]
      #   shift:  [corpo, corpo, testa, NUOVA_TESTA]  ← si è spostato!
      @corpo.shift
    end
  end

  # --------------------------------------------------------------------------
  # CIBO: metti il cibo in una posizione casuale
  # --------------------------------------------------------------------------
  def genera_cibo
    loop do
      # rand(1...N): numero casuale tra 1 e N-1 (il ... esclude l'ultimo)
      @cibo = Punto.new(rand(1...LARGHEZZA - 1), rand(1...ALTEZZA - 1))
      # Controlla che il cibo non finisca SOPRA il serpente
      break unless @corpo.any? { |p| p.x == @cibo.x && p.y == @cibo.y }
    end
  end

  # --------------------------------------------------------------------------
  # DISEGNO: mostra il campo di gioco sullo schermo
  # --------------------------------------------------------------------------
  def disegna
    win = Curses.stdscr

    # Riga del punteggio in alto
    win.setpos(0, 0)
    win.attron(Curses.color_pair(4) | Curses::A_BOLD) do
      win.addstr(" SNAKE! ".ljust(LARGHEZZA))
    end
    win.setpos(0, 10)
    win.attron(Curses.color_pair(4)) do
      win.addstr("Punti: #{@punteggio}   Lunghezza: #{@corpo.size}")
    end

    # --------------------------------------------------------------------------
    # Hash: un dizionario che associa una chiave a un valore.
    # Qui usiamo le coordinate [x,y] come chiave → true come valore.
    # Così per sapere se il serpente occupa una cella basta chiedere al Hash!
    # Molto più veloce che scorrere tutto l'array con .any? ad ogni cella.
    # --------------------------------------------------------------------------
    corpo_pos = {}
    @corpo.each { |p| corpo_pos[[p.x, p.y]] = true }
    testa = @corpo.last

    # Disegna il campo riga per riga
    ALTEZZA.times do |y|
      win.setpos(y + 1, 0)  # +1 perché la riga 0 è il punteggio

      LARGHEZZA.times do |x|
        if y == 0 || y == ALTEZZA - 1 || x == 0 || x == LARGHEZZA - 1
          # Muri
          win.attron(Curses.color_pair(3) | Curses::A_BOLD) { win.addstr(SIMBOLO_MURO) }

        elsif x == testa.x && y == testa.y
          # Testa del serpente
          win.attron(Curses.color_pair(1) | Curses::A_BOLD) { win.addstr(SIMBOLO_TESTA) }

        elsif corpo_pos[[x, y]]
          # Corpo del serpente
          win.attron(Curses.color_pair(1)) { win.addstr(SIMBOLO_CORPO) }

        elsif @cibo.x == x && @cibo.y == y
          # Cibo
          win.attron(Curses.color_pair(2) | Curses::A_BOLD) { win.addstr(SIMBOLO_CIBO) }

        else
          win.addstr(" ")
        end
      end
    end

    # Istruzioni in basso
    win.setpos(ALTEZZA + 1, 0)
    win.addstr(" Frecce: muovi  |  Q: esci".ljust(LARGHEZZA))

    # refresh: manda tutto quello che abbiamo disegnato allo schermo
    # Curses raccoglie tutti i cambiamenti e li mostra in un colpo solo
    # → niente sfarfallio!
    win.refresh
  end

  # --------------------------------------------------------------------------
  # GAME OVER: schermata finale
  # --------------------------------------------------------------------------
  def schermata_game_over
    win = Curses.stdscr

    # Aspetta che nodelay si disattivi per leggere un tasto finale
    win.nodelay = false

    messaggio = [
      "",
      "  ========================",
      "      GAME OVER!",
      "",
      "    Punteggio: #{@punteggio}",
      "    Lunghezza: #{@corpo.size}",
      "",
    ]

    # Messaggino simpatico in base al punteggio
    messaggio << if @punteggio >= 200
                   "    Sei un CAMPIONE! :D"
                 elsif @punteggio >= 100
                   "    Grande! Molto bravo!"
                 elsif @punteggio >= 50
                   "    Bene! Continua cosi!"
                 else
                   "    Riprova, migliorerai!"
                 end

    messaggio << ""
    messaggio << "  ========================"
    messaggio << ""
    messaggio << "  Premi un tasto per uscire"

    # Mostra il messaggio al centro dello schermo
    start_y = (ALTEZZA - messaggio.size) / 2
    messaggio.each_with_index do |riga, i|
      win.setpos(start_y + i + 1, 2)
      win.attron(Curses.color_pair(4) | Curses::A_BOLD) do
        win.addstr(riga)
      end
    end

    win.refresh
    win.getch  # Aspetta un tasto prima di uscire
  end
end

# Avvia il gioco!
Snake.new.gioca
