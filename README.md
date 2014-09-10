Addendum of FAER Study Survey Data

The first thing about the data collected from FAER is that it's got high dimensionality.
A rich set of information on preferences, performance, ratings, etc were gathered by the research team at each stage.
Second is that the responses hold a distribution of rare events. Much of the time, answers are negative or zero-values and are punctuated by spurts of activity for a specific person or time period.
This facet gives the data a right-tailed skew (ie. positive skew), affecting the interpretation of mean and spread.

Basic Description:
n= 32 Subjects assessed at Time0 and followed for 12 months over Time1, Time2, Time3, Time4.
1 withdraw (subject 19).
78 Survey Questions on blocks performed, comfort, preference, events, obstacles, teaching effectiveness, and learning method use.


Description of the survey landscape using heatmaps:
Heatmaps show the relative values of blocks (total number of blocks performed) by each practitioner. 
Visually, this tells me that the individual performance patterns vary widely, making indivual subject effects the leading explanation on how many blocks were performed. 

![alt tag](https://raw.githubusercontent.com/ajkou/FAER_Study/master/10%20all-blocks%20heatmap%20bytime.png)

![alt tag](https://raw.githubusercontent.com/ajkou/FAER_Study/master/10.1%20lineplot%20individualbytime.png)

This heatmap shows the relative values of blocks (number of each type of block) by each practitioner. To each his own. 
Different subjects perform different types of blocks in highly varying frequency. 
Some only do single injection, a few do continuous, while others do both, and some didn't get to doing any blocks at all over the entire time period. 
Differences in administrative, clinical, and professional situation at hospital-of-origin could easily explain this.
Basically, after people go home from seminar, everybody does their own thing.
This basic difference in behavior challenges line fitting and mean comparisons.

Modality of continuous versus single injection blocks also differ. Single Injection is way more popular. 
Could new programs in continuous regional blocks be far more difficult to implement or is this normal occurrence for regional practice?
Note that the intesity of the colors denotes relative values for the individual. Color intensity between rows are not comparable.

![alt tag](https://raw.githubusercontent.com/ajkou/FAER_Study/master/11%20all-blocks%20heatmap%20bytype.png)

![alt tag](https://raw.githubusercontent.com/ajkou/FAER_Study/master/8%20SI-blocks%20heatmap.png)

![alt tag](https://raw.githubusercontent.com/ajkou/FAER_Study/master/9%20c-blocks%20heatmap.png)

Only a few participants (subjects 2,16,18, and 23) were active in performing continuous blocks

Other explanatory variables can be shown via scatterplot matrix.
The first one is easy to infer. The higher the age, the more years of experience claimed. 

![alt tag](https://raw.githubusercontent.com/ajkou/FAER_Study/master/12%20scattermatrix%20age%20exp.png)

This second matrix illustrates the basic relationship between how many SI versus C-blocks a particular person has done.
The curves also illustrate the distribution of rare events (Poisson distribution) of the sample population. 
Over the entire term of the study period, the total number of continuous blocks departs from zero in only a few cases. 
This makes the "Total number of continuous blocks performed" metric difficult to make inferences on. 
Because of this problem and the fact that "number of continuous blocks performed" has far too many zero values, the rest of this README will focus on number of single-injection blocks reported.  

![alt tag](https://raw.githubusercontent.com/ajkou/FAER_Study/master/14%20scattermatrix%20SIvsC.png)

This is the set of count totals of continuous blocks performed for Time0 to Time4
> Total.continuous.Ag
 [1]  3 39  0  3  6  1  2  0  0  0  0  0  3  0  1 49  0 24  5  0  4  2 28  4  0  0  0  3  0  4  0

Comparing the rate of single-injection blocks, video scores, number of single-injection experience stated at Time0, and years of experience.
What trends do you see in this 4x4? 
I see a plausible relationship between years of experience and prior performance (total number of blocks at T=0)
Further, single-injection count stated at Time0 is related to count of blocks performed in the following 12 months.

![alt tag](https://raw.githubusercontent.com/ajkou/FAER_Study/master/13%20scattermatrix%20SI%20blocks.png)

This can be quickly checked using a linear model (least squares regession):
Data has been transformed in this model to remove longitudinal effects of Time0-Time4.
Additional model tuning could increase fit.
The following stat procedures illustrate single-injection practice count totals regressed on a pool of common sense factors like:

	Number of blocks at Time0: Highly related variable.
	Age of participant: Other closesly related variable [Years of Experience] found to be a better explanatory
	Years of experience (var.exp): Related variable 
	Gender: Not a strong factor.
	Teaching-hospital/non-teaching (var.teaching): Weak factor
	Aggregate of video scores during AssessmentTime2 (cuScores): Not a factor


Model selection process run bidirectionally using the MASS package. 
This shows in a stepwise algorithm the selection of relevant variables using AIC (Akaike information criterion) as the judgement parameter.
Lower AIC indicates a better fit while minimizing the level of complexity.

>fit <- lm(Total.singleInjection.Ag~ singleInjection.T0 + var.age + var.exp + var.gender + var.teaching + cuScores )
> step <- stepAIC(fit, direction="both")
	Start:          AIC = 233.54
    Total.singleInjection.Ag ~ singleInjection.T0 + var.age + var.exp + Var.gender Var.teaching + cuScores
    
                         Df Sum of Sq   RSS    AIC
    - var.gender          1         0 36895 231.54
    - cuScores            1        10 36905 231.55
    - var.age             1       450 37345 231.91
    <none>                            36895 233.54
    - var.teaching        1      2972 39868 233.94
    - var.exp             1      3207 40102 234.12
    - singleInjection.T0  1     48161 85056 257.43
    
	Step:          AIC = 231.54
    Total.singleInjection.Ag ~ singleInjection.T0 + var.age + var.exp + Var.teaching cuScores
    
                         Df Sum of Sq   RSS    AIC
    - cuScores            1        12 36907 229.55
    - var.age             1       521 37417 229.97
    <none>                            36895 231.54
    - var.teaching        1      2993 39888 231.96
    - var.exp             1      3516 40412 232.36
    + var.gender          1         0 36895 233.54
    - singleInjection.T0  1     48776 85671 255.65
    
	Step:      AIC = 229.55
    Total.singleInjection.Ag ~ singleInjection.T0 + var.age + var.exp + Var.teaching
    
                         Df Sum of Sq   RSS    AIC
    - var.age             1       515 37423 227.98
    <none>                            36907 229.55
    - var.teaching        1      3105 40012 230.05
    - var.exp             1      3659 40566 230.48
    + cuScores            1        12 36895 231.54
    + var.gender          1         2 36905 231.55
    - singleInjection.T0  1     49498 86405 253.92
    
	Step:      AIC = 227.98
    Total.singleInjection.Ag ~ singleInjection.T0 + var.exp + var.teaching
    
                         Df Sum of Sq   RSS    AIC
    <none>                            37423 227.98
    - var.teaching        1      2805 40228 228.22
    + var.age             1       515 36907 229.55
    + var.gender          1        52 37370 229.93
    + cuScores            1         6 37417 229.97
    - var.exp             1      7899 45322 231.91
    - singleInjection.T0  1     49483 86906 252.10


> step$anova
    Stepwise Model Path
    Analysis of Deviance Table
    
    Initial Model:
    Total.singleInjection.Ag ~ singleInjection.T0 + var.age + var.exp +
        Var.gender Var.teaching + cuScores
    
    Final Model:
    Total.singleInjection.Ag ~ singleInjection.T0 + var.exp + var.teaching
    
    
              Step Df     Deviance Resid. Df Resid. Dev      AIC
    1                                     24   36895.41 233.5375
    2 - var.gender  1   0.01715182        25   36895.43 231.5375
    3   - cuScores  1  12.02427752        26   36907.45 229.5476
    4    - var.age  1 515.28561452        27   37422.74 227.9774

Sumary description of the final model shows that blocks done at Time0 (singleInjection.T0) to be highly related, years of experience (var.exp) to be related, and teaching affliation (var.teaching) to be weakly related.
With an R-squared/Adjusted R2 of 0.57 and 0.52, this model seems to me a reasonable approximation of related cofactors to single-injection practice adoption 0-12 months after seminar(Total.singleInjection.Ag).
Factors related to continuous blocks remain unexplored due to sparcity of data.

> summary( lm(Total.singleInjection.Ag~ singleInjection.T0+var.exp+var.teaching))

	Call:
	lm(formula = Total.singleInjection.Ag ~ singleInjection.T0 + var.exp + var.teaching)
	
	Residuals:
	    Min      1Q  Median      3Q     Max 
	-93.395 -25.433   0.928  12.934  70.565 
	
	Coefficients:
                   Estimate Std. Error t value Pr(>|t|)    
	(Intercept)        -41.8563    27.4032  -1.527   0.1383    
	singleInjection.T0   3.3405     0.5591   5.975 2.26e-06 ***
	var.exp              2.3295     0.9758   2.387   0.0242 *  
	var.teaching        21.2014    14.9024   1.423   0.1663    
	---
	Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1 
	
	Residual standard error: 37.23 on 27 degrees of freedom
	Multiple R-squared: 0.5731,     Adjusted R-squared: 0.5256 
	F-statistic: 12.08 on 3 and 27 DF,  p-value: 3.38e-05 


Survey results of  stated Obstacles to implementation
![alt tag](https://raw.githubusercontent.com/ajkou/FAER_Study/master/15%20barplot%20obstacles.png)

Survey results of  stated benefit of teaching method
![alt tag](https://raw.githubusercontent.com/ajkou/FAER_Study/master/16%20barplot%20teaching.png)

Survey results of incidence of method use
![alt tag](https://raw.githubusercontent.com/ajkou/FAER_Study/master/17%20barplot%20learning.png)


Repeated Subjects ANOVA (RMANOVA) on number of blocks performed:
An F statistic > 0.05 would indicate no stage [Time0, Time1, Time2, Time3, Time4] was significantly different than another after separating individual effects.

> summary(aov(Total.singleInjection~ QTR+Error(SUBJ), data = survey_data))

	Error: SUBJ
	          Df Sum Sq Mean Sq F value Pr(>F)
	Residuals  1   1071    1071               
	
	Error: Within
	           Df Sum Sq Mean Sq F value Pr(>F)
	QTR         1    419   419.2   2.079  0.151
	Residuals 152  30647   201.6               

> summary(aov(Total.continuous ~ QTR+Error(SUBJ), data = survey_data))

	Error: SUBJ
	          Df Sum Sq Mean Sq F value Pr(>F)
	Residuals  1  11.99   11.99               

	Error: Within
	           Df Sum Sq Mean Sq F value Pr(>F)
	QTR         1   15.4  15.358   1.775  0.185
	Residuals 152 1315.3   8.654   


Tukey's range test on number of blocks performed:
A p statistic > 0.05 would indicate a pairwise comparison of quarters not to be significantly different

> TukeyHSD(aov(Total.singleInjection~ QTR), 'QTR', conf.level=0.95)
	  Tukey multiple comparisons of means
	    95% family-wise confidence level
	
	Fit: aov(formula = Total.singleInjection ~ QTR)
	
	$QTR
	         diff       lwr      upr     p adj
	1-0 1.8225806 -8.372359 12.01752 0.9878558
	2-0 2.5161290 -7.678810 12.71107 0.9601932
	3-0 3.0645161 -7.130423 13.25946 0.9209394
	4-0 5.1935484 -5.001391 15.38849 0.6243690
	2-1 0.6935484 -9.501391 10.88849 0.9997189
	3-1 1.2419355 -8.953004 11.43687 0.9972153
	4-1 3.3709677 -6.823972 13.56591 0.8915340
	3-2 0.5483871 -9.646552 10.74333 0.9998894


> TukeyHSD(aov(Total.continuous~ QTR), 'QTR', conf.level=0.95)
	  Tukey multiple comparisons of means
	    95% family-wise confidence level
	
	Fit: aov(formula = Total.continuous ~ QTR)

	$QTR
	           diff        lwr      upr     p adj
	1-0  1.09677419 -0.9765011 3.170049 0.5895269
	2-0  1.12903226 -0.9442430 3.202308 0.5617278
	3-0  0.80645161 -1.2668237 2.879727 0.8195841
	4-0  1.25806452 -0.8152108 3.331340 0.4521831
	2-1  0.03225806 -2.0410172 2.105533 0.9999992
	3-1 -0.29032258 -2.3635979 1.782953 0.9952210
	4-1  0.16129032 -1.9119850 2.234566 0.9995218
	3-2 -0.32258065 -2.3958559 1.750695 0.9928358
	4-2  0.12903226 -1.9442430 2.202308 0.9998026
	4-3  0.45161290 -1.6216624 2.524888 0.9746699


Survey statistics on learning preferences over time
![alt tag](https://raw.githubusercontent.com/ajkou/FAER_Study/master/17.5%20barplot%20timelearning.png)

Survey statistics on comfort scores over time for the various techniques
![alt tag](https://raw.githubusercontent.com/ajkou/FAER_Study/master/20%20lineplot%20comf.png)

Additional longitudinal barplot of Technique Preference over 12months
![alt tag](https://raw.githubusercontent.com/ajkou/FAER_Study/master/21%20barplot%20techpref.png)

Additional longitudinal barplot of Technique Preference over 12months
![alt tag](https://raw.githubusercontent.com/ajkou/FAER_Study/master/22%20barplot%20learningpref.png)

Prior stats on video scores from June 2014 remain archived in this repo at:
https://github.com/ajkou/FAER_Study/blob/master/README1.md
