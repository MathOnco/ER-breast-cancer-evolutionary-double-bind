function [] = selection_gradient(A,name,colors)
    
    labels = {'S','R'};
    [nn,~] = size(A);

    % determine color:
    color = colors(1,:);
    color2 = colors(2,:);

    h = gcf;
    figure_number=h.Number;
    figure(figure_number); hold on;

    % offset axes parameters
    line = [0 1];
    us_ms = 12;
    s_ms = 50;
    REL_DIST = 0.05;
    bump_index = 1; % was TREATMENT
    
    ivec = 1:1:(nn-1);
    
    for i = ivec
        for d = ivec
            j = mod(i-1 + d,nn)+1;
            if (i < j)
                                
                ii = 2;
                jj = 3;

                delta = [0,-REL_DIST*bump_index];
                line_x = zeros(length(line),3);
                line_x(:,ii) = line';
                line_x(:,jj) = 1-line';
                [x_line,y_line] = UVW_to_XY(line_x);
                
                %% add gradient of selection:
                xfit=0:0.001:1;
                [~,xdot2,~] = find_xdot(xfit,A);
                
                myMax=max(xdot2);
                myMin=min(xdot2);
                myMax = max(abs(myMin),abs(myMax));


                myNorm = myMax*20;%REL_DIST*0.85;
                plot(xfit + delta(1),xdot2./myNorm + delta(2),'-', 'LineWidth', 3,'Color',color);hold on;
                plot(xfit + delta(1),xdot2./myNorm + delta(2),'--', 'LineWidth', 3,'Color',color2);hold on;
                
                
                xx = xfit + delta(1);                
                curve1 = xx.*0 + delta(2);
                curve2 = xdot2./myNorm + delta(2);
                inBetween = [curve1, fliplr(curve2)];
                x2 = [xx, fliplr(xx)];
                fill(x2, inBetween, color/2,'FaceAlpha',0.2,'LineStyle','none');
                
                
                %% label left / right
                
                del = 0.04;
                fs=32;
                text(-del+delta(1),y_line(1)+ delta(2),labels{i}, 'HorizontalAlignment','right', 'VerticalAlignment','middle', 'fontsize', fs ,'fontweight','bold');
                text(1+del+delta(1),y_line(1)+ delta(2),labels{j}, 'HorizontalAlignment','left', 'VerticalAlignment','middle', 'fontsize', fs ,'fontweight','bold');
                text(0.5+delta(1),y_line(1)+ delta(2)+0.015,name, 'HorizontalAlignment','center', 'VerticalAlignment','middle', 'fontsize', 32 ,'Color',[.1,.1,.1],'fontweight','bold');


                %% this is the subgame:
                Ap = [A(i,i), A(i,j); A(j,i), A(j,j)];

                % equal competition
                if ((Ap(1,1) == Ap(2,1)) && (Ap(1,2) == Ap(2,2)))
                    % equal competition game 
                    % ( no interior fixed points)

                    % plot dashed line
                    plot(x_line + delta(1),y_line + delta(2),':', 'LineWidth', 3,'Color',color);hold on; 

                % interior point
                elseif ((Ap(1,1)-Ap(2,1))*(Ap(1,2)-Ap(2,2)) < 0)

                    % plot line
                    plot(x_line + delta(1),y_line + delta(2),'-', 'LineWidth', 3,'Color',color);hold on; 
                    plot(x_line + delta(1),y_line + delta(2),'--', 'LineWidth', 3,'Color',color2);hold on; 
                    
                    % there exists an interior point
                    x_star = (Ap(2,2) - Ap(1,2))/ (Ap(1,1) - Ap(1,2) - Ap(2,1) + Ap(2,2) );

                    % [u,v,w] (point is the same if either un/stable)
                    x = zeros(1,3);
                    x(ii) = x_star;
                    x(jj) = 1 - x_star;
                    [x_point,y_point] = UVW_to_XY(x);

                    if ((Ap(1,1) < Ap(2,1)) && (Ap(1,2) > Ap(2,2)))
                        % this interior point is stable:
                        plot(x_point+delta(1),y_point+delta(2),'.', 'MarkerSize', s_ms,'Color',color);hold on; % (left side is stable)
                        plot_arrows(ii,jj,x_star,delta,color,1);
                        
                    else
                        % this interior point is unstable:
                        plot(x_point + delta(1),y_point + delta(2),'o','LineWidth', 1,'MarkerSize', us_ms,'Color',[1,1,1],'MarkerEdgeColor',color,'MarkerFaceColor',[1,1,1]);
                        plot_arrows(ii,jj,x_star,delta,color,-1);
                    end

                else
                    % plot line
                    plot(x_line + delta(1),y_line + delta(2),'-', 'LineWidth', 3,'Color',color);hold on; 
                    plot(x_line + delta(1),y_line + delta(2),'--', 'LineWidth', 3,'Color',color2);hold on; 
                   
                    % testing
                    if (Ap(1,1) >= Ap(2,1))
                        plot_arrows(ii,jj,1,delta,color,1);
                    else
                        plot_arrows(ii,jj,1,delta,color,-1);
                    end
                    
                end

                % determine left stability:
                x = zeros(1,3);            
                x(ii) = 1;
                [x_point,y_point] = UVW_to_XY(x);


                if (Ap(1,1) >= Ap(2,1))
                    plot(x_point+delta(1),y_point+delta(2),'.', 'MarkerSize', s_ms,'Color',color);hold on; % (left side is stable)
                else
                    plot(x_point + delta(1),y_point + delta(2),'o','LineWidth', 1,'MarkerSize', us_ms,'MarkerFaceColor',[1,1,1],'MarkerEdgeColor',color);
                end

                x = zeros(1,3);
                x(jj) = 1;
                [x_point,y_point] = UVW_to_XY(x);

                if (Ap(2,2) >= Ap(1,2))
                    plot(x_point+delta(1),y_point+delta(2),'.', 'MarkerSize', s_ms,'Color',color);hold on; % (left side is stable)
                else
                    plot(x_point + delta(1),y_point + delta(2),'o','LineWidth', 1,'MarkerSize', us_ms,'MarkerFaceColor',[1,1,1],'MarkerEdgeColor',color);
                end

                
                bump_index = bump_index+1;
            end
        end  
    end
    
    %% clean up domain:
    xlim([-REL_DIST,1+REL_DIST]);
    ylim([-bump_index*REL_DIST,0]);
    set(gca,'visible','off');
    set(findall(gca, 'type', 'text'), 'visible', 'on'); % leave on title
    box off;
    set(gcf,'color','w');
    width = 600;
    set(gcf,'Position',[100,100,width/sin(pi/3),width]);

    
end

function plot_arrows(i,j,x_star,delta,color,stability)
    % direction:
    xDiff = zeros(1,3);
    xDiff(i) = 1;
    xDiff(j) = -1;

    % down-left

    V = stability*xDiff(1);
    U = stability*(xDiff(3)-xDiff(2))* cos(pi/3);

    arrow_length = 0;
    len = 0.00001;
    
    xMid = zeros(1,3);
    xMid(i) = x_star/2-arrow_length;
    xMid(j) = 1 - x_star/2+arrow_length;
    [xM,yM] = UVW_to_XY(xMid);
    
    hw = 16;
    hl = 20;
    
    %% bottom up
    if (x_star > 0.1)
        ah = annotation('arrow','headStyle','cback1','HeadLength',hl,'HeadWidth',hw);
        set(ah,'parent',gca);
        set(ah,'position',[xM+delta(1),yM+delta(2), len*U, len*V]);
        set(ah,'Color',color);
    end
    
    if (x_star < 0.9)
        xMid = zeros(1,3);
        xMid(i) = 1-(1-x_star)/2+arrow_length;
        xMid(j) = (1-x_star)/2;
                
        [xM,yM] = UVW_to_XY(xMid);
        
        ah = annotation('arrow','headStyle','cback1','HeadLength',hl,'HeadWidth',hw);
        set(ah,'parent',gca);
        set(ah,'position',[xM+delta(1),yM+delta(2), -len*U, -len*V]);
        set(ah,'Color',color);        
    end

end
