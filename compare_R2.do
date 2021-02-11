clear all
set obs 18
generate person = _n - 1
generate start = 230
generate by = 10
generate n = (start)+(10*person)
generate prop_n1 = 0.5
generate R2_1 = .467
generate R2_2 = .242
generate k =3
generate alpha = .05
generate tails = 2
generate n1 = n * prop_n1
generate n2 = n * (1-prop_n1)
generate SER2_1 = ((4*R2_1)*(1-R2_1)^2)*((n1-k-1)^2) / ((n1^2 - 1)* (n1+3))
generate SER2_2 = ((4*R2_2)*(1-R2_2)^2)*((n2-k-1)^2) / ((n2^2 - 1)* (n2+3))
generate SER2 = (SER2_1 + SER2_2)^.5
generate diff = abs(R2_1-R2_2)
generate alpha_tails = alpha/tails
generate fail = 1-alpha_tails
generate df2 = n1+n2-k-k-1
generate lambda = (diff / SER2)^2
generate fcritical = invFtail(1, df2,  alpha)
generate Power_R2 = nFtail(1, df2, lambda, fcritical)
generate tcritical = invttail(df2,  alpha)
generate LL_diff = diff - (tcritical*SER2)
generate UL_diff = diff + (tcritical*SER2)
list n1 n2 LL_diff UL_diff Power_R2
