
* if you have not already installed this module from the World Bank, you need to:
ssc install wbopendata

wbopendata, indicator(SI.POV.GINI; NY.GDP.PCAP.PP.KD) clear long
keep if year <= 2020
rename si_pov_gini gini
rename ny_gdp_pcap_pp_kd gdp_pc

collapse (mean) gini (mean) gdp_pc (first) countryname, by(countrycode)
gen ln_gdp_pc = ln(gdp_pc)

twoway (scatter gini ln_gdp_pc, mlab(countrycode) mcol(gs5) mlabcol(gs9) ytitle("Gini index") xtitle("GDP p.c. (in PPP and natural logs)") legend(off) note(Data source: WDI; Graph: KMW)) (scatter gini ln_gdp_pc if countrycode=="USA", mlab(countrycode) mlabcol(red)) (lfit gini ln_gdp_pc, lcol(blue))

*check if US also stands out when plotted the other way round:
twoway (scatter ln_gdp_pc gini, mlab(countrycode) mlabcol(gs5) xtitle("Gini index") ytitle("GDP p.c. (in PPP and natural logs)") legend(off)) (scatter ln_gdp_pc gini if countrycode=="USA", mlab(countrycode) mlabcol(red)) (lfit ln_gdp_pc gini)