# ComToolbox
Communication Toolbox &amp; Function for MATLAB2017b

用于通信系统专业的仿真，长期更新。

/*****************************************************/ <br>
 Communication System Toolbox for MATLAB2017b<br>
 Designed and maintained by JumperLe from Southeast University<br>
 Copyright reserved. Any kinds of modification are strictly prohibited.<br>
/*****************************************************/<br><br>

20171126<br>
-------------------<br>
新增：waterfill3.m网络版本的注水分配算法，和原创的稍有不同<br>
新增：calnoisesigma.m现支持不依赖原始输入信号的统计噪声功率计算模式：measured<br>
修正：svdChannel.m中output矩阵的初始化尺寸错误可能导致的程序崩溃问题<br>
<br>
20171125<br>
-------------------<br>
新增：matmirror.m求取矩阵的行/列镜像对称阵<br>
新增：waterfill2.m多入多出MIMO中的信道功率注水分配算法<br>
修正：qam16_demodulation现支持默认/自定义最大功率解调两个模式，若功率进行了事先恢复即可不传入第二个参数<br>
修正：QAM和QPSK的调制解调工具函数均新增函数说明<br>
修正：scatterfig现在容错性更好，支持任意维数的矩阵<br>
修正：scatterfig改名sf，更快输入，更快调试<br>
<br>
20171122<br>
-------------------<br>
新增：任意信道SVD分解函数 svdChannel.m<br>
新增：散点图调试函数 scatterfig.m<br>
修正：mldecision.m考虑了归一化功率因素，不再以之前的理论功率作为判决门限<br>
