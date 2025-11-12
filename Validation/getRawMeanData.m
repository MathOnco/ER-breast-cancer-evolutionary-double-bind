function [fR,Smean,Rmean] = getRawMeanData(experiment,cell_line,drug)


    [fR,S,R] = getRawData(experiment,cell_line,drug);
    [n,~]=size(S);
    
    Smean = zeros(n,length(fR));
    Rmean = zeros(n,length(fR));

    for i  = 1:1:length(fR)
        i0 = 3*(i-1) + 1;
        i1 = i0+2;
        Smean(:,i) = mean(S(:,i0:i1)')';
        Rmean(:,i) = mean(R(:,i0:i1)')';
    end

end