function sigma = calnoisesigma(m,sig,ebnodb,nTx,mode)

    % CALNOISESIGMA return noise power according to the input signal vector
    % ���ݸ������������������ʣ�֧�ֶྶ����ģ��
    % If assuming equal transmit power in different multipath environment,
    % the signal power should be dicided by sqrt(L)*signal.
    % When deploying the same power at each antenna, nTx should always be 1
    % regardless of the multipath environment.
    % Besides, when transmitting symbols of 16-QAM signal instead of
    % bitstream, the m parameter should be set to 2 in order to calculate
    % the noise on each symbol.
    % Author: Jumper_Le (Southeast University) 20171126 Version.2
    % Updates: ����������ԭʼ�źŵ��������ʼ���ģʽ��ֻ����������Ϊ��measured��

    if nargin==4
        sig=sig.*sqrt(nTx);
        k=log2(m);
        Eb=mean((abs(sig)).^2)/k;
        EbN0Lin=10^(ebnodb/10);
        sigma=sqrt(Eb/(EbN0Lin));
    elseif nargin==5 && mode=='measured'
        snr=ebnodb+10*log10(log2(m));
        snrnodb=10^(snr/10);
        sigma=sqrt(1/snrnodb);
    end
    
end

