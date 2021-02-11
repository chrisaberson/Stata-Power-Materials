clear all
set obs 21
generate person = _n - 1
generate start = 200
generate by = 10
generate n = (start)+(by*person)
generate r1y = .3
generate r2y = .1
generate r12 = .04 
generate alpha = .05
generate tails = 2
generate df2 = n-3  
generate r_diff =abs(r1y-r2y)
generate r_ave = (r1y+r2y)/2
generate r_det = 1-(r1y^2)-(r2y^2)-(r12^2)+(2*r1y*r2y*r12)
generate numer = (n-1)*(1+r12)
generate denom1 = ((2*(n-1))/(n-3))*r_det
generate denom2 = (r_ave^2)*((1-r12)^3)
generate denom = denom1+denom2
generate lambda = (r_diff*((numer/denom)^.5))^2
generate alpha_tails = alpha/tails
generate fail = 1-alpha_tails
generate fcritical = invFtail(1, df2,  alpha)
generate Power = nFtail(1, df2, lambda, fcritical)
generate t = lambda^.5
generate p = 1-F(1,df2,lambda)
list n Power t p
