function [] = B_OrganizeData(folder)
%A_PACKAGETRIALS 
AddAllPaths();
M = Parameters();
if nargin == 0
    folder = M.folder;
end
data = load(fullfile(folder,"A_NoiseData.mat"));
TrialsIn = data.Trials;

for i = 1:length(TrialsIn)
     fprintf("Progress %.4f\n",i/length(TrialsIn))
    trial = TrialsIn(i);
    Trials(i).t = trial.data.Time.data; % time
    Trials(i).c = trial.data.Control.data; %control
    Trials(i).e = trial.data.Strain1.data; %strain
    Trials(i).f = trial.data.Untitled_2.data; %frequency
    Trials(i).n = trial.data.Untitled_3.data; %noise
    Trials(i).cal = trial.data.Untitled_4.data; %calibrated
    Offsets.AvgStrain(i) = mean(Trials(i).e);
    Offsets.initialIndex(i) = min(find(Trials(i).f>19));
end


save(fullfile(folder,"B_NoiseData.mat"),"Trials","Offsets","-v7.3");
end

