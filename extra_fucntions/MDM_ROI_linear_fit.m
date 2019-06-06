function [C,fit,ROI_list,BinTVm,BinParm,STDm,data]=MDM_ROI_linear_fit(MDM,aparcaseg,TV,Parameter)

C=unique(seg);
C(C==0)=[];

[ROI_list,fit,BinTVm,BinParm,STDm]=MDM_fit(MDM,C,TV,data,Parameter);

if MDM.save_fig==1
    save(fullfile(MDM.Subject_D,MDM.saveat,['/fit' MDM.str_par '.mat']),'fit')
end

end