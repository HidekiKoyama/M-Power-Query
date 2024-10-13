// API Publica do IBGE com lista e informações de todas as localidades do Brasil.

let
    API_IBGE = "https://servicodados.ibge.gov.br/api/v1/"

    // Tentando se conectar a API
    ,RetornoAPI = 
    try
        Json.Document(
            Web.Contents(API_IBGE, /*link da API*/ 
                [
                    RelativePath = "localidades/distritos"
                    ,Query = [] /* Filtros do seu request, se houver.*/
                ])
            )
    otherwise
        null

    /*
    Transformando o retorno "Record" em tabela, 
    Caso seja bem sucedido o request da API
    */ 
    , Result = 
        if RetornoAPI = null then

            "Erro ao tentar acessar API"
            
        else 
        
            Table.FromRecords(RetornoAPI)

    /* Adicionando coluna com o nome do Municipio e estado */
    , AddColumn = 
        Table.ExpandRecordColumn(
            Table.ExpandRecordColumn(
                Table.ExpandRecordColumn(
                    Table.ExpandRecordColumn(
                        /* Tabela a qual quer expandir as colunas */
                        Result 
                        /* Coluna a qual quer expandir */
                        , "municipio" 
                        /* A lista das colunas que quer expandir */
                        , {"nome", "microrregiao"} 
                        /* E a lista de nome que dara para essas novas colunas.
                        Abaixo repito o processo mais algumas vezes, para diminuir etapas e adicionar apenas colunas desejadas*/
                        , {"Municípo", "microrregiao"})

                    ,"microrregiao"
                    
                    , {"nome", "mesorregiao"}
                    
                    , {"Estado", "mesorregiao"}
                    )
                ,"mesorregiao"
                , {"UF"}
                , {"UF"}
            )
            ,"UF"
            , {"sigla"}
            , {"Sigla da UF"}
        )
in
    AddColumn