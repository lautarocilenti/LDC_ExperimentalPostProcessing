function [] = RunMultipleFolders()
%RunMULTIPLEFOLDERS 

M = Parameters();

for i = 2
    dataSubFolder = ['NoiseTrials\January2022\Set',sprintf('%d',i)];
    folder = fullfile(M.dataFolder,dataSubFolder)
    A_PackageTrials(folder);
    B_OrganizeData(folder);
end
end

