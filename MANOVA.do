
clear all
matrix input mean = (1.0 0.0 1.0 2.4 -0.7)
matrix input SD = (0 0.40 5.0 1.6 1.2)
matrix input corr = (1.0,.0,.0,.0,.0\.0,1,.1,.1,.1\0,.1,1,.35,.45\0,.1,.35,1,.4\0,.1,.45,.4,1)
corr2data x y1 y2 y3 y4 , n(40) means(mean) corr(corr) sds(SD)
save c:\temp\group1

clear
matrix input mean = (2.0 -0.25 -2.0 2.0 -1.0)
matrix input SD = (0 0.40 5.0 1.6 1.2)
matrix input corr = (1.0,.0,.0,.0,.0\.0,1,.1,.1,.1\0,.1,1,.35,.45\0,.1,.35,1,.4\0,.1,.45,.4,1)
corr2data x y1 y2 y3 y4 , n(40) means(mean) corr(corr) sds(SD)
save c:\temp\group2
clear
append using c:\temp\group1 c:\temp\group2 
save c:\temp\merged_data

manova y1 y2 y3 y4 = x
generate alpha_mv = .05

matrix F=e(stat_1)
generat F_mv = F[1, 2]
generate df1_mv = F[1,3]
generate df2_mv = F[1,4]
generate lambda_mv = F_mv * df1_mv
generate fcritical_mv = invFtail(df1_mv, df2_mv, alpha_mv)
generate  Power_mv=nFtail(df1_mv, df2_mv, lambda_mv, fcritical_mv)
tabstat lambda_mv Power_mv, statistics( mean )

erase c:\temp\group1.dta
erase c:\temp\group2.dta

erase c:\temp\merged_data.dta
