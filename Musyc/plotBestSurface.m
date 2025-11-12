function [R2,Ed] = plotBestSurface(CELL_LINE,DRUG1,DRUG2,RESISTANT_TO, S_or_R,FOLDER,d1,d2,c)

    % get the parameters:
    [E0,E1,E2,E3,r1,r2,C1,C2,h1,h2,a12,a21] = getMusycParameters(char(CELL_LINE),char(DRUG1),char(DRUG2),char(RESISTANT_TO), char(S_or_R),FOLDER);

    [Ed] = E(d1*1e6,d2*1e6,E0,E1,E2,E3,r1,r2,C1,C2,h1,h2,a12,a21);
    surf(d1,d2,Ed,...
        'FaceAlpha',0.1,...
        'EdgeColor',c,...
        'EdgeAlpha',1,...
        'FaceColor',c); hold on;
    view(133,25);


    %% annotate plot w/ MUSYC antag / synerg params:
%     text(axis_limits(2), axis_limits(1), text_delta, strcat('R^2 (Sens.) = ',{' '},num2str(R2,3)), 'clipping', 'off','Color',blue());


    
    zl=min([0,E3-abs(E3)*0.05]);
    zlim([zl E0*1.25]);
    
    % to compute the R^2
    [x,y,z,ez]=getMUSYC(CELL_LINE,DRUG1,DRUG2,RESISTANT_TO, S_or_R,FOLDER);

    

    E2test = E(x.*1e6,y.*1e6,E0,E1,E2,E3,r1,r2,C1,C2,h1,h2,a12,a21);
    R2=getRsquared(z,E2test);
    grid off
end


% y1 is...
function [r2]=getRsquared(yMeasured,yFit)
    num=(yMeasured-yFit).^2;
    den=(yMeasured-mean(yMeasured)).^2;
    r2=1-sum(num)/sum(den);
end

