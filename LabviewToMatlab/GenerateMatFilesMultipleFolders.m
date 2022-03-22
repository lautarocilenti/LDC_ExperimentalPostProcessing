function [] = GenerateMatFilesMultipleFolders()
%GENERATEMATFILESMULTIPLEFOLDERS
AddAllPaths();
M = Parameters();

    for i = 2
        dataSubFolder = ['NoiseTrials\January2022\Set',sprintf('%d',i)];
        folder = fullfile(M.dataFolder,dataSubFolder)
        GenerateMatFilesEntireFolder(folder);
    end
end

