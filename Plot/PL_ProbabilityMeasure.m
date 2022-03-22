function [] = PL_ProbabilityMeasure()
%PL_PLOTTRIALTIMESERIES

M = Parameters();
folder = fullfile(M.dataFolder,"NoiseTrials\November2021\A1\PMeasure\");

files = dir(fullfile(folder,"Probability*.mat"));
n = length(files);
X = [];
G = [];
binSizePlot = 50;
c = [0 .7 0; 0 0 1; 1 0 0; 0 0 0];
count = 1;
f1 = figure();
NI = [40,60,80,100];
for i = 1:4
    plot(0,0,'-','color',c(i,:),'displayname',sprintf('Noise Level = %3d, Mean',NI(i)),'linewidth',2)
    hold on
%     plot(0,0,':','color',c(i,:),'displayname',sprintf('Noise Level = %3d, Std. Bound',NI(i)),'linewidth',1.25)
end
legend('location','eastoutside','autoupdate','off')

for i = 1:n
    dataTemp = load(fullfile(files(i).folder,files(i).name));
    if dataTemp.binSize ~= binSizePlot
        continue
    end
    P = dataTemp.P;
    S = dataTemp.S;
    t = dataTemp.t;
    color = c(count,:);
    count = count +1;
    ub = P+S; ub(ub>1) = 1;
    lb = P-S; lb(lb<0) = 0;
    plot(t,P,'-','color',color,'linewidth',2)
    hold on
%     plot(t,ub,':','color',color,'linewidth',1.25)
%     plot(t,lb,':','color',color,'linewidth',1.25)
    
    
    
end

ylabel(['$\eta$',sprintf(' Bin (%d)',binSizePlot)],'interpreter','latex')
xlabel("t")

imagefile = fullfile(folder,sprintf("ProbabilityMeasureBin%3d",binSizePlot));

f1.Units = 'inches';
f1.Position = [0 0 9 4];
ExportPNG(f1,imagefile);
end

