clear all
set obs 16
generate person = _n - 1
generate start = 100
generate by = 40
generate n = (start)+(by*person)

generate Estimates = 1 
generate Group1 = .80
generate Group2 = .65
generate sx1 = 2.10
generate sx2= 2.10
generate sy1= 2.6
generate sy2= 2.6 
generate alpha = .05
generate Prop_N1 = 0.5

generate n1 = n * Prop_N1
generate n2 = n * (1-Prop_N1)
generate r1 = Group1
replace r1 = Group1*(sx1/sy1) if Estimates == 2
generate r2 = Group2
replace r2 = Group2*(sx2/sy2) if Estimates == 2

generate sx1_sq = sx1^2 	
generate sx2_sq = sx2^2
generate sy1_sq = sy1^2
generate sy2_sq = sy2^2
generate r1_sq = r1^2
generate r2_sq = r2^2
generate numer1 = ((n1-1)*r1_sq* sy1_sq) + ((n2-1)*r2_sq* sy2_sq)
generate numer2 = (((n1-1)*r1 * sx1 * sy1)+ ((n2-1)*r2 * sx2 * sy2))^2
generate numer3 = ((n1-1)* sx1_sq)+ ((n2-1)* sx2_sq)
generate numer = numer1 - (numer2 / numer3)
generate denom = ((n1-2)*(1-r1_sq)* sy1_sq) + ((n2-2)*(1-r2_sq)* sy2_sq)
generate f2 = numer/denom
generate df1 = 1
generate df2 = n-4
generate lambda = f2 * df2
generate fcritical = invFtail(1, df2,  alpha)
generate Power = nFtail(1, df2, lambda, fcritical)


list n1 n2 lambda Power
