function [w] = CalculatewFromModel(c,data)
%FUN 
aL = data.leftBranch.A;
aR = data.rightBranch.A;
wR = c(1) +c(2)*aR.^2+sqrt(c(3)./aR.^2-c(4));
wL = c(1) +c(2)*aL.^2-sqrt(c(3)./aL.^2-c(4));
w = [wR wL]';

%     if ~isreal(w)
%         error("Imaginary w\n")
%     end

end

