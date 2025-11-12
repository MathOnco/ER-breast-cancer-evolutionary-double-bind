close all; clear;clc;

%% EXCEL 1: PLATES 7-8
expt_date = '2021-01-25';
sheetS='Plate7-T47DSens_V2-Doxo';
sheetR='Plate8-T47DDoxoR_C2-Doxo';
excel_file = '_Edited_Excel/Excel1';

dose_indices = [2,3,4,5,6]; % don't include the 1st index (0 dose) otherwise it's counted twice.
DRUG1='Doxorubicin';
DRUG2='Disulfiram'; % 2nd should match the hand-crafted one
CELL_LINE='T47D';
RESISTANT_TO='Doxorubicin';

drug1_mono = [3000	1000	300	100	30	10	3	1	0.3	0];
drug2_mono = [3000	900	300	90	30	9	3	0.9	0.3	0];
drug1_combo = [NaN, 0, 30,100,300,10];

writeTOCSV2(excel_file,sheetS,sheetR,dose_indices,CELL_LINE,DRUG1,DRUG2,RESISTANT_TO,drug1_mono,drug2_mono,drug1_combo,expt_date);


%% EXCEL 1: PLATES 9-10
sheetS='Plate9-MCF7Sens_V2-Doxo';
sheetR='Plate10-MCF7DoxoR_Cer2-Doxo';
excel_file = '_Edited_Excel/Excel1';

dose_indices = [2,3,4,5,6]; % don't include the 1st index (0 dose) otherwise it's counted twice.
DRUG1='Doxorubicin';
DRUG2='Disulfiram'; % 2nd should match the hand-crafted one
CELL_LINE='MCF7';
RESISTANT_TO='Doxorubicin';

drug1_mono = [3000	1000	300	100	30	10	3	1	0.3 0];
drug2_mono = [3000	900	300	90	30	9	3	0.9	0.3	0];
drug1_combo = [NaN, 0, 10,30,100,300];

writeTOCSV2(excel_file,sheetS,sheetR,dose_indices,CELL_LINE,DRUG1,DRUG2,RESISTANT_TO,drug1_mono,drug2_mono,drug1_combo,expt_date);


%% EXCEL 2: PLATES 32,35
expt_date = '2021-02-23';
sheetS='Plate32-MCF7SensV2_Doxo';
sheetR='Plate35-MCF7PacliRCer2';
excel_file = '_Edited_Excel/Excel2';

dose_indices = [2,3,4,5,6]; % don't include the 1st index (0 dose) otherwise it's counted twice.
DRUG1='Doxorubicin';
DRUG2='Disulfiram'; % 2nd should match the hand-crafted one
CELL_LINE='MCF7';
RESISTANT_TO='Paclitaxel';

drug1_mono = [3000	1000	300	100	30	10	3	1	0.3	0];
drug2_mono = [3000	1000	300	100	30	10	3	1	0.3	0];
drug1_combo = [NaN, 0, 0.1,1,10,100];

writeTOCSV2(excel_file,sheetS,sheetR,dose_indices,CELL_LINE,DRUG1,DRUG2,RESISTANT_TO,drug1_mono,drug2_mono,drug1_combo,expt_date);


%% EXCEL 3: PLATES 38,39
expt_date = '2021-02-24';
sheetS='Plate38-T47DSensV2_Doxo';
sheetR='Plate39-T47DPacliR_Doxo';
excel_file = '_Edited_Excel/Excel3';

dose_indices = [2,3,4,5,6]; % don't include the 1st index (0 dose) otherwise it's counted twice.
DRUG1='Doxorubicin';
DRUG2='Disulfiram'; % 2nd should match the hand-crafted one
CELL_LINE='T47D';
RESISTANT_TO='Paclitaxel';

drug1_mono = [3000	1000	300	100	30	10	3	1	0.3	0];
drug2_mono = [3000	1000	300	100	30	10	3	1	0.3	0];
drug1_combo = [NaN, 0, 10,30,100,300];

writeTOCSV2(excel_file,sheetS,sheetR,dose_indices,CELL_LINE,DRUG1,DRUG2,RESISTANT_TO,drug1_mono,drug2_mono,drug1_combo,expt_date);


%% EXCEL 4: PLATES 28,29
expt_date = '2021-02-16';
sheetS='Plate28-T47DSensV2_Pacli';
sheetR='Plate29-T47DPacliRCer2_Pacli';
excel_file = '_Edited_Excel/Excel4';

dose_indices = [2,3,4,5,6]; % don't include the 1st index (0 dose) otherwise it's counted twice.
DRUG1='Paclitaxel';
DRUG2='Disulfiram'; % 2nd should match the hand-crafted one
CELL_LINE='T47D';
RESISTANT_TO='Paclitaxel';

drug1_mono = [3000	1000	300	100	30	10	3	1	0.3	0];
drug2_mono = [3000	1000	300	100	30	10	3	1	0.3	0];
drug1_combo = [NaN, 0, 10,30,100,300];

writeTOCSV2(excel_file,sheetS,sheetR,dose_indices,CELL_LINE,DRUG1,DRUG2,RESISTANT_TO,drug1_mono,drug2_mono,drug1_combo,expt_date);

%% EXCEL 4: PLATES 30,31
expt_date = '2021-01-25';
sheetS='Plate30-MCF7SensV2_Pacli';
sheetR='Plate31-MCF7PacliRCer2_PacliApp';
excel_file = '_Edited_Excel/Excel4';

dose_indices = [2,3,4,5,6]; % don't include the 1st index (0 dose) otherwise it's counted twice.
DRUG1='Paclitaxel';
DRUG2='Disulfiram'; % 2nd should match the hand-crafted one
CELL_LINE='MCF7';
RESISTANT_TO='Paclitaxel';

drug1_mono = [3000	1000	300	100	30	10	3	1	0.3	0];
drug2_mono = [3000	1000	300	100	30	10	3	1	0.3	0];
drug1_combo = [NaN, 0, 10,30,100,300];

writeTOCSV2(excel_file,sheetS,sheetR,dose_indices,CELL_LINE,DRUG1,DRUG2,RESISTANT_TO,drug1_mono,drug2_mono,drug1_combo,expt_date);

%% EXCEL 5: PLATES 58,59
sheetS='Plate58-T47D_SensV2_Pacli';
sheetR='Plate59-T47DoxoRC2_Pacli';
excel_file = '_Edited_Excel/Excel5';

dose_indices = [2,3,4,5,6]; % don't include the 1st index (0 dose) otherwise it's counted twice.
DRUG1='Paclitaxel';
DRUG2='Disulfiram'; % 2nd should match the hand-crafted one
CELL_LINE='T47D';
RESISTANT_TO='Doxorubicin';

drug1_mono = [1000	300	100	30	10	3	1	0.3	0.1	0];
drug2_mono = [3000	1000	300	100	30	10	3	1	0.3	0];
drug1_combo = [NaN, 0, 1,3,10,30];

writeTOCSV2(excel_file,sheetS,sheetR,dose_indices,CELL_LINE,DRUG1,DRUG2,RESISTANT_TO,drug1_mono,drug2_mono,drug1_combo,expt_date);

%% EXCEL 5: PLATES 60,61
sheetS='Plate60-MCF7_SensV2_Pacli';
sheetR='Plate61-MCF7_DoxoRCer2_Pacli';
excel_file = '_Edited_Excel/Excel5';

dose_indices = [2,3,4,5,6]; % don't include the 1st index (0 dose) otherwise it's counted twice.
DRUG1='Paclitaxel';
DRUG2='Disulfiram'; % 2nd should match the hand-crafted one
CELL_LINE='MCF7';
RESISTANT_TO='Doxorubicin';

drug1_mono = [1000	300	100	30	10	3	1	0.3	0.1	0];
drug2_mono = [3000	1000	300	100	30	10	3	1	0.3	0];
drug1_combo = [NaN, 0, 1,3,10,30];

writeTOCSV2(excel_file,sheetS,sheetR,dose_indices,CELL_LINE,DRUG1,DRUG2,RESISTANT_TO,drug1_mono,drug2_mono,drug1_combo,expt_date);



%% get one row of data (and merge 4 data points):
function [y]=getData(excel_file,sheet,drug_i,dose,batch)

    data = xlsread(strcat(excel_file,'.xlsx'),sheet,'E26:X37');
    
    row_i = (drug_i-1)*2 + 1;
    data = data((row_i:(row_i+1)),:);
    
    [~,m]=size(data);
    
    %% 4 data points represent one experiment
    viability=zeros(4,m/2);
    j=1;
    for i = 1:2:m
        ystar = data(:,(i:(i+1)));
        ystar = [ystar(1,:),ystar(2,:)]';
        viability(:,j)=ystar;
        
        j=j+1;
    end

    % normalize by zero dose
    %DSMOi=find(dose==0);
    %divisor_norm = viability(batch,DSMOi);
    y = viability(batch,:)./1;%divisor_norm;
    
    % don't include dose2 = 0, because this is replaced by row 1:
    if (drug_i > 1)
        y = y(:,1:end-1);
    end
end



function []=writeTOCSV2(excel_file,sheetS,sheetR,dose_indices,CELL_LINE,DRUG1,DRUG2,RESISTANT_TO,drug1_mono,drug2_mono,drug1_combo,expt_date)

    S_or_R = {strcat('Sensitive_',RESISTANT_TO),strcat('Resistant_',RESISTANT_TO)};
    sheets = {sheetS,sheetR};

    for s_i = 1:1:length(sheets)

        SENSITIVE_OR_RESISTANT = char(S_or_R{s_i});
        this_sheet = char(sheets{s_i});

        filename = strcat('_MUSYC/',CELL_LINE,'(',DRUG1,'_',DRUG2,')_',char(S_or_R{s_i}),'.csv');
        writeCSVHeader(filename,'drug1.conc,drug2.conc,effect,batch,drug1,drug2,sample,expt.date,drug1.units,drug2.units');


        for batch = 1:1:4
            units = 'uM';
        
            
            %% write on DRUG 1 alone first:
            drug_i = 1;
            [Z]=getData(excel_file,this_sheet,drug_i,drug1_mono,batch);

            % first row, normalize by this:
            DSMOi=find(drug1_mono==0);
            myNorm = Z(DSMOi);
            Z=Z./myNorm;

            
                    
            % determine concentrations
            XL = drug1_mono; YL = XL*0;
            writeLines(filename,XL',YL',Z',DRUG1,DRUG2,CELL_LINE,expt_date,units,SENSITIVE_OR_RESISTANT,batch);
            
            j=1;

            for drug_i = dose_indices
                [Z]=getData(excel_file,this_sheet,drug_i,drug2_mono,batch);
                Z=Z./myNorm;
                YL = drug2_mono(1:end-1); XL = YL*0 + drug1_combo(drug_i);
                writeLines(filename,XL',YL',Z',DRUG1,DRUG2,CELL_LINE,expt_date,units,SENSITIVE_OR_RESISTANT,batch);
        
                j=j+1;
            end
        end

        % end of S, R file
    end
end


function [] = writeLines(filename,X,Y,effect,DRUG1,DRUG2,CELL_LINE,expt_date,units,SENSITIVE_OR_RESISTANT,batch)
    %drug1.conc,drug2.conc,effect,batch,drug1,drug2,sample,expt.date,drug1.units,drug2.units
    [n,~]=size(X);
    C= cell(n,10);
    C(:,1)=num2cell(X);
    C(:,2)=num2cell(Y');
    C(:,3)=num2cell(effect);
    C(:,4)=num2cell(zeros(n,1)+batch);
    C(:,5)={DRUG1};
    C(:,6)={DRUG2};
    C(:,7)={strcat(CELL_LINE,'(',SENSITIVE_OR_RESISTANT,')')};
    C(:,8)={expt_date};
    C(:,9)={units};
    C(:,10)={units};

    writecell(C,filename,'WriteMode','append');
end




