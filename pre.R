##Instalar a package tm. Descomente a linha abaixo na primeira vez que for rodar o programa.
#install.packages("SnowballC")
#install.packages("tm")
##Incluir o pacote para uso
require("tm")
require("SnowballC")


#Local (pasta) com os documentos para processamento
folderdir="../bbc/"
#cat (folderdir)
cat(folderdir, recursive = TRUE)

#Carregamento dos arquivos texto
CorpusVar <- Corpus(DirSource(folderdir, encoding = "UTF-8",recursive =TRUE, ignore.case = FALSE, mode = "text"),readerControl=list(reader=readPlain,language="en"))

#Convertendo o texto para minusculas
CorpusVar <- tm_map (CorpusVar, content_transformer(tolower))

#Removendo pontuacao (1)
CorpusVar <- tm_map (CorpusVar, removePunctuation)

#Retirando espacos em branco desnecessarios
CorpusVar <- tm_map (CorpusVar, stripWhitespace)

#Lista de Stop Words (Lista suprimida no quadro para melhor visualizacao, a listacompleta pode ser acessada nos anexos)
myStopWords <- c(stopwords(kind = "en"))

#Removendo stopwords
CorpusVar <- tm_map(CorpusVar, removeWords, myStopWords)

#Aplicando o Stemming / reduz palavaras ao radicais, usando algoritmo de Potter
CorpusVar <- tm_map(CorpusVar, stemDocument)

#Transformando o conjunto de dados em uma matriz de Termos x Documentos. (Termos nas linhas e documentos nas colunas)
#tdm <- TermDocumentMatrix (CorpusVar, control=list(weighting = function(x)weightTfId(x, normalize = TRUE), minWordLength=1, minDocFreq=1))
tdm <- TermDocumentMatrix (CorpusVar, control=list(weighting = function(x)weightTf(x), minWordLength=1, minDocFreq=1))

#Inspecionando a matriz para visualizacao e opcao de copiar os dados do console
inspect(tdm)
#Saida dos dados em arquivo separado por virgula
m <- as.matrix(tdm)
dim(m)
write.csv(m, file=".../bbc/dtm3.csv")

