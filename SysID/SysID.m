function [] = SysID()
%SYSID
close all
M = Parameters();
[data] = PrepareData()
% 

my_cost_fcn= @(pars) [];
for i= 1:length(data.H.w)
    A = data.H.a(i);
    Omega = data.H.w(i);
    my_cost_fcn=@(pars)[ my_cost_fcn(pars); 1 + 3/8 *pars(1)*A^2+sqrt(pars(2)^2/4./A.^2-pars(2)^2/4)-Omega];
end

for i= 1:length(data.L.w)
    A = data.L.a(i);
    Omega = data.L.w(i);
    my_cost_fcn=@(pars)[ my_cost_fcn(pars); 1 + 3/8 *pars(1)*A^2-sqrt(pars(2)^2/4./A.^2-pars(2)^2/4)-Omega];
end


opts = optimoptions('lsqnonlin');
opts.FunctionTolerance=10^-12;
opts.OptimalityTolerance =10^-12;
% fit parameter via nonlinear least squares to analytical  FRF
% pars_id=lsqnonlin(my_cost_fcn,[.3 .05],[],[],opts);
pars_id = fmincon(@(pars) norm(my_cost_fcn(pars)),[.3 .05])

% pars_id = [-0.4880    0.00504];
PL_Analytical(pars_id(1),pars_id(2))

plot(data.L.w,data.L.a,'s','displayname', 'experimental low branch')
plot(data.H.w,data.H.a,'d','displayname','experimental high branch')
legend('location','southoutside')
axis([.7,1.3,0,1])
title(['$\beta$ = ', sprintf('%.4f', pars_id(1)), ', $F_0$ = ', sprintf('%.4f', pars_id(2))],'interpreter','latex') 
pars_id 

ExportPNG(gcf,fullfile(M.folder,"SysIDResults"));
end

% eta^2 = F^2
