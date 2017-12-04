function [bitstream,destarmap] = qpsk_demodulation(starmap)

    % QPSK_DEMODULATION demodulates the received QPSK signal
    % QPSK接收信号解调
    % supporting power equalization
    % Author: Jumper_Le (Southeast University) 20171125 Version.1

    tmp = zeros(1,length(starmap)*2);
    % 门限硬判决
    for ii=1:length(starmap)
       if real(starmap(ii))>0 && imag(starmap(ii))>0
           starmap(ii)=1+1i;
       elseif real(starmap(ii))<=0 && imag(starmap(ii))>0
           starmap(ii)=-1+1i;
       elseif real(starmap(ii))<=0 && imag(starmap(ii))<=0
           starmap(ii)=-1-1i;
       elseif real(starmap(ii))>0 && imag(starmap(ii))<=0
           starmap(ii)=1-1i;
       end
    end
    destarmap=starmap;
    %解码成二进制比特流
    for ii=1:length(starmap)
        pack = zeros(1,2);
        if starmap(ii)==1+1i
            pack=[0 0];
        elseif starmap(ii)==-1+1i
            pack=[0 1];
        elseif starmap(ii)==-1-1i
            pack=[1 1];
        elseif starmap(ii)==1-1i
            pack=[1 0];
        end
        tmp([2*(ii-1)+1 2*(ii-1)+2])=pack;
    end
    bitstream = tmp;
end

