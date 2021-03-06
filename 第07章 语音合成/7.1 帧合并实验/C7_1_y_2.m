%实验要求二：基于重叠存储法的信号分帧与还原
clc
clear all
close all
[s,fs]=audioread('C7_1_y.wav');
winlen=256;
win=hamming(winlen);
overlap=100;
f=enframe(s,win,overlap);
fn=Filpframe_OverlapS(f,win,overlap);
subplot(211)
plot(s/max(abs(s)))
xlabel('点数')
ylabel('幅度')
title('(a)原始信号')
subplot(212)
plot(fn/max(abs(fn)))
xlabel('点数')
ylabel('幅度')
title('(b)还原信号')