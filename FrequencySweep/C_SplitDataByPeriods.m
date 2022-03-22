function [] = C_SplitDataByPeriods()
%C_SPLITDATABYPERIODS 

M = Parameters();

data = load(fullfile(M.folder,"B_frequencySweep.mat"));
sweep = data.sweep;

for i = 1:length(sweep.names)
    indexset = sweep.frequencyIndexSet{i};
    for j = 1:size(indexset,1)
       fprintf("Progress %.2f\n",j/size(indexset,1)/length(sweep.names)+1/length(sweep.names)*(i-1))
       f = sweep.frequencyUnique{i}(j);
       if f~=0
           
            t = sweep.time{i}(indexset(j,1):indexset(j,2));
            T = 1/f;
            tq = t(1):T:t(end);
            for k = 1:length(tq)-1
               periodIndexSet{i,j}(k,1) = min(find(sweep.time{i}>=tq(k)));
               periodIndexSet{i,j}(k,2) = max(find(sweep.time{i}<=tq(k+1)));
            end
       else
           periodIndexSet{i,j}(1,1) = indexset(j,1);
           periodIndexSet{i,j}(1,2) = indexset(j,2);
       end
        
        
    end
    
end
sweep.periodIndexSet = periodIndexSet;
save(fullfile(M.folder,"C_frequencySweep.mat"),'sweep','-v7.3')
end

