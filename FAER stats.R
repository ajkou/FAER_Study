setwd("C:\\Users\\KOU\\Desktop")
data <- read.table("video_stats.txt", header=T)
Rater1 <- subset(data, data$Rater==1)
Rater2 <- subset(data, data$Rater==2)
#Need to remove illegal symbols [#,!,',",%] before reading
survey_data <- read.table("survey_stats.txt", header=T, sep="\t")
demo_data <- read.table("demo_stats.txt", header=T, sep="\t")


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
	par(mfrow=c(2,2))
	boxplot(data$Total ~ data$AssessmentTime, main="Total Score", data = data, col = "grey", xaxt="n")
	axis(1, at=1:3, labels=c("Time0", "Time1", "Time2"))
	boxplot(data$TotProc ~ data$AssessmentTime, main="Proc Score", col = "grey", xaxt="n")
	axis(1, at=1:3, labels=c("Time0", "Time1", "Time2"))
	boxplot(data$TotErgo ~ data$AssessmentTime, main="Ergo Score", col = "grey", xaxt="n")
	axis(1, at=1:3, labels=c("Time0", "Time1", "Time2"))
	boxplot(data$Global ~ data$AssessmentTime, main="Global Score", col = "grey", xaxt="n")
	axis(1, at=1:3, labels=c("Time0", "Time1", "Time2"))

	#Is there an interaction between Rater and AssessmentTime? No.
	summary(aov(data$Total ~ Rater*AssessmentTime))


##Linear Regression; Response Variable:Total Score 
	Rater <- factor(data$Rater)
	AssessmentTime<- factor(data$AssessmentTime)
	#Full model
	summary( lm(data$Total ~ Rater + AssessmentTime))
	#Just Rater model
	summary( lm(data$Total ~ Rater))
	#Just AssessmentTime model
	summary( lm(data$Total ~ AssessmentTime))


##ANOVA by sub-score
	Rater <- factor(data$Rater)
	AssessmentTime<- factor(data$AssessmentTime)
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


## rmANOVA
	data.rm <- within(data, {
		Rater<-factor(Rater) 
		AssessmentTime<-factor(AssessmentTime)
		Subj<-factor(Subj)
	})
	#AOV Subject in error term
	summary(aov(Total ~ Rater*AssessmentTime+Error(Subj), data = data1))
	#AOV Subject with Rater as a between-subjects variable; residual calc is different from NCSS	
	summary(aov(Total ~ Rater*AssessmentTime+Error(Subj/(Rater)), data = data1))
 	#Try LME?
	library(nlme)
	summary(lme(Total ~ Rater * AssessmentTime, random=~1 |Subj, data=data.rm,))



##MANOVA for 3 response variables (Proc, Ergo, Global)
	TotProc <- data$TotProc
	TotErgo <- data$TotErgo
	Global <- data$Global
	data.manova <- manova(cbind(TotProc, TotErgo, Global)~Rater + AssessmentTime)


## Means for all subgroups; raw score histogram
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
	# Correlation of 15 technical scores for Regional Anesth
	x <- cor(subset(data[,8:22], data$Rater==1), subset(data[,8:22], data$Rater==2))
	x.1 <- x[row(x)==col(x)]
	names(x.1) <- names(data[,8:22])
	# Correlation of Ergo scores
	x.Ergo <- cor(subset(data[,6], data$Rater==1), subset(data[,6], data$Rater==2))
	# Correlation of Proc scores
	x.Proc <- cor(subset(data[,5], data$Rater==1), subset(data[,5], data$Rater==2))
	# Correlation of overall scores
	x.Total <- cor(subset(data[,4], data$Rater==1), subset(data[,4], data$Rater==2))
	# Correlation of Global 5 point scale
	x.5Scale <- cor(subset(data[,7], data$Rater==1), subset(data[,7], data$Rater==2))


##t-tests pairwise t-tests for paired data
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



##########################
##Survey series of 3 month quarterly follows
	Total.singleInjection <- apply(apply(apply(survey_data[,grep("N.S.", names(survey_data))], 2, as.character), 2, as.numeric),1, sum)
	Total.continuous <- apply(apply(apply(survey_data[,grep("N.C.", names(survey_data))], 2, as.character), 2, as.numeric),1, sum)
	#remove dropped participant
	survey_data <- subset(survey_data, survey_data$SUBJ!=19) 
	data <- subset(data, substr(data$Subj, 1,2)!="19") 
	#Check for scarcity of data
	timep.0 <- subset(survey_data, survey_data$QTR==0)
	timep.1 <- subset(survey_data, survey_data$QTR==1)
	timep.2 <- subset(survey_data, survey_data$QTR==2)
	timep.3 <- subset(survey_data, survey_data$QTR==3)
	timep.4 <- subset(survey_data, survey_data$QTR==4)
	
	#Graphic of single factor over time
	par(mfrow = c( 1, 6 ))
	n= 3
	boxplot(as.numeric(as.character(survey_data[,n]))~survey_data[,2])
	apply(cbind(timep.0[,n],timep.1[,n],timep.2[,n],timep.3[,n],timep.4[,n]),2,hist)


	#Graphics of factors by boxplot
	jpeg("test.jpg", width = 1000, height = 3500)
	layout(matrix(1:80, 16, 5, byrow = TRUE))
	for (i in c(3:58, 60:77)){
		boxplot(as.numeric(as.character(survey_data[,3])) ~survey_data[,2], main=names(survey_data)[i])
	}
	Total.singleInjection <- apply(apply(apply(survey_data[,grep("N.S.", names(survey_data))], 2, as.character), 2, as.numeric),1, sum)
	Total.continuous <- apply(apply(apply(survey_data[,grep("N.C.", names(survey_data))], 2, as.character), 2, as.numeric),1, sum)
	boxplot(Total.singleInjection~survey_data[,2], main="Tot_S")
	boxplot(Total.continuous~survey_data[,2], main="Tot_C")
	dev.off()

	#Total S-blocks line plot over timep
	plot(survey_data[,2], Total.singleInjection)
	for( i in c(1:18,20:32)){
		lines(survey_data[,2][survey_data[,1]==i], Total.singleInjection[survey_data[,1]==i])
	}
	#Total C-blocks line plot over timep
	plot(survey_data[,2], Total.continuous )
	for( i in c(1:18,20:32)){
		lines(survey_data[,2][survey_data[,1]==i], Total.continuous [survey_data[,1]==i])
	}
	#Graphics of factors by boxplot TOT_S and TOT_C
	boxplot(Total.singleInjection~survey_data[,2], main="Tot_S")
	apply(cbind(Total.singleInjection[survey_data[,2]==0],Total.singleInjection[survey_data[,2]==1],Total.singleInjection[survey_data[,2]==2],Total.singleInjection[survey_data[,2]==3],Total.singleInjection[survey_data[,2]==4]),2,hist)
	boxplot(Total.continuous ~survey_data[,2], main="Tot_S")
	apply(cbind(Total.continuous [survey_data[,2]==0],Total.continuous[survey_data[,2]==1],Total.continuous[survey_data[,2]==2],Total.continuous[survey_data[,2]==3],Total.continuous[survey_data[,2]==4]),2,hist)

	##rmANOVA
	#AOV Subject in error term
	summary(aov(Total.singleInjection~ QTR+Error(SUBJ), data = survey_data))
	#AOV Subject with Rater as a between-subjects variable; residual calc is different from NCSS	
	summary(aov(Total.continuous ~ QTR+Error(SUBJ), data = survey_data))


	#TukeyHSD
	QTR = factor(survey_data$QTR)
	TukeyHSD(aov(Total.singleInjection~ QTR), 'QTR', conf.level=0.95)
	TukeyHSD(aov(Total.continuous~ QTR), 'QTR', conf.level=0.95)


	#Linear Model
	QTR = factor(survey_data$QTR)
	var.teaching <- (demo_data[,7])[c(TRUE,FALSE,FALSE)]
	var.teaching <- var.teaching[c(1:18,20:32)]
	var.teaching <- replace(as.character(var.teaching), var.teaching=="NT", "0")
	var.teaching <- replace(as.character(var.teaching), var.teaching=="T", "1")
	var.teaching <- as.numeric(var.teaching)
	var.teaching <- rep(var.teaching, each=5)
	summary( lm(Total.singleInjection~ var.teaching))
	summary( lm(Total.continuous~ var.teaching ))

	summary( lm(Total.singleInjection~ QTR))
	summary( lm(Total.continuous~ QTR))
	summary( lm(Total.singleInjection~ var.teaching ))
	summary( lm(Total.continuous~ var.teaching ))

	cuScores <- rep((
	data[,4][c(T,F,F,F,F,F)] + 
	data[,4][c(F,T,F,F,F,F)] + 
	data[,4][c(F,F,T,F,F,F)] + 
	data[,4][c(F,F,F,T,F,F)] +
	data[,4][c(F,F,F,F,T,F)] +
	data[,4][c(F,F,F,F,F,T)]
	), each=5)
	summary( lm(Total.singleInjection~ cuScores ))
	summary( lm(Total.continuous~ cuScores ))

	var.gender <- (demo_data[,4])[c(TRUE,FALSE,FALSE)]
	var.gender <- var.gender [c(1:18,20:32)]
	var.gender <- replace(as.character(var.gender ), var.gender =="M", "0")
	var.gender <- replace(as.character(var.gender ), var.gender =="F", "1")
	var.gender <- as.numeric(var.gender)
	var.gender <- rep(var.gender, each=5)
	summary( lm(Total.singleInjection~ var.gender ))
	summary( lm(Total.continuous~ var.gender ))

	var.age <- (demo_data[,3])[c(TRUE,FALSE,FALSE)]
	var.age <- var.age [c(1:18,20:32)]
	var.age <- as.numeric(var.age )
	var.age <- rep(var.age , each=5)
	summary( lm(Total.singleInjection~ var.age ))
	summary( lm(Total.continuous~ var.age ))

	Total.singleInjection.sscore <- (
	Total.singleInjection[c(T,F,F,F,F)] + 
	Total.singleInjection[c(F,T,F,F,F)] + 
	Total.singleInjection[c(F,F,T,F,F)] + 
	Total.singleInjection[c(F,F,F,T,F)] +
	Total.singleInjection[c(F,F,F,F,T)]
	)
	Total.continuous.sscore <- (
	Total.continuous[c(T,F,F,F,F)] + 
	Total.continuous[c(F,T,F,F,F)] + 
	Total.continuous[c(F,F,T,F,F)] + 
	Total.continuous[c(F,F,F,T,F)] +
	Total.continuous[c(F,F,F,F,T)]
	)
	summary( lm(Total.singleInjection~ var.age + var.gender+ var.teaching +cuScores + QTR))
	summary( lm(Total.continuous~ var.age + var.gender+ var.teaching +cuScores+QTR))



	#nxn correlation plots ; stronger filter
	correlation.pickpops <- apply(apply(apply(survey_data,2,as.character),2,as.numeric), 2, median)
	correlation.pickpops <- correlation.pickpops[correlation.pickpops!=0]
	correlation.pickpops <- correlation.pickpops[!is.na(correlation.pickpops)]
	correlation.names <- names(correlation.pickpops)
	survey_data.numeric <- apply(apply(survey_data[correlation.names],2,as.character),2,as.numeric)
	correlation.mlist <- unlist(as.list(cor(survey_data.numeric, survey_data.numeric)))
	correlation.append = NULL
	correlation.append <- cbind( data.frame(rep(correlation.names, each=length(correlation.names))), data.frame(rep(correlation.names, length(correlation.names))) )
	correlation.append <- cbind(correlation.append, correlation.mlist)
	correlation.append <- correlation.append[correlation.append[,1]!=correlation.append[,2],]
	correlation.append <- correlation.append[!is.na(correlation.append[,3]),]
	names(correlation.append) = c("reponse1", "response2", "correlation")
	sink("out.txt")
	correlation.append[correlation.append[,3]>(0.7),]
	correlation.append[correlation.append[,3]<(-0.3),]
	sink()

	#heatmap1
	singleInjection <- apply(apply(survey_data[,grep("N.S.", names(survey_data))], 2, as.character), 2, as.numeric)
	continuous <- apply(apply(survey_data[,grep("N.C.", names(survey_data))], 2, as.character), 2, as.numeric)
	singleInjection.sscore <- (
	subset(singleInjection, c(T,F,F,F,F)) + 
	subset(singleInjection, c(F,T,F,F,F)) + 
	subset(singleInjection, c(F,F,T,F,F)) + 
	subset(singleInjection, c(F,F,F,T,F)) +
	subset(singleInjection, c(F,F,F,F,T))
	)
	continuous.sscore <- (
	subset(continuous, c(T,F,F,F,F)) + 
	subset(continuous, c(F,T,F,F,F)) + 
	subset(continuous, c(F,F,T,F,F)) + 
	subset(continuous, c(F,F,F,T,F)) +
	subset(continuous, c(F,F,F,F,T))
	)	
	x <- cbind(singleInjection.sscore, continuous.sscore)
	rownames(x) <- as.character(c(1:18,20:32))
	heatmap(x, Rowv = NA, Colv = NA,col = cm.colors(256), scale = "row", main="All Blocks (subset total)")
	
	#heatmap2
	timep.0.SI <- cbind(Total.singleInjection[survey_data$QTR==0])
	timep.0.C <- cbind(Total.continuous[survey_data$QTR==0])
	timep.1.SI <- cbind(Total.singleInjection[survey_data$QTR==1])
	timep.1.C <- cbind(Total.continuous[survey_data$QTR==1])
	timep.2.SI <- cbind(Total.singleInjection[survey_data$QTR==2])
	timep.2.C <- cbind(Total.continuous[survey_data$QTR==2])
	timep.3.SI <- cbind(Total.singleInjection[survey_data$QTR==3])
	timep.3.C <- cbind(Total.continuous[survey_data$QTR==3])
	timep.4.SI <- cbind(Total.singleInjection[survey_data$QTR==4])
	timep.4.C <- cbind(Total.continuous[survey_data$QTR==4])		
	#Single Injection heatmap
	x <- cbind(timep.0.SI, timep.1.SI, timep.2.SI, timep.3.SI, timep.4.SI) 
	rownames(x) <- as.character(c(1:18,20:32))
	colnames(x) <- c("Time0", "Time1", "Time2", "Time3", "Time4")
	heatmap(x, Rowv = NA, Colv = NA,col = cm.colors(256), scale = "row", main="Single I Blocks (time total)")
	#Continuous Block heatmap
	x <- cbind(timep.0.C, timep.1.C, timep.2.C, timep.3.C, timep.4.C)
	rownames(x) <- as.character(c(1:18,20:32))
	colnames(x) <- c("Time0", "Time1", "Time2", "Time3", "Time4")
	heatmap(x, Rowv = NA, Colv = NA,col = cm.colors(256), scale = "row", main="Continuous Blocks (time total)")
 	#Block type heatmap
	x <- cbind(timep.0.SI, timep.1.SI, timep.2.SI, timep.3.SI, timep.4.SI), timep.0.C, timep.1.C, timep.2.C, timep.3.C, timep.4.C)
	rownames(x) <- as.character(c(1:18,20:32))
	colnames(x) <- c("Time0", "Time1", "Time2", "Time3", "Time4"), "Time0", "Time1", "Time2", "Time3", "Time4")
	heatmap(x, Rowv = NA, Colv = NA,col = cm.colors(256), scale = "row", main="All blocks (count total)", xlab = "Single I                                 Continuous   ", margins=c(7,2))
 
