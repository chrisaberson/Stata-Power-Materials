
clear all
program define regmult
drop _all
matrix c = (1.0,.30,.30, .30 \.30,1.0,.30,.40\.30,.30,1.0, .30\.30, .40, .30, 1.0)
matrix m = (0, 0, 0, 0 )
matrix sd = (1, 1, 1, 1)
drawnorm y x1 x2 x3, n(282) corr(c) means(m) sds(sd)
regress y x1 x2 x3
end

simulate _b _se, reps(10000): regmult

generate alpha = .05
generate df1=1
generate df2 = e(df_r)
generate lambda_b1 =( _b_x1 / _se_x1)^2
generate lambda_b2 = (_b_x2 / _se_x2)^2
generate lambda_b3 = (_b_x3 / _se_x3)^2
generate fcritical = invFtail(df1, df2, .05)
generate prob1 = Ftail(df1,df2,lambda_b1)
generate power_b1 = .
replace  power_b1 = 0 if (prob1>=alpha)
replace  power_b1 = 1 if (prob1<alpha)
generate prob2 = Ftail(df1,df2,lambda_b2)
generate power_b2 = .
replace  power_b2 = 0 if (prob2>=alpha)
replace  power_b2 = 1 if (prob2<alpha)
generate prob3 = Ftail(df1,df2,lambda_b3)
generate power_b3 = .
replace  power_b3 = 0 if (prob3>=alpha)
replace  power_b3 = 1 if (prob3<alpha)
generate Rejected = power_b1+power_b2+power_b3
label define Rejected 0 "Zero" 1 "One" 2 "Two" 3 "Three"
label values Rejected
tabstat power_b1 power_b2 power_b3, statistics( mean )
proportion Rejected
