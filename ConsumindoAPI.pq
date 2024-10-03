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
                    )[status] = "ERROR" then "Verificar se o CNPJ foi digitado corretamente!"
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
                "Por favor, verificar sua conexão!",

        // Convertendo Record para tabela
        #"Convertido para Tabela" = Record.ToTable(RetornoApi),
        
        // Transpondo linhas para colunas
        #"Tabela Transposta" = Table.Transpose(#"Convertido para Tabela"),

        // Promovendo cabeçarios
        #"Cabeçalhos Promovidos" = Table.PromoteHeaders(#"Tabela Transposta", [PromoteAllScalars=true]),

        // Expandindo sócios, como onde temos nome e atividade dos Sócios. Sendo assim, cada sócio em uma linha.
        #"qsa Expandido" = Table.ExpandListColumn(#"Cabeçalhos Promovidos", "qsa"),

        // Por fim, expandindo os dados dos Record 'qsa' (Quadro societário)
        #"qsa Expandido1" = Table.ExpandRecordColumn(#"qsa Expandido", "qsa", {"nome", "qual"}, {"Nome Sócio", "Atividade Sócio"})

    in
        #"qsa Expandido1"