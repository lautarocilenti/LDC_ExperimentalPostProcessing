function [data] = PrepareData()
%PREPAREDATA 
    M = Parameters();

    data = load(fullfile(M.folder,"E_frequencySweepND.mat"));
    FED = data.sweepND.FED;
    wmin = .7; wmax = 1.5; 
    for i = 1:length(FED.names)
       if contains(FED.names{i},"Down")
           iw = find(FED.omega(i,:)>wmin);
           a = FED.aFirstHarmonic(i,iw);
           w = FED.omega(i,iw);
           [w,iw] = sort(w,'ascend');
           a = a(iw);
           da = diff(a);
           thresh = .2;
           iJumpDown = max(find(abs(da)>thresh))+1;
           iHigh = iJumpDown:length(a);
           data.H.w = w(iHigh);
           data.H.a = a(iHigh);
%            plot(w(iHigh),a(iHigh),'x')
%            hold on
       else
           iw = find(FED.omega(i,:)>wmin);
           a = FED.aFirstHarmonic(i,iw);
           w = FED.omega(i,iw);
           [w,iw] = sort(w,'ascend');
           a = a(iw);
           da = diff(a);
           thresh = .1;
           iJumpUp = max(find(abs(da)>thresh))-1;
           iLow = 1:iJumpUp;
           data.L.w = w(iLow);
           data.L.a = a(iLow);
%            plot(w(iLow),a(iLow),'x')
%            hold on
       end
        
    end
end

