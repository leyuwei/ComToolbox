function [ result, pos ] = mldecision( sig, starmap, maxpwr )

    % MLDECISION maximum likelihood decision 最大似然比判决器
    % especially designed for alamouti code scheme 为Alamouti方案特别设计
    % 每次只能进行一个星座点的判决，最好不要传入接收向量组
    % Author: Jumper_Le (Southeast University) 20171118 Version.2
    % Update: - 修正：考虑了归一化功率因素，不再以之前的理论功率作为判决门限

    if length(starmap)==1
        % 如果星座图输入长度为1，其含义代表调制阶数，那么由函数自动按照starmap阶调制分配星座图
        starmap = getstarmap(starmap); 
        % 使用getstarmap函数自动返回对应调制阶数的星座图
    end

    m = length(starmap);
    % 取得星座图点数（调制阶数）
    realpart = real(starmap);
    imagpart = imag(starmap);
    % 分别取得星座图的实部、虚部数组
    disarr = zeros(1,m);
    % 开一个m长数组，存储平方欧氏距离
    for n=1:m
       disarr(n)=squaredis(sig,[realpart(n),imagpart(n)],maxpwr);
       % 计算输入信号与各个星座点之间的平方欧氏距离
    end
    [~,pos] = min(disarr);
    result = starmap(pos);
    % 找出的判决结果返回给result，对应的星座点格雷编号返回给pos

end

