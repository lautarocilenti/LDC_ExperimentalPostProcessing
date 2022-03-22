function [outputArg1,outputArg2] = PL_PlotSweepTimeSeries()

M = Parameters();

data = load(fullfile(M.folder,"C_frequencySweep.mat"));

sweep = data.sweep;

for i = 1:length(sweep.names)
   figure()
   subplot(3,1,1)
   plot(sweep.time{i},sweep.strain{i}-mean(sweep.strain{i}))
   legend('strain')
   ylabel('strain')
   subplot(3,1,2)
   plot(sweep.time{i},sweep.control{i})
   legend('control')
   ylabel('control')   
   subplot(3,1,3)
   plot(sweep.time{i},sweep.frequency{i})
   legend('frequency')
   ylabel('frequency')
   xlabel('time (s)')
end

end

