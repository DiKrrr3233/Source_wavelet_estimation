function wavelet=s_roots2wavelet(zroots,first,step,maxamp)
% Compute wavelet from the zeros of its z-transform
% Written by: E. Rietsch: June 13, 2004
% Last updated:

%  这段文本是一个名为 s_roots2wavelet 的函数，它根据 z 变换的零点计算小波。
% 该函数有四个输入参数：zroots 是 z 变换的根，first 是第一个样本的时间，step 是采样间隔，maxamp 是结果小波的最大振幅。
% 该函数的输出是一个单轨地震结构的小波。
% 在函数内部，首先使用 poly 函数从 zroots 计算多项式系数，并将其实部存储在 temp 中。
% 然后，将 temp 乘以 maxamp/max(temp) 以调整其最大振幅。
% 接下来，使用 s_convert 函数将 temp 转换为小波，并将其存储在 wavelet 中。最后，为 wavelet 添加标签 'wavelet'。

%          wavelet=s_roots2wavelet(zroots,first,step)
% INPUT
% zroots   roots of the z-transform
% first    time of first sample
% step     sample interval
% maxamp   maximum amplitude of resulting wavelet
% OUTPUT
% wavelet  one-trace seismic structure

temp=real(poly(zroots));
temp=temp*(maxamp/max(temp));
wavelet=s_convert(flipud(temp(:)),first,step);
wavelet.tag='wavelet';
