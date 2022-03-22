function [outputArg1,outputArg2] = SystemIdentification(inputArg1,inputArg2)
%SYSTEMIDENTIFICATION 
close all
M = Parameters();

data = load(fullfile(M.folder,"D_frequencySweep.mat"));
sweep = data.sweep;
FED= sweep.FED;

[wOut,aOut] = PrepareData(FED);
wOut = wOut;
plot(wOut.left,aOut.left,'.','displayname','left')
plot(wOut.right,aOut.right,'.','displayname','right')
legend()

% parameter def
% par(1) = eta;
% par(2) = beta;
% par(3) = w_n;
% par(4) = Fhat;

%initial guess
eta0 = .1; beta0 = -9; w_n0 = 18; F0 = 2.25;
par0 = [eta0;beta0;w_n0;F0];

%cost function
omega = wOut;
A = aOut;
% f = 2.25;
% cost_fun = @(par) eta.^2/4 + (3.*A.^2.*beta./8 - w./w_n+1).^2 - Fhat.^2./4./A.^2;
% cost_fun = @(par) norm((par(1).^2 + ((omega-par(3)) -3/8.*A.^2.*par(2)./par(3) ).^2).*A.^2 - par(4).^2./4./par(3).^2);

a1 = aOut.left;
a2 = aOut.right;
w1 = wOut.left;
w2 = wOut.right;


cost_fun = @(par) norm([-3*a1.^2*par(2)/8/par(3) - sqrt(-par(1).^2+par(4).^2./4./a1.^2./par(3)^2)+par(3)])+ ...
   10*norm([ -3*a2.^2*par(2)/8/par(3) - sqrt(-par(1).^2+par(4).^2./4./a2.^2./par(3)^2)+par(3)-w2]);

cost_fun = @(par) norm([-3*a1.^2*par(2)/8/par(3) - sqrt(-par(1).^2+par(4).^2./4./a1.^2./par(3)^2)+par(3) , ...
    -3*a2.^2*par(2)/8/par(3) + sqrt(-par(1).^2+par(4).^2./4./a2.^2./par(3)^2)+par(3)-w2]);
% opts = optimoptions('lsqnonlin');
% opts.FunctionTolerance=10^-12;
% opts.OptimalityTolerance =10^-12;
% fit parameter via nonlinear least squares to analytical  FRF
nonlcon = @constraints;
A = []; % No other constraints
b = [];
Aeq = [];
beq = [];
lb = [];
ub = [];
pars_id=fmincon(cost_fun,par0,A,b,Aeq,beq,lb,ub,nonlcon)

[w1,w2,A] = AnalyticalCurve(pars_id);
hold on
plot(w1,A,'.','displayname','1')
plot(w2,A,'.','displayname','2')

end


function [w1,w2,A] = AnalyticalCurve(pars)
    eta = pars(1);
    beta = -pars(2);
    w_n = pars(3);
    F0 = pars(4);
    C2 =@(a) sqrt(-eta.^2+F0.^2./4./a.^2./w_n^2  );
    C1 = @(a) -3*a.^2*beta/8/w_n;
    A = .01:.001:1;
    w1 = (C1(A)-C2(A))+w_n;
    w2 = (C1(A)+C2(A))+w_n;
    w1 = w1*-1+2*w_n;
    w2 = w2*-1+2*w_n;

end

function [c,ceq] = constraints(x)
c(1) = +x(1).^2-x(4).^2./4./x(3)^2
c(2) = +x(2);
ceq = [];
end
