function [outputArg1,outputArg2] = ManualSystemIdentification(inputArg1,inputArg2)
%SYSTEMIDENTIFICATION 
close all
M = Parameters();

data = load(fullfile(M.folder,"D_frequencySweep.mat"));
sweep = data.sweep;
FED= sweep.FED;

[wOut,aOut] = PrepareData(FED);
wOut = wOut;


% parameter def
% par(1) = eta;
% par(2) = beta;
% par(3) = w_n;
% par(4) = Fhat;

%initial guess
eta0 = .1; beta0 = -9; w_n0 = 18; F0 = 2.25;

eta0 = .075; beta0 = -300; w_n0 = 19.9; F0 = 3;


eta0 = .00625; beta0 = -200; w_n0 = 20; F0 = 2.5;

eta0 = .45; beta0 = -7850; w_n0 = 126; F0 = 117;


eta0 = .4; beta0 = -1475; w_n0 = 126; F0 = 230;%without reducing amplitude
par0 = [eta0;beta0;w_n0;F0;.1];

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
par = par0;
parcurrent = 1;
parnames = ["eta","beta","w_n","F","increment"];
    for i = 1:5
       fprintf("%s = %f",parnames(i),par(i));
       string(i) = sprintf("%s = %f",parnames(i),par(i));
    end
     fprintf("\nChange %s ... \n",parnames(parcurrent));
    % 28 leftarrow
    % 29 rightarrow
    % 30 uparrow
    % 31 downarrow

    hold off

    plot(wOut.right,aOut.right,'b.','displayname','Experimental')
    hold on
    plot(wOut.left,aOut.left,'b.','displayname','Experimental')
%     legend()
    [w1,w2,A] = AnalyticalCurve(par(1:4));
    hold on
    plot(w2,A,'r--','displayname','Analytical','linewidth',3)
    plot(w1,A,'r--','displayname','Analytical','linewidth',3)
    
    title(sprintf("%s,%s,%s,%s",string(1:4)));

    legend
    axis([75 150 0 2.5])
    xlabel('frequency (rads/s)')
    ylabel('Average max amplitude')
end


function [w1,w2,A] = AnalyticalCurve(pars)
    eta = pars(1);
    beta = -pars(2);
    w_n = pars(3);
    F0 = pars(4);
    C2 =@(a) sqrt(-eta.^2+F0.^2./4./a.^2./w_n^2  );
    C1 = @(a) -3*a.^2*beta/8/w_n;
    A = .01:.001:2.23;
    w1 = (C1(A)-C2(A))+w_n;
    w2 = (C1(A)+C2(A))+w_n;

end


