library(tidyverse)
library(tm)
library(tidytext)
library(wordcloud)
library(lexiconPT)

# Carrega os dados para iniciarmos as analises
pesquisa <- read_csv("dataset/Pesquisa NPS.csv")

# Visualiza os dados
pesquisa

# Verifica a quantidade de respostas por perfil
pesquisa %>%
  group_by(Perfil) %>%
  count(Perfil) 

# Tratamento das respostas para iniciarmos nossas analises
# Transforma o texto em minusculo
# Remove pontuação
# Remove números
# Remove as palavras mais frequentes (artigos, preposições,...)
# Remove os espaços excedentes
# Filtra o dataset para trazer apenas os valores que não são NA após o tratamento
pesquisa$Resposta <- tolower(pesquisa$Resposta)
pesquisa$Resposta <- removePunctuation(pesquisa$Resposta)
pesquisa$Resposta <- removeNumbers(pesquisa$Resposta)
pesquisa$Resposta <- removeWords(pesquisa$Resposta,c(stopwords("pt"), 'é'))
pesquisa$Resposta <- stripWhitespace(pesquisa$Resposta)
pesquisa <- pesquisa %>% filter(is.na(Resposta) == FALSE)

# Transformando as frases em palavras(tokens)
palavras <- pesquisa %>% 
  unnest_tokens(texto, Resposta) %>%
  select(texto, Perfil) %>%
  filter(is.na(texto) == FALSE)

# Identificando as palavras mais comuns
palavras %>% 
  count(texto) %>%
  arrange(desc(n))

# Grafico com as 20 palavras mais comuns 
palavras %>%
  count(texto) %>% 
  top_n(n = 20) %>% 
  ggplot(aes(reorder(texto, n), n)) +
  geom_linerange(aes(ymin = 0, ymax = n, x = reorder(texto, n)),
                 position = position_dodge(width = 0.2), size = 3,
                 color = '#5165C7') + 
  coord_flip() +
  labs(x = 'Top 20 palavras mais comuns', y = 'Contagem') +
  theme_minimal()

# Grafico de nuvem de palavras com as 30 palavras mais comuns
wordcloud(palavras$texto, 
          max.words = 30,
          color = '#5165C7')

# Grafico com as 20 palavras mais comuns promotores
palavras %>%
  filter(Perfil == 'Promoters') %>%
  count(texto) %>%
  top_n(n = 20) %>% 
  ggplot(aes(reorder(texto, n), n)) +
  geom_linerange(aes(ymin = 0, ymax = n, x = reorder(texto, n)),
                 position = position_dodge(width = 0.2), size = 3,
                 color = '#42FC67') + 
  coord_flip() +
  labs(x = 'Top 20 palavras mais comuns promotores', y = 'Contagem') +
  theme_minimal()

# Grafico com as 20 palavras mais comuns detratores
palavras %>%
  filter(Perfil == 'Detractors') %>%
  count(texto) %>%
  top_n(n = 20) %>% 
  ggplot(aes(reorder(texto, n), n)) +
  geom_linerange(aes(ymin = 0, ymax = n, x = reorder(texto, n)),
                 position = position_dodge(width = 0.2), size = 3,
                 color = '#FF2949') + 
  coord_flip() +
  labs(x = 'Top 20 palavras mais comuns detratores', y = 'Contagem') +
  theme_minimal()

# Pegando o sentimento de cada palavra
sentimento = palavras %>%
  inner_join(lexiconPT::oplexicon_v3.0, by = c('texto' = 'term')) %>%
  select(texto, Perfil, polarity)

# Grafico das palavras mais comuns por sentimento
sentimento %>% 
  group_by(polarity) %>% 
  count(texto) %>% 
  top_n(n = 10) %>% 
  ggplot(aes(reorder(texto, n), n)) +
  geom_linerange(aes(ymin = 0, ymax = n, x = reorder(texto, n)),
                 position = position_dodge(width = 0.2), size = 3,
                 color = '#5165C7') + 
  facet_wrap(~polarity, scales = "free") +
  coord_flip() +
  labs(x = 'Top 10 palavras por sentimento', y = 'Contagem') +
  theme_minimal()

# Grafico das palavras mais comuns por sentimento promotores
sentimento %>%
  filter(Perfil == 'Promoters') %>%
  group_by(polarity, Perfil) %>% 
  count(texto) %>% 
  top_n(n = 10) %>% 
  ggplot(aes(reorder(texto, n), n)) +
  geom_linerange(aes(ymin = 0, ymax = n, x = reorder(texto, n)),
                 position = position_dodge(width = 0.2), size = 3,
                 color = '#42FC67') + 
  facet_wrap(~polarity, scales = "free") +
  coord_flip() +
  labs(x = 'Top 10 palavras por sentimento promotores', y = 'Contagem') +
  theme_minimal()

# Grafico das palavras mais comuns por sentimento detratores
sentimento %>%
  filter(Perfil == 'Detractors') %>%
  group_by(polarity, Perfil) %>% 
  count(texto) %>% 
  top_n(n = 10) %>% 
  ggplot(aes(reorder(texto, n), n)) +
  geom_linerange(aes(ymin = 0, ymax = n, x = reorder(texto, n)),
                 position = position_dodge(width = 0.2), size = 3,
                 color = '#FF2949') + 
  facet_wrap(~polarity, scales = "free") +
  coord_flip() +
  labs(x = 'Top 10 palavras por sentimento detratores', y = 'Contagem') +
  theme_minimal()

# Média de sentimento por perfil
sentimentoTotal <- sentimento %>% 
  group_by(Perfil) %>% 
  summarise(mediaSentimento = mean(polarity)) 

# Grafico da média de sentimento por perfil
sentimentoTotal %>%
  group_by(Perfil) %>% 
  arrange(desc(mediaSentimento)) %>% 
  ggplot(aes(reorder(Perfil, mediaSentimento), mediaSentimento)) +
  geom_linerange(aes(ymin = 0, ymax = mediaSentimento, x = reorder(Perfil, mediaSentimento)),
                 position = position_dodge(width = 0.2), size = 3,
                 color = '#5165C7') +
  coord_flip() +
  labs(x = 'Sentimento por perfil', y = 'Contagem') +
  theme_minimal()
