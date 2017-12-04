function PowerAllo = waterfill3(PtotA,ChAh,N0)

    % WATERFILL3 returns waterfill algorithm results of the given SNR paras.
    % עˮ�㷨�����ظ������������Ϸ�����źŹ���
    % PtotA �����䷢���ź��ܹ���
    % ChA ˥���ŵ�����
    % N0 ��������
    % Source: Internet. Copyright belongs to the original author 20171126

    [~,ChA,~] = svd(ChAh);
    ChA = diag(ChA);
    ChA = ChA + eps; 
    B = 1;
    NA = length(ChA);
    % the number of subchannels allocated to 
    H = ChA.^2/(B*N0);
    % the parameter relate to SNR in subchannels 
    % assign the power to subchannel 
    PowerAllo = (PtotA + sum(1./H))/NA - 1./H; 
    while(length(find(PowerAllo < 0 ))>0) 
        IndexN = find(PowerAllo <= 0 ); 
        IndexP = find(PowerAllo > 0); 
        MP = length(IndexP); 
        PowerAllo(IndexN) = 0; 
        ChAT = ChA(IndexP); 
        HT = ChAT.^2/(B*N0); 
        PowerAlloT = (PtotA + sum(1./HT))/MP - 1./HT; 
        PowerAllo(IndexP) = PowerAlloT; 
    end 
    PowerAllo = PowerAllo.';
    
end


