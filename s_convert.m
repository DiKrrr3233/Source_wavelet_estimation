function seismic=s_convert(traces,first,step,history,units)
% Function creates a minimal seismic data structure (the history field is optional)
%这段文本是一个名为 s_convert 的函数，它创建了一个最小的地震数据结构（历史字段是可选的）。
%该函数有五个输入参数：traces 是地震轨迹数组，first 是起始时间/频率/深度，step 是采样间隔，history 是可选的字符串，用于放入历史字段，units 是测量单位的字符串（默认为 'ms'）。
%该函数的输出是满足最低要求的地震结构。

%在函数内部，首先定义了地震数据集的标准字段，包括 type、tag、name、first、last 和 step。
%然后根据输入参数设置 units 和 traces 字段。
%接下来，检查轨迹中是否有 NaN 值，并相应地设置 null 字段。
%然后根据全局变量 S4M.precision 的值将地震数据转换为所需的精度。
%最后，如果全局变量 S4M.history 为真，则使用 s_history 函数向地震数据集添加历史字段。

% Written by; E. Rietsch
% Last updated: October 7, 2006: change output to requested precision
%
%            seismic=s_create(traces,first,step,history,units)
% INPUT
% traces     array of seismic traces
% first      start time/frequency/depth
% step       sample interval
% history    optional string to put into history field
% units      string with units of measurements (default: 'ms')
% OUTPUT
% seismic    seismic structure satisfying minimal requirements
%
% EXAMPLE
%            seismic=s_convert(randn(251,12),0,4,[],'ft');
%            s_wplot(seismic)

global S4M

run_presets_if_needed

%	Define standard fields of a seismic dataset
seismic.type='seismic';
seismic.tag='unspecified';
seismic.name='';
seismic.first=first;
seismic.last=first+(size(traces,1)-1)*step;
seismic.step=step;

if nargin < 5
   seismic.units='ms';
else
   seismic.units=units;
end

seismic.traces=traces;

if any(isnan(traces(:)))   % Check for NaNs
   seismic.null=NaN;
else
   seismic.null=[];
end

%	Convert to the requested precision
if strcmpi(S4M.precision,'single')
   seismic=single(seismic);
else
   seismic=double(seismic);
end


%       Add a history field to the seismic dataset
if S4M.history
   if nargin < 4
      history='';
   end
   seismic=s_history(seismic,'add',history);
end
