function squared = squaredis(data,target,maxlen)

    % SQUAREDIS returns squared euclidean distance between two points
    % ����������ƽ��ŷ�Ͼ��룬���ǵ��˹��ʹ�һ������
    % Author: Jumper_Le (Southeast University) 20171110 Version.1

    squared=(real(data)-target(1)/maxlen)^2+(imag(data)-target(2)/maxlen)^2;
    
end

