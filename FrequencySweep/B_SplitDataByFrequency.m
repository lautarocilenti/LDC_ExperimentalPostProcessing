function [] = SplitDataByFrequency()

M = Parameters();

data = load(fullfile(M.folder,"A_frequencySweep.mat"));
sweep = data.sweep;

for i = 1:length(sweep.names)
    frequency = sweep.frequency{i};
    frequencyUnique = unique(frequency);
    indexset = zeros(length(frequencyUnique),2);
    for j = 1:length(frequencyUnique)
       ii = find(frequencyUnique(j) == frequency); 
       indexset(j,:) = [min(ii) max(ii)];
    end
    sweep.frequencyIndexSet{i} = indexset;
end

save(fullfile(M.folder,"B_frequencySweep.mat"),'sweep','-v7.3')

end

