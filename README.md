# Análise de sentimento com R aplicado a dados de uma pesquisa NPS
Esse projeto tem como objetivo analisar o texto e o sentimento de uma pesquisa de NPS e identificar o sentimento passado por promotores e detratores. As respostas são reais e foram coletadas no ano de 2018 a 2020. Foram retiradas das respostas qualquer identificação possível da empresa e de seus produtos. Para fazer as análises vamos utilizar a linguagem R e alguns pacotes da linguagem.

Análise de sentimento é algo que está em alta atualmente, muito se fala em analisar o sentimentos dos comentários recebidos pelas empresas. Saber se o cliente transmite por meio das palavras escritas um sentimento mais positivo ou negativo da sua marca é muito importante para a saúde da sua empresa.

Caso tenha interesse escrevi esse [artigo](https://medium.com/@rhany.marinho/an%C3%A1lise-de-sentimento-com-r-aplicado-a-dados-de-pesquisa-nps-363d315351f9) mostrando todos os passos realizados nessa análise.

## Pré-requisitos
Para executar o projeto, é necessário os seguintes programas:
- [R-4.0.4 ou superior](https://cran.r-project.org/)
- [RStudio](https://rstudio.com/products/rstudio/download/#download)

## Começando
Para utilizar o projeto é necessário clonar o projeto do GitHub num diretório de sua preferência:
```shell
cd "diretorio"
git clone https://github.com/rhanyele/analise-pesquisa-NPS
```

## Como rodar a aplicação
Para executar o projeto podemos abrir o arquivo ```analise-pesquisa-NPS.Rproj ```, ele é um arquivo que vai configurar as variáveis do RStudio para usar o caminho referencial como a pasta onde está o repositório. Também podemos abrir diretamente o arquivo ```Analise respostas.R``` porém teremos que configurar o caminho referencial para encontrarmos o nosso dataset.

Depois é necessário instalar alguns pacotes do repositório CRAN do R, para isso execute o comando abaixo dentro do RStudio:
```R
install.packages(c("tidyverse", "tm", "tidytext", "wordcloud", "lexiconPT"))
```
O comando irá baixar os pacotes e todas as dependências necessárias para a execução do projeto.

## Casos de Uso
As utilidades da análise de texto e de sentimento são inúmeras como:
- **Recrutamento e seleção**, podemos ter uma etapa onde a pessoa escreve sobre si, sobre suas vivencias ou sobre o porque ela merecer trabalhar na empresa, podemos analisar quais palavras mais se repetem e saber qual sentimento ela está transmitindo no texto.
- **Descoberta de novos nichos de mercados**, através da análise de texto podemos identificar necessidades não atendidas que podem ser alcançadas com determinado produto ou serviço.
- **Análise de comentários em redes sociais**, podemos identificar qual sentimento as pessoas tem em relação a uma postagem que a empresa faz nas redes sociais.
- **Análise de noticias**, podemos identificar qual sentimento aquela noticia mais transmite para nós.
- Entre outras utilidades.

## Melhorias futuras
Como melhoria futura no projeto podemos identificar erros ortográficos, de acentuação, abreviações e gírias a fim de corrigir e termos um sentimento mais próximo do real.

## Licença
The MIT License (MIT)

Copyright ©️ 2021 - Análise de sentimento com R aplicado a dados de uma pesquisa NPS
