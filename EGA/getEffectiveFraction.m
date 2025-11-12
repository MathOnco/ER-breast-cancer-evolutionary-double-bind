function [fEffective] = getEffectiveFraction(foldername,ti,Nf,Nr)
filename = strcat(foldername,'condition',num2str(ti),'.csv');
data = dlmread(filename,',',1,0);
data = data(:,2:end); % remove time column

    fEffective = zeros(1,Nf);

    for fi = 1:1:Nf
        col = (fi-1)*Nr*2 + 1;
        S0 = mean(data(1,col:(col+(Nr-1))));
        R0 = mean(data(1,(col+Nr):(col+(2*Nr-1))));
        
        fEffective(fi) = R0./(S0+R0);
    end
end