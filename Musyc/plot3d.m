%% plot the data w/ error bars
function [h,z,xL,yL]=plot3d(CELL_LINE,DRUG1,DRUG2,RESISTANT_TO, S_or_R,FOLDER,color)
    [x,y,z,ez]=getMUSYC(CELL_LINE,DRUG1,DRUG2,RESISTANT_TO, S_or_R,FOLDER);

    yL = [min(min(y)),max(max(y))];
    xL = [min(min(x)),max(max(x))];

    plot3(x,y,z,'.','Color',color,'MarkerSize',30); hold on;
    for i=1:length(x) % vertical errorbars
            xV = [x(i); x(i)]; yV = [y(i); y(i)];
            zMin = z(i) + ez(i); zMax = z(i) - ez(i);
            zB = [zMin, zMax];
            h=plot3(xV, yV, zB, '-','Color',color); 
            set(h, 'LineWidth', 2); % draw error bars
    end

    set(gca,'XScale','log');
    set(gca,'YScale','log');
    clean();
    setfontsize(12)

    color = black();
    lw = 2;
    
    %% add X:axis line (to guide the eye):
    indices = (y==min(y));

    % grab only this row:
    xAxis = x(indices);
    yAxis = y(indices);
    zAxis = z(indices);

    % sort in correct order:
    [~,i2]=sort(xAxis);
    xAxis = xAxis(i2);
    yAxis = yAxis(i2);
    zAxis = zAxis(i2);

    % plot:
    plot3(xAxis,yAxis,zAxis,'-','Color',color,'LineWidth',lw); hold on;


    %% add Y:axis line (to guide the eye):
    indices = (x==min(x));

    % grab only this row:
    xAxis = x(indices);
    yAxis = y(indices);
    zAxis = z(indices);

    % sort in correct order:
    [~,i2]=sort(yAxis);
    xAxis = xAxis(i2);
    yAxis = yAxis(i2);
    zAxis = zAxis(i2);

    % plot:
    plot3(xAxis,yAxis,zAxis,'-','Color',color,'LineWidth',lw); hold on;



    
    xlabel(DRUG1);
    ylabel(DRUG2);
    zlabel('Effect');


%     view(135,20);

end