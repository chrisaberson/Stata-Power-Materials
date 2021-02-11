clear all
matrix input mean = (-.25 0.0 0.10 0.15)
matrix input SD = (.4 .5 .6 .7)
matrix input corr = (1.0,.50,.30,.15\.50,1.0,.50,.30\.30,.50,1.0,.50\.15,.30,.50,1.00)
corr2data time1 time2 time3 time4, n(25) means(mean) corr(corr) sds(SD)
generate person = _n
save c:\temp\onef_repeated
reshape long time, i(person) j(ti)
save c:\temp\onef_repeated_reshap
anova time person ti, repeated(ti)

generate alpha = .05

generate hf =  `e(hf1)' 
generate gg =  `e(gg1)' 
generate lambda = `e(F_2)' *  `e(df_2)'
generate fcritical = invFtail(`e(df_2)', `e(df_r)', alpha)
generate  Power=nFtail(`e(df_2)', `e(df_r)', lambda, fcritical)
generate df_hfnum = `e(hf1)'*`e(df_2)'
generate df_hfdenom = `e(hf1)'*`e(df_r)'
generate lambda_hf = (lambda/`e(N)') * (`e(N)' * `e(hf1)')
generate fcritical_hf = invFtail(df_hfnum, df_hfdenom, alpha)
generate  Power_hf=nFtail(df_hfnum, df_hfdenom, lambda_hf, fcritical_hf)
generate df_ggnum = `e(gg1)'*`e(df_2)'
generate df_ggdenom = `e(gg1)'*`e(df_r)'
generate lambda_gg = (lambda/`e(N)') * (`e(N)' * `e(gg1)')
generate fcritical_gg = invFtail(df_ggnum, df_ggdenom, alpha)
generate  Power_gg=nFtail(df_ggnum, df_ggdenom, lambda_gg, fcritical_gg)
save c:\temp\onef_estimates

use c:\temp\onef_repeated

generate con = 1
manova time1 time2 time3 time4 = con, noconstant
mat ycomp = (1,0,0,-1\0,1,0,-1\0,0,1,-1)
mat list ycomp
manovatest con, ytrans(ycomp)
generate alpha = .05
matrix MV=r(stat)
generate FMV = MV[1,2]
generate dfmv_1 = MV[1,3]
generate dfmv_2 = MV[1,4]
generate lambda_mv = FMV * dfmv_1
generate fcritical_mv = invFtail(dfmv_1, dfmv_2, alpha)
generate  Power_mv=nFtail(dfmv_1, dfmv_2, lambda_mv, fcritical_mv)
save c:\temp\onef_estimates_mv

use c:\temp\onef_estimates
tabstat lambda Power Power_hf Power_gg, statistics( mean )
use c:\temp\onef_estimates_mv
tabstat lambda_mv Power_mv, statistics( mean )


erase c:\temp\onef_repeated.dta
erase  c:\temp\onef_repeated_reshap.dta
erase c:\temp\onef_estimates.dta
erase c:\temp\onef_estimates_mv.dta
