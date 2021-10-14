function [] = AddAllPaths()
%ADDALLPATHS 
% Determine where your m-file's folder is.
folder = fileparts(which(mfilename)); 
% Add that folder plus all subfolders to the path.
cd(folder)
addpath(genpath(folder));
end

