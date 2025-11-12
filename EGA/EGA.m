clc;clear;close all;

%%  organize the data into preferred format:
% Nc # of conditions (each in separate file)
% Nf # of resistant fractions
% Nr # of replicates

clc;clear;close all;
Nc = 8; %# of conditions (each in separate file)
Nf = 5; %# of resistant fractions
Nr = 3; %# of replicates

timepoints = [0,4,7,11,14,18,21,25,28];
TIME_INDEX = length(timepoints);
fraction = [0,25,50,75,100]/100; % fraction of R
treatments = {'Continuous: Untreated', 'Continuous: Chemo', 'Continuous: Disulfiram (low)', 'Continuous: Disulfiram (medium)', 'Continuous: Disulfiram (high)', 'Continuous: Disulfiram (low) + Chemo', 'Continuous: Disulfiram (medium) + Chemo', 'Continuous: Disulfiram (high) + Chemo'};



%% feed in ti (treatment index),
cell_line = 'MCF7'; % MCF7, T47D
drug = 'Doxo'; % Doxo, Pacli
foldername = strcat('_CSV/',cell_line,'-',drug,'R/')
save_foldername = strcat('plots/',cell_line,'-',drug,'R/')



%% plot all trajectories, with fits:
% for ti=1:length(treatments)
%     ti
%     close all;
%     name = strcat(cell_line,'-',drug,'R/',treatments{ti});
%     runTrajectories(foldername,ti,Nf,Nr,TIME_INDEX,name);
% end


% treatments=treatments{1}

treatment_vec = 1:length(treatments);

close all;
del=0.25;

figure(100);
addGridAndArrows(del);
%% plot all fitness landscapes:
for ti=1%fliplr(treatment_vec)
    [a,b,c,d,point_x,point_y]=plotFitness(foldername,ti,Nf,Nr,fraction,TIME_INDEX);

    ylim([-0.3,0.2]);
    figure(ti);
    title(char(treatments{ti}))
    printPNG(figure(ti),strcat(save_foldername,'fitness',num2str(ti),'.png'));

    figure(100);hold on;
    color = getColor(ti);
    addGameMarker(point_x,point_y,color,del)
end

printPNG(figure(100),strcat(save_foldername,'statespace.png'));






