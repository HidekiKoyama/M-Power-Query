// Criando uma funcao de parâmetro que busca dados de uma API e retorna os dados de um CNPJ

(CNPJ as text) => 
    let
        RetornoApi = 
            try
                if 
                Json.Document(
                        Web.Contents("https://receitaws.com.br", [
                            RelativePath = "/v1/cnpj/" & CNPJ,
                            Query =
                                [
                                    
                                ]
                        ])
                    )[status] = "ERROR" then "Verificar CNPJ"
                else
                  Json.Document(
                        Web.Contents("https://receitaws.com.br", [
                            RelativePath = "/v1/cnpj/" & CNPJ,
                            Query =
                                [
                                    
                                ]
                        ])
                    )  
            otherwise
                "Por favor, verificar sua conexão!"
    in
        RetornoApi