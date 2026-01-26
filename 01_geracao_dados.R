set.seed(2026) 
n_notific <- 300 

vacinas_anonimas <- c("Vacina-ALFA (Lote 1)", "vacina_beta", "Imuno_GAMA", 
                      "ALFA_pediatrica", "Beta-Campaign", "Gama_Plus", 
                      "Vac_Alfa", "BETA_bivalente", "GAMA_trivalente")

relatos <- c("Paciente relata dor local intensa e vermelhidao", 
             "Sem queixas, tudo tranquilo", 
             "Teve febre alta (39) e calafrios a noite", 
             "Nada a declarar", 
             "Dor de cabeca forte e mialgia", 
             "Braço doendo um pouco, mas sem febre", 
             "Assintomatico", 
             "Relatou dor no corpo e fadiga", 
             "Vermelhidao no local da aplicacao", 
             "Negou sintomas")

base_esavi <- tibble(
  ID = 1:n_notific,
  DATA = sample(c("26/01/2026", "2026-01-26", "Hoje"), n_notific, replace = T),
  
  
  PACIENTE = paste0(sample(c("Jose", "Maria", "Ana", "Pedro"), n_notific, replace = T), " | ",
                    sample(c("M", "F"), n_notific, replace = T), " | ",
                    sample(18:85, n_notific, replace = T), " anos"),
  
  
  FABRICANTE_SUJO = sample(vacinas_anonimas, n_notific, replace = T),
  
  
  RELATO = sample(relatos, n_notific, replace = T)
)
