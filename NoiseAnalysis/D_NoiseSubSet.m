function [] = D_NoiseSubSet()
%A_PACKAGETRIALS 
AddAllPaths();
M = Parameters();

data = load(fullfile(M.folder,"C_NoiseData.mat"));
Trials = data.Trials;

for i = 1:length(Trials)
    ii = Trials(i).n>0;
    Trials(i).t = Trials(i).t(ii);
    Trials(i).t =  Trials(i).t -  Trials(i).t(1);
    Trials(i).c = Trials(i).c(ii);
    Trials(i).e = Trials(i).e(ii);
    Trials(i).f = Trials(i).f(ii);
    Trials(i).rms = MovingRMS(Trials(i).t,Trials(i).e,Trials(i).f(1));
    Trials(i).n = Trials(i).n(ii);
    Trials(i).cal = Trials(i).cal(ii);
    Trials(i).rmsThreshold = max(Trials(i).rms)*2/3;
end


save(fullfile(M.folder,"D_NoiseData.mat"),"Trials","-v7.3");

end

function [rms] = MovingRMS(t,y,f1)
r = size(y,1);
if r == 1
    y = y';
    t = t';
end
delta = mean(diff(t));%t(2) - t(1);
L1 = round((1/f1)/ delta);
Zeros = zeros(L1,1);
Signal = y.*conj(y);
Signal = Signal * f1;
Signal = cumtrapz(t,Signal);
Signal1 = [Zeros;Signal(1:(length(Signal)-L1))];
Signal = Signal - Signal1;
Signal = abs(Signal);
rms = sqrt(Signal);
end