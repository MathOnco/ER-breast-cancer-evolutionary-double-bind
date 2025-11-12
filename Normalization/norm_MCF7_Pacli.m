clc;clear;close all;

%% fitting process (MCF7, Doxo):
% read in 100% conditions only:
cell_counts = xlsread('./MCF7_Sens&PacliR.xlsx',1,'D2:K2')
YFPdata = xlsread('./MCF7_Sens&PacliR.xlsx',1,'D3:K5')
RFPdata = xlsread('./MCF7_Sens&PacliR.xlsx',1,'L18:S20')
[n,~]=size(YFPdata);

YFP=[]; % log10(YFP)
RFP=[]; % log10(RFP)
Y=[]; % log10(cellnumber)

%% plot cell count as a function of YFP, RFP
for i = 1:1:n
    Y = [Y,cell_counts];
    YFP=[YFP,YFPdata(i,:)];
    RFP=[RFP,RFPdata(i,:)];
end


%% YFP:
pYFP = getLinearModel(YFP,Y)


%% RFP:
pRFP = getLinearModel(RFP,Y)







%% check to see if all conditions overlap:
colors = ColorRange(green(),red(),6);
color_indices = xlsread('./MCF7_Sens&PacliR.xlsx',1,'T3:T20');
cell_counts = xlsread('./MCF7_Sens&PacliR.xlsx',1,'D2:K2');
YFP = xlsread('./MCF7_Sens&PacliR.xlsx',1,'D3:K17');
RFP = xlsread('./MCF7_Sens&PacliR.xlsx',1,'L6:S20');
[n,~]=size(YFP);

X_YFP=[]; % log10(YFP)
X_RFP=[]; % log10(RFP)
Y=[]; % log10(cellnumber)

%% plot cell count as a function of YFP, RFP
for i = 1:1:n
    
    % for this particular S/R ratio, across all cell counts:
    [YFPcell_count, RFPcell_count] = convertCellCount(YFP(i,:),RFP(i,:),'MCF7','Doxo');
    plot(cell_counts,YFPcell_count+RFPcell_count,'.','MarkerSize',30,'Color',colors(color_indices(i),:)); hold on;

end

clean();
xlabel('seeded cell count');
ylabel('cell count predicted via fluor.'); 
set(gca,'XScale','log')
set(gca,'YScale','log')
plot([10,1e6],[10,1e6],'-k');

title('MCF7 Pacli Resistance')

% printPNG(figure(1),'ValidationPlots/MCF7_PacliR.png');


