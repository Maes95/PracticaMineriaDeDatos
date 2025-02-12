library(dplyr)

basic <- read.delim(file = 'rawData/title.basics.tsv', sep = '\t', header = TRUE)

# Sustituimos '\\N' por NA para que se tome c�mo valor vac�o
basic[basic == '\\N'] <- NA

basic1 <- basic %>%
  # Nos quedamos solo con las peliculas
  filter(titleType == 'movie') %>%
  # Seleccionamos solo las que nos interesan
  select(tconst, titleType, primaryTitle, isAdult, startYear, runtimeMinutes, genres) %>%
  # Omitimos los que tengan datos faltantes
  na.omit()

# Cambiamos el tipo del a�o a num�rico
basic1$startYear <- as.numeric(as.character(basic1$startYear))
# Renombramos la columna
names(basic1)[names(basic1) == 'startYear'] <- 'year'
names(basic1)[names(basic1) == 'primaryTitle'] <- 'title'
names(basic1)[names(basic1) == 'runtimeMinutes'] <- 'duration'

# Filtramos por a�o
basic2 <- basic1 %>% 
  filter(year > 2000)

# Lo guardamos en el formato de datos de R
saveRDS(basic2,file="modData/films2000.Rda")

# Lo leemos (esto es s�lo para comprobar que todo se escribi� bien)
basic3 <- readRDS("modData/films2000.Rda", refhook = NULL)