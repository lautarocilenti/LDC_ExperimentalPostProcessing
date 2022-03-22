function [data] = GenerateExperimentalData()
%GENERATEEXPERIMENTALDATA 
F = .4;
b = -.3; a = 1;
nu = .2;

A = .01:.01:4;
A = A';

c1 = a;
c2 = 3/8*b/sqrt(a);
c3 = F^2/4/a;
c4 = nu^2/4;
del = .00;
Aleft = A+(randn(size(A))*del);
Aright = A+(randn(size(A))*del);

wright = (c1+c2*A.^2)+sqrt(c3./A.^2-c4);
wleft = (c1+c2*A.^2)-sqrt(c3./A.^2-c4);
% 
dw1 = [0 ;diff(wleft)];
dw2 = [diff(wleft); 0];
ii = find(sign(dw1)~=sign(dw2));
wleft = wleft(1:ii(2),1);
Aleft = Aleft(1:ii(2),1);
if ~isreal(wleft)
   error("Not real data\n") 
end

data.leftBranch.A = Aleft;
data.leftBranch.w = wleft;
data.rightBranch.A = Aright;
data.rightBranch.w = wright;

cFirst = [c1 c2 c3 c4]
end

