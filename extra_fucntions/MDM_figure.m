function MDM_figure(MDM,C,BinTVm,BinParm,STDm,fit)

color=parula(length(C));
h=figure('Position', get(0, 'Screensize'));
hold on
for i=1:length(C)
    plot([0,0],[0,0],'LineWidth',2,'color',color(i,:));
    legendInfo{i}=strcat('ROI ',num2str(C(i)),' slop=',num2str(fit(i,1)));
    
end
for i=1:length(C)
    v1=BinTVm{i};
    v2=BinParm{i};
    plot(v1,v2,'.','color',color(i,:),'MarkerSize',15)
end
for i=1:length(C)
    v1=BinTVm{i};
    err=STDm{i};
    [hl,hp]=boundedline(v1,v1*fit(i,1)+fit(i,2),err,'alpha','transparency',0.2,'cmap',color(i,:)) ;
end
for i=1:length(C)
    v1=BinTVm{i};
    plot(MDM.TV_range,MDM.TV_range*fit(i,1) +fit(i,2),'--','color',color(i,:),'LineWidth',1);
    plot(v1,v1*fit(i,1) +fit(i,2),'color',color(i,:),'LineWidth',2);
end

hold off
legend(legendInfo)
xlim(MDM.TV_range)
title([MDM.str_par ' Vs. MTV'])
xlabel(MDM.TV_str)
ylabel(MDM.str_par)
if MDM.save_fig==1
    F    = getframe(h);
    imwrite(F.cdata, fullfile(MDM.saveat,['/MDM_figre.png']), 'png')
    savefig(h,fullfile(MDM.saveat,['/MDM_figre.fig']))
end
end