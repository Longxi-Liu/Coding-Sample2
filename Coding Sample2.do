//First regression，London——OLS
clear

import excel "D:\Files\Postgraduate Files\2023-24\Project\data.xlsx", sheet("London") firstrow

gen logy=log(Price)

reg logy Primary Secondary Type Bedroom Bathroom Parking Garden

eststo LondonOLS


//Second regression，London——Stationary IV
clear

import excel "D:\Files\Postgraduate Files\2023-24\Project\data.xlsx", sheet("London") firstrow

gen logy=log(Price)

ivreg2 logy (Primary Secondary = Inspected Church) Type Bedroom Bathroom Parking Garden 

eststo LondonIV


//Third regression，London——Dynamic IV
clear

import excel "D:\Files\Postgraduate Files\2023-24\Project\data.xlsx", sheet("London") firstrow

gen logy=log(Price)

ivreg2 logy (Primary Secondary D_primary D_secondary A_primary A_secondary = Inspected Church D_inspected D_church A_inspected A_church) Type Bedroom Bathroom Parking Garden During After

eststo London


//Fourth regression，London——FE
clear

import excel "D:\Files\Postgraduate Files\2023-24\Project\data.xlsx", sheet("Fixed Effect") firstrow

gen logy=log(Price)

encode District, generate(NDistrict)

gen D_NDistrict=NDistrict*During
gen A_NDistrict=NDistrict*After
 
reg logy Primary Secondary D_primary D_secondary A_primary A_secondary Type Bedroom Bathroom Parking Garden During After NDistrict D_NDistrict A_NDistrict

eststo LondonFE


//Fifth regression，Birmingham
clear

import excel "D:\Files\Postgraduate Files\2023-24\Project\data.xlsx", sheet("Birmingham") firstrow

gen logy=log(Price)

ivreg2 logy (Primary Secondary D_primary D_secondary A_primary A_secondary = Inspected Church D_inspected D_church A_inspected A_church) Type Bedroom Bathroom Parking Garden During After

eststo Birmingham


//Sixth regression，Liverpool
clear

import excel "D:\Files\Postgraduate Files\2023-24\Project\data.xlsx", sheet("Liverpool") firstrow

gen logy=log(Price)

ivreg2 logy (Primary Secondary D_primary D_secondary A_primary A_secondary = Inspected Church D_inspected D_church A_inspected A_church) Type Bedroom Bathroom Parking Garden During After

eststo Liverpool


//Seventh regression，London24
clear

import excel "D:\Files\Postgraduate Files\2023-24\Project\data.xlsx", sheet("London2024") firstrow

gen logy=log(Price)

ivreg2 logy (Primary Secondary = Inspected Church) Type Bedroom Bathroom Parking Garden 

eststo London24


//Eighth regression，Birmingham24
clear

import excel "D:\Files\Postgraduate Files\2023-24\Project\data.xlsx", sheet("Birmingham2024") firstrow

gen logy=log(Price)

ivreg2 logy (Primary Secondary = Inspected Church) Type Bedroom Bathroom Parking Garden 

eststo Birmingham24


//Ninth regression，Liverpool24
clear

import excel "D:\Files\Postgraduate Files\2023-24\Project\data.xlsx", sheet("Liverpool2024") firstrow

gen logy=log(Price)

ivreg2 logy (Primary Secondary = Inspected Church) Type Bedroom Bathroom Parking Garden 

eststo Liverpool24

esttab LondonOLS LondonIV London LondonFE Birmingham Liverpool London24 Birmingham24 Liverpool24 using "D:\Files\Postgraduate Files\2023-24\Project\result.csv", se(2) star( * 0.15 ** 0.1 *** 0.05 )