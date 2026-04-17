# 🗂️ Git – Il Salvatore del Codice

Immagina di scrivere un libro. Ogni tanto vuoi salvare una versione per poter
tornare indietro se sbagli qualcosa. **Git** fa esattamente questo con il codice!

---

## 🤔 Cos'è Git?

Git è un programma che **ricorda ogni versione** del tuo codice.

- Hai scritto qualcosa che funzionava? Git lo ricorda.
- Hai rotto tutto? Git ti riporta alla versione che funzionava!
- Stai lavorando con qualcun altro? Git mette insieme i cambiamenti di tutti.

---

## 🗺️ I tre posti dove vive il tuo codice

```
Il tuo computer          Internet (GitHub)
┌─────────────────┐      ┌──────────────────┐
│  📁 Cartella    │ push │  ☁️  Repository   │
│  (workspace)    │ ───► │  (copia online)   │
│                 │      │                  │
│  📦 Staging    │ pull │                  │
│  (pronti)      │ ◄─── │                  │
│                 │      │                  │
│  📚 History    │      │                  │
│  (commit fatti) │      │                  │
└─────────────────┘      └──────────────────┘
```

- **Workspace** – la cartella con i file che stai modificando
- **Staging** – i file che hai "preparato" per il prossimo salvataggio
- **History** – tutti i salvataggi fatti finora (i *commit*)
- **GitHub** – la copia online, accessibile da qualsiasi computer

---

## 📋 I Comandi di Base

### Vedere cosa è cambiato

```bash
git status
```

Ti dice quali file hai modificato. I file in rosso non sono ancora pronti,
quelli in verde sono pronti per essere salvati.

---

### Preparare i file per il salvataggio

```bash
git add nomefile.rb        # prepara un file specifico
git add .                  # prepara TUTTI i file modificati
```

`git add` è come mettere i documenti in una busta prima di spedirla.

---

### Salvare (fare un commit)

```bash
git commit -m "Ho aggiunto il punteggio"
```

Il messaggio dopo `-m` spiega **cosa hai fatto**. Scrivilo in modo chiaro,
come se lo dicessi a un amico:

```bash
# ✅ Buoni messaggi
git commit -m "Aggiungi classe Giocatore"
git commit -m "Correggi bug nella mappa del labirinto"
git commit -m "Aggiunge nuovo livello con trappole"

# ❌ Messaggi inutili
git commit -m "roba"
git commit -m "aaa"
git commit -m "modifica"
```

---

### Mandare il codice su GitHub

```bash
git push
```

Spedisce i tuoi commit su GitHub. Come premere "Invia" su una email!

---

### Scaricare i cambiamenti da GitHub

```bash
git pull
```

Scarica i cambiamenti che altri hanno caricato su GitHub.
Fallo sempre prima di iniziare a lavorare!

---

### Vedere la storia dei salvataggi

```bash
git log --oneline
```

Mostra tutti i commit fatti, dal più recente al più vecchio:

```
f450c5a Aggiungi Diana e Lola nel labirinto
819fbd5 Aggiungi livello 4 con nemici
3a7c210 Primo commit
```

---

## 🔄 Il Flusso di Ogni Giorno

Questo è quello che fai ogni volta che lavori al codice:

```
1.  git pull           ← scarica novità da GitHub

2.  ... modifica i file ...

3.  git status         ← controlla cosa hai cambiato

4.  git add .          ← prepara tutto

5.  git commit -m "..." ← salva con un messaggio

6.  git push           ← manda su GitHub
```

---

## 🆘 Errori Comuni

### "Nothing to commit"

```
nothing to commit, working tree clean
```

Non hai modificato nulla! Cambia qualcosa prima di fare `git commit`.

---

### "Please enter a commit message"

Git ha aperto un editor di testo strano. Premi `Esc`, poi scrivi `:q!` e premi
Invio per uscire. La prossima volta usa sempre `-m "..."` nel comando.

---

### Voglio annullare le mie modifiche (prima del commit)

```bash
git restore nomefile.rb
```

⚠️ **Attenzione**: questo butta via le modifiche per sempre! Usalo solo se sei
sicuro di non volerle più.

---

## 💡 Trucchi Utili

```bash
git diff              # vedi esattamente cosa hai cambiato riga per riga
git log --oneline -5  # mostra solo gli ultimi 5 commit
git status -s         # versione corta di git status
```

---

## 🎯 Riassunto

| Comando | Cosa fa |
|---------|---------|
| `git status` | Vedi cosa è cambiato |
| `git add .` | Prepara tutto per il salvataggio |
| `git commit -m "..."` | Salva con un messaggio |
| `git push` | Manda su GitHub |
| `git pull` | Scarica da GitHub |
| `git log --oneline` | Vedi la storia dei salvataggi |
