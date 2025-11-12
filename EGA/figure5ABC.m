clc;clear;close all;


Nc = 8; %# of conditions (each in separate file)
Nf = 5; %# of resistant fractions
Nr = 3; %# of replicates
% 
timepoints = [0,4,7,11,14,18,21,25,28];
TIME_INDEX = length(timepoints);
fraction = [0,25,50,75,100]/100; % fraction of R



treatments = {'Continuous: Untreated',...
'Continuous: Chemo',...
'Continuous: Disulfiram (low)',...
'Continuous: Disulfiram (medium)',...
'Continuous: Disulfiram (high)',...
'Continuous: Disulfiram (low) + Chemo',...
'Continuous: Disulfiram (medium) + Chemo',...
'Continuous: Disulfiram (high) + Chemo'};


fR = 0.5; % 5 percent resistant
% n0 = 1e4;
tspan = 0:0.1:28;

jjj = 1;

for cell_line = {'MCF7','T47D'}
    for drug = {'Doxo','Pacli'}
        if (strcmp(char(cell_line),'T47D') && strcmp(char(drug),'Doxo'))
        else


            figure(jjj);
            {cell_line, drug}
            foldername = strcat('_CSV/',char(cell_line),'-',char(drug),'R/');

            n0 = 100000;

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            clean();hold on;

            % chemo alone:
            ti = 2;
            [a,b,c,d,~,~,~,~,~,~,~,~] = getLandscape(foldername,ti,Nf,Nr,fraction,TIME_INDEX);
            P_chemo=[a,b,c,d];

            % disu alone:
            ti = 5; % high dose:
            [a,b,c,d,~,~,~,~,~,~,~,~] = getLandscape(foldername,ti,Nf,Nr,fraction,TIME_INDEX);
            P_disu=[a,b,c,d];


            chemo_dose = [25	25	0	0;
                          0	    0   25	25;
                          25	0	25	0;
                          0	    25	0	25];

            disu_dose = [0	0	500	500;
                         500	500	0	0;
                         0	500	0	500
                         500	0	500  0];

            % names = {'Sequential: Doxo --> Dis High','Staggered: chemo --> dis high --> chemo --> dis high','Continuous: Disulfiram (high) + Chemo'};
            names = {'Sequential: Chemo --> Dis High','Sequential: Dis Hig --> Chemo', ...
                     'Staggered: Chemo --> Dis High --> Chemo --> Dis High', 'Staggered: Dis High --> Chemo --> Dis High --> Chemo', ...
                     'Continuous: Disulfiram (high) + Chemo'};


            colors = categoricalColors();
            for exp = 1:1:4
                % n0=plotTraj(char(treatments{ti}),cell_line,drug,ti);
                plotAlternatingTherapy(P_chemo, P_disu,chemo_dose(exp,:),disu_dose(exp,:),fR,n0,colors(exp,:));
            end

            % add continuous high dose:
            lw = 4;

            % max combo:
            ti = 8;
            [a,b,c,d,point_x,point_y,fFit,sFit,rFit,fraction,fitnessS,fitnessR] = getLandscape(foldername,ti,Nf,Nr,fraction,TIME_INDEX);
            y0 = n0*[1-fR,fR];
            [t,y] = ode45(@(t,y) EGA_ODE(t,y,a,b,c,d),tspan,y0);
            colors=getColor(ti);
            plot(t,y(:,1) + y(:,2),'-','LineWidth',lw,'Color',colors(1,:)); hold on;
            plot(t,y(:,1) + y(:,2),'--','LineWidth',lw,'Color',colors(2,:)); hold on;
            ylim([0 6e5]);


            legend(names);

            xlabel('time (days)'); ylabel('cell count');


            % save figures:
            name = strcat(char(cell_line),'-',char(drug),'R/');
            printPNG(figure(jjj),strcat('figure5/',name,'alternating.png'));




            jjj = jjj+1;

        end
    end
end


function [] = plotTherapy(ti, a,b,c,d,tspan,fR,n0)

    lw = 4;

    y0 = n0*[1-fR,fR];

    [t,y] = ode45(@(t,y) EGA_ODE(t,y,a,b,c,d),tspan,y0);

    n = y(:,1) + y(:,2);
    S = y(:,1);
    R = y(:,2);

    [colors]=getColor(ti);

    if (ti == 1)
        plot(t,n,'--','LineWidth',lw,'Color',colors(1,:)); hold on;
    else
        plot(t,n,'-','LineWidth',lw,'Color',colors(1,:)); hold on;
        plot(t,n,'--','LineWidth',lw,'Color',colors(2,:)); hold on;
    end

end


function [] = plotAlternatingTherapy(P_chemo, P_disu, chemo_dose, disu_dose,fR,n0,color)

    lw = 4;

    y0 = n0*[1-fR,fR];

    tspan = 0:0.1:7; % days.


    T = [];
    N = [];
    for week = 1:1:4
        a=P_chemo(1);
        b=P_chemo(2);
        c=P_chemo(3);
        d=P_chemo(4);
        
        if (disu_dose(week) > 0) 
            % disulfiram only:
            a=P_disu(1);
            b=P_disu(2);
            c=P_disu(3);
            d=P_disu(4);
        end
        

        [t,y] = ode45(@(t,y) EGA_ODE(t,y,a,b,c,d),tspan,y0);
        n = y(:,1) + y(:,2);
        S = y(:,1); R = y(:,2);

        T = [T;t];
        N = [N;n];
        

        tspan = tspan + 7;
        y0 = y(end,:);

    end


    plot(T,N,'-','LineWidth',lw,'Color',color); hold on;
end











%%%%%%%%%%%%%%%%%




%%%%%%%%%%%%%%

function [n0] = plotTraj(ex,cell_line,drug,ti)

    [colors]=getColor(ti);

    % plot trajectories: 
    [fR,Smean,Rmean] = getMeanCellCountData(ex,cell_line,drug);
    Nmean = Smean + Rmean;

    t=[0,4,7,11,14,18,21,25,28];

    FR_index = 3; % 1 - 5
    Nt = Smean(:,FR_index);% + Rmean(:,FR_index);

    n0=Nt(1);
    % plot(t,Nt,'.','MarkerSize',35,'Color',colors(1,:)); hold on; % sensitive
    % plot(t,Nt,'.','MarkerSize',40,'Color',colors(2,:)); hold on; % sensitive

end




function [fR,Scount,Rcount] = getMeanCellCountData(experiment,cell_line,drug)

    % subtract background from the S=0, R=0 fluoro
    [fR,Sm,Rm] = getNormMeanData(experiment,cell_line,drug); 
    
    
    % convert to cell count, based on fluorescence
    [Scount,Rcount]=convertCellCount(Sm,Rm,'MCF7','Doxo');
    
    % for now, normalize by first time point of this particular experiment:
    N = Scount(1,:)+Rcount(1,:);
    Navg = mean([N(1),N(end)]); % trust the mono-culture, not the co-culture
    
    Scount = Scount./N*Navg;
    Rcount = Rcount./N*Navg;

end

function [fR,Smean,Rmean] = getNormMeanData(experiment,cell_line,drug)

    [fR,Smean,Rmean] = getRawMeanData(experiment,cell_line,drug);
    
    %% subtract background S (when S should not be there)
    % S' = S - S(fR=1)
    % no sensitive cells when none seeded (S=0)
    Smean = Smean - Smean(:,end);

    %% subtract background R (when R should not be there)
    % R' = R - R(fR=0)
    % no resistant cells when none seeded (R=0)
    Rmean = Rmean - Rmean(:,1);

    Rmean = boundAll(Rmean,[0,1e16]);
    Smean = boundAll(Smean,[0,1e16]);
end

function [fR,Smean,Rmean] = getRawMeanData(experiment,cell_line,drug)

    [fR,S,R] = getRawData(experiment,cell_line,drug);
    [n,~]=size(S);
    
    Smean = zeros(n,length(fR));
    Rmean = zeros(n,length(fR));

    for i  = 1:1:length(fR)
        i0 = 3*(i-1) + 1;
        i1 = i0+2;
        Smean(:,i) = mean(S(:,i0:i1)')';
        Rmean(:,i) = mean(R(:,i0:i1)')';
    end

end
% S, R are in units of cell count (#)
function [fR,Scount,Rcount] = getRawData(experiment,cell_line,drug)
exp = {'Continuous: Untreated',...
'Continuous: Chemo',...
'Continuous: Disulfiram (low)',...
'Continuous: Disulfiram (medium)',...
'Continuous: Disulfiram (high)',...
'Continuous: Disulfiram (low) + Chemo',...
'Continuous: Disulfiram (medium) + Chemo',...
'Continuous: Disulfiram (high) + Chemo',...
'Sequential: Chemo > Disulfiram (low)',...
'Sequential: Chemo > Disulfiram (medium)',...
'Sequential: Chemo > Disulfiram (high)',...
'Sequential: Disulfiram (low) > Chemo',...
'Sequential: Disulfiram (medium) > Chemo',...
'Sequential: Disulfiram (high) > Chemo',...
'Layered: Continuous Chemo + Disulfiram (low)',...
'Layered: Continuous Chemo + Disulfiram (medium)',...
'Layered: Continuous Chemo + Disulfiram (high)',...
'Layered: Continuous Disulfiram (low) + Chemo',...
'Layered: Continuous Disulfiram (medium) + Chemo',...
'Layered: Continuous Disulfiram (high) + Chemo',...
'Staggered: Chemo > Disulfiram > Chemo > Disulfiram (low)',...
'Staggered: Chemo > Disulfiram > Chemo > Disulfiram (medium)',...
'Staggered: Chemo > Disulfiram > Chemo > Disulfiram (high)',...
'Staggered: Disulfiram > Chemo > Disulfiram > Chemo (low)',...
'Staggered: Disulfiram > Chemo > Disulfiram > Chemo (medium)',...
'Staggered: Disulfiram > Chemo > Disulfiram > Chemo (high)'};

filename = strcat('_Excel/',char(cell_line),'_',char(drug),'R_master_fluorescence_results.xlsx');


j=100;
for i = 1:length(exp)
    if strcmp(experiment,char(exp(i)) )
        j=i-1;
    end
end

delta_i = j*15; % shift over appropriate amount:


fR = [0, 0.25, 0.50, 0.75, 1.00];

%% Raw flur sens: % B20 - B28
%% Raw flur res: % B35 - B43
[Sall,~,~] = xlsread(filename,1,'B20:OA28');
[Rall,~,~] = xlsread(filename,1,'B35:OA43');

% rows are timepoints, columns are S/R ratios
S = Sall(:,delta_i+1:(delta_i+15));
R = Rall(:,delta_i+1:(delta_i+15));

Scount=S;
Rcount=R;
% [Scount,Rcount]=convertCellCount(S,R,cell_line,drug);


end
























