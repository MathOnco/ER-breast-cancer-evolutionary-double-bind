function [] = runTrajectories(foldername,ti,Nf,Nr,TIME_INDEX,name)
    for fi=1:1:Nf        
        % across all replicates:
        plotTrajectory(foldername,ti,fi,Nr,true,TIME_INDEX);
        figure(fi);
        subplot(211);
        set(gca,'YScale','log');
        ylim([1,1.2e6]);
        printPNG(figure(fi),strcat('plots/',name,'-', num2str(fi),'.png'));
    end    
end