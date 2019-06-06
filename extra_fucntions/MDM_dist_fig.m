function MDM_dist_fig(MDM,C,TV,Parameter,data,BinTVm,BinParm,STDm,fit)


dist=struct;
h=figure('Position', get(0, 'Screensize'));
for i=1:length(C)
    dist(i).TV=TV(data==C(i));
    dist(i).Par=Parameter(data==C(i));
    [p,n]=numSubplots(length(C));
    subplot(p(1),p(2),i)
    plot2Dhist(TV(data==C(i)),Parameter(data==C(i)),100,MDM.TV_range,MDM.range,MDM.TV_str,MDM.str_par); %xlim([0.5 1]);ylim([0.5 1])
    dist(i).xbin=BinTVm{i};
    dist(i).ybin=BinParm{i};
    dist(i).err=STDm{i};
    vec=[min(BinTVm{i})-0.1*min(BinTVm{i}) max(BinTVm{i})+0.1*max(BinTVm{i})];
    hold on
    plot(vec,vec*fit(i,1)+fit(i,2));
    plot(dist(i).xbin,dist(i).ybin,'*')
    title(['ROI ' num2str(C(i))])
    hold off
end

if MDM.save_fig==1
    F    = getframe(h);
    imwrite(F.cdata, fullfile(MDM.saveat,'dist.png'), 'png')
    savefig(h,fullfile(MDM.saveat,'/dist.fig'))
end