
clear all
matrix input mean = (1.0 80)
matrix input SD = (0 10)
matrix input corr = (1.0,.0\.0,1.00)
corr2data x y , n(59) means(mean) corr(corr) sds(SD)
save c:\temp\group1
clear
matrix input mean = (2.0 82)
matrix input SD = (0 10)
matrix input corr = (1.0,.0\.0,1.00)
corr2data x y , n(59) means(mean) corr(corr) sds(SD)
save c:\temp\group2
clear
matrix input mean = (3.0 82)
matrix input SD = (0 10)
matrix input corr = (1.0,.0\.0,1.00)
corr2data x y , n(59) means(mean) corr(corr) sds(SD)
save c:\temp\group3
clear
matrix input mean = (4.0 86)
matrix input SD = (0 10)
matrix input corr = (1.0,.0\.0,1.00)
corr2data x y , n(59) means(mean) corr(corr) sds(SD)
save c:\temp\group4
clear
append using c:\temp\group1 c:\temp\group2 c:\temp\group3 c:\temp\group4
save c:\temp\merged_data
oneway y x

generate alpha = .05
generate lambda = `r(F)' *  `r(df_m)'
generate fcritical = invFtail(`r(df_m)', `r(df_r)', alpha)
generate  Power=nFtail(`r(df_m)', `r(df_r)', lambda, fcritical)
tabstat lambda Power, statistics( mean )

erase c:\temp\group1.dta
erase c:\temp\group2.dta
erase c:\temp\group3.dta
erase c:\temp\group4.dta
erase c:\temp\merged_data.dta
