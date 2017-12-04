function [ result, pos ] = mldecision( sig, starmap, maxpwr )

    % MLDECISION maximum likelihood decision �����Ȼ���о���
    % especially designed for alamouti code scheme ΪAlamouti�����ر����
    % ÿ��ֻ�ܽ���һ����������о�����ò�Ҫ�������������
    % Author: Jumper_Le (Southeast University) 20171118 Version.2
    % Update: - �����������˹�һ���������أ�������֮ǰ�����۹�����Ϊ�о�����

    if length(starmap)==1
        % �������ͼ���볤��Ϊ1���京�������ƽ�������ô�ɺ����Զ�����starmap�׵��Ʒ�������ͼ
        starmap = getstarmap(starmap); 
        % ʹ��getstarmap�����Զ����ض�Ӧ���ƽ���������ͼ
    end

    m = length(starmap);
    % ȡ������ͼ���������ƽ�����
    realpart = real(starmap);
    imagpart = imag(starmap);
    % �ֱ�ȡ������ͼ��ʵ�����鲿����
    disarr = zeros(1,m);
    % ��һ��m�����飬�洢ƽ��ŷ�Ͼ���
    for n=1:m
       disarr(n)=squaredis(sig,[realpart(n),imagpart(n)],maxpwr);
       % ���������ź������������֮���ƽ��ŷ�Ͼ���
    end
    [~,pos] = min(disarr);
    result = starmap(pos);
    % �ҳ����о�������ظ�result����Ӧ����������ױ�ŷ��ظ�pos

end

