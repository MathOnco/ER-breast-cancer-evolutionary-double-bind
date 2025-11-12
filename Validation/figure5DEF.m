clc;clear; close all;

TIME = [0,4,7,11,14,18,21,25,28];


exp = {'Continuous: Untreated',... % 1
'Continuous: Chemo',... % 2
'Continuous: Disulfiram (low)',... % 3
'Continuous: Disulfiram (medium)',... % 4
'Continuous: Disulfiram (high)',... % 5
'Continuous: Disulfiram (low) + Chemo',... % 6
'Continuous: Disulfiram (medium) + Chemo',... % 7
'Continuous: Disulfiram (high) + Chemo',... % 8
'Sequential: Chemo > Disulfiram (low)',... % 9
'Sequential: Chemo > Disulfiram (medium)',... % 10
'Sequential: Chemo > Disulfiram (high)',... % 11
'Sequential: Disulfiram (low) > Chemo',... % 12
'Sequential: Disulfiram (medium) > Chemo',... % 13
'Sequential: Disulfiram (high) > Chemo',... % 14
'Layered: Continuous Chemo + Disulfiram (low)',... % 15
'Layered: Continuous Chemo + Disulfiram (medium)',... % 16
'Layered: Continuous Chemo + Disulfiram (high)',... % 17
'Layered: Continuous Disulfiram (low) + Chemo',... % 18
'Layered: Continuous Disulfiram (medium) + Chemo',... % 19
'Layered: Continuous Disulfiram (high) + Chemo',... % 20
'Staggered: Chemo > Disulfiram > Chemo > Disulfiram (low)',... % 21
'Staggered: Chemo > Disulfiram > Chemo > Disulfiram (medium)',... % 22
'Staggered: Chemo > Disulfiram > Chemo > Disulfiram (high)',... % 23
'Staggered: Disulfiram > Chemo > Disulfiram > Chemo (low)',... % 24
'Staggered: Disulfiram > Chemo > Disulfiram > Chemo (medium)',... % 25
'Staggered: Disulfiram > Chemo > Disulfiram > Chemo (high)'}; % 26

% 8 continuous
% 6 sequential
% 6 layered
% 6 staggered

%% cell line / drug:
cell_line = 'T47D';
drug = 'Pacli';

continuous = 1:8;
sequential = 9:14;
layered = 15:20;
staggered = 21:26;

% untreated, chemo, disu, combo,
% Sequential: Doxo --> Dis High, Sequential: Dis high --> Doxo, Staggered:
% chemo --> dis high --> chemo --> dis high, Staggered: dis high --> chemo --> dis high --> chemo
% ALTERNATING = [1,2,5,8,11,14,23,26]





% filename = 'ALTERNATING';
% ALTERNATING = [1,8,11,14,23,26];
% which = ALTERNATING;
% labels = {'Untreated','Combo','C > D (slow)','D > C (slow)','C > D (fast)','D > C (fast)'};


filename = 'ALTERNATING_time';
ALTERNATING = [1,11,14,23,26]; % 1,8 left out
which = ALTERNATING;
labels = {'untreated','C > D (slow)','D > C (slow)','C > D (fast)','D > C (fast)'};
alternating_colors = [black;categoricalColors()];
combo_colors = [0.6902    0.1412    0.0941; 0.2000    0.8000    1.0000];

% filename = 'COMBO';
% COMBO = [1,6,7,8];
% which = COMBO;
% labels = {'Untreated','C & D (low)','C & D (medium)','C > D (high)'};



jjj = 1;

for cell_line = {'MCF7','T47D'}
    for drug = {'Doxo','Pacli'}
        if (strcmp(char(cell_line),'T47D') && strcmp(char(drug),'Doxo'))
        else


            xvec = [];
            SA = [];
            SRfraction = [];
            i = 1;
            for ex = exp(which)
                char(ex)
                [fR,Smean,Rmean] = getMeanCellCountData(char(ex),char(cell_line),char(drug));
                Nmean = Smean(:,3) + Rmean(:,3);
            

                    plot(TIME,Nmean,'-','LineWidth',3,'Color',alternating_colors(i,:)); hold on;
                    plot(TIME,Nmean,'.','MarkerSize',30,'Color',alternating_colors(i,:));
                
                i = i + 1;
            end
            

            % combo treatment:
            ex = exp(8); % combo
            [fR,Smean,Rmean] = getMeanCellCountData(char(ex),char(cell_line),char(drug));
            Nmean = Smean(:,3) + Rmean(:,3);
                plot(TIME,Nmean,'-','LineWidth',3,'Color',combo_colors(1,:)); hold on;
                plot(TIME,Nmean,'--','LineWidth',3,'Color',combo_colors(2,:)); hold on;
                
                plot(TIME,Nmean,'.','MarkerSize',30,'Color',combo_colors(1,:));
                plot(TIME,Nmean,'.','MarkerSize',10,'Color',combo_colors(2,:));

            clean();

            
            
            
            % printPNG(figure(1),strcat('figure6/',filename,'-',char(cell_line),'-',char(drug),'.png'));

            % figure(1);close all;

            jjj = jjj+1;
            figure(jjj); hold on;

        end
    end
end

close;

function [] = setwhite()
    box on;
    set(gcf,'color','w');
    fs = 14; %was 24;
    set(findobj(gcf,'type','axes'),'FontName','Arial','FontSize',fs,'FontWeight','Bold', 'LineWidth', 2);
end

