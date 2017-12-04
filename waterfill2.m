function [allocatedpower, waterlv] = waterfill2(transpower,noisearr)

    % WATERFILL2 returns waterfill algorithm results of the given SNR paras.
    % 注水算法，返回各个发射天线上分配的信号功率
    % 伴随有完整算法注释。为避免和MATLAB内嵌函数重名，故加上2后缀
    % Author: Jumper_Le (Southeast University) 20171125 Version.1
    
    [arisenoise,dt]=sort(noisearr);
    % 升序排列noise方差序列
    for p=length(arisenoise):-1:1
        % 开始降序号循环
        waterlevel=(transpower+sum(arisenoise(1:p)))/p;
        % 计算当前前p个噪声水平算出的水平面值
        pouringpower=waterlevel-arisenoise;
        % 计算以当前水平面，需要注入的水量
        pp=pouringpower(1:p);
        % 复制注入水量数组的前p个值到新变量pp
        if(pp(:)>=0)
            break;
            % 如果当前情况下，注入水量均为正值（有意义），那么退出循环，确认注水结束
        end
        % 如果注入水量有负值，需要舍弃当前序列噪声最大项，重新进行剩余项的注水分配
    end
    allocatedpower=zeros(1,length(arisenoise));
    allocatedpower(dt(1:p))=pp;
    % 返回p长度的信号功率分配数组，剩余的项均为0，代表超出水平面（不考虑）
    waterlv=waterlevel;
    % 返回waterlevel
    
end

