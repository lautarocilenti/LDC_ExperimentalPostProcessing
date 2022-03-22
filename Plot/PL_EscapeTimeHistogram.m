function [outputArg1,outputArg2] = PL_EscapeTimeHistogram()
%PL_PLOTTRIALTIMESERIES

M = Parameters();
folder = fullfile(M.dataFolder,"NoiseTrials\November2021\A1\EscapeTimes\");

files = dir(fullfile(folder,"EscapeTimes*.mat"));

n = length(files);
X = [];
G = [];
f1 = figure()
for i = 1:n
    dataTemp = load(fullfile(files(i).folder,files(i).name));
%     subplot(n,1,i)
    ET = dataTemp.EscapeTimes;
    nm = dataTemp.nm;
    X = [X ET];
    g1 = repmat({sprintf("%d", nm)},1,length(ET));
    G = [G g1];
%     hold on
%     title(sprintf("Noise %d, Mean escape time %f", nm,mean(ET)))
    
    
end

boxplot(X,G)
ylabel("Escape Time (s)")
xlabel("Noise Intensity")

imagefile = fullfile(folder,"EscapeTimes");
ExportPNG(f1,imagefile);
end

