clear all
matrix input mean = (-.25 0.0 0.10 0.15)
matrix input SD = (.4 .4 .4 .4)
matrix input corr = (1.0,.50,.50,.50\.50,1.0,.50,.50\.50,.50,1.0,.50\.50,.50,.50,1.00)
corr2data time1 time2 time3 time4, n(18) means(mean) corr(corr) sds(SD)
generate person = _n

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
tabstat lambda_mv Power_mv, statistics( mean )

