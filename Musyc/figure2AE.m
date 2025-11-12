clc;clear;close all;
L.AutoUpdate = 'off'; 

FOLDER = '_MUSYC';


DRUGS = {'Doxorubicin','Paclitaxel'}; % resistant to ...
CELLS = {'MCF7','T47D'}; % {'MCF7'}%
% CELLS = {'T47D'};

DRUG2='Disulfiram';
colors = [blue();red()];


%% create common meshgrid:
delta_surface = 50;
axis_limits=10.^[-8.5,-2];
a1=log10(axis_limits);  a2=log10(axis_limits);
axis1=a1(1):(a1(2)-a1(1))/delta_surface:a1(2);
axis2=a2(1):(a2(2)-a2(1))/delta_surface:a2(2);
[d1,d2] = meshgrid(10.^axis1,10.^axis2);

for CELL_LINE = CELLS % MCF7, T47D

    figure(1); hold on;

    subplot(2,1,1); clean();
    
    DRUG1 = 'Doxorubicin';
    RESISTANT_TO = DRUG1; % temp
    title(strcat(DRUG1,' with & without',{' '},DRUG2)); hold on;
    plot1d(char(CELL_LINE),char(DRUG1),char(DRUG2),DRUG1, 'Sensitive',FOLDER,d1,d2,'-');


    subplot(2,1,2);
    DRUG1 = 'Paclitaxel';
    RESISTANT_TO = DRUG1; % temp
    title(strcat(DRUG1,' with & without',{' '},DRUG2)); hold on;
    plot1d(char(CELL_LINE),char(DRUG1),char(DRUG2),DRUG1, 'Sensitive',FOLDER,d1,d2,'-');

    % printPNG(figure(1),strcat('Figure1/single_',char(CELL_LINE),'.png'));
    
    
    
    close all;
    
end


