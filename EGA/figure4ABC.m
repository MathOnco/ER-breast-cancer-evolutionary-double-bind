clc;clear;close all;

%%  organize the data into preferred format:
% Nc # of conditions (each in separate file)
% Nf # of resistant fractions
% Nr # of replicates


Nc = 8; %# of conditions (each in separate file)
Nf = 5; %# of resistant fractions
Nr = 3; %# of replicates

timepoints = [0,4,7,11,14,18,21,25,28];
TIME_INDEX = length(timepoints);
fraction = [0,25,50,75,100]/100; % fraction of R
treatments = {'Continuous: Untreated', 'Continuous: Chemo', 'Continuous: Disulfiram (low)', 'Continuous: Disulfiram (medium)', 'Continuous: Disulfiram (high)', 'Continuous: Disulfiram (low) + Chemo', 'Continuous: Disulfiram (medium) + Chemo', 'Continuous: Disulfiram (high) + Chemo'};



% constants for StateSpace figure:
del=0.23;

jjj = 1;
for cell_line = {'MCF7','T47D'}
    for drug = {'Doxo','Pacli'}
        if (strcmp(char(cell_line),'T47D') && strcmp(char(drug),'Doxo'))
        else

            {cell_line, drug}
            foldername = strcat('_CSV/',char(cell_line),'-',char(drug),'R/');

            figure(100);clf;hold on;
            addGridAndArrows(del);

            x0 = 0; % normalize EGT by untreated game
            y0 = 0; % normalize EGT by untreated game

            figure(101);clean();hold on;
            figure(102);clean();hold on;
            
            for ti=1:length(treatments)

                %% plot all trajectories, with fits:
                figure(1);clf;hold on;
                name = strcat(char(cell_line),'-',char(drug),'R/',char(treatments{ti}));
                CustomRunTrajectories(foldername,ti,Nf,Nr,TIME_INDEX,name);
                xlim([0 28]);
                resize(1.5,0.45);
                % printPNG(figure(1),strcat('figure4/',name,'.png'));
                figure(1);close; % don't close figure for SS yet

                %% plot fitness curves:
                figure(2); clf; hold on;
                [a,b,c,d,point_x,point_y,phi_star]=CustomPlotFitness(foldername,ti,Nf,Nr,fraction,TIME_INDEX);

                if (ti == 1)
                    x0 = point_x(1);
                    y0 = point_y(1);
                end
                
                

                resize(1,0.45)
                name = strcat(char(cell_line),'-',char(drug),'R/','fitness-',char(treatments{ti}));
                % printPNG(figure(2),strcat('figure4/',name,'.png'));
                figure(2); close;

                

                %% plot statespace of fitness:
                figure(100);
                [relR,relS,deltaR,deltaS] = CustomAddGameMarker(point_x,point_y,getColor(ti),del,x0,y0);
                T = -0.4:0.1:0.4;
                xticks(T);yticks(T);
                
                CreateFitnessPlot(relR,relS, getColor(ti),ti,phi_star);


            end

            

            name = strcat(char(cell_line),'-',char(drug),'R/');
            % printPNG(figure(100),strcat('figure4/',name,'statespace.png'));
            figure(100); close;


            figure(101);xticks([1,2,3,4,5,6,7,8]);xticklabels([]);
            plot([0,9],[0,0],'--','LineWidth',2,'Color',black);
            
            % printPNG(figure(101),strcat('figure4/',name,'_fitness.png'));
            figure(101); close;

            figure(102);xticks([1,2,3,4,5,6,7,8]);xticklabels([]);
            plot([0,9],[0,0],'--','LineWidth',2,'Color',black);

            % printPNG(figure(102),strcat('figure4/',name,'_average_fitness.png'));
            figure(102); close;


            % jjj = jjj+50;

        end
    end
end

function [] = CreateFitnessPlot(relR,relS,color,ti,phi_star)

    [n,~]=size(color);
    color1=color;
    color2=color;
    if (n>1)
        color1=color(1,:);
        color2=color(2,:);
    end
    black=[0,0,0];
    del = [5,0.25];

    %% rel R on top

    LLLW = 6;

    LS1 = '-';LS2 = '-';
%     if (relR < 0) && (relS > 0)
%         LS1 = ':'; % S dominates
%         LS2 = '-'; % S dominates
%     elseif (relR < 0) && (relS > 0)
%         LS1 = '-'; % R dominates
%         LS2 = ':'; % R dominates
%     end

    % plot the leading lines:
    figure(101);hold on;
    X1 = ti-0.25; 
    X2 = ti+0.25;
    plot([X2,X2],[0,relS],LS2,'LineWidth',LLLW,'Color',gold); hold on;
    plot([X1,X1],[0,relR],LS1,'LineWidth',LLLW,'Color',red); hold on;


    CustomHalfCircleMarker(0,X1,relR,black,color1,color2,del);
    CustomHalfCircleMarker(0,X2,relS,black,color1,color2,del);

    ylim([-del(2),del(2)]);
    xlim([0-.5,9.5]);

    

    figure(102);hold on;
    del2 = [5,0.1];
    plot([ti,ti],[0,phi_star],'-','LineWidth',LLLW,'Color',black); hold on;
    CustomHalfCircleMarker(0,ti,phi_star,black,color1,color2,del2);
    ylim([-0.05,0.15]);
    xlim([0-.5,9.5]);
    
    
    

end

function [a,b,c,d,point_x,point_y,phi_star] = CustomPlotFitness(foldername,ti,Nf,Nr,fraction,TIME_INDEX)
    COLOR_S = gold(); 
    COLOR_R = red();


    del=0.1;

    plot([0,0],[-0.3,0.2],'--k','LineWidth',2); hold on;
    plot([1,1],[-0.3,0.2],'--k','LineWidth',2);
    plot([-del,1.0+del],[0,0],'--k','LineWidth',2);


    [a,b,c,d,point_x,point_y,fFit,sFit,rFit,fraction,fitnessS,fitnessR] = getLandscape(foldername,ti,Nf,Nr,fraction,TIME_INDEX);
    
    % ignore S=0
    fractionS = fraction(1:end-1);
    fitnessS=fitnessS(:,1:end-1);
    
    % ignore R=0
    fractionR = fraction(2:end);
    fitnessR=fitnessR(:,2:end); 
    
    plot(fFit,sFit,'-','LineWidth',3,'Color',COLOR_S);hold on;
    plot(fFit,rFit,'-','LineWidth',3,'Color',COLOR_R);hold on;
    
    
    %% plot error bars of growth rates
    ms = 10;
    
    Sm = mean(fitnessS); Rm = mean(fitnessR);
    Sstd = std(fitnessS); Rstd = std(fitnessR);

    for i = 1:1:length(fitnessR)
        plot([fractionS(i),fractionS(i)],[Sm(i)-Sstd(i),Sm(i)+ Sstd(i)],'-','LineWidth',3,'Color',black());hold on;
        plot([fractionR(i),fractionR(i)],[Rm(i)-Rstd(i),Rm(i)+ Rstd(i)],'-','LineWidth',3,'Color',black());hold on;
    end

    plot(fractionS,mean(fitnessS),'o','MarkerSize',ms,'MarkerFaceColor',COLOR_S,'Color',black(),'LineWidth',2);hold on;
    plot(fractionR,mean(fitnessR),'o','MarkerSize',ms,'MarkerFaceColor',COLOR_R,'Color',black(),'LineWidth',2);
    
    YL = [-0.3,0.2];
    
    ylim(YL);

    clean();
    
    %% you can adjust the x-axis everytime, since we are on [0,1]:
    
    xlim([-del,1.0+del]);

    phi_star = nan;
    if ( ((b-d)>0) && ((c-a)<0) )
        phi_star = a; % S-dominates
    elseif ( ((b-d)<0) && ((c-a)>0) )
        phi_star = d; % R-dominates
    end


end


function [] = CustomRunTrajectories(foldername,ti,Nf,Nr,TIME_INDEX,name)
    for fi=1:1:Nf        
        % across all replicates:
        CustomPlotTrajectory(foldername,ti,fi,Nr,true,TIME_INDEX,Nf);

        set(gca,'YScale','log');
        %ylim([10,1.2e6]);
        ylim([0.5,1e6]);
    end    
end

function [gS,gR] = CustomPlotTrajectory(foldername,ti,fi,Nr,plotBool,TIME_INDEX,Nf)
    COLOR_S = gold(); 
    COLOR_R = red();
    
    MS = 10;
    %% get fitness for all replicates:
    [gS,gR,t,S,R,yMax,tFit,sFit,rFit] = getFitness(foldername,ti,fi,Nr,TIME_INDEX);

    if (plotBool)

        subplot(1,Nf,fi);

        % sensitive
        if (~isempty(sFit))
            if (fi < Nf)
                jplot(tFit,sFit,'Color',COLOR_S,'LineWidth',1); hold on;
            end
        end

        % resistance

        if (~isempty(rFit))
            if (fi > 1)
                jplot(tFit,rFit,'Color',COLOR_R,'LineWidth',1); hold on;
            end
        end

        % marker plots on top
        if (fi < Nf)
            plot(t,S,'o','MarkerFaceColor',COLOR_S,'MarkerSize',MS,'Color',black(),'LineWidth',2); hold on;
        end
        if (fi > 1)
            plot(t,R,'o','MarkerFaceColor',COLOR_R,'MarkerSize',MS,'Color',black(),'LineWidth',2); hold on;
        end

        ylim([0,yMax*1.05]);
        clean();
      
    end
end



function [relR,relS,deltaR,deltaS] = CustomAddGameMarker(point_x,point_y,color,del,x0,y0)
    rotate = 0;
    relR=point_x(1);%-x0;
    relS=point_y(1);%-y0;
    
    [n,~]=size(color);
    color1=color;
    color2=color;
    if (n>1)
        color1=color(1,:);
        color2=color(2,:);
    end
    black=[0,0,0];


    plot([relR-point_x(2),relR+point_x(2)],[relS,relS],'-','LineWidth',2,'Color',black); hold on;
    plot([relR,relR],[relS-point_y(2),relS+point_y(2)],'-','LineWidth',2,'Color',black);

    halfCircleMarker(rotate,relR,relS,black,color1,color2,del);

    deltaR=point_x(2);
    deltaS=point_y(2);
end




function [] = CustomHalfCircleMarker(rotate,xData,yData,color,color1,color2,del)

    del = del*4;
    r = del/55;
    markerSize = 0.6;

    lw = 1.5;
    markerEdgeColor = color;
    markerFaceColor = color;

    % color-filled circle, then gray circle
    for i = 1:2
        if i == 2
            r1 = del(1)/60;
            r2 = del(2)/60;

            markerFaceColor = color2;
            phi2 = rotate:0.01:(pi+rotate);
            markerDataX = r1*cos(phi2);
            markerDataY = r2*sin(phi2);
        else
            r1 = del(1)/55;
            r2 = del(2)/55;

            markerFaceColor = color1;
            phi1 = 0:0.01:(2*pi);
            markerDataX = r1*cos(phi1);
            markerDataY = r2*sin(phi1);
        end

        xData = reshape(xData,length(xData),1) ;
        yData = reshape(yData,length(yData),1) ;
        markerDataX = markerSize * reshape(markerDataX,1,length(markerDataX)) ;
        markerDataY = markerSize * reshape(markerDataY,1,length(markerDataY)) ;

        vertX = repmat(markerDataX,length(xData),1) ; vertX = vertX(:) ;
        vertY = repmat(markerDataY,length(yData),1) ; vertY = vertY(:) ;

        vertX = repmat(xData,length(markerDataX),1) + vertX ;
        vertY = repmat(yData,length(markerDataY),1) + vertY ;
        faces = 0:length(xData):length(xData)*(length(markerDataY)-1) ;
        faces = repmat(faces,length(xData),1) ;
        faces = repmat((1:length(xData))',1,length(markerDataY)) + faces ;

        patchHndl = patch('Faces',faces,'Vertices',[vertX vertY]);

        if (i>1)
            set(patchHndl,'FaceColor',markerFaceColor,'EdgeColor','none') ;
        else
            set(patchHndl,'FaceColor',markerFaceColor,'EdgeColor',markerEdgeColor,'LineWidth',lw);
        end
    end
end