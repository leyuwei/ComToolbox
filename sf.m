function [] = sf(sig)

    % SF returns the scatterplot of the parameter signal
    % 返回输入信号的散点图，一般用于调试
    % Author: Jumper_Le (Southeast University) 20171125 Version.1
    
    figure;
    [maxlen,~]=max(size(sig));
    % 为兼容各种不同维数的矩阵
    x=reshape(sig,1,maxlen);
    scatter(real(x),imag(x));
    
end

