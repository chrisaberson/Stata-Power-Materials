clear all
matrix input mean = (1.0 1.0 0.85)
matrix input SD = (0 0 1.70)
matrix input corr = (1.0,.0, .0\.0, 1.0, .0\.0,.0, 1.00)
corr2data x1 x2 y , n(250) means(mean) corr(corr) sds(SD)
save c:\temp\groupfact1
clear

matrix input mean = (1.0 2.0 0.85)
matrix input SD = (0 0 1.70)
matrix input corr = (1.0,.0, .0\.0, 1.0, .0\.0,.0, 1.00)
corr2data x1 x2 y, n(250) means(mean) corr(corr) sds(SD)
save c:\temp\groupfact2
clear

matrix input mean = (2.0 1.0 0.0)
matrix input SD = (0 0 1.70)
matrix input corr = (1.0,.0, .0\.0, 1.0, .0\.0,.0, 1.00)
corr2data x1 x2 y, n(250) means(mean) corr(corr) sds(SD)
save c:\temp\groupfact3
clear

matrix input mean = (2.0 2.0 0.60)
matrix input SD = (0 0 1.70)
matrix input corr = (1.0,.0, .0\.0, 1.0, .0\.0,.0, 1.00)
corr2data x1 x2 y, n(250) means(mean) corr(corr) sds(SD)
save c:\temp\groupfact4
clear

append using c:\temp\groupfact1 c:\temp\groupfact2 c:\temp\groupfact3 c:\temp\groupfact4
save c:\temp\merged_fact


anova y x1 x2 x1#x2
contrast r.x2@x1

generate alpha = .05
matrix c=r(F)
matrix df=r(df)
generate L_x2atx1_1 =  c[1,1] * df[1,1]
generate L_x2atx1_2 =  c[1,2] * df[1,2]
generate fcritical_x1 = invFtail(df[1,1], `e(df_r)', alpha)
generate fcritical_x2 = invFtail(df[1,2], `e(df_r)', alpha)
generate  Pow_x2atx1_1=nFtail(df[1,1], `e(df_r)', L_x2atx1_1, fcritical_x1)
generate  Pow_x2atx1_2=nFtail(df[1,2], `e(df_r)', L_x2atx1_2, fcritical_x2)

tabstat L_x2atx1_1 Pow_x2atx1_1 L_x2atx1_2 Pow_x2atx1_2, statistics( mean )

erase c:\temp\groupfact1.dta
erase c:\temp\groupfact2.dta
erase c:\temp\groupfact3.dta
erase c:\temp\groupfact4.dta
erase c:\temp\merged_fact.dta

