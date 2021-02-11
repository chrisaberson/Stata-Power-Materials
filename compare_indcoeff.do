clear all
set obs 21
generate start = 100
generate by = 10

generate prop_n1 = 0.5
generate b1 = 3.733
generate r2y1 = .467
generate r2_1 = .063
generate b2 = 1.493
generate r2y2 = .243
generate r2_2 = .063
generate sdy1 = 7
generate sdy2 = 7
generate sd1 = 1
generate sd2 = 1
generate alpha = .05
generate tails = 2
generate k = 3


generate person = _n - 1
generate n = (start)+(10*person)
generate n1 = n * prop_n1
generate n2 = n * (1-prop_n1)
generate seb1 = (sdy1/sd1)* (1/(1-r2_1)^.5)*(((1-r2y1)/(n1-k-1))^.5)
generate seb2 = (sdy2/sd2)*(1/(1-r2_2)^.5)*(((1-r2y2)/(n2-k-1))^.5)
generate df2 = n1+n2-k-k-2
generate alpha_tails = alpha/tails
generate fail = 1-alpha_tails
generate diff = abs(b1-b2)
generate sediff = ((seb1^2) + (seb2^2))^.5
generate lambda = (diff / sediff)^2

generate fcritical = invFtail(1, df2,  alpha)
generate Power = nFtail(1, df2, lambda, fcritical)
generate tcritical = invttail(df2,  alpha_tails)
generate LL_diff = diff - (tcritical*sediff)
generate UL_diff = diff + (tcritical*sediff)
list n1 n2 LL_diff UL_diff Power
