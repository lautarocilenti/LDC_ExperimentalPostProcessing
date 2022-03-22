function [wOut,aOut] = PrepareData(FED)
%PREPAREDATA 

frequency= FED.frequency;
amplitude = FED.amplitude;
% figure()

for i = 1:2
   jj = frequency(i,:) == 0;
   f{i} = frequency(i,~jj);
   a{i} = amplitude(i,~jj);
   if contains(FED.names{i},"Up")
       fTemp = f{i};
       aTemp = a{i};
       ii = 1:(min(find(a{i}>.4))-1);

       fOut.left = fTemp(ii);
       aOut.left = aTemp(ii);
       ff = fOut.left>12;
       fOut.left = fOut.left(ff)*2*pi;
       aOut.left = aOut.left(ff);
   else
       fTemp = f{i};
       aTemp = a{i};
       ii = min(find(a{i}>1)):length(fTemp);
       fOut.right = fTemp(ii)*2*pi;
       aOut.right = aTemp(ii);
   end
%    plot(fTemp(ii),aTemp(ii))
   hold on
end
wOut = fOut;
% aOut = aOut;
m = max(aOut.right);
aOut.right = aOut.right;
aOut.left = aOut.left;

data{1}.frequency = fOut.left;
data{2}.frequency = fOut.right;
data{1}.notes = "Up Sweep, Low Vibration Branch, Frequency In Hz, Max Amplitude In Volts";
data{2}.notes = "Down Sweep, High Vibration Branch, Frequency In Hz, Max Amplitude In Volts";
data{1}.amplitude = aOut.left;
data{2}.amplitude = aOut.right;
% save("E_SysIDPreparedData.mat",'data')

end

