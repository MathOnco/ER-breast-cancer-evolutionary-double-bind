function [drug1,drug2,Effect,E_sem] = getMUSYC(CELL_LINE,DRUG1,DRUG2,RESISTANT_TO, S_or_R,FOLDER)

    S_or_R = strcat(S_or_R,'_',RESISTANT_TO);
    filename = char(strcat(FOLDER,'/',CELL_LINE,'(',DRUG1,'_',DRUG2,')_',char(S_or_R),'.csv'));
    d1 = getColumnOfCSV(filename,1);
    d2 = getColumnOfCSV(filename,2);
    E = getColumnOfCSV(filename,3);
    batch = getColumnOfCSV(filename,4);

    d1=d1./1e6; % uM
    d2=d2./1e6; % uM
    
    for i = 1:1:max(batch)
        indices = (batch==i);

        drug1(:,i)=d1(indices);
        drug2(:,i)=d2(indices);
        EffectAll(:,i)=E(indices); 
    end



    drug1 = mean(drug1')';
    drug2 = mean(drug2')';
    Effect = mean(EffectAll')';

    E_sem=sem(EffectAll')';

    
    %% do some trickery for log-scale axes:
    L=sort(unique(drug1)); % linear scale
    L10=log10(L); L10=L10(L10>-Inf);
    d20=10.^(min(L10)-mean(diff(L10))); % linear scale
    drug2(drug2==0) = d20;%replace


    L=sort(unique(drug2)); % linear scale
    L10=log10(L); L10=L10(L10>-Inf);
    d10=10.^(min(L10)-mean(diff(L10))); % linear scale
    drug1(drug1==0) = d10;%replace

end