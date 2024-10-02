// Criando uma funcao de parâmetro que busca dados de uma API e retorna os dados de um CNPJ

(CNPJ as text) => 
    let
        RetornoApi = 
            Json.Document(
                    Web.Contents("https://receitaws.com.br", [
                        RelativePath = "/v1/cnpj/" & CNPJ,
                        Query =
                            [
                                
                            ]
                    ])
                )
    in
        RetornoApi
