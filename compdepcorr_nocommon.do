clear all
set obs 11
generate person = _n - 1
generate start = 20
generate by = 10
generate n = (start)+(by*person)

generate r12 = .4
generate rxy = .7
generate r1x = .3
generate r1y = .1 
generate r2x = .45
generate r2y = .35 
generate alpha = .05
generate tails = 2
generate z_r12 = 0.5 * (ln((1 + r12) / (1 - r12)))
generate z_rxy = 0.5 * (ln((1 + rxy) / (1 - rxy)))
generate q = abs(z_r12-z_rxy)
generate r_ave = (r12+rxy)/2
generate denom = (1-r_ave^2)^2 
generate numer1 = (r1x -(r12*r2x))*(r2y-(r2x*rxy))
generate numer2 = (r1y -(r1x*rxy))*(r2x-(r12*r1x))
generate numer3 = (r1x -(r1y*rxy))*(r2y-(r12*r1y))
generate numer4 = (r1y -(r12*r2y))*(r2x-(r2y*rxy))
generate numer = (numer1 + numer2 +numer3+numer4)/2 
generate cov = numer /denom
generate z = (q*((n-3)^.5)) / ((2-(2*cov))^.5)

generate prob = 1-alpha
replace prob = 1-(alpha/2) if tails == 2
generate tabled = invnormal(prob)
generate z_power = tabled-z
generate Power = 1-normal(z_power) 
generate p = (1-normal(z))*tails 
list n Power z p
