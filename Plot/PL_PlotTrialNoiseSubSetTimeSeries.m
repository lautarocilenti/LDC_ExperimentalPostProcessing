function [outputArg1,outputArg2] = PL_PlotTrialTimeSeries(indexSet)
%PL_PLOTTRIALTIMESERIES
if nargin == 0
    indexSet = [1:10];
end

M = Parameters();

data = load(fullfile(M.folder,"D_NoiseData.mat"));

for i = 1:length(indexSet)
    j = indexSet(i);
    trial = data.Trials(j);
    f1 = figure();
    subplot(2,1,1)
    plot(trial.t,trial.e,'displayname','strain')
    ylabel('strain')
    hold on
    plot(trial.t,trial.rms,'k','displayname','rms','linewidth',1)
    plot(trial.t,trial.rmsThreshold.*ones(size(trial.t)),'--','displayname','threshold','linewidth',2)
    legend('location','southwest')

    subplot(2,1,2)
    plot(trial.t,trial.c,'displayname',sprintf('control w/ noise multiplier %d',trial.n(1)))
    ylabel('control')
    xlabel('time (s)')
    
    
    
end

end

