clear all
matrix input mean = (1.0 2.0 3.0 4.0)
matrix input SD = (7 1 1 2)
matrix input corr = (1.0,.40,.40,-.40\.40,1.0,-.15,-.60\.40,-.15,1.0,.25\-.40,-.60,.25,1.00)
corr2data y x1 x2 x3, n(20) means(mean) corr(corr) sds(SD)
regress y x1
regress y x1 x2 x3
