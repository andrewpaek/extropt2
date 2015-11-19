# AMPL Model for Task 2

param num_people >= 1; # number of people 

set PAIRS := 1..num_people; #donor-recipient pairs who donate kidneys
set 3D := {PAIRS, PAIRS, PAIRS}; #set of cycles of length 3
set 2D := {PAIRS, PAIRS}; #set of cycles of length 2

param compat_pairs {(i,j) in 2D};

var X{3D} >=0, binary;
var Y{2D} >=0, binary;
var vis{2D} >=0, binary;
var twodef >=0, integer;
var threedef >=0, integer;
var test{PAIRS} >=0, integer;


# remember objective value will count (2,1) and (1,2) as separate
maximize OBJ: 3*(sum{(i,j,k) in 3D:i<j and i<k} X[i,j,k]) + (sum{(i,j) in 2D} Y[i,j]);

subject to testd{k in PAIRS}: sum{(i,j) in 2D} X[i,j,k] = test[k]; 
subject to twod: sum{(i,j) in 2D} Y[i,j] = twodef;
subject to threed: sum{(i,j,k) in 3D} X[i,j,k] = threedef;

subject to first {a in PAIRS}: (sum{(j,k) in 2D} X[a,j,k])+(sum{(i,k) in 2D} X[i,a,k]) + (sum{(i,j) in 2D} X[i,j,a]) <=1;
#subject to second {j in PAIRS}: sum{(i,k) in 2D:i<>j<>k} X[i,j,k] <=1;
#subject to third {k in PAIRS}: sum{(i,j) in 2D:i<>j<>k} X[i,j,k] <=1;
subject to fix{i in PAIRS}: sum{j in PAIRS} Y[i,j] <=1;
subject to lala{j in PAIRS}: sum{i in PAIRS} Y[i,j] <=1;

subject to hm {i in PAIRS}: sum{(j,k) in 2D} X[i,j,k] + sum{j in PAIRS} Y[i,j] <=1;
subject to gr {j in PAIRS}: sum{(i,k) in 2D} X[i,j,k] + sum{i in PAIRS} Y[j,i] <=1;
subject to grr {k in PAIRS}: sum{(i,j) in 2D} X[i,j,k] + sum{j in PAIRS} Y[k,j] <=1;
subject to pairs {(i,j) in 2D:i<>j}: Y[i,j] = Y[j,i];

subject to fourth {(i,j,k) in 3D:i<j and i<k}: 3*X[i,j,k] <= compat_pairs[i,j]+compat_pairs[j,k]+compat_pairs[k,i]; 


subject to fifth{(i,j) in 2D}: Y[i,j] <= compat_pairs[i,j];
