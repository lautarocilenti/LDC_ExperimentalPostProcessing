function [] = E_Nondimensionalization()
%E_Nondimensionalize by time and maximum ampliude

    M = Parameters();

    data = load(fullfile(M.folder,"D_frequencySweep.mat"));
    sweep = data.sweep;

    if ~M.isKnownWn
        error("this steps requires Wn")
    else

        a_p = max(max(sweep.FED.aFirstHarmonic));

        sweepND = sweep;
        sweepND = rmfield( sweepND , "frequency" )
        for i = 1:length(sweep.names)
           sweepND.time{i} = sweep.time{i}.*M.Wn;
           sweepND.control{i} = sweep.control{i}./a_p;
           sweepND.strain{i} = sweep.strain{i}./a_p;
           sweepND.omega{i} = sweep.frequency{i}*2*pi./M.Wn;   
           sweepND.omegaUnique{i} = sweep.frequencyUnique{i}*2*pi./M.Wn;

           omegaUnique = sweepND.omegaUnique{i};
            for j = 1:length(omegaUnique)
            fprintf("Progress %.2f\n",j/length(omegaUnique)/length(sweep.names)+1/length(sweep.names)*(i-1))
                w = omegaUnique(j);
                if w~=0
                    indexSet = sweepND.periodIndexSet{i,j};
                    indexSet =  indexSet(ceil(size(indexSet,1)/2):end,:);
                    T = 2*pi/w;
                    tq = linspace(0,T,100);
                    for k = 1:size(indexSet,1)
                        tau = sweepND.time{i}(indexSet(k,1):indexSet(k,2));
                        tau = tau + 1E-9*[1:length(tau)];
                        strain = sweepND.strain{i}(indexSet(k,1):indexSet(k,2));
                        center = max(strain)-range(strain)/2;
                        strain = strain-center;
                        tauAug = [tau-min(tau)-T tau-min(tau) tau-min(tau)+T];

                        strainAug = [strain strain strain];
                        strainq(k,:) = interp1(tauAug,strainAug,tq);
                        a_c =2/T*trapz(tq,strainq(k,:).*cos(2*pi/T*tq));
                        a_s =2/T*trapz(tq,strainq(k,:).*sin(2*pi/T*tq));
                        a(k) = sqrt(a_c.^2+a_s.^2);
                        


    %                        subplot(3,1,1)
    %                        plot(tAug,strainAug)
    %                        hold on
    %                        subplot(3,1,2)
    %                        plot(tq,strainq(k,:))
    %                        hold on
                    end
                    meanStrainq = mean(strainq,1);
                    meanVq = diff(meanStrainq); 
                    meanVq = [meanVq,meanVq(1)];
                    L2Avg = sqrt(trapz(tq,(meanStrainq.^2+meanVq.^2)));   
                    strainAvg = mean(strainq,1);
                    aAvg = mean(a);
    %                             subplot(3,1,3)
    %                             plot(tq,strainAvg)
                    omega(i,j) = w;
                    amplitude(i,j) = max(strainAvg);
                    aFirstHarmonic(i,j) = aAvg;
                    L2(i,j) = L2Avg;
                end


            end

        end
        sweepND.FED.omega = omega;
        sweepND.FED.amplitude = amplitude;
        sweepND.FED.aFirstHarmonic = aFirstHarmonic;
        sweepND.FED.names = sweep.names;
        sweepND.FED.L2 = L2;


        save(fullfile(M.folder,"E_frequencySweepND.mat"),'sweep','sweepND','-v7.3')
    end



end

