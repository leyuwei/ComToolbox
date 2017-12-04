function starmap = qam16_modulation(bitstream)

    % QAM16_MODULATION modulates bitstream to 16-QAM signal
    % 16-QAM信号调制，不含功率归一化
    % Author: Jumper_Le (Southeast University) 20171125 Version.1
    
    tmp = zeros(1,length(bitstream)/4);
    for n1=1:length(bitstream)/4
        pack = [bitstream(1,(n1-1)*4+1) bitstream(1,(n1-1)*4+2) bitstream(1,(n1-1)*4+3) bitstream(1,(n1-1)*4+4)];
        if  pack==[0 0 0 0]
            tmp(n1)=1+1j;
        elseif  pack==[0 0 1 0]
            tmp(n1)=3+1j;
        elseif  pack==[0 0 1 1]
            tmp(n1)=3+3j;
        elseif  pack==[0 0 0 1]
            tmp(n1)=1+3j;
        elseif  pack==[0 1 0 1]
            tmp(n1)=-1+3j;
        elseif  pack==[0 1 0 0]
            tmp(n1)=-1+1j;
        elseif  pack==[0 1 1 1]
            tmp(n1)=-3+3j;
        elseif  pack==[0 1 1 0]
            tmp(n1)=-3+1j;
        elseif  pack==[1 1 1 0]
            tmp(n1)=-3-1j;
        elseif  pack==[1 1 1 1]
            tmp(n1)=-3-3j;
        elseif  pack==[1 1 0 1]
            tmp(n1)=-1-3j;
        elseif  pack==[1 1 0 0]
            tmp(n1)=-1-1j;
        elseif  pack==[1 0 0 0]
            tmp(n1)=1-1j;
        elseif  pack==[1 0 1 0]
            tmp(n1)=3-1j;
        elseif  pack==[1 0 0 1]
            tmp(n1)=1-3j;
        else
            tmp(n1)=3-3j;
        end
    end
    starmap = tmp;
end

