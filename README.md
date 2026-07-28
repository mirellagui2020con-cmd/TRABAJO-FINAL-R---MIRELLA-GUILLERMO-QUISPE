# PROYECTO FINAL
## Autora: Guillermo Quispe Mirella Jhasmin

# Acceso al financiamiento de las MYPE peruanas en el sistema financiero formal (2024)

## 📌 Descripción del proyecto
Este proyecto realiza un análisis exploratorio del acceso al financiamiento de las Micro, Pequeñas y Medianas Empresas (MYPE) peruanas con créditos vigentes en el sistema financiero formal durante el año 2024.

El análisis utiliza información del Ministerio de la Producción (PRODUCE) y estudia el saldo de deuda financiada, el nivel de ventas, la actividad exportadora y la distribución territorial y sectorial de las empresas según su tamaño.

Se emplean técnicas de limpieza, transformación, estadística descriptiva y visualización de datos utilizando R.


## 📂 Fuente de datos Ministerio de la Producción - PRODUCE

### Base de datos:

"Acceso de las MIPYME al crédito en el sistema financiero formal, 2024"

La base contiene información de 645,791 MYPE con préstamos vigentes en el sistema financiero formal, incluyendo tamaño de empresa, sector económico, ubicación geográfica, número de trabajadores, saldo de deuda y ventas promedio.


## 🎯 Objetivos 

Comparar el saldo de deuda financiada promedio según el tamaño de empresa. Analizar el indice de apalancamiento (deuda sobre ventas) por tamaño y sector. Identificar el porcentaje de empresas sin financiamiento activo según su tamaño. Evaluar la relación entre ventas y acceso al crédito. Identificar diferencias sectoriales y territoriales en el acceso al financiamiento.


## 📌 Hipótesis ¿Es más difícil para las microempresas y pequeñas empresas acceder al financiamiento formal en comparación con las medianas empresas?

## 📌 Conclusiones Principales

### Grafico 1 - Saldo de deuda financiada promedio por tamaño de empresa: 
Se evidencia una brecha muy amplia entre tamaños de empresa: las medianas empresas mantienen un saldo de deuda promedio de S/ 1.44 millones, mientras que las pequeñas llegan a S/ 428 mil y las microempresas apenas a S/ 68 mil. Esto confirma que el sistema financiero formal concentra el financiamiento en las empresas de mayor tamaño.

### Grafico 2 - Distribución del índice de apalancamiento por tamaño de empresa: 
Al observar la relación entre deuda y ventas, la dispersión es mucho mayor en las microempresas que en las medianas, lo que indica que el financiamiento que sí obtienen las microempresas representa una carga relativa más alta e inestable frente a sus ingresos, mientras que en las medianas empresas la deuda se comporta de forma más proporcional y predecible respecto a sus ventas.

### Grafico 3 - Porcentaje de empresas exportadoras por tamaño: 
Solo el 0.14% de las microempresas exporta, frente a 2.35% en las pequeñas y 7.30% en las medianas. La capacidad exportadora, que suele estar asociada a mejores condiciones de acceso al crédito (por historial y garantías), es prácticamente inexistente en el segmento micro.

### Grafico 4 - Número de MYPE con crédito vigente por departamento (Top 10): 
Lima concentra el 36.4% de todas las empresas con financiamiento activo a nivel nacional, seguido por Arequipa, La Libertad, Piura y Cusco. Esto sugiere que el acceso al crédito formal no solo depende del tamaño de la empresa, sino también de su cercanía a centros financieros urbanos.

### Grafico 5 - Saldo de deuda promedio por sector económico y tamaño de empresa: 
La brecha entre tamaños de empresa se repite en todos los sectores económicos, sin excepción, lo que indica que la dificultad de acceso al financiamiento para las empresas más pequeñas no depende del rubro al que se dediquen, sino estructuralmente de su tamaño.

### Hallazgo principal: 
El 32.6% de las microempresas registradas no mantiene ningún saldo de deuda financiada, frente a 28.8% en las pequeñas y solo 14.7% en las medianas. Es decir, 1 de cada 3 microempresas formalizadas no logra acceder a financiamiento formal, mientras que en las medianas esta proporción baja a menos de 1 de cada 7.

### ✅ Conclusión general:
Los resultados confirman la hipótesis planteada: es más difícil para las micro y pequeñas empresas acceder al financiamiento formal en comparación con las medianas empresas. Esta brecha se observa tanto en el monto de deuda obtenido, como en el porcentaje de empresas y se mantiene en todos los sectores económicos analizados. Este patrón es consistente con la teoría de racionamiento de crédito (Stiglitz & Weiss, 1981), según la cual las entidades financieras restringen el acceso a empresas más pequeñas debido a la asimetría de información y al mayor riesgo relativo que representan.

### 🛠️ Herramientas utilizadas RStudio Principales paquetes: 
dplyr 
ggplot2 
tidyr 
readr 
scales 
ggthemes
