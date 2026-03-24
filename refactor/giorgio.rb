#!/usr/bin/env ruby

class GiorgioAvventura
  def initialize
    @player = nil
  end

  def gioca
    benvenuto
    capitolo_1_bivio
    capitolo_2_fiume
    capitolo_3_paese
    capitolo_4_citta
    capitolo_5_isola
    vittoria_finale
  end

  private

  def ask(question)
    puts question
    puts "___________________________________________________________________________"
    gets.chomp.downcase
  end

  def ask_scelta(question, opzioni)
    loop do
      risposta = ask(question)
      return risposta if opzioni.include?(risposta)

      puts "Scelta non valida. Opzioni: #{opzioni.join(', ')}"
    end
  end

  def benvenuto
    @player = ask("Come ti chiami giocatore? ")
    puts "Ciao #{@player}!"
    ask_scelta("Sei pronto per la tua avventura? ", %w[si yes])
  end

  def capitolo_1_bivio
    puts "Stavi correndo e hai perso la strada per casa."
    ask_scelta(
      "Devi scegliere tra due strade. Quale scegli, la prima o la seconda?",
      %w[prima seconda]
    )
  end

  def capitolo_2_fiume
    puts "Sei entrato in un bosco. C'è un fiume."
    ask_scelta("Cosa fai? Nuoti o torni indietro?", %w[nuoto torni])
    puts "Sei uscito dal bosco!"
  end

  def capitolo_3_paese
    puts "Ti sei trovato in un paese."
    puts "Devi scegliere tra Via Molino Vecchio o Via 4 Novembre."
    ask_scelta("Quale strada scegli?", ["molino vecchio", "4 novembre"])
    puts "Sei arrivato a casa!"
    puts "_________________________"
  end

  def capitolo_4_citta
    puts "Il giorno dopo sei andato al supermercato e sei scappato a casa."
    ask_scelta("Cosa fai, vai al bosco o in città?", %w[bosco citta])
    puts "Vedi la mamma dietro di te!"
    puts "Sei corso a casa e hai vinto il capitolo 2! (2/?)"
    puts "_____________________________________________________________________"
  end

  def capitolo_5_isola
    puts "Il giorno dopo sei andato al mare."
    puts "Hai nuotato troppo lontano e ti sei trovato su un'isola."
    ask_scelta("Costruisci una casa o una barca?", %w[casa barca])

    raccogli_legno
    costruisci
  end

  def raccogli_legno
    puts "Ti serve il legno. Distruggi un albero!"
    loop do
      risposta = ask("Premi 'd' 10 volte per distruggere l'albero:")
      break if risposta.size == 10

      puts "Non basta! Servono esattamente 10 caratteri."
    end
    puts "+ 20 legno"
  end

  def costruisci
    loop do
      risposta = ask("Per costruire metti 'c' 2 volte:")
      break if risposta.size == 2

      puts "Servono esattamente 2 caratteri."
    end
    puts "Costruita!"
    ask_scelta("Sei pronto a tornare a casa?", %w[si yes])
  end

  def vittoria_finale
    puts "Sei ritornato a casa dalla mamma!"
    puts "Gioco terminato, hai vinto 3/3! Complimenti #{@player}!"
  end
end

GiorgioAvventura.new.gioca
