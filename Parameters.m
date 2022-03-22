function [M] = Parameters()
%PARAMETERS Summary of this function goes here
%   Detailed explanation goes here

cd(fileparts(which(mfilename)));

filePath = fileparts(which(mfilename));
if contains(filePath,"F:")
    dataFolder = "G:\My Drive\ExperimentData\Data\Beam8";
else
    dataFolder = "E:\Google Drive Work\ExperimentData\Data\Beam8";
end
dataSubFolder = "FrequencySweep\NovemberAmplitude1";
% dataSubFolder = "NoiseTrials\January2021\";
dataSubFolder = "";

M.dataFolder = dataFolder;
M.folder = fullfile(dataFolder,dataSubFolder);


%FrequencySweepParameters
M.isKnownWn = true;
M.Fn = 20.0535; % (Hz)
M.Wn = M.Fn*2*pi;



end

