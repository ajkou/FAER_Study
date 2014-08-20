Addendum of Faer Survey Data

Description of the survey landscape using heatmaps
Heatmaps show the relative values of blocks (total number of blocks performed) by each practitioner. Visually, this tells me that the performance patters of each person varys extremely widely, making indivual subject effects the leading explanation how many blocks were performed. 

![alt tag](https://raw.githubusercontent.com/ajkou/FAER_Study/master/10%20all-blocks%20heatmap%20bytime.png)

This heatmap shows the relative values of blocks (number of each type of block) by each practitioner. To each his own. Different subjects perform different types of blocks in highly varying frequency. Some only do single injection, some do continuous, while others do both, and some didn't get to do any blocks at all. Differences in administrative, clinical, and professional situation at hospital-of-origin could easily explain this.
Continuous versus single injection blocks also differ. Single Injection is way more popular. Could new programs in continuous regional blocks be far more difficult to implement?
Remember, the intesity of the colors denotes relative values for the individual. Color intensity between rows is not comparable.
![alt tag](https://raw.githubusercontent.com/ajkou/FAER_Study/master/11%20all-blocks%20heatmap%20bytype.png)

![alt tag](https://raw.githubusercontent.com/ajkou/FAER_Study/master/8%20SI-blocks%20heatmap.png)

![alt tag](https://raw.githubusercontent.com/ajkou/FAER_Study/master/9%20c-blocks%20heatmap.png)


Other explanatory variables can be shown via scatterplot matrix.
The first one is easy to infer. The higher the age, the more years of experience claimed. 

![alt tag](https://raw.githubusercontent.com/ajkou/FAER_Study/master/12%20scattermatrix%20age%20exp.png)

This second matrix illustrates the basic relationship between how many SI versus C-blocks a particular person has done.
The curves also illustrate the distribution of rare events (Poisson distribution) of the sample population. Over the entire term of the study period, the total number of blocks departs from zero in only a few cases. This makes the "Total number of blocks performed" metric difficult to make inferences on. Because of this problem and the fact that "number of continuous blocks performed" has far too many zero values, the rest of this README will focus on number of single-injection blocks reported.  
![alt tag](https://raw.githubusercontent.com/ajkou/FAER_Study/master/14%20scattermatrix%20SIvsC.png)

> Total.continuous.Ag
 [1]  3 39  0  3  6  1  2  0  0  0  0  0  3  0  1 49  0 24  5  0  4  2 28  4  0  0  0  3  0  4  0


Comparing the rate of single-injection blocks, video scores, number of single-injection experience stated at Time0, and years of experience. What trends do you see in this 4x4?
![alt tag](https://raw.githubusercontent.com/ajkou/FAER_Study/master/13%20scattermatrix%20SI%20blocks.png)


Prior stats on video scores from June 2014 remain archived in this repo at:
https://github.com/ajkou/FAER_Study/blob/master/README1.md
