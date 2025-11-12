%% plot the data w/ error bars
function [h,z]=plot1d(CELL_LINE,DRUG1,DRUG2,RESISTANT_TO, S_or_R,FOLDER,d1,d2,ls)
    
    color=black();

    %% x is the concentraiton of the respective chemotherapy:
    [x,y,z,ez]=getMUSYC(CELL_LINE,DRUG1,DRUG2,RESISTANT_TO, S_or_R,FOLDER);

    %% disulfiram = 0
    indices = (y==min(y)); % disulfiram = 0.
    [xvec,zvec]=addData(indices,x,y,z,ez,color,'o');

    % add Hill fit:
    [E0,E1,E2,E3,r1,r2,C1,C2,h1,h2,a12,a21] = getMusycParameters(char(CELL_LINE),char(DRUG1),char(DRUG2),char(RESISTANT_TO), char(S_or_R),FOLDER);
    [Ed] = E(d1*1e6,d2*1e6,E0,E1,E2,E3,r1,r2,C1,C2,h1,h2,a12,a21);
    %plot(d1(1,:), Ed(1,:), '-','Color',color,'LineWidth',2); hold on;

    [~,~,chi,model,resnorm, RESIDUAL]=getHillFit(xvec,zvec);
    
    exp_fit = -7.5:0.1:-2.5;
    yfit = model(chi,exp_fit);
    plot(10.^(exp_fit), yfit, ls,'Color',color,'LineWidth',2); hold on;
    
    color = color + 0.6;

    %% disulfiram = max
    indices = (y==max(y)); % disulfiram = 0.
    [xvec,zvec]=addData(indices,x,y,z,ez,color,'s');

    % add Hill fit:
    [E0,E1,E2,E3,r1,r2,C1,C2,h1,h2,a12,a21] = getMusycParameters(char(CELL_LINE),char(DRUG1),char(DRUG2),char(RESISTANT_TO), char(S_or_R),FOLDER);
    [Ed] = E(d1*1e6,d2*1e6,E0,E1,E2,E3,r1,r2,C1,C2,h1,h2,a12,a21);
    %plot(d1(end,:), Ed(end,:), '--','Color',color,'LineWidth',2); hold on;

    [~,~,chi,model,resnorm, RESIDUAL]=getHillFit(xvec,zvec);

    yfit = model(chi,exp_fit);
    plot(10.^(exp_fit), yfit, ls,'Color',color,'LineWidth',2); hold on;

    %% axis / plot features
    set(gca,'XScale','log');
    clean(); setfontsize(12);
    xlabel(DRUG1);
    ylabel('Effect');
    ylim([0 1.5])

    h=legend('','chemo','','chemo + disulf.','','','','','','','','','','','','','','');




%     [C1chemo,C1chemo_disu]

%     plot([C1chemo,C1chemo],[0 1],'-','Color',black(),'LineWidth',4); hold on;
%     plot([C1chemo_disu,C1chemo_disu],[0 1],':','Color',color,'LineWidth',4);


end

function [xvec,zvec] = addData(indices,x,y,z,ez,color,marker)
    xvec = []; zvec = [];
    for i=1:length(x) % vertical errorbars
        if (indices(i) == 1)
            xV = [x(i); x(i)]; yV = [y(i); y(i)];
            zMin = z(i) + ez(i); zMax = z(i) - ez(i);
            zB = [zMin, zMax];
%             plot(xV, zB, '-','Color',color,'LineWidth',2); hold on;
            xvec = [xvec,x(i)];
            zvec = [zvec,z(i)];
        end
    end
    plot(xvec,zvec,marker,'Color',color,'MarkerSize',10,'MarkerFaceColor',color); hold on;
end