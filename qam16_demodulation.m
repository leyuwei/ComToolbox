function [bitstream,destarmap] = qam16_demodulation(starmap,maxpower)

    % QAM16_DEMODULATION demodulates the received 16-QAM signal
    % 16-QAM�����źŽ��
    % supporting power equalization
    % Author: Jumper_Le (Southeast University) 20171125 Version.2
    % Update: -�������ʹ�һ����BUG����ͬʱ֧��qam��ԭʼ���ʽ���͹�һ�����ʽ��

    tmp = zeros(1,length(starmap)*4);
    thre=2;
    if nargin==1
        maxlen=sqrt(2);
    else
        maxlen=maxpower;
    end
    %��һ������ֵ
    demoduleI=zeros(1,length(starmap));
    demoduleQ=zeros(1,length(starmap));
    % ����Ӳ�о�
    recvI=real(starmap);
    recvQ=imag(starmap);
    demoduleI(find(recvI<=(-thre/maxlen))) = -3;
    demoduleI(find(recvI>(-thre/maxlen) & recvI<=0)) = -1;
    demoduleI(find(recvI<=(thre/maxlen) & recvI>0)) = 1;
    demoduleI(find(recvI>(thre/maxlen))) = 3;
    demoduleQ(find(recvQ>(-thre/maxlen) & recvQ<=0)) = -1;
    demoduleQ(find(recvQ<=(thre/maxlen) & recvQ>0)) = 1;
    demoduleQ(find(recvQ>(thre/maxlen))) = 3;
    demoduleQ(find(recvQ<=(-thre/maxlen))) = -3;
    demoduleSig = demoduleI + 1j*demoduleQ;
    destarmap=demoduleSig;
    %����ɶ����Ʊ�����
    for n1=1:length(starmap)
        pack=zeros(1,4);
        if  demoduleSig(n1)==1+j
            pack=[0 0 0 0];
        elseif  demoduleSig(n1)==3+j
            pack=[0 0 1 0];
        elseif  demoduleSig(n1)==3+3j
            pack=[0 0 1 1];
        elseif  demoduleSig(n1)==1+3j
            pack=[0 0 0 1];
        elseif  demoduleSig(n1)==-1+3j
            pack=[0 1 0 1];
        elseif  demoduleSig(n1)==-1+j
            pack=[0 1 0 0];
        elseif  demoduleSig(n1)==-3+3j
            pack=[0 1 1 1];
        elseif  demoduleSig(n1)==-3+j
            pack=[0 1 1 0];
        elseif  demoduleSig(n1)==-3-j
            pack=[1 1 1 0];
        elseif  demoduleSig(n1)==-3-3j
            pack=[1 1 1 1];
        elseif  demoduleSig(n1)==-1-3j
            pack=[1 1 0 1];
        elseif  demoduleSig(n1)==-1-j
            pack=[1 1 0 0];
        elseif  demoduleSig(n1)==1-j
            pack=[1 0 0 0];
        elseif  demoduleSig(n1)==3-j
            pack=[1 0 1 0];
        elseif  demoduleSig(n1)==1-3j
            pack=[1 0 0 1];
        else
            pack=[1 0 1 1];
        end
        tmp(4*(n1-1)+1:4*(n1-1)+4) = pack;
    end
    bitstream = tmp;
end

