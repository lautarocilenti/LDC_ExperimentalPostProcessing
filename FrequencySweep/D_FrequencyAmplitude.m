function [] = D_FrequencyAmplitude()
%C_SPLITDATABYPERIODS 

M = Parameters();

data = load(fullfile(M.folder,"C_frequencySweep.mat"));
sweep = data.sweep;

for i = 1:length(sweep.names)
    frequencyUnique = sweep.frequencyUnique{i};
    for j = 1:length(frequencyUnique)
        fprintf("Progress %.2f\n",j/length(frequencyUnique)/length(sweep.names)+1/length(sweep.names)*(i-1))
        f = frequencyUnique(j);
        if f~=0
            indexSet = sweep.periodIndexSet{i,j};
            indexSet =  indexSet(ceil(size(indexSet,1)/2):end,:);
            T = 1/f;
            tq = linspace(0,T,100);
            a = [];
            L2 = [];
            for k = 1:size(indexSet,1)
               t = sweep.time{i}(indexSet(k,1):indexSet(k,2));
               t = t + 1E-9*[1:length(t)];
               strain = sweep.strain{i}(indexSet(k,1):indexSet(k,2));
               center = max(strain)-range(strain)/2;
               strain = strain-center;
               tAug = [t-min(t)-T t-min(t) t-min(t)+T];
               
               strainAug = [strain strain strain];
               strainq(k,:) = interp1(tAug,strainAug,tq);
               a_c =2/T*trapz(tq,strainq(k,:).*cos(2*pi/T*tq));
               a_s =2/T*trapz(tq,strainq(k,:).*sin(2*pi/T*tq));
               
               a(k) = sqrt(a_c.^2+a_s.^2);
    

%                subplot(3,1,1)
%                plot(tAug,strainAug)
%                hold on
%                subplot(3,1,2)
%                plot(tq,strainq(k,:))
%                hold on
            end
            
            strainAvg = mean(strainq,1);
            aAvg = mean(a);
            
%             subplot(3,1,3)
%             plot(tq,strainAvg)
            frequency(i,j) = f;
            amplitude(i,j) = max(strainAvg);
            aFirstHarmonic(i,j) = aAvg;
        end
        
 
    end
   

end
sweep.FED.frequency = frequency;
sweep.FED.amplitude = amplitude;
sweep.FED.aFirstHarmonic = aFirstHarmonic;
sweep.FED.names = sweep.names;



save(fullfile(M.folder,"D_frequencySweep.mat"),'sweep','-v7.3')
end

