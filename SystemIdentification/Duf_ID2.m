close all
clear all
%clc




data = load("E_SysIDPreparedData.mat");
Oms = [data.data{1}.frequency,data.data{2}.frequency]';
ampls = [data.data{1}.amplitude,data.data{2}.amplitude]';
opts = odeset('RelTol',1e-8,'AbsTol',1e-10);    % set ode options

% Initialize variables 
my_cost_fcn= @(pars) [];

f = 1;

% Numeric frequency sweep, this would need to be replaced by the actual
% experiment
for iter_Oms=1:length(Oms)
    Oms(iter_Oms)
   % pars(1)=mu
    % pars(2)=w0
    % pars(3)=kappa
    
    % Create function for least squares optimization
   % if Oms(iter_Oms)>1 && Oms(iter_Oms)<1.15
        my_cost_fcn=@(pars)[ my_cost_fcn(pars);  (pars(1)^2+(Oms(iter_Oms)- pars(2)-3/8*pars(3)/pars(2)*ampls(iter_Oms)^2)^2)*ampls(iter_Oms)^2-pars(4)^2/(4* pars(2)^2)];
   % end
end


%%

% Set parameters for nonlinear least squares fit
opts = optimoptions('lsqnonlin');
opts.FunctionTolerance=10^-10;
opts.OptimalityTolerance =10^-8;
% fit parameter via nonlinear least squares to analytical  FRF
pars_id=lsqnonlin(my_cost_fcn,[0 3 0 .2],[],[],opts)

%verify fit
ampls_id=NaN(3,length(Oms));
%pars_id=[c/2 sqrt(k) kappa];
f = pars_id(4);
for iter_Oms=1:length(Oms)
   fkt=3/8*pars_id(3)/pars_id(2);
   sig=Oms(iter_Oms)-pars_id(2);
   p(1)=fkt^2;
   p(2)=-2*sig*fkt;
   p(3)=sig^2+pars_id(1)^2;
   p(4)=-f^2/(4*pars_id(2).^2);
   ampls_id(:,iter_Oms)=roots(p);
end
ampls_id(imag(ampls_id)~=0)=NaN;
figure
plot(Oms,ampls)
hold on
plot(Oms,sqrt(ampls_id),'r')
xlabel('Frequency')
ylabel('amplitude')
legend('Simulated','Identified')
