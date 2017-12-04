function ber = alamouti_sim_mimo(n,order,ebn0db)

    % ALAMOUTI_SIM_MIMO returns BER simulation result under certain EbN0dB
    % 根据设定误码率返回各种调制模式在Alamouti模式下两发两收的仿真结果
    % 环境：加性复高斯噪声的瑞利衰落信道，两发两收MIMO
    % ENV: AWGN Rayleigh Fading Channel with 4 path
    % Supporting BPSK/QPSK/16QAM
    % Author: Jumper_Le (Southeast University) 20171118 Version.1

    %% 参数准备
    if order~=2 && order~=4 && order~=16
        % 非法值判定，强制置BPSK模式
        order=2;
    end
    starmap=getstarmap(order);
    % 星座图
    m=n/log2(order);
    % 符号数
    sig_orig=rand(1,n)>0.5;
    % 原始信号
    sig=zeros(1,m);
    % 符号内存预分配
    
    %% 调制并功率归一化
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
    % 功率归一化并减半，分散至两条发送天线
    
    %% Alamouti发送部分实现
    sigT1=reshape(sig,2,length(sig)/2);
    % [1 2 3 4 5 6] -> [1 3 5;2 4 6] T1时隙
    sigT2=[-conj(sigT1(2,:));conj(sigT1(1,:))];
    % [1 3 5;2 4 6] -> [-2* -4* -6*;1* 3* 5*] T2时隙
    s=[sigT1;zeros(2,size(sigT1,2))];
    s=reshape(s,2,size(sigT1,2)*2);
    % [1 3 5;2 4 6] -> [1 0 3 0 5 0;2 0 4 0 6 0]
    s(:,2:2:size(s,2))=sigT2;
    % [1 0 3 0 5 0;2 0 4 0 6 0] -> [1 -2* 3 -4* 5 -6*;2 1* 4 3* 6 5*]
    % 按照alamouti模式： [T1 T2 T1 T2 T1 T2 ...]_(2*M)
    s=[s;s];
    % 拷贝一份s构成4*M数组，供接下来四径传播使用
    
    %% 信道模型
    L=4;
    % 传播路径数
    sigma=calnoisesigma(order,sig,ebn0db,2);
    % 噪声功率
    noise=sigma/sqrt(2)*(randn(2,size(s,2))+1j*randn(2,size(s,2)));
    % 产生四路（noise矩阵每2*2做一个切割）加性复高斯噪声
    h=1/sqrt(2)*(randn(L,size(s,2)/2)+1j*randn(L,size(s,2)/2));
    h=reshape([h;h],L,size(s,2));
    % 产生归一化瑞利衰落信道，需要假设两个时隙的信道是时不变的
    % 这里出现的L代表四径传播系统
    hEq=abs(h(1,:)).^2+abs(h(2,:)).^2+abs(h(3,:)).^2+abs(h(4,:)).^2;
    % 接收端均衡器预设置
    rays=h.*s;
    tx=[rays(1,:)+rays(2,:);rays(3,:)+rays(4,:)]+noise;
    % 接收端接收信号 矩阵2*M 分别为两根天线接收向量
    
    %% 接收处理和ML判决
    rx=zeros(2,size(tx,2)/2);
    rx(1,:)=conj(h(1,1:2:size(h,2))).*tx(1,1:2:size(tx,2))...
            +h(2,1:2:size(h,2)).*conj(tx(1,2:2:size(tx,2)))...
            +conj(h(3,1:2:size(h,2))).*tx(2,1:2:size(tx,2))...
            +h(4,1:2:size(h,2)).*conj(tx(2,2:2:size(tx,2)));
    rx(2,:)=conj(h(2,1:2:size(h,2))).*tx(1,1:2:size(tx,2))...
            -h(1,1:2:size(h,2)).*conj(tx(1,2:2:size(tx,2)))...
            +conj(h(4,1:2:size(h,2))).*tx(2,1:2:size(tx,2))...
            -h(3,1:2:size(h,2)).*conj(tx(2,2:2:size(tx,2)));
    rx=reshape(rx,1,size(rx,2)*2);
    % 接收端按照alamouti模式合并
    rx=rx./hEq;
    % 合并接收信号均衡
    re=zeros(1,size(rx,2));
    for ii=1:size(rx,2)
        [re(ii),~]=mldecision(rx(ii),starmap,maxpwr);
    end
    % 进行ML判决，re数组存下判决结果
    
    %% 信号解调与BER计算
    switch order
        case 2
            result=re>0;
        case 4
            result=qpsk_demodulation(re);
        case 16
            result=qam16_demodulation(re);
    end
    ber=(size(find(sig_orig-result),2))/n;
    
end

