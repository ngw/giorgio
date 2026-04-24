require 'sinatra'
require 'securerandom'
require 'json'

ROWS  = 6
COLS  = 7
GAMES = {}
MUTEX = Mutex.new

configure do
  enable :sessions
  set :session_secret, ENV.fetch('SESSION_SECRET') { SecureRandom.hex(64) }
  set :bind, '0.0.0.0'
end

# ── Helpers ────────────────────────────────────────────────────────────────

def nuova_partita(giocatori = {})
  {
    'board'          => Array.new(ROWS) { Array.new(COLS, nil) },
    'giocatore'      => 1,
    'vincitore'      => nil,
    'celle_vincenti' => nil,
    'pareggio'       => false,
    'giocatori'      => giocatori   # { 1 => session_sid, 2 => session_sid }
  }
end

def inserisci_disco(board, col, giocatore)
  (ROWS - 1).downto(0) do |riga|
    if board[riga][col].nil?
      board[riga][col] = giocatore
      return riga
    end
  end
  nil
end

def trova_vincitore(board, riga, col, giocatore)
  [[0,1],[1,0],[1,1],[1,-1]].each do |dr, dc|
    celle = [[riga, col]]
    [1, -1].each do |s|
      i = 1
      loop do
        nr = riga + s * dr * i
        nc = col  + s * dc * i
        break unless nr.between?(0, ROWS - 1) && nc.between?(0, COLS - 1)
        break unless board[nr][nc] == giocatore
        celle << [nr, nc]
        i += 1
      end
    end
    return celle if celle.length >= 4
  end
  nil
end

def board_piena?(board)
  board[0].none?(&:nil?)
end

# ── Session ID ─────────────────────────────────────────────────────────────

before do
  session[:sid] ||= SecureRandom.hex(16)
end

# ── Lobby ───────────────────────────────────────────────────────────────────

get '/' do
  @errore = params[:errore]
  erb :lobby
end

post '/crea' do
  codice = SecureRandom.hex(3).upcase
  MUTEX.synchronize { GAMES[codice] = nuova_partita(1 => session[:sid]) }
  session[:codice] = codice
  session[:numero] = 1
  redirect "/gioca/#{codice}"
end

post '/unisciti' do
  codice  = params[:codice].to_s.strip.upcase
  errore  = nil
  numero  = nil

  MUTEX.synchronize do
    partita = GAMES[codice]
    if partita.nil?
      errore = 'Partita+non+trovata'
    elsif partita['giocatori'][1] == session[:sid]
      numero = 1
    elsif partita['giocatori'][2] == session[:sid]
      numero = 2
    elsif partita['giocatori'][2].nil?
      partita['giocatori'][2] = session[:sid]
      numero = 2
    else
      errore = 'Partita+già+piena'
    end
  end

  return redirect "/?errore=#{errore}" if errore
  session[:codice] = codice
  session[:numero] = numero
  redirect "/gioca/#{codice}"
end

# ── Gioco ───────────────────────────────────────────────────────────────────

# IMPORTANTE: questa route va PRIMA di /gioca/:codice/:col
post '/gioca/:codice/reset' do
  codice = params[:codice].upcase
  MUTEX.synchronize do
    partita = GAMES[codice]
    next unless partita
    next unless partita['giocatori'].values.include?(session[:sid])
    GAMES[codice] = nuova_partita(partita['giocatori'])
  end
  redirect "/gioca/#{codice}"
end

get '/gioca/:codice' do
  codice  = params[:codice].upcase
  partita = nil
  numero  = nil

  MUTEX.synchronize do
    partita = GAMES[codice]
    next unless partita

    if partita['giocatori'][1] == session[:sid]
      numero = 1
    elsif partita['giocatori'][2] == session[:sid]
      numero = 2
    elsif partita['giocatori'][2].nil?
      # prima visita tramite link condiviso → auto-assign P2
      partita['giocatori'][2] = session[:sid]
      numero = 2
    else
      numero = nil  # spettatore
    end
  end

  halt 404, 'Partita non trovata' unless partita
  session[:numero] = numero
  session[:codice] = codice if numero

  @codice     = codice
  @partita    = partita
  @mio_numero = numero
  @mio_turno  = numero &&
                !partita['vincitore'] &&
                !partita['pareggio'] &&
                partita['giocatore'] == numero
  @in_attesa  = numero &&
                !partita['vincitore'] &&
                !partita['pareggio'] &&
                !@mio_turno
  @attende_p2 = partita['giocatori'][2].nil?

  erb :gioco
end

# Polling JSON
get '/gioca/:codice/stato' do
  content_type :json
  codice  = params[:codice].upcase
  partita = MUTEX.synchronize { GAMES[codice] }
  halt 404 unless partita
  {
    giocatore: partita['giocatore'],
    vincitore: partita['vincitore'],
    pareggio:  partita['pareggio'],
    ha_p2:     !partita['giocatori'][2].nil?
  }.to_json
end

post '/gioca/:codice/:col' do
  codice     = params[:codice].upcase
  col        = params[:col].to_i
  mio_numero = session[:numero]

  MUTEX.synchronize do
    partita = GAMES[codice]
    next unless partita
    next if partita['vincitore'] || partita['pareggio']
    next unless partita['giocatore'] == mio_numero
    next unless partita['giocatori'][mio_numero] == session[:sid]
    next unless col.between?(0, COLS - 1)

    board = partita['board']
    riga  = inserisci_disco(board, col, mio_numero)
    if riga
      celle = trova_vincitore(board, riga, col, mio_numero)
      if celle
        partita['vincitore']      = mio_numero
        partita['celle_vincenti'] = celle
      elsif board_piena?(board)
        partita['pareggio'] = true
      else
        partita['giocatore'] = mio_numero == 1 ? 2 : 1
      end
    end
  end

  redirect "/gioca/#{codice}"
end
