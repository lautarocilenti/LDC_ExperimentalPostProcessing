function [] = A_PackageTrials(folder)
%A_PACKAGETRIALS 
AddAllPaths();
M = Parameters();
if nargin == 0
    folder = M.folder;
end
files = dir(fullfile(folder,"*Trial*.mat"));

for i = 1:length(files)
   fprintf("Progress %.4f\n",i/length(files))
   filename = files(1).name; 
   trialNum = textscan(filename,"Trial%d.000000.mat");
   Trials(i).name = filename;
   Trials(i).trialNum = trialNum{1};
   dataTemp = load(fullfile(files(i).folder,files(i).name));
   Trials(i).data = dataTemp.data.Data;
end

save(fullfile(folder,"A_NoiseData.mat"),"Trials","-v7.3");
end

