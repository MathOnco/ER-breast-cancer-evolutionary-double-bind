function [YFPcell_count,RFPcell_count] = convertCellCount(YFP,RFP,cell_line,drug)

    pYFP=[];
    pRFP=[];

    if (strcmp(cell_line,'MCF7') && strcmp(drug,'Doxo'))
        pYFP = [1.0221   -5.0507];
        pRFP = [1.0091   -5.2655];
    elseif (strcmp(cell_line,'MCF7') && strcmp(drug,'Pacli'))
        pYFP = [1.0234   -4.9071];
        pRFP = [1.0126   -5.0590];
    elseif (strcmp(cell_line,'T47D') && strcmp(drug,'Pacli'))
        pYFP = [1.0422   -5.0762];
        pRFP = [1.0323   -5.2417];
    end

    model = @(x,p) p(1)*x + p(2);

    YFPcell_count=10.^model(log10(YFP),pYFP);
    RFPcell_count=10.^model(log10(RFP),pRFP);

end