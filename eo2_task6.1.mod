# AMPL for Task 6

param num_people >= 1, integer; # number of people 

set DONORS := 1..num_people; # people who donate kidneys
set RECIPIENTS := 1..num_people; # people who receive kidney donations
set PAIRS := {DONORS,RECIPIENTS}; # create matrix of donor/recipient pairs

param compat_pairs{(i,j) in PAIRS}; # shows compatible donor/recipient pairs

var X{PAIRS} >= 0, binary; # whether a specific donor donates to a specific recipient

maximize Pairwise_Swaps: sum{(i,j) in PAIRS} compat_pairs[i,j]*X[i,j]; # maximize number of pairs

subject to Donate_Receive {i in DONORS}: sum{j in RECIPIENTS} X[i,j]*compat_pairs[i,j] = sum{j in DONORS} X[j,i]*compat_pairs[j,i]; # ensures that each donor also receives a kidney

#subject to Yo {i in DONORS}: sum{j in RECIPIENTS} X[i,j]*compat_pairs[i,j] <= 1;

subject to Kidney_Donate {i in DONORS}: sum{j in RECIPIENTS} X[i,j]*compat_pairs[i,j] <= 1; # ensures that each donor only donates one kidney
subject to Kidney_Recieve {j in RECIPIENTS}: sum{i in DONORS} X[i,j]*compat_pairs[i,j] <= 1; # ensures that each recipient only receives one kidney

subject to Cycle_Constraint {(i,j) in PAIRS, (k,l) in PAIRS}: compat_pairs[i,j]*X[i,j] + compat_pairs[j,k]*X[j,k] + compat_pairs[k,l]*X[k,l] <= 2; # ensures no cycles greater than 2