function [] = sf(sig)

    % SF returns the scatterplot of the parameter signal
    % ���������źŵ�ɢ��ͼ��һ�����ڵ���
    % Author: Jumper_Le (Southeast University) 20171125 Version.1
    
    figure;
    [maxlen,~]=max(size(sig));
    % Ϊ���ݸ��ֲ�ͬά���ľ���
    x=reshape(sig,1,maxlen);
    scatter(real(x),imag(x));
    
end

