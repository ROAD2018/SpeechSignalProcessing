%LPC转LSP函数
function lsf=lpctolsf(a)
a=a(:);                       % 将a转换为列向量
% 如果a不是实数，输出错误信息：LSF不适用于复多项式的求解
if ~isreal(a) ,
      error('Line spectral frequencies are not defined for complex polynomials.');
end
% 如果a(1)不为1,将矩阵a的每个元素除以a(1)再赋给矩阵
if a(1) ~= 1.0,
    a=a./a(1); 
end
% 如果a的根不在单位圆内,显示错误信息并返回
if (max(abs(roots(a))) >= 1.0),
    error ('The polynomial must have all roots inside of the unit circle. ');
    return;
end
%求对称和反对称多项式的系数
p=length(a) - 1;              % 求对称和反对称多项式的阶次
a1=[a;0];                     % 给行矩阵a再增加一个元素0的行 
a2=a1(end:-1:1);              % a2的第一行为a1的最后一行，最后一行为al的第一行
P1=a1+a2;                     % 按式(3-82)求对称多项式的系数
Q1=a1-a2;                     % 按式(3-83)求反对称多项式的系数
%如果阶次p为偶数次，按式(3-89)和式(3-90)从P1去掉实数根z=-1，从Q1去掉实数根z=1
%如果阶次为奇数次，从Q1去掉实数根z=1及z=-1
if rem(p,2),                  % 求解P除以2的余数，如果P为奇数次。余数为1，否则为0
   Q=deconv(Q1,[1 0 -1]);     % 奇数阶次，从Q1去掉实数根z=1及z=-1
   P=P1;
else                          % P为偶数阶次执行下面的操作
   Q=deconv(Q1,[1 -1]);       % 从Q1去掉实数根z=1
   P=deconv(P1, [1 1] );      % 从P1去掉实数根z=-1
end
rP=roots(P);                  % 求去掉实根后的多项式P的根
rQ=roots(Q) ;                 % 求去掉实根后的多项式Q的根
aP=angle(rP(1: 2:end) ) ;     % 将多项式P的根转换为角度(为归一化角频率)赋给ap
aQ=angle(rQ(1: 2:end));       % 将多项式Q的根转换为角度(为归一化角频率)赋给aQ 
lsf= sort([aP; aQ]);          % 将P、Q的根(归一化角频率)按从小到大的顺序排序后即为lsf

