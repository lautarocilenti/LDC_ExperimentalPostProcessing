function [] = C_ApplyOffsets()
%A_PACKAGETRIALS 
AddAllPaths();
M = Parameters();

data = load(fullfile(M.folder,"B_NoiseData.mat"));

Trials = data.Trials;
Offsets = data.Offsets;
clearvars data
nmChange = input("Would you like to change the Noise multiplier?\n");
if nmChange
    nm = input("New Noise Multiplier: ");
end

for i = 1:length(Trials)
    Trials(i).t = Trials(i).t(Offsets.initialIndex(i):end); % time
    Trials(i).t =  Trials(i).t -  Trials(i).t(1);
    Trials(i).c =  Trials(i).c(Offsets.initialIndex(i):end); %control
    Trials(i).e =  Trials(i).e(Offsets.initialIndex(i):end)-mean(Offsets.AvgStrain); %strain
    Trials(i).f =  Trials(i).f(Offsets.initialIndex(i):end); %frequency
    Trials(i).n =  Trials(i).n(Offsets.initialIndex(i):end); %noise
    if nmChange
        a = Trials(i).n./max(Trials(i).n)*nm;
        Trials(i).n = a;
    end
    Trials(i).cal = Trials(i).cal(Offsets.initialIndex(i):end); %calibrated
end


save(fullfile(M.folder,"C_NoiseData.mat"),"Trials","-v7.3");
end

