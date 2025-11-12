clc;clear;close all;
FOLDER = '_MUSYC';
% RESULTS_FOLDER = '_MUSYC_Results';

RESULTS_FOLDER = '_MUSYC_Results (No Bounds)';

DRUGS = {'Doxorubicin','Paclitaxel'}; % resistant to ...
CELLS = {'MCF7','T47D'};


% DRUGS = {'Paclitaxel'};
% CELLS = {'MCF7'};


%% plot 1D:
%                 subplot(2,1,1); clean();
%                 S_or_R='Sensitive';
%                 plot1d(char(CELL_LINE),char(DRUG1),char(DRUG2),char(RESISTANT_TO), char(S_or_R),FOLDER,darken(blue(),1.5),d1,d2);


%% tick labels


%% create common meshgrid:
delta_surface = 50;
axis_limits=10.^[-8.5,-2];
a1=log10(axis_limits);  a2=log10(axis_limits);
axis1=a1(1):(a1(2)-a1(1))/delta_surface:a1(2);
axis2=a2(1):(a2(2)-a2(1))/delta_surface:a2(2);
[d1,d2] = meshgrid(10.^axis1,10.^axis2);


DRUG2='Disulfiram';
colors = [blue();red()];

for CELL_LINE = CELLS % MCF7, T47D

    
    S_or_R = 'Sensitive'; % use DRUG1 control here:
    figure(1); hold on;

    subplot(2,1,1); clean();
    
    DRUG1 = 'Doxorubicin';
    title(strcat(DRUG1,' &',{' '},DRUG2));
    addDoseResponseAndBestFit(CELL_LINE,DRUG1,DRUG2,DRUG1,S_or_R,d1,d2,FOLDER,axis_limits);

    DRUG1 = 'Paclitaxel';
    subplot(2,1,2); clean();
    title(strcat(DRUG1,' &',{' '},DRUG2));
    addDoseResponseAndBestFit(CELL_LINE,DRUG1,DRUG2,DRUG1,S_or_R,d1,d2,FOLDER,axis_limits);

    png_filename = strcat('Figure1/Sensitive_',CELL_LINE,'(Pac-Doxo,',DRUG2,').png');
    % printPNG(figure(1),char(png_filename)); 


        for RESISTANT_TO = DRUGS

            if (strcmp(char(RESISTANT_TO),'Doxorubicin'))
                top_drug1 = 'Doxorubicin';
                bottom_drug1 = 'Paclitaxel';
            else 
                top_drug1 = 'Doxorubicin';
                bottom_drug1 = 'Paclitaxel';
            end
                

                S_or_R = 'Resistant';
                figure(2); hold on;

                subplot(2,1,1); clean();
                DRUG1 = top_drug1;
                title(strcat(DRUG1,' &',{' '},DRUG2));
                addDoseResponseAndBestFit(CELL_LINE,DRUG1,DRUG2,RESISTANT_TO,S_or_R,d1,d2,FOLDER,axis_limits);

                DRUG1 = bottom_drug1;
                subplot(2,1,2); clean();
                title(strcat(DRUG1,' &',{' '},DRUG2));
                addDoseResponseAndBestFit(CELL_LINE,DRUG1,DRUG2,RESISTANT_TO,S_or_R,d1,d2,FOLDER,axis_limits);

                
               
                png_filename = strcat('Figure1/',char(S_or_R),'_',CELL_LINE,'(Pac-Doxo,',DRUG2,')_',RESISTANT_TO,'.png');
                % printPNG(figure(2),char(png_filename)); 
                
                close all;

        end
    
end

function [] = addDoseResponseAndBestFit(CELL_LINE,DRUG1,DRUG2,RESISTANT_TO,S_or_R,d1,d2,FOLDER,axis_limits)
    % where the R^2 is displayed
                text_delta = 2.0;
                axis_ticks = -7:1:-3;
                axis_ticks = 10.^axis_ticks;
    color = blue();

    if (strcmp(char(S_or_R),'Resistant'))
        color = red();
    end

    [~,~,xL,yL]=plot3d(char(CELL_LINE),char(DRUG1),char(DRUG2),char(RESISTANT_TO), char(S_or_R),FOLDER,darken(color,1.5));
    [R2,ES]=plotBestSurface(char(CELL_LINE),char(DRUG1),char(DRUG2),char(RESISTANT_TO), char(S_or_R),FOLDER,d1,d2,color);
    text(0.0005, axis_limits(1), text_delta, strcat('R^2 = ',{' '},num2str(R2,3)), 'clipping', 'off','Color',color,'FontSize',16);

    xlim([xL(1), xL(2) ]); xticks(axis_ticks);
    ylim([yL(1), yL(2) ]); yticks(axis_ticks);

    zlim([-0.05,1.5]);
    view(133,25);

end

function [c]=darken(c,F)
    c = boundAll(c/F,[0,1]);
end


