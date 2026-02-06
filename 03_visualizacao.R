library(tidyverse)
library(ggplot2)
source("02_analise_esavi.R")

#===========================================================================================
# 1. ANÁLISE DEMOGRÁFICA POR SEXO:
#===========================================================================================

#Extraindo e separando dados por sexo:

dados_sexo <- base_limpa %>% 
  count(SEXO) %>% 
  mutate(porcentagem = n / sum(n) * 100)

#Criando um gráfico de pizza:

grafico_sexo <- dados_sexo %>% 
  ggplot(aes(x = "", y = porcentagem, fill = SEXO)) +
  geom_bar(stat = "identity", width = 1) +
  coord_polar("y", start = 0) +
  theme_void() +
  geom_text(aes(label = sprintf("%.1f%%", porcentagem)),
            position = position_stack(vjust = 0.5)) +
  labs(title = "DISTRIBUIÇÃO POR SEXO", fill = "SEXO") +
  scale_fill_manual(values = c("#FC0FC0", "#87cefa")) 

ggsave("grafico_sexo.png", plot = grafico_sexo, width = 6, height = 6)

#===========================================================================================
# 2. RESULTADOS OBTIDOS (TAXA DE REAÇÃO):
#===========================================================================================

#criando um gráfico de barras que nos mostra a taxa de reação percentual de cada vacina por fabricante:

grafico_barras <- relatorio_final %>% 
  ggplot(aes(x = reorder(FABRICANTE_REAL, TAXA_REACAO_PERCENTUAL), y = TAXA_REACAO_PERCENTUAL)) +
  geom_col(aes(fill = FABRICANTE_REAL)) +
  labs(
    title = "TAXA DE REAÇÃO PERCENTUAL POR FABRICANTE",
    subtitle = "Os resultados refletem apenas a base simulada e não representam dados reais.",
    x = "FABRICANTE DA VACINA",
    y = "TAXA DE REAÇÃO(%)",
    fill = "FABRICANTE") +
  geom_text(aes(label = sprintf("%.1f%%", TAXA_REACAO_PERCENTUAL)), vjust = -0.5) +
  theme_classic() 

ggsave("grafico_taxa_reacao.png", plot = grafico_barras, width = 8, height = 5)
