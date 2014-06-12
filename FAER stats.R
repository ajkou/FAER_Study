setwd("C:\\Users\\KOU\\Desktop")
data <- read.table("chunk.txt", header=T)
Rater1 <- subset(data, data$Rater==1)
Rater2 <- subset(data, data$Rater==2)

##Total Rater Scores (30 Points)
#Lineplot Mean over TimeAssessment
Mean.Total <- aggregate(data$Total, list(data$AssessmentTime), mean)
Mean.Rater1 <- aggregate(Rater1$Total, list(Rater1$AssessmentTime), mean)
Mean.Rater2 <- aggregate(Rater2$Total, list(Rater2$AssessmentTime), mean)
plot(rbind(Mean.Total, Mean.Rater1, Mean.Rater2), main="Total (means)" )
lines(Mean.Total)
lines(Mean.Rater1 , col="red")
lines(Mean.Rater2 , col="blue")
legend(range(Mean.Total["Group.1"])[1], range(Mean.Total["x"])[2],c("Rater1", "Rater2", "u"),c("red", "blue", "black"), border="white", bty="n")
#BoxWhisker Mean over TimeAssessment
boxplot(data$Total ~ data$AssessmentTime, data = data,log = "y", col = "grey")
#Is there an interaction between Rater and AssessmentTime? No.
summary(aov(data$Total ~ Rater*AssessmentTime))


##Linear Regression; Response Variable:Total Score 
Rater <- factor(data$Rater)
AssessmentTime<- factor(data$AssessmentTime)
#Full model
data.lm <- lm(data$Total ~ Rater + AssessmentTime)
summary(data.lm)
anova(data.lm)
#Just Rater model
data.lm.Rater <- lm(data$Total ~ Rater)
summary(data.lm.Rater)
anova(data.lm.Rater)
#Just AssessmentTime model
data.lm.ATime <- lm(data$Total ~ AssessmentTime)
summary(data.lm.ATime)
anova(data.lm.ATime)


##ANOVA with scoring segregation
#Total Score
data.aov <- aov(data$Total ~ Rater + AssessmentTime)
TukeyHSD(data.aov , 'AssessmentTime', conf.level=0.95)
boxplot(Total~Rater+AssessmentTime, data = data, main="Total Score (0-30)", xlab="(Rater).(Time)", col="grey")
#Proc Score
data.aovProc <- aov(data$TotProc ~ Rater + AssessmentTime)
TukeyHSD(data.aovProc, 'AssessmentTime', conf.level=0.95)
boxplot(TotProc~Rater+AssessmentTime, data = data, main="TotProc Score (0-20)", xlab="(Rater).(Time)", col="grey")
#Ergo Score
data.aovErgo <- aov(data$TotErgo ~ Rater + AssessmentTime)
TukeyHSD(data.aovErgo, 'AssessmentTime', conf.level=0.95)
boxplot(TotErgo~Rater+AssessmentTime, data = data, main="TotErgo Score (0-10)", xlab="(Rater).(Time)", col="grey")
#Global 5 Point Score
data.aov5 <- aov(data$Global ~ Rater + AssessmentTime)
TukeyHSD(data.aov5 , 'AssessmentTime', conf.level=0.95)
boxplot(Global~Rater+AssessmentTime, data = data, main="Global Score (1-5)", xlab="(Rater).(Time)", col="grey")


##MANOVA for 3 response variables (Proc, Ergo, Global)
TotProc <- data$TotProc
TotErgo <- data$TotErgo
Global <- data$Global
data.manova <- manova(cbind(TotProc, TotErgo, Global)~Rater + AssessmentTime)


## Means for all subgroups
print(model.tables(data.aov ,"means"),digits=3)
print(model.tables(data.aovProc ,"means"),digits=3)
print(model.tables(data.aovErgo ,"means"),digits=3)
print(model.tables(data.aov5 ,"means"),digits=3)
tapply(data$Total, factor(data$Rater), mean)
tapply(data$Total, factor(data$AssessmentTime), mean)
#Total Score Dist
par(mfrow = c( 2, 2 ))
hist(data$Total)
hist(data$TotProc)
hist(data$TotErgo)
hist(data$Global)
par(mfrow = c( 1, 1 ))


## Correlation Between Raters
x <- cor(subset(data[,8:22], data$Rater==1), subset(data[,8:22], data$Rater==2))
x.1 <- x[row(x)==col(x)]
# Correlation of 15 technical scores for Regional Anesth
names(x.1) <- names(data[,8:22])
# Correlation of Ergo scores
x.Ergo <- cor(subset(data[,6], data$Rater==1), subset(data[,6], data$Rater==2))
# Correlation of Proc scores
x.Proc <- cor(subset(data[,5], data$Rater==1), subset(data[,5], data$Rater==2))
# Correlation of overall scores
x.Total <- cor(subset(data[,4], data$Rater==1), subset(data[,4], data$Rater==2))
# Correlation of Global 5 point scale
x.5Scale <- cor(subset(data[,7], data$Rater==1), subset(data[,7], data$Rater==2))


##t-tests pairwise t-tests for paired data; not a big factor 
t.test(data$Total[data$Rater==1], data$Total[data$Rater==2], paired=TRUE)
pairwise.t.test(data$Total, AssessmentTime, paired=F, p.adj="bonferroni")


##ICC
library(psych)
data.ICC <- cbind(subset(data["Total"], data$Rater==1),subset(data["Total"], data$Rater==2))
colnames(data.ICC) <- c("Rater1", "Rater2")
ICC(data.ICC)

##kappa
data.kappa <- cbind(subset(data["Global"], data$Rater==1),subset(data["Global"], data$Rater==2))
kappa2(data.kappa, c(0,1,2,3,4))
data.kappa <- cbind(subset(data["Total"], data$Rater==1),subset(data["Total"], data$Rater==2))
kappa2(data.kappa, 0:(range(data.kappa)[2]-range(data.kappa)[1]))

