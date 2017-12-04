function [allocatedpower, waterlv] = waterfill2(transpower,noisearr)

    % WATERFILL2 returns waterfill algorithm results of the given SNR paras.
    % עˮ�㷨�����ظ������������Ϸ�����źŹ���
    % �����������㷨ע�͡�Ϊ�����MATLAB��Ƕ�����������ʼ���2��׺
    % Author: Jumper_Le (Southeast University) 20171125 Version.1
    
    [arisenoise,dt]=sort(noisearr);
    % ��������noise��������
    for p=length(arisenoise):-1:1
        % ��ʼ�����ѭ��
        waterlevel=(transpower+sum(arisenoise(1:p)))/p;
        % ���㵱ǰǰp������ˮƽ�����ˮƽ��ֵ
        pouringpower=waterlevel-arisenoise;
        % �����Ե�ǰˮƽ�棬��Ҫע���ˮ��
        pp=pouringpower(1:p);
        % ����ע��ˮ�������ǰp��ֵ���±���pp
        if(pp(:)>=0)
            break;
            % �����ǰ����£�ע��ˮ����Ϊ��ֵ�������壩����ô�˳�ѭ����ȷ��עˮ����
        end
        % ���ע��ˮ���и�ֵ����Ҫ������ǰ���������������½���ʣ�����עˮ����
    end
    allocatedpower=zeros(1,length(arisenoise));
    allocatedpower(dt(1:p))=pp;
    % ����p���ȵ��źŹ��ʷ������飬ʣ������Ϊ0��������ˮƽ�棨�����ǣ�
    waterlv=waterlevel;
    % ����waterlevel
    
end

