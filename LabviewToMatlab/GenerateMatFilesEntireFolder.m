function [] = GenerateMatFilesEntireFolder(folder)
%GENERATEMATFILES 
AddAllPaths();
M = Parameters();
if nargin == 1
    M.folder = folder;
end

files = dir(fullfile(M.folder,"*.tdms"));
ProgressBar(length(files),"Generating Mat Files");
    parfor i = 1:length(files)
        initialFile = fullfile(files(i).folder,files(i).name);
        
        [pathstr, name, ext] = fileparts(initialFile);
        finalFile = fullfile(pathstr,[name,'.mat']);
        data = TDMS_getStruct(initialFile);
        parsave(finalFile, data);  
        fprintf("\b|\n")
    end


end

function parsave(finalFile, data)
  save(finalFile, 'data', '-v7.3')
end
