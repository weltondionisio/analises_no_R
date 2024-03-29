library(readxl) #carregando o pacote
require(readxl)
dados<- read_excel("Pasta1.xlsx", col_names=T) #criando um objeto com os dados da pasta
install.packages("factoextra", dep=T) #instalando o pacote para a pca
library(factoextra) #carregando o pacote
res.pca<- prcomp(dados, center = T, scale. = T) #executando a pca com m�dia e vari�ncia padronizados
res.pca #observando os resultados
fviz_eig(res.pca) #observando a contribui��o de cada dimens�o/eixo em explicar a vari�ncia dos dados
fviz_pca_var(res.pca, col.var="contrib")+
  scale_color_gradient2(low="white", mid="gray",
                        high="black") + theme_minimal() #observando a contribui��o de cada vari�vel para as principais dimens�es/eixos

ind<-get_pca_ind(res.pca) #criando um objeto com os valores individuais dos res�duos
res<-ind$cos2 #criando objeto com os valores individuais de cos2 
res2 <-as.data.frame(res) #transformando numa matriz de dados
res2 #observando os dados


#Uma vez que os res�duos foram obtidos, comparar o tamanho entre as diferentes popula��es

#criando objetos com os res�duos, i.e. os valores combinados das vari�veis morfom�tricas
pc1_pop1<- res2[1:30, 1] #criando objeto com os valores residuais do eixo 1 da pca para a popula��o 1
pc1_pop2 <- res2[31:60, 1] #criando objeto com os valores residuais do eixo 1 da pca para a popula��o2
pc2_pop1 <- res2[1:30, 2] #criando objeto com os valores residuais do eixo 2 da pca para a popula��o1
pc2_pop2 <- res2[31:60, 2] #criando objeto com os valores residuais do eixo 2 da pca para a popula��o2

#testando a normalidade dos resíduos do eixo 1 da pca em cada município antes de compará-los
shapiro.test(pc1_pop1)
shapiro.test(pc1_pop2)

#Em caso de n�o-normalidade em ao menos uma das vari�veis, executar o teste de wilcoxon-Mann-Whitney
wilcox_result1 <- wilcox.test(pc1_pop1, pc1_pop2, correct = F, alternative = "two.sided")
wilcox_result1 #observando o resultado
#Houve diferen�a de tamanho entre as diferentes popula��es com base no eixo 1 da pca?

#em caso de normalidade em ambas as vari�veis, executar o teste t de Welch
test1<-t.test(pc1_pop1, pc1_pop2)
test1

#comparando as diferen�as no eixo 2

#testando a normalidade dos res�duos do eixo 2 da pca em cada munic�pio antes de compar�-los
shapiro.test(pc2_pop2)
shapiro.test(pc2_pop1)

#Em caso de n�o-normalidade em ao menos uma das vari�veis, executar o teste de wilcoxon-Mann-Whitney
wilcox_result2 <- wilcox.test(pc2_pop1, pc2_pop2, correct = F, alternative = "two.sided")
wilcox_result2 #observando o resultado

#em caso de normalidade em ambas as vari�veis, executar o teste t de Welch
test2<-t.test(pc2_pop1, pc2_pop2)
test2