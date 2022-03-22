function [] = PL_PlotSweepSpectrumFirstHarmonicND()

M = Parameters();

data = load(fullfile(M.folder,"E_frequencySweepND.mat"));

FED = data.sweepND.FED;
f1 = figure();
for i = 1:length(FED.names)
   ii = FED.omega(i,:)~=0;
   plot(FED.omega(i,ii),FED.aFirstHarmonic(i,ii),'o')
   hold on
   legendStr{i} = FED.names{i};
   legendStr{i} = erase(legendStr{i},"RAW_");
   legendStr{i} = erase(legendStr{i},".mat");
end
legend(legendStr);
xlabel('$\Omega$ ', 'interpreter' ,'latex')
ylabel('Mean First Harmonic Amplitude')
filename = fullfile(M.folder,"NondimensionalizedSpectrumFirstHarmonic");
ExportPNG(f1,filename);
end

