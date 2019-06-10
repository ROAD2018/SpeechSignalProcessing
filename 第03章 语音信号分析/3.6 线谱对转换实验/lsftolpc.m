%LSP转LPC函数
function a=lsftolpc(lsf)
% 如果线谱频率lsf是复数，则返回错误信息
if (~isreal(lsf)) ,
       error ('Line spectral frequencies must be real. ' ) ;
end
% 如果线谱频率lsf不在O～pi范围，则返回错误信息
if (max(lsf) > pi || min(lsf)< 0),
       error ( 'Line spectral frequencies must be between 0 and pi. ' ) ;
end
lsf=lsf(:);                   % 将lsf转换为列向量
p=length(lsf);                % lsf阶次为p
% 用lsf形成零点
z= exp(j * lsf);
rP=z(1:2:end);                % 把奇次z(1)、z(3)到z(p-1)赋给rP
rQ=z(2:2:end);                % 把偶次z(2)、z(4)到z(p)赋给rQ
% 考虑共轭复根
rQ=[rQ;conj(rQ)];             % 把rQ的共轭复根赋上
rP=[rP;conj(rP)];             % 把rP的共轭复根赋上
% 构成多项式P和Q，注意必须是实系数
Q =poly(rQ);
P =poly(rP);
% 考虑z=1和z=-1以形成对称和反对称多项式
if rem(p,2),
% 如果是奇数阶次，则z=+l和z=-1都是Q1(z)的根
     Q1=conv(Q,[1 0 -1]);
     P1=P;
else
% 如果是偶数阶次，z=-1是对称多项式P1(z)的根，z=1是反对称多项式Ql(z)的根
     Q1=conv(Q,[1 -1]);
     P1=conv(P,[1 1]);
end
% 按式(3-87)由P1和Q1求解LPC系数
a=.5 * (P1+Q1);
a(end)=[];                    %最后一个系数是O，不返回
