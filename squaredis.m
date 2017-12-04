function squared = squaredis(data,target,maxlen)

    % SQUAREDIS returns squared euclidean distance between two points
    % 返回两点间的平方欧氏距离，考虑到了功率归一化因素
    % Author: Jumper_Le (Southeast University) 20171110 Version.1

    squared=(real(data)-target(1)/maxlen)^2+(imag(data)-target(2)/maxlen)^2;
    
end

