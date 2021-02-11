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
generate alpha = .05
generate l_x1 = `e(F_1)' *  `e(df_1)'
generate l_x2 = `e(F_2)' *  `e(df_2)'
generate l_int = `e(F_3)' *  `e(df_3)'
generate fcritical_x1 = invFtail(`e(df_1)', `e(df_r)', alpha)
generate fcritical_x2 = invFtail(`e(df_2)', `e(df_r)', alpha)
generate fcritical_int = invFtail(`e(df_3)', `e(df_r)', alpha)
generate  Pow_x1=nFtail(`e(df_1)', `e(df_r)', l_x1, fcritical_x1)
generate  Pow_x2=nFtail(`e(df_2)', `e(df_r)', l_x2, fcritical_x2)
generate  Pow_int=nFtail(`e(df_3)', `e(df_r)', l_int, fcritical_int)

tabstat l_x1 Pow_x1 l_x2 Pow_x2 l_int Pow_int, statistics( mean )

erase c:\temp\groupfact1.dta
erase c:\temp\groupfact2.dta
erase c:\temp\groupfact3.dta
erase c:\temp\groupfact4.dta
erase c:\temp\merged_fact.dta
