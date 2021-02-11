clear all
matrix input mean = (1.0 2.0 3.0 4.0)
matrix input SD = (7 1 1 2)
matrix input corr = (1.0,.40,.40,-.40\.40,1.0,-.15,-.60\.40,-.15,1.0,.25\-.40,-.60,.25,1.00)
corr2data y x1 x2 x3, n(110) means(mean) corr(corr) sds(SD)
regress y x1 x2 x3
generate alpha = .05
generate df_r = e(df_r)
generate df1=1
generate df2 = df_r
generate dfm=e(df_m)
generate lambda_b1 =( _b[x1] / _se[x1])^2
generate lambda_b2 =( _b[x2] / _se[x2])^2
generate lambda_b3 =( _b[x3] / _se[x3])^2
generate lambda_R2=e(F)*dfm
generate fcritical = invFtail(df1, df2, alpha)
generate fcritical_R2 = invFtail(dfm, df2,  alpha)
generate  Power_b1=nFtail(df1, df2, lambda_b1, fcritical)
generate  Power_b2=nFtail(df1, df2, lambda_b2, fcritical)
generate  Power_b3=nFtail(df1, df2, lambda_b3, fcritical)
generate  Power_R2 = nFtail(dfm, df2, lambda_R2, fcritical_R2)
tabstat Power_b1 Power_b2 Power_b3 Power_R2, statistics( mean )
