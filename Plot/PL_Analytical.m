function [] = PL_Analytical(beta,F,eta)
%PL_ANALYTICAL 
% close all
N = 100;
A = linspace(0,1,N);
a_p = 2.3;
% beta = -.3*a_p^2; F = .4/a_p; eta = .17;
if nargin == 2
eta = F;
end

Omega(1,:) = 1+3/8*beta*A.^2+sqrt(F^2./4./A.^2-eta^2/4);
Omega(2,:) = 1+3/8*beta*A.^2-sqrt(F^2./4./A.^2-eta^2/4);
[w1,a1] = FindBifurcationPoint1(Omega(2,:),A)
plot(Omega(1,:),A,'b:','linewidth',3,'displayname','Analytical High Branch')
hold on
plot(Omega(2,:),A,'r:','linewidth',3,'displayname','Analytical Low Branch')

% plot(w1,a1,'og','markersize',10)

axis([.5 1.5 0 1])



end

function [w1,a1] = FindBifurcationPoint1(w,a)

dw1 = [0 diff(w)];
dw2 = [diff(w) 0];
ii = find(sign(dw1)~= sign(dw2));

w1 = w(ii(2));
a1 = a(ii(2));

end

