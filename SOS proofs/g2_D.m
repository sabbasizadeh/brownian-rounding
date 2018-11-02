% attempt 12 - Differential Equation for g(x,y,z)=1-xy-2z(x-x^2)(y-y^2),
% assuming -1/2<=z<=0. We will check L[g]>=0. 
function []=Dg(lower)

ops = sdpsettings('solver','sdpt3');
ops = sdpsettings('sdpt3.gaptol', 1e-9,'sdpt3.inftol',1e-9,'sdpt3.steptol',1e-9)
ops.sdpt3
sdpvar x y z lower
dg = (1 + 2*x^2 + 2*y^2 + 2*z - 2*y*(1 + 2*z) + x*(-2 + (-4 + 8*y)*z));
helper = [x-x^2;y-y^2;-z*(2*z+1)];

d = 3;
[s1,c1] = polynomial([x y z],d);
[s2,c2] = polynomial([x y z],d);
[s3,c3] = polynomial([x y z],d);

F = [sos(dg-lower-[s1 s2 s3]*helper), sos(s1), sos(s2), sos(s3)];
[sol,v,Q]=solvesos(F,-lower,[],[c1;c2;c3;lower]);

Q{1}
Q{2}
Q{3}
Q{4}

value(lower)
sdisplay(sosd(F(1)))
gg = sosd(F(1));
a = 1e-2;
"F(1)"
sdisplay(clean(gg,a))
"F(1)^2="
sdisplay(clean(gg'*gg,a))
"F(2)="
hh=sosd(F(2));
sdisplay(clean(hh,a));
"F2^2"
sdisplay(clean(hh'*hh,a));
"F(3)="
hh=sosd(F(3));
sdisplay(clean(hh,1e-4));
"F3^2"
sdisplay(clean(hh'*hh,1e-4));
"F(4)="
hh=sosd(F(4));
sdisplay(clean(hh,1e-4));
"F4^2"
sdisplay(clean(hh'*hh,1e-4));