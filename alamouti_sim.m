function ber = alamouti_sim(n,order,ebn0db)

    % ALAMOUTI_SIM returns BER simulation result under certain EbN0dB
    % �����趨�����ʷ��ظ��ֵ���ģʽ��Alamoutiģʽ������һ�յķ�����
    % ���������Ը���˹����������˥���ŵ�������һ��MISO
    % ENV: AWGN Rayleigh Fading Channel with 2 path
    % Supporting BPSK/QPSK/16QAM
    % Author: Jumper_Le (Southeast University) 20171118 Version.1

    %% ����׼��
    if order~=2 && order~=4 && order~=16
        % �Ƿ�ֵ�ж���ǿ����BPSKģʽ
        order=2;
    end
    starmap=getstarmap(order);
    % ����ͼ
    m=n/log2(order);
    % ������
    sig_orig=rand(1,n)>0.5;
    % ԭʼ�ź�
    sig=zeros(1,m);
    % �����ڴ�Ԥ����
    
    %% ���Ʋ����ʹ�һ��
    switch order
        case 2
            sig=sig_orig*2-1;
            maxpwr=1;
        case 4
            sig=qpsk_modulation(sig_orig);
            maxpwr=sqrt(2);
        case 16
            sig=qam16_modulation(sig_orig);
            maxpwr=sqrt(10);
    end
    maxpwr=maxpwr*2; 
    sig=sig./maxpwr;
    % ���ʹ�һ�������룬��ɢ��������������
    
    %% Alamoutiʵ��
    sigT1=reshape(sig,2,length(sig)/2);
    % [1 2 3 4 5 6] -> [1 3 5;2 4 6] T1ʱ϶
    sigT2=[-conj(sigT1(2,:));conj(sigT1(1,:))];
    % [1 3 5;2 4 6] -> [-2* -4* -6*;1* 3* 5*] T2ʱ϶
    s=[sigT1;zeros(2,size(sigT1,2))];
    s=reshape(s,2,size(sigT1,2)*2);
    % [1 3 5;2 4 6] -> [1 0 3 0 5 0;2 0 4 0 6 0]
    s(:,2:2:size(s,2))=sigT2;
    % [1 0 3 0 5 0;2 0 4 0 6 0] -> [1 -2* 3 -4* 5 -6*;2 1* 4 3* 6 5*]
    % ����alamoutiģʽ�� [T1 T2 T1 T2 T1 T2 ...]_(2*M)
    
    %% �ŵ�ģ��
    sigma=calnoisesigma(order,sig,ebn0db,2);
    % ��������
    noise=sigma/sqrt(2)*(randn(1,size(s,2))+1j*randn(1,size(s,2)));
    % ������·���Ը���˹����
    h=1/sqrt(2)*(randn(2,size(s,2)/2)+1j*randn(2,size(s,2)/2));
    h=reshape([h;h],2,size(s,2));
    % ������һ������˥���ŵ�����Ҫ��������ʱ϶���ŵ���ʱ�����
    hEq=abs(h(1,:)).^2+abs(h(2,:)).^2;
    % ���ն˾�����Ԥ����
    tx=sum(h.*s)+noise;
    % ���ն˽����ź�
    
    %% ���մ����ML�о�
    rx=zeros(2,size(tx,2)/2);
    rx(1,:)=conj(h(1,1:2:size(h,2))).*tx(1:2:size(tx,2))+h(2,1:2:size(h,2)).*conj(tx(2:2:size(tx,2)));
    rx(2,:)=conj(h(2,1:2:size(h,2))).*tx(1:2:size(tx,2))-h(1,1:2:size(h,2)).*conj(tx(2:2:size(tx,2)));
    rx=reshape(rx,1,size(rx,2)*2);
    % ���ն˰���alamoutiģʽ�ϲ�
    rx=rx./hEq;
    % �ϲ������źž���
    re=zeros(1,size(rx,2));
    for ii=1:size(rx,2)
        [re(ii),~]=mldecision(rx(ii),starmap,maxpwr);
    end
    % ����ML�о���re��������о����
    
    %% �źŽ����BER����
    switch order
        case 2
            result=re>0;
        case 4
            result=qpsk_demodulation(re);
        case 16
            result=qam16_demodulation(re,maxpwr);
    end
    ber=(size(find(sig_orig-result),2))/n;
    
end

