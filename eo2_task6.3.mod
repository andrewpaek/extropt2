# AMPL Model for Task 2

param num_people >= 1; # number of people 

set PAIRS := 1..num_people; #donor-recipient pairs who donate kidneys
set 3D := {PAIRS, PAIRS, PAIRS}; #set of cycles of length 3
set 2D := {PAIRS, PAIRS}; #set of cycles of length 2

param compat_pairs {(i,j) in 2D};

var X{3D} >=0, binary;
var Y{2D} >=0, binary;
var ind3 >=0, binary;

# remember objective value will count (2,1) and (1,2) as separate
maximize OBJ: (sum{(i,j,k) in 3D} X[i,j,k]) + (sum{(i,j) in 2D} Y[i,j]);

subject to first {i in PAIRS}: sum{(i,j,k) in 3D} (X[i,j,k] + Y[i,j] + Y[j,k] + Y[k,i]) <= 1;
subject to second {j in PAIRS}: sum{(i,j,k) in 3D} (X[i,j,k] + Y[i,j] + Y[j,k] + Y[k,i]) <= 1;
subject to third {k in PAIRS}: sum{(i,j,k) in 3D} (X[i,j,k] + Y[i,j] + Y[j,k] + Y[j,k]) <= 1;
subject to fourth {(i,j,k) in 3D}: 3*X[i,j,k] = compat_pairs[i,j]+compat_pairs[j,k]+compat_pairs[k,i]; 