clear all

matrix input mean = (0 0)
matrix input SD = (0 0)
matrix input corr = (1.0,.0\.0,1.00)
corr2data x y , n(50) means(mean) corr(corr) sds(SD)
save c:\temp\log1
clear
matrix input mean = (0 1)
matrix input SD = (0 0)
matrix input corr = (1.0,.0\.0,1.00)
corr2data x y , n(50) means(mean) corr(corr) sds(SD)
save c:\temp\log2
clear
matrix input mean = (1 0)
matrix input SD = (0 0)
matrix input corr = (1.0,.0\.0,1.00)
corr2data x y , n(33) means(mean) corr(corr) sds(SD)
save c:\temp\log3
clear
matrix input mean = (1 1)
matrix input SD = (0 0)
matrix input corr = (1.0,.0\.0,1.00)
corr2data x y , n(67) means(mean) corr(corr) sds(SD)
save c:\temp\log4
clear

append using c:\temp\log1 c:\temp\log2 c:\temp\log3 c:\temp\log4
save c:\temp\merged_log
logistic y x

generate alpha = .05
generate lambda = (_b[y:x] /  _se[y:x])^2

generate chicritical = invchi2tail(e(df_m),  alpha)
generate Power = 1-nchi2(e(df_m), lambda, chicritical)
tabstat Power, statistics( mean )

erase c:\temp\log1.dta
erase c:\temp\log2.dta
erase c:\temp\log3.dta
erase c:\temp\log4.dta
erase c:\temp\merged_log.dta

