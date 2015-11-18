# AMPL Model for Task 2

param num_people >= 1; # number of people 

set indv := 1..num_people; #donor-recipient pairs who donate kidneys
set PAIRS := {indv, indv};
set 3D := {indv, indv, indv}; #set of cycles of length 3
set 2D := {indv, indv}; #set of cycles of length 2

param compat_pairs {(i,j) in PAIRS};

var X{3D} >=0, binary;
var Y{2D} >=0, binary;
var threedef >=0, integer;
var twodef >=0, integer;

# remember objective value will count (2,1) and (1,2) as separate
maximize OBJ: 2*threedef + 4*twodef;
#maximize OBJ: sum{(i,j) in 2D} vis[i,j];

subject to thrdefinition: threedef = sum{(i,j,k) in 3D} X[i,j,k];
subject to twodefinition: twodef = sum{(i,j) in 2D} Y[i,j];

subject to first {i in indv}: sum{(i,j,k) in 3D} (X[i,j,k]+Y[i,j] + Y[k,i]) <= 1;
subject to second {j in indv}: sum{(i,j,k) in 3D} (X[i,j,k] + Y[i,j] + Y[j,k]) <= 1;
subject to third {k in indv}: sum{(i,j,k) in 3D} (X[i,j,k] + Y[j,k] + Y[k,i]) <= 1;


subject to fourth {(i,j,k) in 3D}: 3*X[i,j,k] <= compat_pairs[i,j]+compat_pairs[j,k]+compat_pairs[k,i]; 
subject to fifth {(i,j) in 2D}: 2*Y[i,j] <= compat_pairs[i,j]+compat_pairs[j,i];