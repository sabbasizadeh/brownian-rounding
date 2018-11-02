% attempt 12 - Differential Equation for g(x,y,z)=1-xy-(1/2)(1+5z)(x-x^2)(y-y^2)(x+y)(2-x-y),
% assuming -1<=z<= -1/2. We will check L[g]>=0. 
function [sol,v,Q,F]=Dh(lower)

sdpvar x y z lower
g =-2*z + x^4 *(1 + 5 *z) + y^4* (1 + 5* z) - 2* y* (1 + 7* z + 10* z^2) -  y^3* (5 + 29* z + 20* z^2) + y^2 *(6 + 39* z + 45* z^2) +  x^3 *(1 + 5* z)* (-5 - 4* z + y* (6 + 8 *z)) +  3 *x^2 *(1 + 5* z)* (2 + 3* z + y^2* (4 + 6* z) - y* (7 + 10* z)) +  x* (-2* (1 + 7* z + 10 *z^2) + 6* y* (3 + 19* z + 20* z^2) +     y^3 *(6 + 38* z + 40 *z^2) - 3* y^2* (7 + 45* z + 50* z^2))
h = [x-x^2;y-y^2;z+1;-(2*z+1)];

d=4;
[s1,c1] = polynomial([x y z],d);
[s2,c2] = polynomial([x y z],d);
[s3,c3] = polynomial([x y z],d);
[s4,c4] = polynomial([x y z],d);

ops = sdpsettings('solver','mosek');

F = [sos(g-lower-[s1 s2 s3 s4]*h), sos(s1), sos(s2), sos(s3), sos(s4)];
[sol,v,Q]=solvesos(F,-lower,[],[c1;c2;c3;c4;lower]);

a=1e-8;
"Error here="
sdisplay((g-v{1}'*Q{1}*v{1}-v{2}'*Q{2}*v{2}*(x-x^2)-v{3}'*Q{3}*v{3}*(y-y^2)-v{4}'*Q{4}*v{4}*(z+1)-v{5}'*Q{5}*v{5}*(-(2*z+1))))% 

" 1. v,Q , v^T Q v ="

sdisplay(v{1})
Q{1}
eig(Q{1})
sdisplay(v{1}'*Q{1}*v{1})


"(x-x^2) v,Q , v^T Q v ="
sdisplay(v{2})
Q{2}
eig(Q{2})
sdisplay(v{2}'*Q{2}*v{2})


"(y-y^2) v,Q , v^T Q v ="
sdisplay(v{3})
Q{3}
eig(Q{3})

sdisplay(v{3}'*Q{3}*v{3})
"z+1 v,Q , v^T Q v ="

sdisplay(v{4})
Q{4}
eig(Q{4})
sdisplay(v{4}'*Q{4}*v{4})
"(2z+1) v,Q , v^T Q v ="
sdisplay(v{5})
Q{5}
eig(Q{5})
sdisplay(v{5}'*Q{5}*v{5})


"Eigenvalues"
eig(Q{1})

eig(Q{2})

eig(Q{3})

eig(Q{4})

eig(Q{5})