use "S:\College\Current Classes\Eco 231w\replication_data.dta", clear
merge 1:1 _n using "C:\Users\mtaruno\Desktop\modified_replication_data.dta", keepusing(simul_wages)
drop if bpl == 600 & yrsusa <= 1
drop if uhrswork <= 35
tab educ
drop if year <= 2010
drop if year == 2016
replace incwage = incwage * 1.053695 if year == 2011
replace incwage = incwage * 1.032331 if year == 2012
replace incwage = incwage * 1.017428 if year == 2013
replace incwage = incwage * 1.001187 if year == 2014
replace marst = 1000 if marst == 1
replace marst = 0 if marst != 1000
replace yrsusa = 1 if yrsusa <=9
replace yrsusa = 2 if inrange(yrsusa, 10,19)
replace yrsusa = 3 if yrsusa >= 20
replace educd = 1000 if educd<= 62
replace educd = 2000 if inrange(educd,63,64)
replace educd = 3000 if inrange(educd, 65, 100)
replace educd = 4000 if educd == 101
replace educd = 5000 if educd == 114
replace educd = 6000 if educd == 115
replace educd = 7000 if educd == 116
tab educd if bpl == 600
tab educd if bpl != 600
sum incwage if bpl == 600 & educd == 1000, detail
sum incwage if bpl != 600 & educd == 1000, detail
sum incwage if bpl == 600 & educd == 2000, detail
sum incwage if bpl != 600 & educd == 2000, detail
sum incwage if bpl == 600 & educd == 3000, detail
sum incwage if bpl != 600 & educd == 3000, detail
sum incwage if bpl == 600 & educd == 4000, detail
sum incwage if bpl != 600 & educd == 4000, detail
sum incwage if bpl == 600 & educd == 5000, detail
sum incwage if bpl != 600 & educd == 5000, detail
sum incwage if bpl == 600 & educd == 6000, detail
sum incwage if bpl != 600 & educd == 6000, detail
sum incwage if bpl == 600 & educd == 7000, detail
sum incwage if bpl != 600 & educd == 7000, detail
tab sex if bpl == 600
tab sex if bpl != 600
sum incwage if bpl == 600 & sex == 1, detail
sum incwage if bpl != 600 & sex == 2, detail
tab speakeng if bpl == 600
sum incwage if bpl == 600 & speakeng ==1 | speakeng == 6,detail
sum incwage if bpl == 600 & speakeng !=1 | speakeng != 6,detail
tab yrsusa1 
tab yrsusa1 if bpl == 600
tab yrsusa1 if bpl != 600
sum incwage if bpl == 600 & yrsusa1 ==1, detail
sum incwage if bpl == 600 & yrsusa1 ==2, detail
sum incwage if bpl == 600 & yrsusa1 ==3, detail
tab bpld if bpl ==600
sum incwage if bpl == 600 & bpld == 60012, detail
sum incwage if bpl == 600 & bpld == 60044, detail
sum incwage if bpl == 600 & bpld == 60023, detail
sum incwage if bpl == 600 & bpld == 60045, detail
sum incwage if bpl == 600 & bpld == 60031, detail
sum incwage if bpl == 600 & bpld == 60094, detail
sum incwage if bpl == 600 & bpld != 60094 & bpld != 60012 & bpld != 60044 & bpld != 60023& bpld != 60031& bpld != 60045,detail
tab colony if bpl ==600
sum incwage if bpl == 600 & colony ==1,detail
sum incwage if bpl == 600 & colony ==2,detail
sum incwage if bpl == 600 & colony ==3,detail
//Get the sample size
sum bpl if bpl ==600
sum bpl if bpl !=600
//table 3
gen age2 = age^2
tabulate sex, gen(female)
drop female1
tab educd, generate(education)
tab degfield
sort degfield
// degfield = 1000 means it is a STEM major
replace degfield = 1000 if degfield != 64 & degfield != 62 & degfield != 19 & degfield !=22 & degfield != 23 & degfield != 26 & degfield != 32 & degfield != 33 & degfield != 34 & degfield != 40 & degfield != 48 & degfield != 49 & degfield != 52 & degfield != 54 & degfield != 55 & degfield != 60
replace degfield =2000 if degfield !=1000
tab degfield, gen(stem)
tab marst, gen(married)
//drop the not married stats
drop married1
gen fem_mar = female * married2
//borned abroad = 1, natualized citizen=2. Both are American citizens
replace citizen = 1000 if citizen ==1 | citizen ==2
//if not a citizen change the data to 3
replace citizen = 2000 if citizen ==3
tab citizen, gen(citizen)
//drop non-itizen variable
drop citizen1
drop citizen3
tab speakeng
//speakeng = 1000  for limited english
replace speakeng = 1000 if speakeng ==1 |speakeng ==6
replace speakeng = 2000 if speakeng !=1000
tab yrsusa1, gen(yearsusa)
drop yearsusa1
tab bpld if bpl == 600
drop brcol
drop frcol
tab colony, gen(colonies)
drop colonies3
//replace bpld = 1 if it's Egypt
replace bpld = 1 if bpld == 60012
//replace bpld = 1 if it's Kenya
replace bpld = 2 if bpld == 60045
//replace bpld = 1 if it's Ethiopia
replace bpld = 3 if bpld == 60044
//replace bpld = 1 if it's Nigeria
replace bpld = 4 if bpld == 60031
//replace bpld = 1 if it's Ghana
replace bpld = 5 if bpld == 60023
//replace bpld = 1 if it's South Africa
replace bpld = 6 if bpld == 60094
replace bpld = 7 if bpl ==600 & bpld != 1 & bpld != 2 & bpld != 3 & bpld != 4& bpld != 5& bpld != 6
//genrate a new vairable = log(income and wage)
gen lnwage = log(incwage)
replace lnwage = 0 if lnwage ==.
//run the regression
regress lnwage education2 education3 education4 education5 education6 education7 stem1 age age2 female2 married2 fem_mar uhrswork if bpl == 600
regress lnwage education2 education3 education4 education5 education6 education7 stem1 age age2 female2 married2 fem_mar uhrswork if bpl != 600
//generate dummy variable for lmited englilsh 
tab speakeng, gen(limitedeng)
drop limitedeng2
//generate dummy avariables for all the African countries
tab bpld if inrange(bpld,1,7), gen(origin)
regress lnwage education2 education3 education4 education5 education6 education7 stem1 age age2 female2 married2 fem_mar uhrswork citizen2 limitedeng1 yearsusa2 yearsusa3 origin1 origin2 origin3 origin4 origin5 origin6 if bpl == 600
regress lnwage education2 education3 education4 education5 education6 education7 stem1 age age2 female2 married2 fem_mar uhrswork citizen2 limitedeng1 yearsusa2 yearsusa3 colonies1 colonies2 saharan lowgdp if bpl == 600
// simul wage
gen lnsimul_wage = log(simul_wage)
regress lnwage education2 education3 education4 education5 education6 education7 stem1 age age2 female2 married2 fem_mar uhrswork lnsimul_wage if bpl == 600
gen stem_simul_wage = simul_wage + 25000
regress lnwage education2 education3 education4 education5 education6 education7 stem1 age age2 female2 married2 fem_mar uhrswork lnstem_simul_wage if bpl == 600

