function starmap = qpsk_modulation(bitstream)

    % QPSK_MODULATION modulates bitstream to QPSK signal
    % QPSK信号调制，不含功率归一化
    % Author: Jumper_Le (Southeast University) 20171125 Version.1
    
    tmp = zeros(1,length(bitstream)/2);
    for ii=1:length(bitstream)/2
        pack = [bitstream(1,(ii-1)*2+1) bitstream(1,(ii-1)*2+2)];
        if pack==[0 0]
            tmp(ii)=1+1i;
        elseif pack==[0 1]
            tmp(ii)=-1+1i;
        elseif pack==[1 1]
            tmp(ii)=-1-1i;
        elseif pack==[1 0]
            tmp(ii)=1-1i;
        end
    end
    starmap = tmp;
end

