function [] = PL_PlotSweepSpectrum()

M = Parameters();

data = load(fullfile(M.folder,"D_frequencySweep.mat"));

FED = data.sweep.FED;
f1 = figure();
for i = 1:length(FED.names)
   ii = FED.frequency(i,:)~=0;
   plot(FED.frequency(i,ii),FED.amplitude(i,ii),'x')
   hold on
   legendStr{i} = FED.names{i};
   legendStr{i} = erase(legendStr{i},"RAW_");
   legendStr{i} = erase(legendStr{i},".mat");
end
legend(legendStr);
xlabel('frequency (Hz)')
ylabel('Mean Max Amplitude (V)')
filename = fullfile(M.folder,"FrequencySpectrum");
ExportPNG(f1,filename);
end

