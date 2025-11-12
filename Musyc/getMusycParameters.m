%% get the best fit parameters, downloaded from https://musyc.lolab.xyz/
function [E0,E1,E2,E3,r1,r2,C1,C2,h1,h2,a12,a21,E0all,E1all,E2all,E3all,C1all,C2all,h1all,h2all,a12all,a21all,betaall,a21_ci_all,beta_ci_all] = getMusycParameters(CELL_LINE,DRUG1,DRUG2,RESISTANT_TO, S_or_R,FOLDER)

    S_or_R = strcat(S_or_R,'_',RESISTANT_TO);
    filename = char(strcat(FOLDER,'_Results/',CELL_LINE,'(',DRUG1,'_',DRUG2,')_',char(S_or_R),'.csv'));
% _MUSYC_Results(No Bounds)


    h1all=[]; h2all = [];
    a12all = []; a21all = [];
    E0all = []; E1all = []; E2all = []; E3all = [];
    C1all = []; C2all = []; betaall = [];

    % for table:
    a21_ci_all = [];
    beta_ci_all = [];

    table = readtable(filename);
    fieldnames(table);

    for batch = 1:1:4
        h1all=[h1all,table.('h1')(batch)];
        h2all=[h2all,table.('h2')(batch)];
        a12all=[a12all,10.^table.('log_alpha12')(batch)];
        a21all=[a21all,10.^table.('log_alpha21')(batch)];
    
        E0all=[E0all,table.('E0')(batch)];
        E1all=[E1all,table.('E1')(batch)];
        E2all=[E2all,table.('E2')(batch)];
        E3all=[E3all,table.('E3')(batch)];
    
        C1all=[C1all,table.('C1')(batch)];
        C2all=[C2all,table.('C2')(batch)];
        betaall=[betaall,table.('beta')(batch)];

        CI = returnCIVector(table,'log_alpha21_ci',batch);
        a21_ci_all=[a21_ci_all;CI];

        CI = returnCIVector(table,'beta_ci',batch);
        beta_ci_all=[beta_ci_all;CI];
    end


    h1=mean(h1all); h2 = mean(h2all);
    a12 = mean(a12all); a21 = mean(a21all);
    E0 = mean(E0all); E1 = mean(E1all); E2 = mean(E2all); E3 = mean(E3all);
    C1 = mean(C1all); C2 = mean(C2all);

    r1=100;
    r2=100;
    
    a12all = log10(a12all);
    a21all = log10(a21all);

end



function [CI] = returnCIVector(table,fieldname,batch)
    % confidence interval conversion
    MYSTR = char(table.(fieldname)(batch));
    MYSTR=MYSTR(2:end-1);
    CI = [str2num(extractBefore(MYSTR,",")), str2num(extractAfter(MYSTR,", "))];
    

end
