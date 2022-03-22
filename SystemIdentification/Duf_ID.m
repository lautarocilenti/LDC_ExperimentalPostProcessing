close all
clear all
%clc


% set parameters
m=1;            % mass
k=32.8.^2;            % stiffness
c=2*0.008*32.8;         % damping
dim=1;          % number of oscillators
ampl=18;      % forcing amplitude
kappa=225;      % nonlinear stiffness


M=m.*eye(dim);
K=k;
C=c;


Oms=30:0.1:38;       % frequencies 



A = [zeros(1) eye(1);...
    -M\K    -M\C];
S = @(x)kappa.*x.^3;
NL=@(z)[zeros(dim,1);-M\S(z(1:dim))];
f=ampl;

z0=zeros(2*dim,1);      % Initial condition
opts = odeset('RelTol',1e-8,'AbsTol',1e-10);    % set ode options

% Initialize variables 
my_cost_fcn= @(pars) [];
a_c=zeros(length(Oms),1);
a_s=zeros(length(Oms),1);

ampls=zeros(length(Oms),1);


% Numeric frequency sweep, this would need to be replaced by the actual
% experiment
for iter_Oms=1:length(Oms)
    Oms(iter_Oms)
    G=@(t)[zeros(dim,1); M\f].*sin(Oms(iter_Oms)*t);
    RHS=@(t,z) A*z + NL(z) + G(t);
    T=2*pi/Oms(iter_Oms);
    [~, z_trans] = ode45(@(t,z)RHS(t,z), [0 500*T],z0,opts); % Transients
    z0=z_trans(end,:)';
    [t, z_ss] = ode45(@(t,z)RHS(t,z), [0:T/10^3:T], z0);

     
    
    a_c(iter_Oms)=2/T*trapz(t,z_ss(:,1).*cos(Oms(iter_Oms)*t));
    
    a_s(iter_Oms)=2/T*trapz(t,z_ss(:,1).*sin(Oms(iter_Oms)*t));
    
    
    
    ampls(iter_Oms)= sqrt(a_c(iter_Oms).^2+a_s(iter_Oms).^2); %<-- we need to measure the steady state amplitude
    % pars(1)=mu
    % pars(2)=w0
    % pars(3)=kappa
    
    % Create function for least squares optimization
   % if Oms(iter_Oms)>1 && Oms(iter_Oms)<1.15
        my_cost_fcn=@(pars)[ my_cost_fcn(pars);  (pars(1)^2+(Oms(iter_Oms)- pars(2)-3/8*pars(3)/pars(2)*ampls(iter_Oms)^2)^2)*ampls(iter_Oms)^2-f^2/(4* pars(2)^2)];
   % end
end


%%

% Set parameters for nonlinear least squares fit
opts = optimoptions('lsqnonlin');
opts.FunctionTolerance=10^-10;
opts.OptimalityTolerance =10^-8;
% fit parameter via nonlinear least squares to analytical  FRF
pars_id=lsqnonlin(my_cost_fcn,[0 30 0],[],[],opts)

%verify fit
ampls_id=NaN(3,length(Oms));
%pars_id=[c/2 sqrt(k) kappa];
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
