
clear all
matrix input mean = (1.0 80)
matrix input SD = (0 10)
matrix input corr = (1.0,.0\.0,1.00)
corr2data x y , n(525) means(mean) corr(corr) sds(SD)
save c:\temp\group1
clear
matrix input mean = (2.0 82)
matrix input SD = (0 10)
matrix input corr = (1.0,.0\.0,1.00)
corr2data x y , n(525) means(mean) corr(corr) sds(SD)
save c:\temp\group2
clear
matrix input mean = (3.0 82)
matrix input SD = (0 10)
matrix input corr = (1.0,.0\.0,1.00)
corr2data x y , n(525) means(mean) corr(corr) sds(SD)
save c:\temp\group3
clear
matrix input mean = (4.0 86)
matrix input SD = (0 10)
matrix input corr = (1.0,.0\.0,1.00)
corr2data x y , n(525) means(mean) corr(corr) sds(SD)
save c:\temp\group4
clear
append using c:\temp\group1 c:\temp\group2 c:\temp\group3 c:\temp\group4
save c:\temp\merged_data
anova y x
generate alpha = .017
generate lambda = `e(F)' *  `e(df_m)'
generate fcritical = invFtail(`e(df_m)', `e(df_r)', alpha)
generate fcritical_c = invFtail(1, `e(df_r)', alpha)
generate  Power=nFtail(`e(df_m)', `e(df_r)', lambda, fcritical)
contrast {x 1 -1 0 0}, effects
matrix c1=r(table)
generate lambda1 = c1[3,1]^2
contrast {x 1 0 -1 0}, effects
matrix c2=r(table)
generate lambda2 = c2[3,1]^2
contrast {x 1 0 0 -1}, effects
matrix c3=r(table)
generate lambda3 = c3[3,1]^2
generate  Power_c1=nFtail(1, `e(df_r)', lambda1, fcritical_c)
generate  Power_c2=nFtail(1, `e(df_r)', lambda2, fcritical_c)
generate  Power_c3=nFtail(1, `e(df_r)', lambda3, fcritical_c)

tabstat lambda1 Power_c1 lambda2 Power_c2 lambda3 Power_c3, statistics( mean )

erase c:\temp\group1.dta
erase c:\temp\group2.dta
erase c:\temp\group3.dta
erase c:\temp\group4.dta
erase c:\temp\merged_data.dta


