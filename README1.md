Study construction:
    Response variable: Total Score, Ergo Score, Proc Score, Global 5-point score
    Independent variable: Rater[1,2], AssessmentTime[0,1,2]
    Within-subject variable: Rater[1,2], AssessmentTime[0,1,2]
    Between-subject variable:
    Fixed-effect variable: Rater[1,2], AssessmentTime[0,1,2]

![alt tag](https://raw.githubusercontent.com/ajkou/FAER_Study/master/7%20Scores%20bar.png)
A few basic aspects of the data


![alt tag](https://raw.githubusercontent.com/ajkou/FAER_Study/master/3%20Total%20box2input.png)
Total Score Description
    Grand mean
    16.14062
    
    Rater
        1     2
    15.73 16.55
    
    AssessmentTime
        0     1     2
    12.78 14.30 21.34

![alt tag](https://raw.githubusercontent.com/ajkou/FAER_Study/master/4%20TotProc%20box2input.png)
Proc score Description
    Grand mean
    10.375
    
    Rater
        1     2
    10.29 10.46
    
    AssessmentTime
        0     1     2
     8.11  9.61 13.41

![alt tag](https://raw.githubusercontent.com/ajkou/FAER_Study/master/5%20TotErgo%20box2input.png)
Ergo score Description
    Grand mean
    5.765625
    
    Rater
       1    2
    5.44 6.09
    
    AssessmentTime
       0    1    2
    4.67 4.69 7.94

![alt tag](https://raw.githubusercontent.com/ajkou/FAER_Study/master/6%20Global%20box2input.png)
Global score Description
    Grand mean
    2.109375
    
    Rater
        1     2
    2.177 2.042
    
    AssessmentTime
        0     1     2
    1.625 1.875 2.828




Comparing the raters by t-test?
> t.test(data$Total[data$Rater==1], data$Total[data$Rater==2], paired=TRUE)

    Paired t - test

    data:  data$Total[data$Rater == 1] and data$Total[data$Rater == 2]
    t = -2.7545, df = 95, p-value = 0.007045
    alternative hypothesis: true difference in means is not equal to 0
    95 percent confidence interval:
     -1.4160160 -0.2298173
    sample estimates:
    mean of the differences
                 -0.8229167

Comparing the 3 AssessmentTimes by t-test?
>pairwise.t.test(data$Total, AssessmentTime, paired=TRUE, p.adj="bonferroni")
    
      0      1
    1 0.0093 -
    2 <2e-16 <2e-16
    
    P value adjustment method: bonferroni




Subject Repeated Measures ANOVA removes variablility created by individual effects from the F-test calculation. The highly disparate subject scores removes a huge chunk of variability
Both Rater and AssessmentTime have a case for showing a difference in means, especially in TotErgo score. 
No interaction effect between Rater and AssessmentTime relating to these 4 scoring schemes.

ANOVA Total Score
> summary(aov(Total ~ Rater*AssessmentTime+Error(Subj), data = data.rm ))

Error: Subj
          Df Sum Sq Mean Sq F value Pr(>F)
Residuals 30   1725   57.49               

Error: Within
                      Df Sum Sq Mean Sq F value Pr(>F)    
Rater                  1   31.1    31.1   3.058 0.0824 .  
AssessmentTime         2 2493.8  1246.9 122.798 <2e-16 ***
Rater:AssessmentTime   2   27.1    13.6   1.335 0.2663    
Residuals            150 1523.1    10.2                   


ANOVA Proc Score
> summary(aov(TotProc ~ Rater*AssessmentTime+Error(Subj), data = data.rm ))

Error: Subj
          Df Sum Sq Mean Sq F value Pr(>F)
Residuals 30   1052   35.07               

Error: Within
                      Df Sum Sq Mean Sq F value Pr(>F)    
Rater                  1    1.7     1.7   0.309  0.579    
AssessmentTime         2  880.0   440.0  78.147 <2e-16 ***
Rater:AssessmentTime   2   10.1     5.0   0.897  0.410    
Residuals            150  844.5     5.6                   


ANOVA Ergo Score
> summary(aov(TotErgo ~ Rater*AssessmentTime+Error(Subj), data = data.rm ))

Error: Subj
          Df Sum Sq Mean Sq F value Pr(>F)
Residuals 30    250   8.332               

Error: Within
                      Df Sum Sq Mean Sq F value Pr(>F)    
Rater                  1   18.1   18.09   6.458 0.0121 *  
AssessmentTime         2  430.1  215.07  76.791 <2e-16 ***
Rater:AssessmentTime   2    4.3    2.17   0.774 0.4632    
Residuals            150  420.1    2.80                   


ANOVA Global Score [1,5]
> summary(aov(Global ~ Rater*AssessmentTime+Error(Subj), data = data.rm ))

Error: Subj
          Df Sum Sq Mean Sq F value Pr(>F)
Residuals 30  58.47   1.949               

Error: Within
                      Df Sum Sq Mean Sq F value Pr(>F)    
Rater                  1   0.91   0.909   2.229 0.1375    
AssessmentTime         2  50.33  25.167  61.744 <2e-16 ***
Rater:AssessmentTime   2   2.78   1.392   3.416 0.0354 *  
Residuals            150  61.14   0.408                   




Tukey-Kramer Multiple-Comparison Test (Tukey's Range Test or Tukey-Kramer Multiple-Comparison Test)
Does a pairwise comparison between the 3 time points. Results are equivalent to Ed's Scoring Summary.
![alt tag](https://raw.githubusercontent.com/ajkou/FAER_Study/master/8%204Scores%20bar.png)
HSD Total Score
      Tukey multiple comparisons of means
        95% family-wise confidence level
    
    Fit: aov(formula = data$Total ~ Rater + AssessmentTime)
    
    $AssessmentTime
            diff        lwr       upr     p adj
    1-0 1.515625 -0.2510111  3.282261 0.1086183
    2-0 8.562500  6.7958639 10.329136 0.0000000
    2-1 7.046875  5.2802389  8.813511 0.0000000


HSD Proc Score
      Tukey multiple comparisons of means
        95% family-wise confidence level
    
    Fit: aov(formula = data$TotProc ~ Rater + AssessmentTime)
    
    $AssessmentTime
            diff       lwr      upr     p adj
    1-0 1.500000 0.1366515 2.863348 0.0271246
    2-0 5.296875 3.9335265 6.660223 0.0000000
    2-1 3.796875 2.4335265 5.160223 0.0000000


HSD Ergo Score
      Tukey multiple comparisons of means
        95% family-wise confidence level
    
    Fit: aov(formula = data$TotErgo ~ Rater + AssessmentTime)
    
    $AssessmentTime
            diff        lwr       upr    p adj
    1-0 0.015625 -0.7780071 0.8092571 0.998808
    2-0 3.265625  2.4719929 4.0592571 0.000000
    2-1 3.250000  2.4563679 4.0436321 0.000000


HSD Global 5 Point Score
      Tukey multiple comparisons of means
        95% family-wise confidence level
    
    Fit: aov(formula = data$Global ~ Rater + AssessmentTime)
    
    $AssessmentTime
            diff         lwr       upr     p adj
    1-0 0.250000 -0.09220328 0.5922033 0.1982244
    2-0 1.203125  0.86092172 1.5453283 0.0000000
    2-1 0.953125  0.61092172 1.2953283 0.0000000





Linear Model Full
AssessmentTime1 and AssessmentTime2 are lm constructs for the 3 levels of Time0/Time1/Time2

    Call:
    lm(formula = data$Total ~ Rater + AssessmentTime)
    
    Residuals:
         Min       1Q   Median       3Q      Max
    -11.9323  -2.9323  -0.1927   2.2917  11.8073
    
    Coefficients:
                    Estimate Std. Error t value Pr(>|t|)
    (Intercept)      12.3698     0.6106  20.259   <2e-16 ***
    Rater2            0.8229     0.6106   1.348   0.1794
    AssessmentTime1   1.5156     0.7478   2.027   0.0441 *
    AssessmentTime2   8.5625     0.7478  11.450   <2e-16 ***
    ---
    Signif. codes:  0 ‘***’ 0.001 ‘**’ 0.01 ‘*’ 0.05 ‘.’ 0.1 ‘ ’ 1
    
    Residual standard error: 4.23 on 188 degrees of freedom
    Multiple R-squared: 0.4457,     Adjusted R-squared: 0.4368
    F-statistic: 50.39 on 3 and 188 DF,  p-value: < 2.2e-16






Comparing Rater1 and Rater2.
The simplest calculation for comparing Rater1/Rater2 would just be correlation coeff. Shown for Total, Proc, Ergo, and Global

Total score

    >cor(subset(data[,4], data$Rater==1), subset(data[,4], data$Rater==2))
    [1] 0.8725729

Proc Score

    > cor(subset(data[,5], data$Rater==1), subset(data[,5], data$Rater==2))
    [1] 0.7975124

Ergo Score

    > cor(subset(data[,6], data$Rater==1), subset(data[,6], data$Rater==2))
    [1] 0.827612

Global Score

    > cor(subset(data[,7], data$Rater==1), subset(data[,7], data$Rater==2))
    [1] 0.6748529

The correlation coeff values are all pretty high, indicating overall agreement in the scoring system


These Pearson correlation values can be tested for whether they are non zero.
Shown below is the correlation test for total Scores between raters

    > cor.test(subset(data[,4], data$Rater==1), subset(data[,4], data$Rater==2))
    
    Pearson 's product-moment correlation
    
    data:  subset(data[, 4], data$Rater == 1) and subset(data[, 4], data$Rater == 2)
    t = 17.3187, df = 94, p-value < 2.2e-16
    alternative hypothesis: true correlation is not equal to 0
    95 percent confidence interval:
     0.8145903 0.9132893


We can also look at the constituent parts of the total score
Viewing rating correlation by category shows that some categories have high agreement (MachinePosition), while others have low agreement (NoCrossing). No categories show gross disagreement.

               Time          Passes   Visualization       EquipPrep          Target
          0.9207586       0.5923389       0.4910720       0.6459121       0.5022038
    
          Stability     NeedleManip     VisualFocus       InjSpread         CathTip
          0.3701013       0.2465698       0.1410969       0.7819622       0.5988901
    
    MachinePosition          NoFlex       NoHeadRot  NoShoulderTilt      NoCrossing
          0.9701194       0.6792917       0.8282686       0.4464817      -0.0627703






Intraclass Correlation from psychmetrics package (psych)
Before, the Pearson correlation was shown evaluating variability between raters (inter-observer).
ICC evaluates the variability (intra-observer) in the scoring of each video recording. This looks for similiarity of judgement.
So our response variable is the score, whether by Rater1 or Rater2 (2 Judges), and each video sent to the raters is the grouping (96 groups).

    Intraclass correlation coefficients
                             type  ICC  F df1 df2 p lower bound upper bound
    Single_raters_absolute   ICC1 0.86 13  95  96 0        0.79        0.90
    Single_random_raters     ICC2 0.86 14  95  95 0        0.79        0.90
    Single_fixed_raters      ICC3 0.87 14  95  95 0        0.80        0.91
    Average_raters_absolute ICC1k 0.92 13  95  96 0        0.88        0.95
    Average_random_raters   ICC2k 0.92 14  95  95 0        0.88        0.95
    Average_fixed_raters    ICC3k 0.93 14  95  95 0        0.89        0.95
    
     Number of subjects = 96     Number of Judges =  2> data.ICC

Which ICC type should we use?
Documentation on the R ICC function says,

    "Shrout and Fleiss (1979) consider six cases of reliability of ratings done by k raters on n targets.
    ICC1: Each target is rated by a different judge and the judges are selected at random. (This is a one-way ANOVA fixed effects model and is found by (MSB- MSW)/(MSB+ (nr-1)*MSW))
    ICC2: A random sample of k judges rate each target. The measure is one of absolute agreement in the ratings. Found as (MSB- MSE)/(MSB + (nr-1)*MSE + nr*(MSJ-MSE)/nc)
    ICC3: A fixed set of k judges rate each target. There is no generalization to a larger population of judges. (MSB - MSE)/(MSB+ (nr-1)*MSE)
    Then, for each of these cases, is reliability to be estimated for a single rating or for the average of k ratings? (The 1 rating case is equivalent to the average intercorrelation, the k rating case to the Spearman Brown adjusted reliability.)
    ICC1 is sensitive to differences in means between raters and is a measure of absolute agreement.
    ICC2 and ICC3 remove mean differences between judges, but are sensitive to interactions of raters by judges. The difference between ICC2 and ICC3 is whether raters are seen as fixed or random effects.
    ICC1k, ICC2k, ICC3K reflect the means of k raters."

ICC3 for a fixed set of 2 judges seems to be the metric to use here. Shows an ICC of 0.87 between Jack and Eddie.






Kappa (Cohen's kappa coefficient for 2 raters) measuring inter-observer
Kappa scores were used to by (Gaba 1998) and (Devitt 1997) called the "kappa statistic of agreement"
Kappa on this scale is weighted by the difference in stated score. (If Rater1 marks a score of 8 and Rater2 marks 11, the weight is 11-8=3)

Kappa measure of the Global Score Ranged (1-5)

    >kappa2(data.kappa, c(0,1,2,3,4))
     
    Cohen 's Kappa for 2 Raters (Weights: 0,1,2,3,4)
    
     subjects = 96
       Raters = 2
        Kappa = 0.441
    
            Z = 6.79
      P -Value = 0.0000000000114

Kappa measure of the Total Score Ranged (6-30)

    > kappa2(data.kappa, 0:(range(data.kappa)[2]-range(data.kappa)[1]))
     Cohen 's Kappa for 2 Raters (Weights: 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24)
    
     subjects = 96
       Raters = 2
        Kappa = 0.449
    
            Z = 7.26
      P -Value = 0.000000000000374

What does this mean? Wikipedia quotes some older papers,
    
    "Landis and Koch,[13] who characterized values < 0 as indicating no agreement and 0–0.20 as slight, 0.21–0.40 as fair, 0.41–0.60 as moderate, 0.61–0.80 as substantial, and 0.81–1 as almost perfect agreement."

and then it also says
    
    "Fleiss's[15]:218 equally arbitrary guidelines characterize kappas over 0.75 as excellent, 0.40 to 0.75 as fair to good, and below 0.40 as poor."

