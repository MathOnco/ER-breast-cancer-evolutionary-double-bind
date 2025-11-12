clc;clear;close all;
FOLDER = '_MUSYC';
% RESULTS_FOLDER = '_MUSYC_Results';

RESULTS_FOLDER = '_MUSYC_Results (No Bounds)';

DRUGS = {'Doxorubicin','Paclitaxel'};
CELLS = {'MCF7','T47D'};



DRUGS = {'Doxorubicin'};
CELLS = {'MCF7'};








for DRUG1 = DRUGS
    DRUG2='Disulfiram';
    for CELL_LINE = CELLS
        for RESISTANT_TO = DRUGS
            %for S_or_R = SR
                {DRUG1,DRUG2,CELL_LINE,RESISTANT_TO}





                axis_limits=10.^[-8,-2];

                x_axis_limit = 10.^[-7.5229,-2];
                y_axis_limit = 10.^[-7.0229,-2];

                


                %% create common meshgrid:
                delta_surface = 50;
                a1=log10(axis_limits);  a2=log10(axis_limits);
                axis1=a1(1):(a1(2)-a1(1))/delta_surface:a1(2);
                axis2=a2(1):(a2(2)-a2(1))/delta_surface:a2(2);
                [d1,d2] = meshgrid(10.^axis1,10.^axis2);
                
                % where the R^2 is displayed
                text_delta = 1.75;


                figure(1); hold on;
                

                %% plot sensitive:
                subplot(1,3,1); clean();
                S_or_R='Sensitive';
                plot3d(char(CELL_LINE),char(DRUG1),char(DRUG2),char(RESISTANT_TO), char(S_or_R),FOLDER,darken(blue(),1.5));
                [R2,ES]=plotBestSurface(CELL_LINE,DRUG1,DRUG2,RESISTANT_TO, S_or_R,FOLDER,d1,d2,blue());
                

                text(axis_limits(2), axis_limits(1), text_delta, strcat('R^2 (Sens.) = ',{' '},num2str(R2,3)), 'clipping', 'off','Color',blue());

                
                xlim([x_axis_limit(1), x_axis_limit(2) ]);
                ylim([y_axis_limit(1), y_axis_limit(2) ]);
                zlim([-0.05,1.5]);

                %% plot resistant:
                subplot(1,3,2); clean();
                S_or_R='Resistant';
                [~,yMeasured_R]=plot3d(char(CELL_LINE),char(DRUG1),char(DRUG2),char(RESISTANT_TO), char(S_or_R),FOLDER,darken(red(),1.5));
                [R2,ER]=plotBestSurface(CELL_LINE,DRUG1,DRUG2,RESISTANT_TO, S_or_R,FOLDER,d1,d2,red());

                
                png_filename = strcat('Plots/',CELL_LINE,'(',DRUG1,'_',DRUG2,')_',RESISTANT_TO,'.png');

                text(axis_limits(2), axis_limits(1), text_delta, strcat('R^2 (Res.) = ',{' '},num2str(R2,3)), 'clipping', 'off','Color',red());

                xlim([x_axis_limit(1), x_axis_limit(2) ]);
                ylim([y_axis_limit(1), y_axis_limit(2) ]);
                zlim([-0.05,1.5]);


                % green to purple difference.
                subplot(1,3,3);clean();
                plotSurfaceDifference(d1,d2,ES,ER,d1,d2,DRUG1,DRUG2);
                xlim([x_axis_limit(1), x_axis_limit(2) ]);
                ylim([y_axis_limit(1), y_axis_limit(2) ]);
                


                resize(3,1);
                printPNG(figure(1),char(png_filename)); 
                
                
%                 close all;
        end
    end
end



function [c]=darken(c,F)
    c = boundAll(c/F,[0,1]);
end


