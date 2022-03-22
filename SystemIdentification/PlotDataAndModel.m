function [] = PlotDataAndModel(data,wModel,aModel)
%PLOTDATAANDMODEL 

%experimental results
plot(data.leftBranch.w,data.leftBranch.A,'x');
hold on
plot(data.rightBranch.w,data.rightBranch.A,'x');

plot(wModel,aModel,'.')



end

