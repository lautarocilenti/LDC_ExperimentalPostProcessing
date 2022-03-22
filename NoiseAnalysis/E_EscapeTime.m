function [] = E_EscapeTime()
%A_PACKAGETRIALS 
AddAllPaths();
M = Parameters();

data = load(fullfile(M.folder,"D_NoiseData.mat"));
TrialsIn = data.Trials;
count = 1;
for i = 1:length(TrialsIn)
    ii = max(find(TrialsIn(i).rms>TrialsIn(i).rmsThreshold));
    escapetime = TrialsIn(i).t(ii);
    if escapetime == max(TrialsIn(i).t)
        EscapeTimes(count) = escapetime;
        count = count +1;
    else
        EscapeTimes(count) = escapetime;
        count = count +1;
    end
        
end
nm = max(TrialsIn(1).n);

save(fullfile(M.folder,sprintf("EscapeTimes%3d.mat",nm)),"EscapeTimes","nm","-v7.3");

end

