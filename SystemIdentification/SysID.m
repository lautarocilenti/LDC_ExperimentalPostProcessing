close all;
clear all;

M = Parameters();

data = load(fullfile(M.folder,"D_frequencySweep.mat"));
sweep = data.sweep;
FED= sweep.FED;

frequency= FED.frequency;
amplitude = FED.amplitude;

for i = 1:2
   jj = frequency(i,:) == 0;
   f{i} = frequency(i,~jj);
   a{i} = amplitude(i,~jj);
   if contains(FED.names{i},"Up")
       fTemp = f{i}-15;
       aTemp = a{i};
       ii = 1:(min(find(a{i}>.9))-1);
       data.leftBranch.A = aTemp(ii);
       data.leftBranch.w = fTemp(ii)/2/pi;
   else
       fTemp = f{i}-15;
       aTemp = a{i};
       ii = min(find(a{i}>1)):length(fTemp);
       data.rightBranch.A = aTemp(ii);
       data.rightBranch.w = fTemp(ii)/2/pi;
   end
   plot(fTemp(ii),aTemp(ii))
   hold on
end
axis([8 22 0 4.5])


%Initial guess
c1 = 1; c2 = -3/8*.1; c3 = 1; c4 = .01;
x0 = [c1 c2 c3 c4];

%constraints
% -c3/max(A)^2+c4 <= minvalue 
%   + tries to prevent imaginary values
%   + wont prevent imaginary values in initial choice of c
%       
% -c1+c2 <= 0
%   + Linear stiffness > nonlinear stiffness
%
% c2-c3 <=0
%
% -c3 <= minvalue
%   + Squared forcing must be positive
%
% -c4 <= minvalue
%   + Squared damping must be positive


minValue = -.001;
Ac = [0 0 -1/max(data.rightBranch.A)^2 1;-1 1 0 0;0 1 -1 0;0 0 -1 0;0 0 0 -1];
bc = [minValue;0;0;minValue;minValue];

%cost function
wExperimental = [data.rightBranch.w  data.leftBranch.w]';
costfun = @(x) vecnorm(wExperimental-CalculatewFromModel(x,data),2);

%solve
c = fmincon(costfun,x0,Ac,bc)

%plot solution
wF = CalculatewFromModel(c,data); 
aF = [data.rightBranch.A data.leftBranch.A]';
figure()
PlotDataAndModel(data,wF,aF)