% attempt 12 - Differential Equation for g(x,y,z)=1-xy-2z(x-x^2)(y-y^2),
% assuming -1/2<=z<=0. We will show that g(x,y,z) >= 7/8 (1-xy-z(x-x^2)^0.5*(y-y^2)^0.5. 
function []=g_approx(lower)

sdpvar x y z lower
g =(1-x*y -16*z*(x-x^2)*(y-y^2))^2-49*z^2*(x-x^2)*(y-y^2);
h = [x-x^2;y-y^2;-z; 1+2*z; x*y-(1-x)*(1-y)*z^2;(1-x)*(1-y)-x*y*z^2];
ops = sdpsettings('solver','mosek')
ops.sdpt3
d=6;
[s1,c1] = polynomial([x y z],d);
[s2,c2] = polynomial([x y z],d);
[s3,c3] = polynomial([x y z],d);
[s4,c4]=polynomial([x y z],d);
[s5,c5]=polynomial([x y z],d);
[s6,c6]=polynomial([x y z],d);
%[s7,c7]=polynomial([x y z],d);

%options = sdpsettings('sos.newton',1,'sos.congruence',1);
%options = sdpsettings('sos.numblkdg',1e-4);
F = [sos(g-lower-[s1 s2,s3,s4,s5,s6]*h), sos(s1), sos(s2),sos(s3),sos(s4),sos(s5),sos(s6)];
[sol,v,Q]=solvesos(F,-lower,[],[c1;c2;c3;c4;c5;c6;lower]);

"Error here="
sdisplay((g-v{1}'*Q{1}*v{1}-v{2}'*Q{2}*v{2}*(x-x^2)-v{3}'*Q{3}*v{3}*(y-y^2)-v{4}'*Q{4}*v{4}*(-z)-v{5}'*Q{5}*v{5}*((2*z+1))-v{6}'*Q{6}*v{6}*(x*y-(1-x)*(1-y)*z^2) -v{7}'*Q{7}*v{7}*(1-x)*(1-y)-x*y*z^2))% 

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
"-z v,Q , v^T Q v ="

sdisplay(v{4})
Q{4}
eig(Q{4})
sdisplay(v{4}'*Q{4}*v{4})
"(2z+1) v,Q , v^T Q v ="


sdisplay(v{5})
Q{5}
eig(Q{5})
sdisplay(v{5}'*Q{5}*v{5})
"x*y-(1-x)*(1-y)*z^2 v,Q , v^T Q v ="

sdisplay(v{6})
Q{6}
eig(Q{6})
sdisplay(v{6}'*Q{6}*v{6})

"(1-x)*(1-y)-x*y*z^2 v,Q , v^T Q v ="

sdisplay(v{7})
Q{7}
eig(Q{7})
sdisplay(v{7}'*Q{7}*v{7})


eig(Q{1})

eig(Q{2})

eig(Q{3})

eig(Q{4})
eig(Q{5})
eig(Q{6})
eig(Q{7})




% sdisplay(s1*h-v{2}'*Q{2}*v{2})
% %Q{1}
 value(lower)
%sdisplay(sosd(F(1)))
%  gg1=sosd(F(1));
% a=1e-2;
%  "F(1)"
% sdisplay(clean(gg1,a))
% "F(1)^2="
% sdisplay(clean(gg1'*gg1,a))
% %sdisplay(sosd(F(2)))
% "F(2)="
% hh=sosd(F(2));
% sdisplay(clean(hh,a));
% "F2^2"
% sdisplay(clean(hh'*hh,a));
% %sdisplay(sosd(F(3)))
% "F(3)="
% hh=sosd(F(3));
% sdisplay(clean(hh,1e-4));
% "F3^2"
% sdisplay(clean(hh'*hh,1e-4));
% %sdisplay(sosd(F[4]))
% "F(4)="
% hh=sosd(F(4));
% sdisplay(clean(hh,1e-4));
% "F4^2"
% sdisplay(clean(hh'*hh,1e-4));
% "F(5)="
% hh=sosd(F(5));
% sdisplay(clean(hh,1e-4));
% "F5^2"
% sdisplay(clean(hh'*hh,1e-4));
% % "F(6)="
% % hh=sosd(F(6));
% % sdisplay(clean(hh,1e-4));
% % "F6^2"
% % sdisplay(clean(hh'*hh,1e-4));






