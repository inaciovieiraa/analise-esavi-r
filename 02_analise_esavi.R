# --- 02_analise_esavi.R ---
# Objetivo: Limpar a base bruta e gerar indicadores de farmacovigilância
# Autor: Inácio Vieira

library(tidyverse)

# 1. LIMPEZA DOS DADOS (ETL) --------------------------------------------------
# Objetivo: Transformar a base suja (base_esavi) em dados prontos para análise (base_limpa)

# Ajuste de Data (Corrigindo o "Hoje" da coluna "DATA" e mantendo as outras datas)
base_limpa <- base_esavi %>% 
  mutate(DATA_REAL = case_when(DATA == "Hoje" ~ "26/01/2026",
                               TRUE ~ DATA)) %>% 

#Removendo coluna de DATAS que acabei de alterar:
 
  select(-DATA) %>% 

#Separando dados de pacientes (Nome, Sexo e Idade estão na mesma coluna) e criando colunas próprias para cada dado:

  separate(col = PACIENTE,
           into = c("NOME", "SEXO", "IDADE_TEXTO"),
           sep = " \\| " ) %>% 
  
#Tirando a palavra "anos" da coluna de idade que acabei de criar:
  

  mutate(IDADE = str_remove(IDADE_TEXTO , "anos")) %>% 

#Convertendo a coluna de IDADE para dígitos numéricos:


  mutate(IDADE = as.numeric(IDADE)) %>% 

#Deixando os dados da coluna "FABRICANTE_SUJO" em caps lock para facilitar identificação:


  mutate(FABRICANTE_SUJO = str_to_upper(FABRICANTE_SUJO)) %>% 

#Padronizando o laboratório:

  mutate(FABRICANTE_REAL = case_when(str_detect(FABRICANTE_SUJO, "ALFA") ~ "LAB_ALFA",
                                     str_detect(FABRICANTE_SUJO, "BETA") ~ "LAB_BETA",
                                     str_detect(FABRICANTE_SUJO, "GAMA") ~"LAB_GAMA",
                                     TRUE ~ "OUTROS")) %>% 

#Identificando reações da vacina(Sim/Não):

  mutate(REACAO = if_else(
    condition = str_detect(RELATO, "Dor|DOR|dor|febre|Febre|mialgia|fadiga|vermelhidao|Vermelhidao"),
    true = "sim",
    false = "nao")) %>% 

#Deletando colunas sem utilidade:
  
  select(-IDADE_TEXTO, -FABRICANTE_SUJO ) %>% 
  
#Colocando a coluna "REACAO" em caps lock para facilitar a identificação:
  
  mutate(REACAO = str_to_upper(REACAO))


# 2. ANÁLISE E RELATÓRIO (KPIs) -----------------------------------------------
# Agrupando os dados limpos para gerar a tabela de decisão
  
  relatorio_final <- base_limpa %>% 
    group_by(FABRICANTE_REAL) %>% 
    
    summarise(
      
      TOTAL_PACIENTES_VACINADOS = n(),
      MEDIA_IDADE_VACINADOS = mean(IDADE),
      TOTAL_REACOES = sum(REACAO == "SIM"),
      TAXA_REACAO_PERCENTUAL = (TOTAL_REACOES/TOTAL_PACIENTES_VACINADOS) * 100 )
  
# 3. VISUALIZAÇÃO DOS RESULTADOS ----------------------------------------------
  print("--- RELATÓRIO FINAL: TAXA DE REAÇÃO POR FABRICANTE ---")
  print(relatorio_final)
                                
                                     