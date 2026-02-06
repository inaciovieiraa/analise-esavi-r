library(tidyverse)
library(ggplot2)

#criando um gráfico de barras que nos mostra a taxa de reação percentual de cada vacina por fabricante

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
    
    