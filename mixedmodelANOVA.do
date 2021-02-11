clear
matrix input mean = (-.25 0.0 0.10 0.15)
matrix input SD = (.4 .4 .4 .4)
matrix input corr = (1.0,.50,.50,.50\.50,1.0,.50,.50\.50,.50,1.0,.50\.50,.50,.50,1.00)
corr2data time1 time2 time3 time4, n(20) means(mean) corr(corr) sds(SD)
generate condition = 1
save c:\temp\mixed1
clear

matrix input mean = (-.25 -.25 -.25 -.25)
matrix input SD = (.4 .4 .4 .4)
matrix input corr = (1.0,.50,.50,.50\.50,1.0,.50,.50\.50,.50,1.0,.50\.50,.50,.50,1.00)
corr2data time1 time2 time3 time4, n(20) means(mean) corr(corr) sds(SD)
generate condition = 2
save c:\temp\mixed2
clear
append using c:\temp\mixed1 c:\temp\mixed2
generate person = _n
save c:\temp\merged_mixed
reshape long time, i(person) j(ti)
save c:\temp\onef_repeated_reshap

anova time condition / person|condition ti condition#ti/, repeated(ti)
generate alpha = .05

generate Lambda_bet = `e(F_1)' * `e(df_1)'
generate fcritical_bet = invFtail(`e(df_1)', `e(df_2)', alpha)
generate  Power_bet=nFtail(`e(df_1)', `e(df_2)', Lambda_bet, fcritical_bet)

generate Lambda_rep = `e(F_3)' * `e(df_3)'
generate fcritical_rep = invFtail(`e(df_3)', `e(df_r)', alpha)
generate  Power_rep=nFtail(`e(df_3)', `e(df_r)', Lambda_rep, fcritical_rep)
generate Lambda_int = `e(F_4)' * `e(df_4)'
generate fcritical_int = invFtail(`e(df_4)', `e(df_r)', alpha)
generate  Power_int=nFtail(`e(df_4)', `e(df_r)', Lambda_int, fcritical_int)

save c:\temp\mixed_estimates_uni


clear all



use c:\temp\merged_mixed

manova time1 time2 time3 time4 = condition
mat ycomp = (1,0,0,-1\0,1,0,-1\0,0,1,-1)
mat list ycomp
manovatest condition, ytransform(ycomp)

generate alpha = .05
matrix MV=r(stat)
generate Fint_mv = MV[1,2]
generate df_int_1 = MV[1,3]
generate df_int_2 = MV[1,4]
generate lambda_intmv = Fint_mv * df_int_1
generate fcritical_intmv = invFtail(df_int_1, df_int_2, alpha)
generate  Power_intmv=nFtail(df_int_1, df_int_2, lambda_intmv, fcritical_intmv)


mat xmat = (.5, .5, 1)
mat list xmat 
manovatest, test(xmat) ytransform(ycomp)

matrix MV=r(stat)
generate Frep_mv = MV[1,2]
generate df_rep_1 = MV[1,3]
generate df_rep_2 = MV[1,4]
generate lambda_repmv = Frep_mv * df_rep_1
generate fcritical_repmv = invFtail(df_rep_1, df_rep_2, alpha)
generate  Power_repmv=nFtail(df_rep_1, df_rep_2, lambda_repmv, fcritical_repmv)
save c:\temp\mixed_estimates_mv


use c:\temp\mixed_estimates_uni
generate L_Bet = Lambda_bet
generate P_Bet = Power_bet 
generate L_Rep_U = Lambda_rep 
generate P_Rep_U = Power_rep 
generate L_Int_U = Lambda_int 
generate P_Int_U = Power_int 
save c:\temp\mixed_estimates_uni2
use c:\temp\mixed_estimates_mv
generate L_Rep_MV = lambda_repmv 
generate P_Rep_MV = Power_repmv 
generate L_Int_MV = lambda_intmv 
generate P_Int_MV = Power_intmv 
save c:\temp\mixed_estimates_mv2

use c:\temp\mixed_estimates_uni2
tabstat  L_Bet P_Bet L_Rep_U P_Rep_U L_Int_U P_Int_U, statistics( mean )
use c:\temp\mixed_estimates_mv2
tabstat L_Rep_MV P_Rep_MV L_Int_MV P_Int_MV, statistics( mean )



erase c:\temp\mixed_estimates_uni.dta
erase c:\temp\mixed_estimates_uni2.dta
erase c:\temp\mixed_estimates_mv.dta
erase c:\temp\mixed_estimates_mv2.dta
erase c:\temp\mixed1.dta
erase c:\temp\mixed2.dta
erase c:\temp\merged_mixed.dta
erase c:\temp\onef_repeated_reshap.dta
