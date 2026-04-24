# Capitolo 4 — HTML: come si fa una pagina web

## Cos'è HTML?

**HTML** significa *HyperText Markup Language* — un linguaggio per descrivere
la struttura di una pagina web.

Non è un linguaggio di programmazione (non fa calcoli),
ma è un linguaggio di **marcatura**: usi dei **tag** per dire al browser
"questa è un'intestazione", "questo è un paragrafo", "questo è un pulsante".

## I tag HTML

Un tag è una parola tra parentesi angolari `< >`.
Quasi tutti i tag hanno un'apertura e una chiusura:

```html
<p>Questo è un paragrafo.</p>
```

- `<p>` apre il tag "paragrafo"
- `</p>` lo chiude (nota la barra `/`)
- In mezzo c'è il contenuto

## Struttura base di una pagina

```html
<!DOCTYPE html>
<html lang="it">
  <head>
    <meta charset="UTF-8">
    <title>La mia prima pagina</title>
  </head>
  <body>
    <h1>Ciao Mondo!</h1>
    <p>Benvenuto nella mia pagina.</p>
  </body>
</html>
```

Ogni parte ha il suo scopo:

| Tag | Scopo |
|-----|-------|
| `<!DOCTYPE html>` | Dice al browser "questo è HTML moderno" |
| `<html>` | Contiene tutto il documento |
| `<head>` | Informazioni sulla pagina (titolo, stili…) |
| `<title>` | Il testo che appare nella linguetta del browser |
| `<body>` | Il contenuto visibile nella pagina |

## I tag più usati

### Intestazioni

```html
<h1>Titolo grandissimo</h1>
<h2>Titolo grande</h2>
<h3>Titolo medio</h3>
```

`h1` è il più importante (un solo h1 per pagina), `h6` il più piccolo.

### Paragrafi e testo

```html
<p>Questo è un paragrafo.</p>
<strong>Testo in grassetto</strong>
<em>Testo in corsivo</em>
```

### Link

```html
<a href="https://google.com">Vai su Google</a>
```

`href` è un **attributo**: aggiunge informazioni extra al tag.

### Immagini

```html
<img src="foto.jpg" alt="Una bella foto">
```

Il tag `img` non ha chiusura — si chiude da solo.
`alt` descrive l'immagine per chi non può vederla.

### Pulsanti e moduli

```html
<form action="/gioca/3" method="post">
  <button type="submit">Gioca nella colonna 3</button>
</form>
```

- `<form>` è il contenitore di un modulo
- `action` dice dove mandare i dati
- `method` dice come mandarli (`get` o `post`)
- `<button>` è il pulsante che l'utente preme

### Div — il contenitore universale

```html
<div class="tabellone">
  <!-- Qui dentro ci sono le celle -->
</div>
```

`<div>` è una scatola invisibile usata per raggruppare elementi
e applicarci stili CSS.

## Gli attributi `class` e `id`

Gli attributi `class` e `id` servono a "dare un nome" agli elementi
così puoi:
- **stilizzarli** con CSS
- **trovarli** con JavaScript

```html
<div class="cella disco p1"><!-- cerchio rosso --></div>
<div class="cella vuoto"><!-- cerchio vuoto --></div>
```

Più elementi possono avere la stessa `class`.
L'`id` invece è unico (un solo elemento per pagina).

## CSS — il vestito dell'HTML

HTML è lo scheletro, **CSS** è il vestito.
Con CSS decidi colori, dimensioni, posizioni:

```css
/* Tutte le celle del tabellone */
.cella {
  border-radius: 50%;   /* forma circolare */
  width: 70px;
  height: 70px;
}

/* Il disco del giocatore 1 */
.disco.p1 {
  background: red;
}
```

Il selettore `.disco.p1` significa
"gli elementi che hanno sia la classe `disco` che la classe `p1`".

## ERB — HTML con Ruby dentro

Nel progetto il server usa file `.erb` invece di `.html`.
ERB significa *Embedded Ruby*: puoi scrivere codice Ruby dentro l'HTML
usando i tag speciali `<% %>` e `<%= %>`:

```erb
<p>Turno del Giocatore <%= @partita['giocatore'] %></p>

<% if @partita['vincitore'] %>
  <p>Ha vinto il giocatore <%= @partita['vincitore'] %>!</p>
<% end %>
```

- `<%= espressione %>` — stampa il valore nella pagina
- `<% istruzione %>` — esegue codice Ruby senza stampare nulla

Quando il browser chiede la pagina, il server esegue il codice Ruby,
costruisce l'HTML definitivo e lo manda al client.

---

[← HTTP](03_http.md) | [Prossimo: Il codice del gioco →](05_il_codice.md)
