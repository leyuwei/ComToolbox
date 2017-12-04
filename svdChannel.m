function [ precode, equalizer, diagonal, output ] = svdChannel( H, sig )

    % SVDCHANNEL returns svd decomposition of random CSI matrix
    % ��������MIMO�ŵ���Ԥ������󡢽��ն˾�������SVD�ֽ��ĶԽ���
    % Author: Jumper_Le (Southeast University) 20171126 Version.2
    % Updates��- ������output����ĳ�ʼ���ߴ������ܵ��µĳ����������

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
            % U:M�׾��� V:N�׾��� S:M*N
            precode(:,:,ii)=V;
            equalizer(:,:,ii)=U';
            diagonal(:,:,ii)=S; 
            if nargin==2
                output(:,:,ii)=H(:,:,ii)*precode(:,:,ii)*sig(:,:,ii);
                % ������������ź�����ô˳�����H*F*s����˿�������������������
            end
        end
    end
    
end

