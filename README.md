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
![alt tag](https://raw.githubusercontent.com/ajkou/FAER_Study/master/13%20scattermatrix%20SI%20blocks.png)

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
An p statistic > 0.05 would indicate a pairwise comparison of quarters not to be significantly different

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


Linear model (least squares regession):
Count totals regressed on common sense factors like age of participant, gender, teaching-hospital/non-teaching, and aggregate of video scores given by the raters.
Data has been transformed in this model to remove longitudinal effects of Time0-Time4.
While teaching/non-teaching and gender could sometimes have a relationship with number of blocks performed, the variability is far too high to show this statistically.

> summary( lm(Total.singleInjection.Ag~ var.age + var.gender+ var.teaching +cuScores ))

	Call:
	lm(formula = Total.singleInjection.Ag ~ var.age + var.gender + 
	    var.teaching + cuScores)
	
	Residuals:
	   Min     1Q Median     3Q    Max 
	61.81 -39.60  -6.79  17.85 150.86 
	
	Coefficients:
	             Estimate Std. Error t value Pr(>|t|)
	(Intercept)  -25.5244   113.8256  -0.224    0.824
	var.age        0.9182     1.6398   0.560    0.580
	var.gender     8.5645    25.7294   0.333    0.742
	var.teaching  10.4026    23.2782   0.447    0.659
	cuScores       0.5671     1.1270   0.503    0.619
	
	Residual standard error: 57.38 on 26 degrees of freedom
	Multiple R-squared: 0.02341,    Adjusted R-squared: -0.1268 
	F-statistic: 0.1558 on 4 and 26 DF,  p-value: 0.9586 

> summary( lm(Total.continuous.Ag~ var.age + var.gender+ var.teaching +cuScores))

	Call:
	lm(formula = Total.continuous.Ag ~ var.age + var.gender + var.teaching + 
	    cuScores)
	
	Residuals:
	    Min      1Q  Median      3Q     Max 
	-10.221  -6.311  -3.909  -0.154  41.547 
	
	Coefficients:
	             Estimate Std. Error t value Pr(>|t|)
	(Intercept)   14.9957    24.7519   0.606    0.550
	var.age       -0.0127     0.3566  -0.036    0.972
	var.gender    -7.4817     5.5950  -1.337    0.193
	var.teaching  -3.3394     5.0620  -0.660    0.515
	cuScores      -0.1299     0.2451  -0.530    0.601
	
	Residual standard error: 12.48 on 26 degrees of freedom
	Multiple R-squared: 0.07583,    Adjusted R-squared: -0.06635 
	F-statistic: 0.5333 on 4 and 26 DF,  p-value: 0.7124 


Prior stats on video scores from June 2014 remain archived in this repo at:
https://github.com/ajkou/FAER_Study/blob/master/README1.md
