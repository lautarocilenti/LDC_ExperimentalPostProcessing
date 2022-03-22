function [] = PL_PlotSweepSpectrumL2ND()

M = Parameters();

data = load(fullfile(M.folder,"E_frequencySweepND.mat"));

FED = data.sweepND.FED;
% f1 = figure();
hold on
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
ylabel('Mean L2')
filename = fullfile(M.folder,"NondimensionalizedSpectrumL2");
% ExportPNG(f1,filename);

load('F:\OneDrive - University of Maryland\University of Maryland\GitProjects\LDC_ExperimentalPostProcessing\Auto\FixedPointsOneDuffingExp.mat')
plot(Auto.W,sqrt(Auto.L2.^2-1),'.k')
axis([0.3 1.8 0 1])
end

