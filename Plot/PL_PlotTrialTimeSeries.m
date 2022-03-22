function [outputArg1,outputArg2] = PL_PlotTrialTimeSeries(indexSet)
%PL_PLOTTRIALTIMESERIES
if nargin == 0
    indexSet = [1];
end

M = Parameters();

data = load(fullfile(M.folder,"C_NoiseData.mat"));

for i = 1:length(indexSet)
    j = indexSet(i);
    trial = data.Trials(j);
    f1 = figure()
    subplot(3,1,1)
    plot(trial.t,trial.e,'displayname','strain')
    ylabel('strain')
    subplot(3,1,2)
    plot(trial.t,trial.c,'displayname','control')
    ylabel('control')
    subplot(3,1,3)
    yyaxis left
    plot(trial.t,trial.f,'displayname','frequency')
    ylabel('frequency (Hz)')

    hold on
    yyaxis right
    plot(trial.t,trial.n,'displayname','noise multiplier')
    ylabel('noise multiplier')
    
    
    
end

end

