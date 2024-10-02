// Entendendo como funcionam funcoes recursivas com iteracao
let
    #"Lista pares" = 
            List.Generate(
                ()=> 10, 
                each _ > 1,
                each _ -2
            )
in
    #"Lista pares"