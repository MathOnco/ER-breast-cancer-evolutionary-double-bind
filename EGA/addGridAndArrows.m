function [] = addGridAndArrows(del)
    LEFT = 1; RIGHT = 2;

    xlim([-del,del]);
    ylim([-del,del]);
    clean();
    
    yTop = 0.9*del;
    yBot = -0.9*del;
    
    xLL= -0.9*del; xLR= -0.1*del;
    xRL= 0.1*del; xRR= 0.9*del;

    % bottom left:
    a=area([-del,0,0],[-del,-del,0]);
    a.FaceColor = blue();
    a.EdgeColor = 'none';
    a.FaceAlpha = 0.5;

    % top left:
    a=area([-del,0,0],[del,del,del]);
    a.FaceColor = yellow();
    a.EdgeColor = 'none';
    a.FaceAlpha = 0.5;

    % bottom right:
    a=area([-del,0,0]+del,[-del,-del,0]);
    a.FaceColor = red();
    a.EdgeColor = 'none';
    a.FaceAlpha = 0.5;

    % top right:
    a=area([-del,0,0]+del,[del,del,del]);
    a.FaceColor = [1.0000    0.6000    0.2000]; % orange
    a.EdgeColor = 'none';
    a.FaceAlpha = 0.5;

    % axes lines:
    plot([-del,del],[0,0],':k','LineWidth',3);
    plot([0,0],[-del,del],':k','LineWidth',3);
    
    % top-left
    plot([xLL,xLR],[yTop,yTop],'-k','LineWidth',3);
    plotEquil(xLL,yTop,true);
    plotEquil(xLR,yTop,false);
    plot_arrows(xLL,xLR,yTop,LEFT);
    
    % top-right
    plot([xRL,xRR],[yTop,yTop],'-k','LineWidth',3);
    plotEquil(xRL,yTop,false);
    plotEquil((xRL+xRR)/2,yTop,true);
    plotEquil(xRR,yTop,false);
    plot_arrows((xRL+xRR)/2,xRR,yTop,LEFT);
    plot_arrows((xRL+xRR)/2,xRL,yTop,RIGHT);
    
    % bottom-left
    plot([xLL,xLR],[yBot,yBot],'-k','LineWidth',3);
    plotEquil(xLL,yBot,true);
    plotEquil((xLL+xLR)/2,yBot,false);
    plotEquil(xLR,yBot,true);
    plot_arrows((xLL+xLR)/2,xLR,yBot,RIGHT);
    plot_arrows((xLL+xLR)/2,xLL,yBot,LEFT);
    
    % bottom-right
    plot([xRL,xRR],[yBot,yBot],'-k','LineWidth',3);
    plotEquil(xRL,yBot,false);
    plotEquil(xRR,yBot,true);
    plot_arrows(xRL,xRR,yBot,RIGHT);
    

end


function []=plotEquil(x,y,booleanStable)

    us_ms = 13;
    s_ms = 50;
    if (booleanStable)
        plot(x,y,'.', 'MarkerSize', s_ms,'Color',[0,0,0]);hold on;
    else
        plot(x,y,'o','LineWidth', 1,'MarkerSize', us_ms,'Color',[1,1,1],'MarkerEdgeColor',[0,0,0],'MarkerFaceColor',[1,1,1]);
    end

end




function plot_arrows(x1,x2,y,dir)
    LEFT = 1; RIGHT = 2;
    
    V = 0;
    U = 1*cos(pi/3);
    
    if (dir==LEFT)
        V = 0;
        U = -1*cos(pi/3);
    end

    len = 0.00001;
    color=[0,0,0];
    
    
    hw = 16;
    hl = 20;
    
    %% bottom up
    ah = annotation('arrow','headStyle','cback1','HeadLength',hl,'HeadWidth',hw);
    ah.LineStyle='none';
    set(ah,'parent',gca);
    set(ah,'position',[(x1+x2)/2,y, len*U, len*V]);
    set(ah,'Color',color);


end

