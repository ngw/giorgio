# Capitolo 7 — Installare e avviare l'app su Debian (Chromebook)

I Chromebook moderni permettono di aprire un terminale Linux (Debian)
direttamente dentro Chrome OS — si chiama **Linux sul Chromebook** o "Crostini".
È perfetto per imparare a programmare!

## 1. Abilitare Linux sul Chromebook

1. Clicca sull'orologio in basso a destra → ⚙️ **Impostazioni**
2. Cerca **"Linux"** nella barra di ricerca
3. Clicca **Attiva** accanto a "Ambiente Linux (Beta)"
4. Segui le istruzioni — ci vuole qualche minuto
5. Al termine si aprirà una finestra terminale nera: è il tuo Linux!

## 2. Aggiornare i pacchetti

Nel terminale Linux digita sempre prima questo — assicura che tutto sia aggiornato:

```bash
sudo apt update && sudo apt upgrade -y
```

> `sudo` significa "fammi fare questa cosa da amministratore".
> `apt` è il negozio di programmi di Debian.

## 3. Installare le dipendenze di base

```bash
sudo apt install -y git curl build-essential libssl-dev libreadline-dev \
  zlib1g-dev libyaml-dev libffi-dev
```

Queste librerie servono a Ruby per compilarsi e funzionare bene.

## 4. Installare Ruby con rbenv

`rbenv` è un gestore di versioni Ruby — ci permette di avere la versione
giusta senza toccare Ruby di sistema.

```bash
# Scarica rbenv
git clone https://github.com/rbenv/rbenv.git ~/.rbenv

# Aggiungi rbenv al PATH (lo fa trovare dal terminale)
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
source ~/.bashrc

# Scarica ruby-build (plugin per installare versioni Ruby)
git clone https://github.com/rbenv/ruby-build.git \
  "$(rbenv root)"/plugins/ruby-build
```

Ora installa Ruby 3.3.7 (può volerci qualche minuto):

```bash
rbenv install 3.3.7
rbenv global 3.3.7
```

Verifica che funzioni:

```bash
ruby --version
# → ruby 3.3.7 ...
```

## 5. Installare Bundler

```bash
gem install bundler
```

`gem` è il gestore di pacchetti Ruby (come `apt` ma per Ruby).
`bundler` legge il `Gemfile` e installa le librerie giuste.

## 6. Copiare il progetto

### Opzione A — se il progetto è su GitHub

```bash
git clone https://github.com/ngw/giorgio.git
cd giorgio/forza4
```

### Opzione B — copia manuale dal Chromebook

I file Linux si trovano in **File → Linux** nel gestore file di Chrome OS.
Puoi trascinarci la cartella `forza4` dall'esterno.

```bash
cd ~/forza4      # oppure il percorso dove hai copiato i file
```

## 7. Installare le gemme del progetto

```bash
bundle install
```

Vedrai scorrere nomi di librerie — è normale!

## 8. Avviare il server

```bash
bundle exec ruby app.rb
```

Se tutto va bene vedrai qualcosa come:

```
== Sinatra (v4.x.x) has taken the stage on 4567 for development ...
```

## 9. Aprire il gioco nel browser

Apri **Chrome** sul Chromebook e vai a:

```
http://localhost:4567
```

Chrome OS "vede" il server Linux come se fosse sulla stessa macchina,
quindi `localhost` funziona direttamente!

## 10. Far giocare un amico sulla stessa rete WiFi

Se il tuo amico è connesso alla **stessa rete WiFi**, puoi fargli aprire
il gioco senza deploy su Render.

Devi trovare l'indirizzo IP del tuo Chromebook:

```bash
hostname -I
```

Otterrai qualcosa come `100.115.92.205`. Il tuo amico dovrà aprire:

```
http://100.115.92.205:4567
```

> **Nota:** questo funziona solo sulla stessa rete locale (casa, scuola…).
> Per giocare da Internet serve il deploy su Render — vedi il [README](../README.md).

## Riavviare il server

Quando chiudi il terminale il server si ferma. Per riavviarlo:

```bash
cd ~/giorgio/forza4   # o dove hai i file
bundle exec ruby app.rb
```

## Riepilogo comandi

| Cosa fare | Comando |
|-----------|---------|
| Aggiornare Debian | `sudo apt update && sudo apt upgrade -y` |
| Installare Ruby | `rbenv install 3.3.7 && rbenv global 3.3.7` |
| Installare gemme | `bundle install` |
| Avviare il gioco | `bundle exec ruby app.rb` |
| Trovare l'IP | `hostname -I` |

---

[← Il codice del gioco](05_il_codice.md) | [← Torna all'indice](README.md)
