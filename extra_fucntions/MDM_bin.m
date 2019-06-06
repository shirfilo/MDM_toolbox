function [BinTV,BinPar,std_c,num]=MDM_bin(Bin,TV,seg,Parameter,seg_type)

% This function pools the qMRI parameter (R1,MTsat,etc..) and MTV into bins.
% seg is the segmentation matrix.
% seg_type is a label that determines the ROI on which the binning is done.
% outputs are:
% 1) median values of MTV within each bin
% 2) median values of the qMRI parameter within each bin
% 3) the STD of the qMRI parameter within each bin

BinTV=nan(length(Bin)-1,1);
BinPar=nan(length(Bin)-1,1);
num=zeros(length(Bin)-1,1);
std_c=nan(length(Bin)-1,1);

for ii=1:length(Bin)-1
    clear ind
    ind=find(TV>=Bin(ii) & TV<Bin(ii+1) & seg==seg_type);
    num(ii)=length(ind);
    if ~isempty(ind)
       BinTV(ii)=median(TV(ind)); % median values of MTV within each bin
       BinPar(ii)=median(Parameter(ind)); % median values of the qMRI parameter within each bin
       std_c(ii)=mad(Parameter(ind),1); % the STD of the qMRI parameter within each bin
    end
end
end