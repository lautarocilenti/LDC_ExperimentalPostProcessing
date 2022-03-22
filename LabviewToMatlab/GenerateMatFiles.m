function [] = GenerateMatFiles()
%GENERATEMATFILES 
AddAllPaths();
M = Parameters();

files = dir(fullfile(M.folder,"*.tdms"));
    for i = 1:length(files)
        initialFile = fullfile(files(i).folder,files(i).name);
        acceptRun = input(sprintf("Run on %s ?", files(i).name))
        if acceptRun
            [pathstr, name, ext] = fileparts(initialFile);
            finalFile = fullfile(pathstr,[name,'.mat']);
            data = TDMS_getStruct(initialFile);
            save(finalFile,'data','-v7.3')   
        end
    end


end

