#=================================================
# Tarea 1
# Profesor:   Mirko Smith Caja Ventura
# Estudiante: Guillermo Quispe Mirella Jhasmin
#=================================================


####################################
# 1. Importacion de datos
####################################
library(dplyr)
library(readr)
library(tidyr)

datos <- read.csv("C:/Users/USER/Documents/R/financiamiento_2024_rev_rest.csv",
                  header = TRUE,
                  stringsAsFactors = TRUE)

datos %>% summary()
datos %>% is.na() %>% colSums()
datos %>% glimpse()

####################################
# 2. Limpieza y preparacion
####################################
datos <- datos %>%
  mutate(
    ciiu = as.character(ciiu),
    id_anonimo_emp = as.character(id_anonimo_emp),
    tamano = factor(tamano, levels = c("MICRO", "PEQUEÑA", "MEDIANA"), ordered = TRUE)
  )

# Indicador de apalancamiento: Se crea una variable nueva para medir que tanta deuda 
# tiene cada empresa en comparacion con lo que vende. Si el numero es alto, la empresa debe
# mucho en relacion a sus ventas; si es bajo, debe poco.
datos <- datos %>%
  mutate(indice_apalancamiento = round(saldo_miles_soles * 1000 / ventas_prom, 4))

####################################
# 3. Estadisticas descriptivas
####################################

# Variables categoricas
datos %>%
  select(tamano) %>%
  table() %>%
  as_tibble() %>%
  arrange(desc(n))

datos %>%
  select(sector) %>%
  table() %>%
  as_tibble() %>%
  arrange(desc(n))

# Variables numericas
datos %>%
  select(saldo_miles_soles) %>%
  summary()

datos %>%
  group_by(tamano) %>%
  summarise(
    n_empresas = n(),
    saldo_promedio = mean(saldo_miles_soles, na.rm = TRUE),
    ventas_promedio = mean(ventas_prom, na.rm = TRUE),
    apalancamiento_promedio = mean(indice_apalancamiento, na.rm = TRUE)
  ) %>%
  arrange(desc(apalancamiento_promedio))

#=================================================
# C05-Paquete dplyr
#=================================================

# Empresas MICRO con saldo de deuda mayor a 0
filter(datos, tamano == "MICRO", saldo_miles_soles > 0)

# Empresas que exportan y tienen mas de 5 trabajadores
filter(datos, exporta == "SI", nrotrab > 5)

# ED-01
# Mostrar las empresas de tamano MICRO que SI exportan
ED_01 <- filter(datos, tamano == "MICRO", exporta == "SI")
ED_01

# ED-02
# Mostrar las empresas de tamano PEQUEÑA que provienen de AREQUIPA,
# CUSCO y PUNO
ED_02 <- filter(datos, tamano == "PEQUEÑA",
                departamento %in% c("AREQUIPA", "CUSCO", "PUNO"))
ED_02

# ED-03
# Mostrar las empresas que no son de tamano MICRO y tienen entre
# 1 y 3 trabajadores
ED_03 <- filter(datos, tamano != "MICRO", nrotrab >= 1, nrotrab <= 3)
ED_03

# ED5-04
# Mostrar una muestra aleatoria de 10 observaciones 
ED5_04 <- datos %>%
  select(-starts_with("id"), -starts_with("fec")) %>%
  sample_n(10)
ED5_04

# ED5-05
# Seleccionar las variables que terminan en CIIU de las empresas
# de tamano MEDIANA
ED5_05 <- datos %>%
  filter(tamano == "MEDIANA") %>%
  select(ends_with("ciiu"))
ED5_05

# ED5-06
# Seleccionar las variables que contienen en su nombre "_" y mostrar
# las empresas ubicadas en el departamento de CAJAMARCA que tienen
# un saldo de deuda mayor o igual a 100 mil soles
ED5_06 <- datos %>%
  filter(departamento == "CAJAMARCA", saldo_miles_soles >= 100) %>%
  select(contains("_"))
ED5_06

# ED5-07
# Seleccionar las variables que NO contienen en su nombre "_" y mostrar
# las empresas del sector MINERIA de tamano PEQUEÑA o MEDIANA
ED5_07 <- datos %>%
  filter(sector == "MINERIA", tamano %in% c("PEQUEÑA", "MEDIANA")) %>%
  select(-contains("_"))
ED5_07

# ED5-08
# Ordenar ascendentemente segun el saldo de deuda a las empresas que
# SI exportan y pertenecen al sector MANUFACTURA
ED5_08 <- datos %>%
  filter(exporta == "SI", sector == "MANUFACTURA") %>%
  arrange(saldo_miles_soles)
ED5_08

# ED5-09
# Ordenar ascendentemente segun el numero de trabajadores, luego
# descendentemente segun las ventas promedio
ED5_09 <- datos %>%
  filter(contribuyente == "SOCIEDAD ANONIMA CERRADA", sector == "COMERCIO") %>%
  arrange(nrotrab, desc(ventas_prom))
ED5_09

# ED5-10
# Calcular el indice de apalancamiento
ED5_10 <- datos %>%
  select(id_anonimo_emp, tamano, saldo_miles_soles, ventas_prom,
         indice_apalancamiento)
ED5_10

# ED5-11
# Calcular la cantidad de empresas por sector economico y el promedio
# del indice de apalancamiento agrupado por sector
ED5_11 <- datos %>%
  group_by(sector) %>%
  summarise(
    n_empresas = n(),
    apalancamiento_promedio = mean(indice_apalancamiento, na.rm = TRUE)
  ) %>%
  arrange(desc(apalancamiento_promedio))
ED5_11

# ED5-12
# Calcular el valor maximo del 25% inferior y el valor minimo del 75%
# superior del indice de apalancamiento, agrupado por tamano de
# empresa y sector economico
ED5_12 <- datos %>%
  group_by(tamano, sector) %>%
  summarise(
    p25_max = quantile(indice_apalancamiento, 0.25, na.rm = TRUE),
    p75_min = quantile(indice_apalancamiento, 0.75, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  arrange(tamano, sector)
ED5_12

####################################
# 5. Visualizacion de datos
####################################
library(ggplot2)
library(ggthemes)
library(scales)

## GRAFICOS

# 1. Saldo de deuda promedio por tamano de empresa
grafico1 <- datos %>%
  group_by(tamano) %>%
  summarise(saldo_promedio = mean(saldo_miles_soles, na.rm = TRUE)) %>%
  ggplot(aes(x = tamano, y = saldo_promedio, fill = tamano)) +
  geom_col() +
  scale_fill_brewer(palette = "Blues") +
  theme_minimal() +
  theme(legend.position = "none") +
  labs(
    title = "Saldo de deuda financiada promedio por tamano de empresa",
    subtitle = "MYPE con creditos vigentes en el sistema financiero formal, 2024",
    x = "Tamano de empresa",
    y = "Saldo de deuda promedio (miles de soles)"
  )
grafico1
ggsave("saldo_deuda_por_tamano.png", grafico1, width = 8, height = 6, dpi = 300)

# 2. Distribucion del indice de apalancamiento por tamano (escala log)
grafico2 <- datos %>%
  filter(indice_apalancamiento > 0) %>%
  ggplot(aes(x = tamano, y = indice_apalancamiento, fill = tamano)) +
  geom_boxplot(outlier.size = 0.8, alpha = 0.8) +
  scale_y_log10(labels = comma) +
  scale_fill_brewer(palette = "Oranges") +
  theme_minimal() +
  theme(legend.position = "none") +
  labs(
    title = "Distribucion del indice de apalancamiento segun tamano de empresa",
    subtitle = "Indice = saldo de deuda / ventas promedio (escala log)",
    x = "Tamano de empresa",
    y = "Indice de apalancamiento (log)"
  )
grafico2
ggsave("apalancamiento_por_tamano.png", grafico2, width = 8, height = 6, dpi = 300)

# 3. Porcentaje de empresas exportadoras por tamano
grafico3 <- datos %>%
  group_by(tamano) %>%
  summarise(pct_exporta = mean(exporta == "SI") * 100) %>%
  ggplot(aes(x = tamano, y = pct_exporta, fill = tamano)) +
  geom_col() +
  geom_text(aes(label = paste0(round(pct_exporta, 2), "%")), vjust = -0.5) +
  scale_fill_brewer(palette = "Greens") +
  theme_minimal() +
  theme(legend.position = "none") +
  labs(
    title = "Porcentaje de empresas exportadoras segun tamano",
    x = "Tamano de empresa",
    y = "% de empresas que exportan"
  )
grafico3
ggsave("pct_exportadoras_por_tamano.png", grafico3, width = 8, height = 6, dpi = 300)

# 4. Numero de empresas por departamento (top 10)
grafico4 <- datos %>%
  count(departamento, sort = TRUE) %>%
  slice_head(n = 10) %>%
  ggplot(aes(x = reorder(departamento, n), y = n, fill = departamento)) +
  geom_col() +
  coord_flip() +
  theme_minimal() +
  theme(legend.position = "none") +
  labs(
    title = "Numero de MYPE con credito vigente por departamento (Top 10)",
    x = "",
    y = "Numero de empresas"
  )
grafico4
ggsave("empresas_por_departamento.png", grafico4, width = 8, height = 6, dpi = 300)

# 5. Saldo de deuda promedio por sector economico y tamano de empresa
grafico6 <- datos %>%
  group_by(sector, tamano) %>%
  summarise(saldo_promedio = mean(saldo_miles_soles, na.rm = TRUE), .groups = "drop") %>%
  ggplot(aes(x = reorder(sector, saldo_promedio), y = saldo_promedio, fill = tamano)) +
  geom_col(position = "dodge") +
  coord_flip() +
  scale_fill_brewer(palette = "Blues") +
  theme_minimal() +
  labs(
    title = "Saldo de deuda promedio por sector economico y tamano de empresa",
    x = "Sector economico",
    y = "Saldo de deuda promedio (miles de soles)",
    fill = "Tamano"
  )
grafico5
ggsave("saldo_deuda_sector_tamano.png", grafico6, width = 10, height = 7, dpi = 300)

####################################
# 6. Hallazgo principal
####################################
# Comparacion final: acceso al financiamiento segun tamano de empresa
sintesis <- datos %>%
  group_by(tamano) %>%
  summarise(
    n_empresas = n(),
    pct_empresas = round(n() / nrow(datos) * 100, 2),
    saldo_deuda_promedio_soles = round(mean(saldo_miles_soles, na.rm = TRUE) * 1000, 0),
    ventas_promedio_soles = round(mean(ventas_prom, na.rm = TRUE), 0),
    pct_exportadoras = round(mean(exporta == "SI") * 100, 2)
  )
sintesis

