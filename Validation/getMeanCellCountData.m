function [fR,Scount,Rcount] = getMeanCellCountData(experiment,cell_line,drug)

    % subtract background from the S=0, R=0 fluoro
    [fR,Sm,Rm] = getNormMeanData(experiment,cell_line,drug); 
    
    
    % convert to cell count, based on fluorescence
    [Scount,Rcount]=convertCellCount(Sm,Rm,'MCF7','Doxo');
    
    % for now, normalize by first time point of this particular experiment:
    N = Scount(1,:)+Rcount(1,:);
    Navg = mean([N(1),N(end)]); % trust the mono-culture, not the co-culture
    
    Scount = Scount./N*Navg;
    Rcount = Rcount./N*Navg;

end



function [fR,Smean,Rmean] = getNormMeanData(experiment,cell_line,drug)

    [fR,Smean,Rmean] = getRawMeanData(experiment,cell_line,drug);
    
    %% subtract background S (when S should not be there)
    % S' = S - S(fR=1)
    % no sensitive cells when none seeded (S=0)
    Smean = Smean - Smean(:,end);

    %% subtract background R (when R should not be there)
    % R' = R - R(fR=0)
    % no resistant cells when none seeded (R=0)
    Rmean = Rmean - Rmean(:,1);

    Rmean = boundAll(Rmean,[0,1e16]);
    Smean = boundAll(Smean,[0,1e16]);
end