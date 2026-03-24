#!/user/bin/env ruby
def pirla
  player = ask("come ti chiami giocatore? ")
  print "ciao #{player}"
  response = ask("sei pronto per la tua aventura? ")
  if ["yes", "si"].include?(response)
    puts "tu stavi correndo e hai perso la strada per casa"
    response = ask("dovevi scegliere tra due strade, quale strada scegli, la prima o la seconda?")
    if ["seconda", "prima"].include?(response)
      puts "sei entrato in un bosco, c'e' un fiume, cosa fai? nuoti o torni indietro?"
      response = ask("nuoti o torni?")
      if response == "nuoto"
        puts "sei uscito dal bosco "
        puts "e ti sei trovato in un paese dove devi scegliere tra via molino vecchio o via 4 novembre"
        response = ask("Quale strada scegli? ")
        if response == "molino vecchio"    
          puts "sei arivato a casa!"
          puts "_________________________"
          puts "il prossimo giorno sei andato al supermercato"
          puts "e sei scappato a casa"
          response = ask("cosa fai al bosco o in città?")
          if response == "citta"
            puts "vedi la mamma dietro di te"
            puts "sei corso a casa e hai vinto gioco_avventura:aventura giorgio! 2/?"    
            puts "_____________________________________________________________________"
            puts "il prossimo giorno"
            puts "sei andato al mare"
            puts "e hai nuotato troppo lontano"
            puts "e ti sei trovato su un'isola"
            puts "devi costuire una casa o costuire una barca"
            response = ask("Quale scegli? ")
            if ["casa", "barca"].include?(response)
              puts "ti serve il legno"
              puts "ditruggi un albero"
              puts "premi d 10 volte per distruggere l'albero"
              response = gets.chomp
              if response.size == 10
                puts "+ 20 legno"
                response = ask("per costuire metti c 2 volte")
                if response.size == 2
                  puts "costuito casa!"
                  response = ask("sei pronto a andare a casa? ")
                  if ["si", "yes"].include?(response)
                    puts "sei ritornato! (mamma)"
                    puts "gioco terminato, hai vinto 3/3"
                  end
                end
              end
            end
          end
        end
      end 
    end
  end
end

def ask(question)
  puts question
  puts "___________________________________________________________________________"
  gets.chomp.downcase
end

pirla