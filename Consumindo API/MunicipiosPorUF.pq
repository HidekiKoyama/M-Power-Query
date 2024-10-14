/*
    Mostrando todos os municipios de acordo com a UF do estado validando se a UF esta no cadastro da API
*/

(#"Parâmetro UF" as text) =>

let 
    // Pegando todas as UFs cadastradas
    UF = 
        let 
            data = 
                try
                    
                    Table.FromRecords(
                            Json.Document(Web.Contents("https://servicodados.ibge.gov.br/api/v1/localidades/estados"))
                        )[sigla]
                                            
                otherwise
                    null
        in
            data

    ,data = 
        //Verificando se a UF escolhida no parâmetro existe de no cadastro de Nossa API
        if List.Contains(UF, #"Parâmetro UF") then 
        
            try
                Json.Document(
                        Web.Contents(
                            
                            "https://servicodados.ibge.gov.br/api/v1/localidades/estados/" & #"Parâmetro UF" &"/municipios"
                            )
                        )
            otherwise

                null
        
        else

            "UF não existente!"

        , result = 

        if data = null then
        
            "Erro ao concultar API"
        
        else  
            let 
                tratamento = Table.FromRecords(data) 

            in tratamento
        

in result