function [MDM]=MDM_fit(MDM,C,TV,data,Parameter)

% fit the linear relationship between the qMRI parameter and MTV
% for the different ROIs in the segmentation

Bin=0.05:0.01:0.4; % Create bins for MTV values

BinTVm=[];
BinParm=[];
NUMm=zeros(length(Bin)-1,length(C));
STDm=[];
fit=nan(length(C),2);

for i=1:length(C) % for each ROI
    BinTV=[]; BinPAR=[]; std_c=[]; num=[];
    % divide to bins
    [BinTV,BinPAR,std_c,num]=MDM_bin(Bin,TV,data,Parameter,C(i));
    NUMm(:,i)=num;
    
    % take only bins with enough voxels
    y=BinPAR;
    y(isnan(BinPAR) | isnan(BinTV) | num<0.04*sum(num) ) = [];
    x=BinTV;
    x(isnan(BinPAR) | isnan(BinTV) | num<0.04*sum(num) ) = [];
    BinTVm{i}=x;
    BinParm{i}=y;
    std_c(isnan(BinPAR) | isnan(BinTV) | num<0.04*sum(num) ) = [];
    STDm{i}=std_c;
    
    % linear fit
    if ~isempty(x)
        mdl=fitlm(x,y);
        fit(i,1)=mdl.Coefficients{2,1};
        fit(i,2)=mdl.Coefficients{1,1};
    end
end

MDM.fit=fit; % slope and intersection of the linear relationship between a qMRI parameter and MTV
MDM.BinTV=BinTVm; %  median values of MTV within each bin
MDM.BinPar=BinParm; % median values of the qMRI parameter within each bin
MDM.STD=STDm; % STD of the qMRI parameter within each bin
end