function [ starmap ] = getstarmap( order )

    % GETSTARMAP return starmap array corresponding to the input value,
    % using GREYCODE.
    % 根据调制阶数自动返回对应的星座图数组，使用格雷码顺序
    % maximum input value is 16 that is 16-QAM
    % Author: Jumper_Le (Southeast University) 20171110 Version.1

    starmap = zeros(1,order);
    if order==2
        starmap = [-1 1];
    elseif order==4
        starmap = [1+1j -1+1j -1-1j 1-1j];
    elseif order==16
        starmap = [1+1j 3+1j 3+3j 1+3j -1+3j -1+1j -3+3j -3+1j -3-1j -3-3j -1-3j -1-1j 1-1j 3-1j 1-3j 3-3j];
    end

end

