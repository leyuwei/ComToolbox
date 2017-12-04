function [ precode, equalizer, diagonal, output ] = svdChannel( H, sig )

    % SVDCHANNEL returns svd decomposition of random CSI matrix
    % 返回任意MIMO信道的预编码矩阵、接收端均衡矩阵和SVD分解后的对角阵
    % Author: Jumper_Le (Southeast University) 20171126 Version.2
    % Updates：- 修正：output矩阵的初始化尺寸错误可能导致的程序崩溃问题

    dim=length(size(H));
    if dim<=2
        [U,S,V]=svd(H);
        precode=V;
        equalizer=U';
        diagonal=S;
        if nargin==2
            output=precode*sig;
        end
    elseif dim==3
        precode=zeros(size(H,2),size(H,2),size(H,3));
        equalizer=zeros(size(H,1),size(H,1),size(H,3));
        diagonal=zeros(size(H,1),size(H,2),size(H,3));
        output=zeros(size(H,1),size(sig,2),size(H,3));
        for ii=1:size(H,3)
            [U,S,V]=svd(H(:,:,ii));
            % U:M阶矩阵 V:N阶矩阵 S:M*N
            precode(:,:,ii)=V;
            equalizer(:,:,ii)=U';
            diagonal(:,:,ii)=S; 
            if nargin==2
                output(:,:,ii)=H(:,:,ii)*precode(:,:,ii)*sig(:,:,ii);
                % 如果参数包含信号阵，那么顺带输出H*F*s海飞丝结果，不包含加性噪声
            end
        end
    end
    
end

