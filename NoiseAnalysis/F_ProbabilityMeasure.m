function [] = E_EscapeTime()
%A_PACKAGETRIALS 
AddAllPaths();
M = Parameters();

data = load(fullfile(M.folder,"D_NoiseData.mat"));
TrialsIn = data.Trials;
count = 1;
binSize = 50;

for i = 1:length(TrialsIn)
    tmax(i) = max(TrialsIn(i).t);
end
tmax = min(tmax);
tq = 0:.1:tmax;

trialcount = 1;
bincount = 1;
eta = true(binSize,length(tq));
for i = 1:length(TrialsIn)

    
    ii = max(find(TrialsIn(i).rms>TrialsIn(i).rmsThreshold));
    escapetime = TrialsIn(i).t(ii);

    jj = find(tq>=escapetime);
    eta(trialcount,jj) = false;
    trialcount = trialcount+1;
    
    
    EscapeTimes(count) = escapetime;
    count = count +1;
    
    if trialcount>binSize
        trialcount = 1;
        p(bincount,:) = mean(eta,1);
        bincount = bincount +1;
        eta = true(binSize,length(tq));
        dummy = 1;
    end


        
end
% figure()
% for j = 1:size(p,1)
%     plot(tq,p(j,:),'r')
%     hold on
% end
% plot(tq,mean(p,1),'b')
% plot(tq,mean(p,1)+std(p,1),'g')
% plot(tq,mean(p,1)-std(p,1),'g')

S = std(p,1);
P = mean(p,1);
eta = p;
t = tq; 
nm = max(TrialsIn(1).n);

save(fullfile(M.folder,sprintf("ProbabilityMeasure%3d_binS%3d.mat",nm,binSize)),"binSize","EscapeTimes","nm","t","eta","P","S","-v7.3");

end

