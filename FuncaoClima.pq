// Entendendo conceito de condicionais no Power Query

(x as number) => 
    let 
        mensagem =
        
            if x <= 2 then Number.ToText(x) & " - " &"Frio"

            else if x >= 30 then Number.ToText(x) & " - " &"Calor"

            else Number.ToText(x) & " - " &"Ameno"
    in 
        mensagem